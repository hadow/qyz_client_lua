local unpack = unpack
local print = print
local EventHelper = UIEventListenerHelper
local uimanager = require("uimanager")
local network = require("network")
local login = require("login")
local Player = require "character.player"
local HumanoidAvatar = require"character.avatar.humanoidavatar"
local defineenum = require"defineenum"
local Define = require"define"
local HumanoidAvatarDetailType = defineenum.HumanoidAvatarDetailType
local CameraManager = require"cameramanager"
local gameObject
local name
local selectedRoleID
local fields
local currRoles
local m_player
local playerModel
local rotateSpeed = 0.3
local obj_dlgDel
local fractionSelects
local CameraManager = require"cameramanager"
local canloadnewmodel
local standTime
local CharacterType = defineenum.CharacterType
local CharacterManager = require"character.charactermanager"
local IdleTime
local TimeUtils = require"common.timeutils"

local ListItems = {}

local function SetItemsEnable(b)
    for i=1,4 do
        if i ~= selectedRoleID then
            ListItems[i].item.Enable = b
        end
    end
    ListItems[selectedRoleID].item.Checked = b
end

local function GetRemainTime(delTime)
    local serverTime = TimeUtils.GetServerTime()
    local removeTime = delTime + 3600*24*3
    return (removeTime - serverTime)
end

local function GetRemainDeleteDateTimeStr(remainTime)
    local datetime = TimeUtils.getDateTime(remainTime)
    return string.format(LocalString.Login_Delete_Time,datetime.days,datetime.hours,datetime.minutes,datetime.seconds)
end

local function OnModelLoaded(go)

    if not m_player or not m_player.m_Object then --[[printyellow("no object??")]] return end
    local playerTrans         = m_player.m_Object.transform
    playerTrans.localScale    = Vector3.one
    playerTrans.position = Vector3(-34.30257, 3.08, 2.775848)
    playerTrans.rotation = Quaternion.Euler(0,23.93724,0)
    m_player:RefreshAvatarObject()
    canloadnewmodel = true
    if m_player.m_ShadowObject then
        m_player.m_ShadowObject:SetActive(false)
    end
    standTime = 0
    IdleTime = 0
    SetItemsEnable(true)

end

local function RefreshModel()
    if m_player then m_player:release() end
    if not currRoles[selectedRoleID] then
        fields.UIButton_DeletePlayer.gameObject:SetActive(false)
        return
    end
    if currRoles[selectedRoleID].deltime then
        local remainTime = GetRemainTime(currRoles[selectedRoleID].deltime)
        if remainTime and remainTime>0 and remainTime <= 24*3600*3 then
            fields.UIButton_DeletePlayer.gameObject:SetActive(false)
        else
            fields.UIButton_DeletePlayer.gameObject:SetActive(true)
        end
    else
        fields.UIButton_DeletePlayer.gameObject:SetActive(true)
    end
    m_player = Player:new(false)
    m_player.m_AnimSelectType = cfg.skill.AnimTypeSelectType.UI
    m_player:RegisterOnLoaded(OnModelLoaded)
    local roleInfo = currRoles[selectedRoleID]
    m_player:init(roleInfo.roleid,roleInfo.profession,roleInfo.gender,nil,roleInfo.dressid,roleInfo.equips)
    SetItemsEnable(false)
end

local function check_authcode(text)
    return true
end


local function destroy()
    if m_player then
        m_player:release()
        m_player = nil
    end
end

local function hide_UIs()
    fields.UIGroup_UIs.gameObject:SetActive(false)
end

local function show_UIs()
    fields.UIGroup_UIs.gameObject:SetActive(true)
    IdleTime = 3.5
end

local function ShowInitEffect()
    local spriteLoop1 = ListItems[1].item.Controls["UISprite_Loop1"]
    local spriteLoop2 = ListItems[1].item.Controls["UISprite_Loop2"]
    local spriteStartLight = ListItems[1].item.Controls["UISprite_StartLight"]
end

local function show(params)
    CameraManager.CreatLoginAssist()
    CameraManager.stop()
    standTime = 0
    if not params then
        hide_UIs()
    end
    selectedRoleID = 1
    IdleTime = nil
end

local function hide()
    if m_player then
        m_player:release()
        m_player = nil
    end
end

local function refresh(params)
    printyellow("refresh")
    local roles = login:get_roles()
    for i =1,4 do
        local uigroup_select = ListItems[i].item.Controls["UIGroup_Select"]
        local uilabel_create = ListItems[i].item.Controls["UILabel_Create"]
        local needCreate = true
        -- local roles = login:get_roles()
        currRoles= roles
        if roles and roles[i] then
            needCreate = false
            if not needCreate then
                ListItems[i].spriteVip.gameObject:SetActive((not Local.HideVip) and roles[i].viplevel > 0)
                ListItems[i].labelName.text = roles[i].rolename
                ListItems[i].labelVip.text = roles[i].viplevel
                ListItems[i].labelLevel.text = roles[i].level
                local professionInfo = ConfigManager.getConfigData("profession",roles[i].profession)
                local modelname = cfg.role.GenderType.MALE == roles[i].gender and professionInfo.modelname or professionInfo.modelname2
                local icon = ConfigManager.getConfigData("model",modelname).headicon
                ListItems[i].item:SetIconTexture(icon)
                ListItems[i].item.Enable = true
                if roles[i].deltime then

                    local remainTime = GetRemainTime(roles[i].deltime)
                    if remainTime and remainTime>0 and remainTime <= 24*3600*3 then
                        ListItems[i].btnRecover.gameObject:SetActive(true)
                        -- printyellow("remainTime in range",remainTime)
                        EventHelper.SetClick(ListItems[i].btnRecover,function()
                            uimanager.ShowAlertDlg{
                                content = LocalString.Login_RecoverDelRole,
                                callBackFunc = function()
                                    network.send(lx.gs.login.CCancelDelteRole{roleid=roles[i].roleid})
                                end
                            }

                        end)
                        ListItems[i].deltime = roles[i].deltime
                    else
                        -- fields.UIButton_DeletePlayer.gameObject:SetActive(true)
                        -- printyellow("remainTime in range",remainTime)
                        ListItems[i].btnRecover.gameObject:SetActive(false)
                    end
                else
                    -- fields.UIButton_DeletePlayer.gameObject:SetActive(true)
                    -- printyellow("not remainTime")
                    ListItems[i].btnRecover.gameObject:SetActive(false)
                end
            else
                -- fields.UIButton_DeletePlayer.gameObject:SetActive(false)
                ListItems[i].btnRecover.gameObject:SetActive(false)
                ListItems[i].item.Enable = false
            end
        else
            -- fields.UIButton_DeletePlayer.gameObject:SetActive(false)
            ListItems[i].btnRecover.gameObject:SetActive(false)
        end
        NGUITools.SetActive(uigroup_select.gameObject,not needCreate)
        NGUITools.SetActive(uilabel_create.gameObject,needCreate)
    end
    RefreshModel()
