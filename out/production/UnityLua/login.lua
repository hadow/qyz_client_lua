local require = require
local print = print
local printt = printt

local network = require "network"
local auth = require "auth"
local message = require "common.message"
local uimanager = require("uimanager")
local scenemanager = require("scenemanager")
local CameraManager = require"cameramanager"
local EctypeManager =require"ectype.ectypemanager"
local Assistant = require("assistant.assistant")
local bagmanager = require("character.bagmanager")
local CharacterManager = require"character.charactermanager"
local message = require "common.message"
local ConfigManager = require("cfg.configmanager")
local PrologueManager = require"prologue.prologuemanager"
local gameevent = require "gameevent"
local AudioMgr = require"audiomanager"
local ObjPoolsManager = require"objectpoolsmanager"
local SceneMgr = Game.SceneMgr
local evt_system_message = gameevent.evt_system_message
local PetManager = require"character.pet.petmanager"
local EventHelper = UIEventListenerHelper
--local errCode = require"errorcode"
local errMgr = require "assistant.errormanager"
local TimeUtils = require"common.timeutils"

local code

local LogoutType = enum{
    "to_login",
    "to_choose_player",
}

local roles = { }
local selectedroleid = 0
local loginroleid = 0
local firstlogin = true
local serverid = 0
local userid
local localsid
local resverurl

local SPING_EXPIRT_TIME = 90
local recvSPingExpireTime

local nextSendCPingTime
local SEND_CPING_INTERVAL = 10

local nextCheckResVerTime
local CHECK_RESVER_INTERVAL = 600

local function remove_role(idx)
    table.remove(roles,idx)
end

local function get_roles()
    return roles
end

local function get_loginrole()
	return loginroleid
end

local function NotifySceneLoginLoaded()
    selectedroleid = 0
	loginroleid = 0
end

local function role_login(role_index)
    selectedroleid = role_index
    local roleid = roles[selectedroleid].roleid
    local re = lx.gs.login.CRoleLogin( { roleid = roleid })
    network.send(re)
end

local function create_role(rolename, roleprofession, rolegender)
    local platformtype = 0
    if Application.platform == UnityEngine.RuntimePlatform.Android then
        platformtype = 0
    elseif Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
        platformtype = 1
    elseif Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer then
        if Game.Platform.Interface.Instance:GetPlatform() == "Android" then
            platformtype = 0
        else
            platformtype = 1
        end
    end
    local re = lx.gs.login.CCreateRole( { name = rolename, profession = roleprofession, gender = rolegender ,plattype = platformtype})
    network.send(re)

end

local function remove_role(role_index)
    local srole = roles[role_index]
    local delete_role_id = roles[role_index].roleid
    local re = lx.gs.login.CDeleteRole( { roleid = delete_role_id })
    network.send(re)
end



local function login_sucess(roleinfo,roledetail)
    if not ObjPoolsManager.IsInited() then
        ObjPoolsManager.init()
    end
    local PlayerRole = require "character.playerrole"
    -- if Application.platform ~= UnityEngine.RuntimePlatform.WindowsEditor then
    --     BuglyAgent.SetUserId(tostring(roleinfo.roleid))
    -- end
    PlayerRole:Instance():init(roleinfo,roledetail)
    CharacterManager.AddCharacter(roleinfo.roleid,PlayerRole.Instance())
    Assistant.init()
	loginroleid = roleinfo.roleid
end

local function SubmitUserInfo(subtype)
	local selectedServer = network.getSelectedServer()
	local roleid = tostring(PlayerRole:Instance().m_Id)
	local rolelevel = tostring(PlayerRole:Instance().m_Level)
	printyellow("submituserinfo rolelevel "..rolelevel)
	printyellow("login time serverid",auth.get_zoneid())
    local name = PlayerRole:Instance().m_Name
    local createTime = PlayerRole.Instance().m_CreateTime
    printyellow("login time",createTime)
	Game.Platform.Interface.Instance:SubmitUserInfo(subtype, roleid, name, rolelevel, auth.get_zoneid(), selectedServer.name, tostring(createTime));
end

