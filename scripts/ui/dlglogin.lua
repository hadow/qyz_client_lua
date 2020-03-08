local unpack = unpack
local EventHelper = UIEventListenerHelper
local uimanager = require("uimanager")
local network = require("network")
local serverlist
local CameraManager = require"cameramanager"
local gameObject
local name
local fields
local selectedServer
local elapsedTime
local bc
local loginCode
local function destroy()

end

local function OpEnable(b)
    fields.UILabel_Change.gameObject:SetActive(b)
    fields.UILabel_Server.gameObject:SetActive(b)
end

local function update()
    if fields.UILabel_Change.gameObject.activeSelf then
        elapsedTime = nil
    else
        if elapsedTime then
            elapsedTime = elapsedTime - Time.deltaTime
            if elapsedTime<0 then
                OpEnable(true)
            end
        else
            elapsedTime = 1
        end
    end
end

local function getLatestLoginServer()
    return network.GetDefaultLogin()
end

local function show(params)
    OpEnable(true)
    local bcObj = fields.UILabel_Change.gameObject
    bc = bcObj:GetComponent("BoxCollider")
    --if params and params.bNeedLogin then
    --    Game.Platform.Interface.Instance:Login()
    --else
    --    --uimanager.show"dlgnotice"
    --end
    selectedServer = getLatestLoginServer()
end

local function hide()

end

local function serverLabelInfo(serverNum, serverName)
    return string.format(LocalString.mapping.concatStr,serverNum,serverName)
end

local function OnLoginSuccess()
    print("auth.lua called loginsuccess")
    selectedServer = getLatestLoginServer()

    local avatarmanager = require("roleheadavatarmanager")
    if avatarmanager then
        avatarmanager.init()
    end

end


local function refresh(params)
    serverlist = GetServerList()
    local platform = Game.Platform.Interface.Instance:GetPlatform()
    if "WindowsPlayer" == platform then
        bc.enabled = false
        fields.UILabel_Change.text = ""
    else
        bc.enabled = true
        fields.UILabel_Change.text = serverLabelInfo(selectedServer, serverlist[selectedServer].name)
    end
end

local function saveLatestLoginServer(idx)
    if IsWindows then
        local platform = Game.Platform.Interface.Instance:GetPlatform()
        UserConfig.win_DefaultLogin[platform] = idx
        SaveUserConfig()
    else
        UserConfig.DefaultLogin = idx
        UserConfig.DefaultServer = idx
        SaveUserConfig()
    end

end

local function SetAnchor(fields)
    uimanager.SetAnchor(fields.UIWidget_TopLeft)
    uimanager.SetAnchor(fields.UIWidget_Bottom)
    uimanager.SetAnchor(fields.UIWidget_BottomRight)
    uimanager.SetAnchor(fields.UIWidget_Center)
end

local function login(logincode)

    loginCode = logincode
    local loginstatus = Game.Platform.Interface.Instance:GetLoginStatus();
    print("dlglogin.lua login status:"..loginstatus)
    if loginstatus == -1 or loginstatus == 0 then
        Game.Platform.Interface.Instance:Login(loginCode)
    else
        CameraManager.ActiveSunShaft()
        saveLatestLoginServer(selectedServer)
        network.connect()
        OpEnable(false)
    end
end
local function init(params)
    name, gameObject, fields = unpack(params)
    SetAnchor(fields)


    EventHelper.SetClick(fields.UILabel_Change, function()
        uimanager.show("dlgselectserver", getLatestLoginServer())
        OpEnable(false)
    end )
    EventHelper.SetClick(fields.UILabel_Server, function()

        login(0)
    end )

    EventHelper.SetClick(fields.UIButton_Announcement, function()
        uimanager.show("dlgnotice")
        OpEnable(false)
    end )

    EventHelper.SetClick(fields.UILabel_Account,function()
        Game.Platform.Interface.Instance:Logout()
        Game.Platform.Interface.Instance:Login(Game.Platform.Interface.Instance:GetLoginCode());
        --fields.UIWidget_Account.gameObject:SetActive(true)

    end)
    --EventHelper.SetClick(fields.UIButton_Close,function ()
    --    fields.UIWidget_Account.gameObject:SetActive(false)
    --end)
    --EventHelper.SetClick(fields.UIButton_Login,function ()
    --
    --    if(fields.UIInput_Account.value ~='' or fields.UIInput_Account.value ~=nil) then
    --        --Game.Platform.Interface.Instance.set_m_userName(fields.UIInput_Account.value)
    --        --Game.Platform.Interface.Instance.set_m_tokenId(fields.UIInput_Account.value)
    --        Game.Platform.Interface.Instance:SetUserInfo(fields.UIInput_Account.value,fields.UIInput_Account.value)
    --        Game.Platform.Interface.Instance:Login()
    --        fields.UIWidget_Account.gameObject:SetActive(false)
    --    end
    --end)

    fields.UIButton_Scan.gameObject:SetActive(false)
end

local function ResetSelectedServer(idx)
    selectedServer = idx
    network.setSelectedServer(selectedServer)
    refresh()
end

local function get_login_code()
    return loginCode
end

return {
    init = init,
    show = show,
    hide = hide,
    update = update,
    destroy = destroy,
    refresh = refresh,
    serverLabelInfo = serverLabelInfo,
    ResetSelectedServer = ResetSelectedServer,
    OpEnable = OpEnable,
    OnLoginSuccess = OnLoginSuccess,
    get_login_code = get_login_code,
}