end

local function update()
    if m_player and m_player.m_Avatar then
        m_player.m_Avatar:Update()
        if IdleTime then
            IdleTime = IdleTime + Time.deltaTime
            if IdleTime >5 then
                CameraManager.Rotate(0.2,0)
            end
        end
    end

    if m_player and m_player.m_Object and not m_player:IsPlayingAction(cfg.skill.AnimType.Idle) then
        if standTime then
            if not m_player:IsPlayingStand() then
                m_player:PlayLoopAction(cfg.skill.AnimType.Stand)
            end
            standTime = standTime + Time.deltaTime
            if standTime > 5 then
                m_player:PlayLoopAction(cfg.skill.AnimType.Idle)
                standTime = nil
            end
        else
            standTime = 0
        end
    end

    local bNeedRefresh = false
    for i=4,1,-1 do
        if ListItems[i] then
            if ListItems[i].deltime then
                local remainTime = GetRemainTime(ListItems[i].deltime)
                if remainTime < -10 then
                    ListItems[i].btnRecover.gameObject:SetActive(false)
                    ListItems[i].deltime = nil
                    table.remove(roles,i)
                    bNeedRefresh = true
                elseif remainTime>0 and remainTime <= 24*3600*3 then
                    ListItems[i].labelDeleteTime.text = GetRemainDeleteDateTimeStr(remainTime)
                end
            end
        end
    end
    if bNeedRefresh then
        refresh()
    end
end
local function SetAnchor(fields)
    uimanager.SetAnchor(fields.UIWidget_TopLeft)
    uimanager.SetAnchor(fields.UIWidget_BottomRight)
end

local function init(params)
    name, gameObject, fields = unpack(params)
    SetAnchor(fields)
    for i=1,4 do
        local item = fields.UIList_FactionSelect:GetItemByIndex(i-1)
        ListItems[i] = {}
        ListItems[i].item = item
        item.Controls["UISprite_VIP"].gameObject:SetActive(not Local.HideVip)
        ListItems[i].btnRecover = item.Controls["UIButton_Recovery"]
        ListItems[i].spriteVip = item.Controls["UISprite_VIP"]
        ListItems[i].labelDeleteTime = item.Controls["UILabel_DeleteTime"]
        ListItems[i].labelName = item.Controls["UILabel_Name"]
        ListItems[i].labelLevel = item.Controls["UILabel_LV"]
        ListItems[i].labelVip = item.Controls["UILabel_VIP"]
    end
    EventHelper.SetListClick(fields.UIList_FactionSelect,function(item)
        local index = item.m_nIndex
        local roles = login:get_roles()
        if roles and roles[index+1] then
            selectedRoleID = index+1
            if canloadnewmodel then
                canloadnewmodel = false
                RefreshModel()
            end
            --refresh info and recreate player model
        else
            uimanager.show("dlgcreatplayer",true)
            uimanager.destroy(name)
        end
    end)

    EventHelper.SetClick(fields.UIButton_DeletePlayer,function()
        local roles = login:get_roles()
        if roles and roles[selectedRoleID] then
            -- login.remove_role(selectedRoleID)
            uimanager.show("dlgalert_reminder",{content=LocalString.Login.DeleteRole,callBackFunc=function()
                login.remove_role(selectedRoleID)
            end})
        end
    end)

    EventHelper.SetClick(fields.UIButton_Return,function()
        local roles = login:get_roles()
        hide_UIs()
        CameraManager.LoginPush("dlgchooseplayer")
    end)

    EventHelper.SetClick(fields.UILabel_Play, function ()
        local roles = login:get_roles()
        if selectedRoleID <0 or not roles[selectedRoleID] then
            uimanager.ShowSingleAlertDlg({content=LocalString.login.SelectARole})
        else
            login.role_login(selectedRoleID)
        end
    end)

    EventHelper.SetDrag(fields.UISprite_PlayerModel,function(o,delta)
        CameraManager.Rotate(delta.x,delta.y/20)
        IdleTime = 0
    end)

    local MapManager=require"map.mapmanager"
    MapManager.PreLoadLoadingTexture()
end

return {
  init = init,
  show = show,
  hide = hide,
  update = update,
  destroy = destroy,
  refresh = refresh,
  show_UIs = show_UIs,
  hide_UIs = hide_UIs,
}