local function OnLoginSceneLoaded(logouttype,bNeedLogin)
    -- printyellow("[login:OnLoginSceneLoaded] OnLoginFinish!")
    CharacterManager.NotifySceneLoginLoaded()
    uimanager.NotifySceneLoginLoaded()
    CameraManager.NotifySceneLoginLoaded()
    EctypeManager.NotifySceneLoginLoaded()
    local auth = require"auth"
    auth.NotifySceneLoginLoaded()
	NotifySceneLoginLoaded()
    -- loginroleid = 0
    local sceneInfo = ConfigManager.getConfigData("scene","login")
    AudioMgr.PlayBackgroundMusic(sceneInfo.backgroundmusicid)

    uimanager.hide("dlgloading")
    if logouttype == LogoutType.to_login then
        uimanager.show("dlglogin",{bNeedLogin = bNeedLogin})
    elseif logouttype == LogoutType.to_choose_player then
        -- network.reconnect()
        network.connect()
        Aio.Session.Instance.AutoReconnect = true
    else
        uimanager.show("dlglogin",{bNeedLogin = bNeedLogin})
    end
end

local function RegisterLoginSceneLoadedCallback(logouttype,bNeedLogin)
    --printyellow("[login:RegisterLoginSceneLoadedCallback] RegisteOnLoginFinish!")
    SceneMgr.Instance:RegisteOnSceneLoadFinish(function(result)
        if result==true then
            -- local LoadOver=function()
            --     OnLoginSceneLoaded(logouttype,bNeedLogin)
            -- end
            -- local timer=Timer.New(LoadOver,0.5,false)
            -- timer:Start()
            OnLoginSceneLoaded(logouttype,bNeedLogin)
        else
            SceneMgr.Instance:ChangeMap("login")
        end

    end)
end

--只供sdk和login.logout调用，其他地方登出请用login.logout
local function role_logout(logouttype, haslogout)
    --logout
    print("[login:role_logout] role logout!")

	if scenemanager.GetSceneName() == "login" then
        print("[login:role_logout] scenemanager.GetSceneName() == login!")
        uimanager.DestroyAllDlgs()
        CameraManager.NotifySceneLoginLoaded()
        -- printyellow("LoadLoginScene");
        uimanager.show("dlglogin")
		network.close(false)
    else
        --msg

		network.send(lx.gs.login.CRoleLogout({}))
        -- if logouttype == LogoutType.to_login then
        network.close(false)
        network.reset_last_reconnect_time()
        -- else
        --     network.close(true)
        -- end
        --ui
		evt_system_message:trigger("logout", logouttype)
		uimanager.show("dlgloading")

        --load scene
        print("[login:role_logout] load login scene!")
        RegisterLoginSceneLoadedCallback(logouttype,true)
		SceneMgr.Instance:ChangeMap("login")
		loginroleid = 0
    end
end

--角色登出
local function logout(logouttype, haslogout)
    if logouttype == LogoutType.to_login then
	    if Application.platform == UnityEngine.RuntimePlatform.Android or
            Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer or 
            Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer then
            Game.Platform.Interface.Instance:Logout()
        else
            role_logout(logouttype, haslogout)
        end
    elseif logouttype == LogoutType.to_choose_player then
        role_logout(logouttype, haslogout)
    end
end

local function onmsg_OnlineAnnounce(d)
    print("auth onlineannounce ...")
    userid = d.userid
    if loginroleid == 0 then
        local PlatformType = 0
        if Application.platform == UnityEngine.RuntimePlatform.Android then
            PlatformType = 0
        elseif Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
            PlatformType = 1
        elseif Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer then
            if Game.Platform.Interface.Instance:GetPlatform() == "Android" then
                PlatformType = 0
            else
                PlatformType = 1
            end
        end
        network.create_and_send("lx.gs.login.CGetRoleList",{plattype=PlatformType})
    else
        local count = message.getProtocolCount()
        local re = lx.gs.login.CRoleRelogin(
            {
                roleid = loginroleid,
                receivedmessagecount = count,
            })
        network.send(re)
    end
end

