local Unpack = unpack
local EventHelper = UIEventListenerHelper
local UIManager = require("uimanager")


local name
local gameObject
local fields


local function refresh(params)
	if params then    
		if params.reconnect then
			fields.UILabel_Reconnect.text = params.reconnect
		end
				if params.tip then
					fields.UILabel_Tip.text = params.tip
				end
			end  
end

local function show(params)
    if params then    
		if params.reconnect then
			fields.UILabel_Reconnect.text = params.reconnect
		end
		if params.tip then
			fields.UILabel_Tip.text = params.tip
		end
    end   
end

local function init(params)
    name,gameObject,fields=Unpack(params)
end

local function uishowtype()
	return UIShowType.DestroyWhenHide
end

local function hide()
	
end

return{
    show = show,
    init = init,
    refresh = refresh,
	uishowtype = uishowtype,
	hide = hide,
}