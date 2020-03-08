local printt = printt
local print = print
local gnet = gnet
local SystemInfo = SystemInfo
local Application = Application

local network = require "network"
local login
local gameevent = require "gameevent"
local message = require "common.message"
--local scenemanager = require "scenemanager"
--local dlglogin = require "ui.dlglogin"

--local username = "1_6"..SystemInfo.deviceUniqueIdentifier
--local token = "abcdefghi"
local username = "115051502325418100686"
local token = "4/vQHkpOZOoZFhJbR7OPYC41sK1ePDrQiHggvPvslSBxl1NUxiuRCVLLaufr0UYyOjs7OIyK2yOrosS4zZHcOGSUw"

local ToString = Slua.ToString
local ToBytes = Slua.ToBytes

local plattype = gnet.PlatType.TEST
local deviceid = SystemInfo.deviceUniqueIdentifier
local platform = tostring(Application.platform)
local version
local oss
local LoggedInPlatform

local userid
local isOnline = false
local uimanager = require("uimanager")
local zoneid

 --print("username:", username, token, deviceid)
 local function onmsg_Challenge(d)
	print("onmsg_Challenge serverid = "..d.serverid)
	version = d.version;
	--plattype = gnet.PlatType.ONESDK;
     --plattype = gnet.PlatType.GOOGLEPLAY;
	login.serverid = d.serverid;
	zoneid = d.serverid
	if Application.platform == UnityEngine.RuntimePlatform.Android then
		oss = "2"
	elseif Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
		if Local.JailBreak then
			oss = "0"
		else
			oss = "3"
		end
	elseif Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer then
     oss = "4"
     else
     oss = "0"
     end

     platform = Game.Platform.Interface.Instance:GetSDKPlatformName()
     print("auth.lua receive platform ->" .. platform)
     --print("compress token->"..compressToken)
     local re = gnet.Response({
     user_identity = username,
     --添加前缀,区分登陆方式 1:facebook 0:google
     --token = dlglogin.get_login_code()..token,
     --token = string.sub(token,1,10),
     token = Game.Platform.Interface.Instance:GetLoginCode()..token,
     plattype = { plat = plattype },
     deviceid = deviceid,
     os = oss,
     platform = platform
     })
	message.send(re, false)
 end

 local function onmsg_KeyExchange(d)
 	local nonce = ToString(LuaHelper.GenKeyExchangeNonceAndSetInOutSecurity(ToBytes(username), ToBytes(Game.Platform.Interface.Instance:GetLoginCode()..token), ToBytes(d.nonce)))
 	local kick = 1
 	message.create_and_send("gnet.KeyExchange", {nonce = nonce, kick_olduser = kick}, false)
     print("auth.lua key exchange")
 end


local KEEPALIVE_SEND_INTERVAL = 10
local nextSendKeepaliveTime = 0

local KEEPALIVE_EXPIRE_TIME = 120

local recvKeepaliveExpireTime


local function NotifySceneLoginLoaded()
    isOnline = false
	userid = 0
end

 local function onmsg_OnlineAnnounce(d)
	print("auth onlineannounce ...")
    isOnline = true
    local now = timeutils.GetLocalTime()
    nextSendKeepaliveTime = now + KEEPALIVE_SEND_INTERVAL
    recvKeepaliveExpireTime = now + KEEPALIVE_EXPIRE_TIME
 end

local function on_network_abort()
    isOnline = false
end

 local function onmsg_ErrorInfo(d)
     print("onmsg_ErrorInfo " .. d.errcode.code)
     if(d.errcode.code == gnet.ErrCode.ERR_KICK_BY_ANOTHER_USER) then
         Aio.Session.Instance.AutoReconnect = false
         uimanager.ShowSingleAlertDlg{
             content=LocalString.Err_KickByAnotherPlayer,
             callBackFunc = function()
                  Game.Platform.Interface.Instance:Logout()
             end
         }
     else
        isOnline = false
        network.close(Aio.Session.Instance.AutoReconnect)
     end
 end

 local function onmsg_KeepAlive(d)
     recvKeepaliveExpireTime = timeutils.GetLocalTime() + KEEPALIVE_EXPIRE_TIME
 end

 local function second_update()
     local now = timeutils.GetLocalTime()
     if isOnline then
        if nextSendKeepaliveTime <= now then
            nextSendKeepaliveTime = now + KEEPALIVE_SEND_INTERVAL
            message.create_and_send("gnet.KeepAlive", {code = now * 1000}, false)
        end
        if recvKeepaliveExpireTime <= now then
            network.reconnect()
        end
     end
 end

local function IsOnline()
    return isOnline
end

local function get_zoneid()
    return zoneid
end

local function get_token()
    return token
end

local function InitFail()
	-- print("sdk init fail...")
end

local function InitSuccess()
	-- print("sdk init success...")
end

local function LoginSuccess()
    print("slua receive:loginsuccess logged in platform->")
	-- printyellow("LoginSuccess")
	if not LoggedInPlatform then
		LoggedInPlatform = true
		username = Game.Platform.Interface.Instance:GetUserName()
		--token = ToString(LuaHelper.GZipStrings(Game.Platform.Interface.Instance:GetToken()))
        token = Game.Platform.Interface.Instance:GetToken()
        print("user id->" .. username .. " token ->" .. token)
	end

    network.SetServer()
    if uimanager.hasloaded"dlglogin" then
        uimanager.call("dlglogin","OnLoginSuccess")
        uimanager.refresh"dlglogin"
    end
end

local function LoginCancel()
	-- printyellow("LoginCancel")
	LoggedInPlatform = false;
	uimanager.ShowSystemFlyText(LocalString.Login_LoginPlatformCanceled)
end

local function Logout()
	-- printyellow("Logout")
	if LoggedInPlatform then
		LoggedInPlatform = false
		uimanager.ShowSystemFlyText(LocalString.Login_LogoutPlatform)
        -- login.RegisterLoginSceneLoadedCallback(login.LogoutType.to_login,true)
        login.role_logout(login.LogoutType.to_login, true)
		--[[�˳���ǰ�ʺ�]]--
		-- scenemanager.LoadLoginScene()
	end
end

local function LoginFail()
	uimanager.ShowSystemFlyText(LocalString.Login_LoginPlatformFailed)
end

 local function init()
     login = require "login"
	network.add_listeners({
		{"gnet.Challenge", onmsg_Challenge },
		{"gnet.KeyExchange", onmsg_KeyExchange },
		{"gnet.OnlineAnnounce", onmsg_OnlineAnnounce },
		{"gnet.KeepAlive", onmsg_KeepAlive },
		{"gnet.ErrorInfo", onmsg_ErrorInfo },
	}
	)
	gameevent.evt_second_update:add(second_update)
	gameevent.evt_system_message:add("initFail", InitFail)
	gameevent.evt_system_message:add("initSucceed", InitSuccess)
	gameevent.evt_system_message:add("loginSuccess", LoginSuccess)
	gameevent.evt_system_message:add("loginCancel", LoginCancel)
	gameevent.evt_system_message:add("logoutSuccess", Logout)
    gameevent.evt_system_message:add("network_abort", on_network_abort)
	LoggedInPlatform = false
 end

 return {
	init = init,
	Logout = Logout,
    IsOnline = IsOnline,
    NotifySceneLoginLoaded = NotifySceneLoginLoaded,
	get_zoneid = get_zoneid,
    get_token  = get_token,
 }