local function refreshPing(ping)
    if uimanager.isshow("dlguimain") then
        local DlgUIMain = require "ui.dlguimain"
        DlgUIMain.refreshTime(ping)
        --Game.Tools.TimeTool.SetServerTime(msg.sendservertime / 1000)
    end
end

local function onmsg_SGetRoleList(d)
    --printyellow("[login:onmsg_SGetRoleList] onmsg_SGetRoleList!")
    roles = d.roles
    Aio.Session.Instance.AutoReconnect = true
    if loginroleid == 0 then
        uimanager.hide("common.dlgdialogbox_disconnetion")
        network.reset_reconnect_count()
    end
    if scenemanager.GetSceneName() == "login" and uimanager.isshow("dlgcreatplayer") then
        return
    end
    if #roles > 0 then
        for roleid,deltime in pairs(d.deleteinfo or {}) do
            for _,roleinfo in ipairs(roles) do
                if roleinfo.roleid == roleid then
                    roleinfo.deltime = deltime/1000
                end
            end
        end
        uimanager.show("dlgchooseplayer")
        CameraManager.LoginPull("dlgchooseplayer")

        print("[login:onmsg_SGetRoleList] #roles > 0, hide dlglogin!")
        uimanager.hide("dlglogin")
    else
        uimanager.show("dlgcreatplayer")
        CameraManager.LoginPull("dlgcreatplayer")

        --cg related
        print("[login:onmsg_SGetRoleList] #roles <= 0, hide dlglogin immediate!")
        uimanager.hideimmediate("dlglogin")
        PrologueManager.PlayPrefixVedio()
    end
end

local function onmsg_SCancelDelte(msg)
    if roles then
        for _,v in pairs(roles) do
            if v.roleid == msg.roleid then
                v.deltime = nil
                break
            end
        end
    end
    if uimanager.hasloaded("dlgchooseplayer") then
        uimanager.call("dlgchooseplayer","refresh")
    end
end

