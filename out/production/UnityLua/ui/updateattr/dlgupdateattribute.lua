local unpack = unpack
local EventHelper = UIEventListenerHelper
local ConfigManager = require("cfg.configmanager")
local UIManager = require("uimanager")

local gameObject
local fields
local name

local seconds 

local function hide()
end

local function GetStatusTextById(d)
	local statustext = ConfigManager.getConfig("statustext")
	for _,k in pairs(statustext) do
		if k.attrtype == d then
			return k 
		end
	end
	return nil
end

local function SetItemInfo(attrid,oldattr,newattr)
	
	local list_item
	local status = GetStatusTextById(attrid)
	list_item = fields.UIList_Attribute:AddListItem()  
	list_item.Controls["UILabel_Attribute"].text = status.text..":"
	list_item.Controls["UISprite_AttributeIcon"].spriteName = status.spritename
	list_item.Controls["UILabel_AttributeAmount"].text = math.floor(oldattr[attrid]) or 0 
--	printyellow("newattr[attrid]",newattr[attrid])
--	printyellow("oldattr[attrid]",oldattr[attrid])
	list_item.Controls["UILabel_AttributeUpdateAmount"].text = "(+".. math.floor(newattr[attrid] - oldattr[attrid])  .. "]"
	
end
local function show(params)
    seconds = 2
	local oldattr = params.old_attr
	local newattr = params.new_attr
	local level = params.level
	fields.UIList_Attribute:Clear()
	fields.UILabel_UpdateLevel.text = level .. LocalString.Level

	SetItemInfo(cfg.fight.AttrId.HP_FULL_VALUE   ,oldattr,newattr)
	SetItemInfo(cfg.fight.AttrId.MP_FULL_VALUE   ,oldattr,newattr)
	SetItemInfo(cfg.fight.AttrId.ATTACK_VALUE_MAX,oldattr,newattr)
	SetItemInfo(cfg.fight.AttrId.ATTACK_VALUE_MIN,oldattr,newattr)
	SetItemInfo(cfg.fight.AttrId.DEFENCE         ,oldattr,newattr)
	SetItemInfo(cfg.fight.AttrId.HIT_RATE        ,oldattr,newattr)
	SetItemInfo(cfg.fight.AttrId.HIT_RESIST_RATE  ,oldattr,newattr)
	
	EventHelper.SetClick(fields.UISprite_Black ,function()
--		printyellow("setclick black")
		UIManager.hide(name)
	end)



end 

local function refresh(params)
	local oldattr = params.old_attr
	local newattr = params.new_attr
	local level = params.level
	fields.UIList_Attribute:Clear()
	fields.UILabel_UpdateLevel.text = level .. LocalString.Level

	SetItemInfo(cfg.fight.AttrId.HP_FULL_VALUE   ,oldattr,newattr)
	SetItemInfo(cfg.fight.AttrId.MP_FULL_VALUE   ,oldattr,newattr)
	SetItemInfo(cfg.fight.AttrId.ATTACK_VALUE_MAX,oldattr,newattr)
	SetItemInfo(cfg.fight.AttrId.ATTACK_VALUE_MIN,oldattr,newattr)
	SetItemInfo(cfg.fight.AttrId.DEFENCE         ,oldattr,newattr)
	SetItemInfo(cfg.fight.AttrId.HIT_RATE        ,oldattr,newattr)
	SetItemInfo(cfg.fight.AttrId.HIT_RESIST_RATE  ,oldattr,newattr)
end 

local function second_update()
	seconds = seconds - 1
	if seconds == 0 then
		seconds = 2
		UIManager.hide(name)
	end
end

local function init(params)

	name, gameObject, fields = unpack(params)
end

return {
	init = init,
	show = show,
	hide = hide,
	refresh = refresh,
	second_update = second_update,
}