local EventHelper = UIEventListenerHelper
local uimanager 	= require "uimanager"
--------------------------------------------------------------------------------------------


local gameObject
local name
local fields


--=====================================================================================================================================
local function refresh(params)
   --print(name, "refresh")
end


local function destroy()
  --print(name, "destroy")
end

local function show(params)
    
end

local function hide()
  --print(name, "hide")
end

local function update()
	
end

local function init(params)
   	name, gameObject, fields = unpack(params)
end


--��д�˺��� Ĭ��Ϊ UIShowType.Default
local function uishowtype()
    --return UIShowType.Default
    --return UIShowType.ShowImmediate--ǿ����showtabҳʱ ���ص�showtab
    return UIShowType.Refresh  --ǿ�����л�tabҳʱ�ص�show
    --return bit.bor(UIShowType.ShowImmediate,UIShowType.Refresh)
end


return {
  init                      = init,
  show                      = show,
  hide                      = hide,
  update                    = update,
  destroy                   = destroy,
  refresh                   = refresh,
  uishowtype                = uishowtype,
}