local function onmsg_SCreateRole(d)
    if d.err == 0 then
        if roles then
            table.insert(roles, d.newinfo)
        end
		local selectedServer = network.getSelectedServer()
        local createTime = d.servertime and math.floor(d.servertime/1000) or 0
        printyellow("creat role time",createTime)
		Game.Platform.Interface.Instance:SubmitUserInfo("create",tostring(d.newinfo.roleid), d.newinfo.rolename, tostring(d.newinfo.level), auth.get_zoneid(), selectedServer.name, tostring(createTime));
        uimanager.hide("dlgcreatplayer")
        CameraManager.RemoveSunShafts()
        CameraManager.DestroyLoginAssist()
        CameraManager.NewCharacter(true)
        role_login(#roles)
    else
        uimanager.ShowSingleAlertDlg({content=errMgr.GetErrorText(d.err)})
    end

end


local function onmsg_SDeleteRole(d)
    if d.err == lx.gs.login.SDeleteRole.OK then
        if roles then
            for i = 1, 4 do
                if roles[i].roleid == d.roleid then
                    -- table.remove(roles, i)
                    roles[i].deltime = TimeUtils.GetServerTime()
                    break
                end
            end
            if uimanager.hasloaded("dlgchooseplayer") then
                uimanager.call("dlgchooseplayer","refresh")
            end
        end
        if #roles>0 then
            uimanager.refresh("dlgchooseplayer")
        else
            uimanager.hide("dlgchooseplayer")
            uimanager.show("dlgcreatplayer",true)
        end

    else
    end

end

local function onmsg_SRoleLogin(d)
    if d.err == lx.gs.login.SRoleLogin.OK then
        firstlogin = false
        CameraManager.DestroyLoginAssist()
        CameraManager.RemoveSunShafts()
        local MapManager=require"map.mapmanager"
        if MapManager.IsFirstLogin()==true then
            uimanager.show("dlgloading")
        end
        login_sucess(roles[selectedroleid], d.roledetail)
        uimanager.hide("dlgchooseplayer")
		SubmitUserInfo("login")
        nextSendCPingTime = timeutils.GetLocalTime() + SEND_CPING_INTERVAL
        recvSPingExpireTime = timeutils.GetLocalTime() + SPING_EXPIRT_TIME
		nextCheckResVerTime = timeutils.GetLocalTime() + CHECK_RESVER_INTERVAL
        refreshPing(1)
        uimanager.hide("common.dlgdialogbox_disconnetion")
        network.reset_reconnect_count()
    elseif d.err == lx.gs.login.SRoleLogin.TOOMANY_ONLINES_ROLE then
        uimnager.ShowSingleAlertDlg{content=LocalString.Login_Toomany_Onlines_Role}
    elseif d.err == lx.gs.login.SRoleLogin.SERVER_LOADAVG_BUSY then
        uimnager.ShowSingleAlertDlg{content=LocalString.Login_Server_Loadavg_Busy}
    else
        loginroleid = 0
        firstlogin = true
        -- TODO
    end

end

local function onmsg_SRoleReLogin(d)
    if d.err == lx.gs.login.SRoleLogin.OK then
        nextSendCPingTime = timeutils.GetLocalTime() + SEND_CPING_INTERVAL
        recvSPingExpireTime = timeutils.GetLocalTime() + SPING_EXPIRT_TIME
		nextCheckResVerTime = timeutils.GetLocalTime() + CHECK_RESVER_INTERVAL
        SubmitUserInfo("login");
        uimanager.hide("common.dlgdialogbox_disconnetion")
        network.reset_reconnect_count()
    else
		local re = lx.gs.login.CRoleLogin( { roleid = loginroleid })
		network.send(re)
    end
end


local function onmsg_KillMonster(msg)
    local PlayerRole = require "character.playerrole"
    PlayerRole:Instance().m_TodayKillMonsterExtraExp = msg.todaytotaladdmonsterexp
    if uimanager.isshow("dlgdailyexp") then
        uimanager.call("dlgdailyexp","refreshExp")
    end
--    for k, v in pairs(msg.currencys) do
--        local flyText=string.format(LocalString.CurrencyFlyText[v.ctype],v.add)
--        uimanager.ShowItemFlyText(flyText)
--    end
    -- PetManager.PetExpChange(msg.petexps)
    for _,petexp in pairs(msg.petexps) do
        PetManager.PetExpChange(petexp.modelid,petexp.level,petexp.exp)
    end
end

local function onmsg_SDayOver(msg)
    local PlayerRole = require "character.playerrole"
    PlayerRole:Instance().m_TodayKillMonsterExtraExp = 0
    if uimanager.isshow("dlgdailyexp") then
        uimanager.call("dlgdailyexp","refreshExp")
    end
end

local function OnMsgSOfflineExp(msg)
    --printyellow("OnMsgSOfflineExp", tostring(msg.offlinetime), tostring(msg.offlineexp))
    if msg.offlinetime > 0 and msg.offlineexp > 0 then
        local PlayerRole = require "character.playerrole"
        PlayerRole:Instance().m_OfflineTime = msg.offlinetime
        PlayerRole:Instance().m_OfflineExp = msg.offlineexp

        if uimanager.isshow("dlguimain") then
            uimanager.call("dlguimain", "ShowGetOfflineExpUI")
        end
    end
end


local function onmsg_SLevelChange(msg)
	--printyellow("onmsg_SLevelChange")
    local oldLevel = PlayerRole.Instance().m_Level
    PlayerRole.Instance().m_Level = msg.level
    PlayerRole.Instance().m_RealLevel = msg.level
    if oldLevel ~= msg.level and uimanager.hasloaded("dlguimain") then
        uimanager.call("dlguimain","RefreshTaskList")
    end
	SubmitUserInfo("level");
    local ModuleLockManager=require"ui.modulelock.modulelockmanager"
    ModuleLockManager.OnPlayerLevelUp()
	local MultiEctypeManager=require"ui.ectype.multiectype.multiectypemanager"
	MultiEctypeManager.SetMaxLevelCanChallege(msg.level)
end

local function onmsg_CurrencyAlert(msg)
    local PlayerRole = require "character.playerrole"
    for k, v in pairs(msg.currencys) do
        if LocalString.CurrencyFlyText[v.ctype] then
            local flyText=string.format(LocalString.CurrencyFlyText[v.ctype],v.add)
            uimanager.ShowItemFlyText(flyText)
        end
    end
end

local function onmsg_ChangeCurrency(msg)
    local PlayerRole = require "character.playerrole"
    for k, v in pairs(msg.currencys) do
        PlayerRole:Instance().m_Currencys[k] = v
    end

    local DlgDialog = require "ui.dlgdialog"
    DlgDialog.RefreshCurrency()

    if uimanager.hasloaded("dlguimain") then
        uimanager.call("dlguimain","RefreshRoleInfo")
    end
    if uimanager.hasloaded("partner.dlgpartner") then
        uimanager.call("partner.dlgpartner","refresh")
    end
--    local DlgShop_Common = require "ui.dlgshop_common"
--    DlgShop_Common.RefreshMoneyText()

--    local DlgWelfare = require "ui.dlgwelfare"
--    DlgWelfare.RefreshMoneyText()
--
--    local DlgBag = require"ui.playerrole.bag.tabbag"
--    DlgBag.RefreshMoneyText()
--
--    local roleskill       = require "character.skill.roleskill"
--    roleskill.RefreshMoney()
--
--    local lotterymanager = require "ui.lottery.lotterymanager"
--    lotterymanager.RefreshMoney()
--
--    local achievementmanager = require "ui.achievement.achievementmanager"
--    achievementmanager.RefreshMoney()
end

local function onmsg_ChangeVipExp(msg)
    local PlayerRole = require "character.playerrole"
    PlayerRole:Instance().m_VipExp = msg.exp
    PlayerRole:Instance().m_VipLevel = msg.level
end


local function onmsg_SPing(msg)
    recvSPingExpireTime = timeutils.GetLocalTime() + SPING_EXPIRT_TIME
    refreshPing(msg.recvclienttime - msg.sendclienttime)
    message.setProtocolCount(msg.sendmessagecount)
end

local function onmsg_SKickRole(msg)
	uimanager.ShowSystemFlyText(msg.desc)
	role_logout(LogoutType.to_login, true)
end


local function onmsg_SCombatPowerChange(msg)
--    local DlgCombatPower = require "ui.dlgcombatpower"
--    DlgCombatPower.showchange(PlayerRole:Instance().m_Power,msg.combatpower)
--    PlayerRole:Instance().m_Power = msg.combatpower
end


local function onmsg_SReSetWorldLevel(d)
    if d ~= nil and d.newlevel ~= nil then
        PlayerRole:Instance().m_worldlevel = d.newlevel
        if uimanager.isshow("dlgdailyexp") then
            uimanager.call("dlgdailyexp","refreshWorldLevelRate")
        end
    end
end

local function onmsg_SReSetWorldLevelRate(d)
    if d ~= nil and d.newrate ~= nil then
        PlayerRole:Instance().m_worldlevelrate = d.newrate
        if uimanager.isshow("dlgdailyexp") then
            uimanager.call("dlgdailyexp","refreshWorldLevelRate")
        end
    end
end


local errcode2msg = {
    LocalString.ERR_FORMATE_INVALID,
    LocalString.ERR_INVALID,
    LocalString.ERR_TYPE_NOT_MATCH,
    LocalString.ERR_CODE_IS_USED,
    LocalString.ERR_CODE_IS_EXPIRATED,
    LocalString.ERR_CODE_IS_NOT_OPEN,
    LocalString.ERR_FUNCTION_IS_CLOSED,
    LocalString.ERR_PLATFORM_NOT_MATCH,
    LocalString.ERR_HAS_ALEADY_ACTIVATED,
    LocalString.ERR_NETWORK,
    LocalString.ERR_EXCEED_DAY_USENUM,
    LocalString.ERR_EXCEED_ALL_USENUM,
    LocalString.ERR_INTERNAL,
	LocalString.ERR_INVALID,
    LocalString.ERR_LEVEL_TOO_LOWE,
    LocalString.ERR_LEVEL_TOO_HIGH,
}

local function  getErrMsg(errcode)
    return errcode2msg[errcode] or LocalString.LOGIN_InvalidActivationCode
end

local function  onmsg_RequireLoginActivationCode(msg)
    userid = msg.userid
    localsid = msg.localsid;
    if msg.err.code == 0 then
        uimanager.show("common.dlgdialogbox_input", {callBackFunc=function(fields)
							fields.UIGroup_Button_Mid.gameObject:SetActive(true)
							fields.UIGroup_Button_Norm.gameObject:SetActive(false)
							fields.UIGroup_Resource.gameObject:SetActive(false)
							fields.UIGroup_Select.gameObject:SetActive(false)
							fields.UIGroup_Clan.gameObject:SetActive(false)
							fields.UIGroup_Rename.gameObject:SetActive(false)
							fields.UIGroup_Slider.gameObject:SetActive(false)
							fields.UIGroup_Delete.gameObject:SetActive(false)
							fields.UIInput_Input.gameObject:SetActive(true)
							fields.UIInput_Input_Large.gameObject:SetActive(false)
                            fields.UIGroup_Describe.gameObject:SetActive(false)

                            EventHelper.SetClick(fields.UIButton_Mid, function()
                                    uimanager.hideimmediate("common.dlgdialogbox_input")
                                    code = fields.UIInput_Input.value
									local re = gnet.InputLoginActivationCode( { code = code, localsid=localsid, userid = userid })
                                    message.send(re)
							end)

							EventHelper.SetClick(fields.UIButton_Close, function()
									uimanager.hide("common.dlgdialogbox_input")
							end)


                            fields.UILabel_Button_Mid.text = LocalString.SureText
							fields.UILabel_Title.text = LocalString.LOGIN_Activation
							fields.UIInput_Input.defaultText = ""
							fields.UIInput_Input.selectAllTextOnFocus = true
							fields.UIInput_Input.characterLimit = 15
							fields.UIInput_Input.value = LocalString.LOGIN_ActivationCode
							fields.UIInput_Input.isSelected = false
							fields.UILabel_Input.text = LocalString.LOGIN_ActivationCode
						end})

    else

        local  errmsg = getErrMsg(msg.err.code)
        uimanager.show("common.dlgdialogbox_input", {callBackFunc=function(fields)
							fields.UIGroup_Button_Mid.gameObject:SetActive(true)
							fields.UIGroup_Button_Norm.gameObject:SetActive(false)
							fields.UIGroup_Resource.gameObject:SetActive(false)
							fields.UIGroup_Select.gameObject:SetActive(false)
							fields.UIGroup_Clan.gameObject:SetActive(false)
							fields.UIGroup_Rename.gameObject:SetActive(false)
							fields.UIGroup_Slider.gameObject:SetActive(false)
							fields.UIGroup_Delete.gameObject:SetActive(false)
							fields.UIInput_Input.gameObject:SetActive(true)
							fields.UIInput_Input_Large.gameObject:SetActive(false)
                            fields.UIGroup_Describe.gameObject:SetActive(true)

                            EventHelper.SetClick(fields.UIButton_Mid, function()
                                    uimanager.hideimmediate("common.dlgdialogbox_input")
                                    code = fields.UIInput_Input.value
                                    local re = gnet.InputLoginActivationCode( { code = code, localsid=localsid, userid = userid })
                                    network.send(re)
							end)

							EventHelper.SetClick(fields.UIButton_Close, function()
									uimanager.hide("common.dlgdialogbox_input")
							end)

                            fields.UILabel_Button_Mid.text = LocalString.SureText
							fields.UILabel_Title.text = LocalString.LOGIN_Activation
							fields.UIInput_Input.defaultText = ""
							fields.UIInput_Input.selectAllTextOnFocus = true
							fields.UIInput_Input.characterLimit = 15
							fields.UIInput_Input.value = code
							fields.UIInput_Input.isSelected = false
							fields.UILabel_Describe.text = errmsg
							fields.UILabel_Input.text = code
						end})
    end

end;

local www = nil

local function second_update()
    local now = timeutils.GetLocalTime()
    if auth.IsOnline() and nextSendCPingTime and nextSendCPingTime < now and loginroleid > 0 then
        nextSendCPingTime = now + SEND_CPING_INTERVAL
        local recvCount = message.getProtocolCount()
        --if recvCount > 0 then
            LuaHelper.Ping(recvCount)
        --end
    end
    if recvSPingExpireTime and recvSPingExpireTime < now and loginroleid > 0 then
        network.reconnect()
    end

	if resverurl~=nil then
		if nextCheckResVerTime and nextCheckResVerTime < now then
			if www == nil then
				www    = WWW(resverurl)
			else
				if www.isDone then
					local resver = tonumber(www.text)
					www:Dispose()
					www = nil;
					nextCheckResVerTime = now + CHECK_RESVER_INTERVAL
					printyellow("LocalResVer "..LocalResVer)
					printyellow("resver"..resver)
					if LocalResVer < resver then
						uimanager.ShowSystemFlyText("need update res")
					end
				end
			end
		end
	end


end

local function on_connected()
    if loginroleid > 0 then
        recvSPingExpireTime = timeutils.GetLocalTime() + SPING_EXPIRT_TIME
    end
end

local function on_abort()
    recvSPingExpireTime = nil
    nextSendCPingTime = nil
end

local function ClearRoles()
    roles = {}
end

local function init()
    network.add_listeners( {
        { "lx.gs.login.SGetRoleList", onmsg_SGetRoleList },
        { "lx.gs.login.SCreateRole", onmsg_SCreateRole },
        { "lx.gs.login.SDeleteRole", onmsg_SDeleteRole },
        { "lx.gs.login.SRoleLogin", onmsg_SRoleLogin },
		{ "lx.gs.login.SRoleRelogin", onmsg_SRoleReLogin },
		{ "lx.gs.login.SKickRole", onmsg_SKickRole },
        { "lx.gs.login.SCancelDelteRole",onmsg_SCancelDelte},
        -- { "lx.gs.role.msg.SNormalExpChange", onmsg_SNormalExpChange },
        { "lx.gs.role.msg.SLevelChange",onmsg_SLevelChange},
        { "lx.gs.role.msg.SCurrencyChange", onmsg_ChangeCurrency },
        { "lx.gs.role.msg.SCurrencyAlert", onmsg_CurrencyAlert},
        { "lx.gs.role.msg.SVipExpChange", onmsg_ChangeVipExp },
        { "lx.gs.role.msg.SKillMonster", onmsg_KillMonster },
        { "lx.gs.role.msg.SDayOver", onmsg_SDayOver },
        { "lx.gs.role.msg.SOffLineExp", OnMsgSOfflineExp },
        { "lx.gs.SPing", onmsg_SPing },
        { "lx.gs.role.msg.SCombatPowerChange", onmsg_SCombatPowerChange },
        { "lx.gs.role.msg.SReSetWorldLevel", onmsg_SReSetWorldLevel },
        { "lx.gs.role.msg.SReSetWorldLevelRate", onmsg_SReSetWorldLevelRate },
        { "gnet.RequireLoginActivationCode", onmsg_RequireLoginActivationCode },
        {"gnet.OnlineAnnounce", onmsg_OnlineAnnounce },
    } )
    gameevent.evt_second_update:add(second_update)
    gameevent.evt_system_message:add("logout",ClearRoles)
    gameevent.evt_system_message:add("network_abort", on_abort)
    gameevent.evt_system_message:add("network_connected", on_connected)

	if Application.platform == UnityEngine.RuntimePlatform.Android then
		resverurl = ResVersionUrlConfig.android
	elseif Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
		resverurl = ResVersionUrlConfig.ios
	else
		resverurl = ResVersionUrlConfig.android
	end

end



return {
    init = init,
    get_roles = get_roles,
    get_mails = get_mails,
    role_login = role_login,
    create_role = create_role,
    display_roles = display_roles,
    remove_role = remove_role,
    logout = logout,
    role_logout = role_logout,
	get_loginrole = get_loginrole,
	set_loginrole = set_loginrole,
	serverid = serverid,
	NotifySceneLoginLoaded = NotifySceneLoginLoaded,
    LogoutType = LogoutType,
    getErrMsg = getErrMsg,
}
