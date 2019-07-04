--region *.lua
--Date
--此文件由[BabeLua]插件自动生成



--endregion

--region *.lua
--Date
--此文件由[BabeLua]插件自动生成



--endregion

local unpack = unpack
local print = print
local math = math
local EventHelper = UIEventListenerHelper
local uimanager = require("uimanager")
local network = require("network")
local login = require("login")
local viewutil = require "common.viewutil"
local defineenum = require "defineenum"
local UpdateState = defineenum.UpdateState
local gameObject
local name

local fields
local currProcess
local currState
local elapsedTime 
local oldApp,oldResource
local slider 
local function destroy()
  --print(name, "destroy")
end

local function show(params)
  --print(name, "show")
  fields.UILabel_1.text = "当前资源版本:"
  fields.UILabel_2.text = "当前程序版本:"
  fields.UILabel_3.text = "检查资源更新中……"
  currProcess = 0;
  fields.UISprite_Foreground.width=0
  fields.UILabel_Tip.text = "0 %"
  currState = UpdateState.Init
  elapsedTime = nil
  oldApp = -1 
  oldResource = -1
end
--    public enum NetworkReachability
--    {
--        NotReachable = 0,
--        ReachableViaCarrierDataNetwork = 1,
--        ReachableViaLocalAreaNetwork = 2,
--    }
local function hide()
  --print(name, "hide")
end

local function update()
    currState = LuaHelper.CurrUpdateState()
    if currState == UpdateState.Init then 
        fields.UILabel_3.text = "正在初始化……"
    elseif currState == UpdateState.InitSDK then 
        fields.UILabel_3.text = "正在初始化SDK……"
    elseif currState == UpdateState.UnZipData then 
        fields.UILabel_3.text = "正在解压数据……"
    elseif currState == UpdateState.CheckNextState then 
        if Application.internetReachability  == NetworkReachability.NotReachable then 
            uimanager.ShowAlertDlg({title = "network problem",content ="检查网络是否通畅",btn_sure=network.Connect,btn_return = Application.Quit,
            text_sure = "重试",text_return = "退出"})
        elseif Application.internetReachability == NetworkReachability.ReachableViaCarrierDataNetwork then 
            uimanager.ShowAlertDlg({title = "not wifi",content = "是否继续更新",btn_return =Application.Quit})
        end
    elseif currState == UpdateState.UpdateApp then 
        -- do something to update APP 
    elseif currState == UpdateState.UpdateResource then 
        fields.UILabel_3.text = "正在解压数据……"
        local percent = LuaHelper.DownloadPercent()
            fields.UILabel_Tip.text = tostring(percent).." %"
            fields.UISprite_Foreground.width = percent*1033*0.01
    elseif currState == UpdateState.StartGame then 
        if not elapsedTime then 
        fields.UILabel_3.text = "加载完成!!!"
            fields.UILabel_Tip.text = "100 %"
            fields.UISprite_Foreground.width = 1033
          elapsedTime=0 
        else elapsedTime=elapsedTime+Time.deltaTime end 
        if elapsedTime>1.5 then 
        uimanager.show("dlglogin") uimanager.destroy(name) 
        end 
    end
    if oldResource<0 or oldApp<0 then 
        local oldResource,oldApp = LuaHelper.oldVersion()
        if oldApp>=0 and oldResource>=0 then 
            fields.UILabel_1.text = "当前资源版本:"..tostring(oldResource)
            fields.UILabel_2.text = "当前程序版本:"..tostring(oldApp)
        end
    end
 --    UpdateManager:EvtCheckUpdate("aaaaa")
end

local function refresh(params)
end


local function init(params)
  name, gameObject, fields = unpack(params)

end

return {
  init = init,
  show = show,
  hide = hide,
  update = update,
  destroy = destroy,
  refresh = refresh,
}