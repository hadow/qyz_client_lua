local unpack = unpack
local print = print
local EventHelper = UIEventListenerHelper
local uimanager = require("uimanager")

local gameObject
local name

local fields
local function destroy()
	--print(name, "destroy")
end

local function show(params)
	--print(name, "show")
end

local function hide()
	--print(name, "hide")
end

local function refresh(params)
 -- print(name, "refresh")
end

local function update()
	--print(name, "update")
end

local function init(params)
	name, gameObject, fields = unpack(params)
	EventHelper.SetClick(fields.Button_Out, function () 
		--print("Button_Out click")
		uimanager.hide(name)
	end)
end

return {
	init = init,
	show = show,
	hide = hide,
	update = update,
	destroy = destroy,
	refresh = refresh,
}