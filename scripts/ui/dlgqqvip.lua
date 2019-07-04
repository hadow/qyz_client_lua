local unpack = unpack
local print = print
local require = require
local network        = require("network")
local printt = printt
local EventHelper = UIEventListenerHelper
local uimanager = require("uimanager")
local BonusManager   = require("item.bonusmanager")
local ConfigManager  = require("cfg.configmanager")
local ItemIntroduct  = require("item.itemintroduction")
local ItemEnum       = require("item.itemenum")
local gameObject
local name

local fields



local function destroy()
	-- printyellow(name, "destroy joystick")
end

local function show(params)
	
end

local function hide()
	--uimanager.show("dlguimain")
end

local function refresh(params)
  --print(name, "refresh")
end

local function update()
	
end


local function init(params)

	name, gameObject, fields = unpack(params)
	EventHelper.SetClick(fields.UIButton_Close, function()
        --printyellow("UIButton_TeamTab click")
		uimanager.hidedialog("dlgqqvip")
    end )

	EventHelper.SetClick(fields.UIButton_Exchange,function()
		local exchangeId = fields.UIInput_CDKEY.value
		if trim(exchangeId) ~= "" then 
			local msg = lx.gs.role.msg.CUseCode{ code = exchangeId }
			network.send(msg)	
		else
			uimanager.ShowSystemFlyText(LocalString.Welfare_ExchangeId_NoId)
		end
	end)
	
	
		local activecode = ConfigManager.getConfigData("qqclubmember", 2)
        local items = BonusManager.GetItems(activecode.items)
            for i = 1, #items do
                local dayGiftListItem = fields.UIList_Reward01:AddListItem()
				printyellow("texture"..items[i]:GetTextureName());
                dayGiftListItem:SetIconTexture(items[i]:GetTextureName())
                dayGiftListItem.Controls["UILabel_Amount"].text = items[i]:GetNumber()
				dayGiftListItem.Controls["UISprite_Quality"].color = colorutil.GetQualityColor(items[i]:GetQuality())
				dayGiftListItem.Controls["UISprite_Fragment"].gameObject:SetActive(items[i]:GetBaseType() == ItemEnum.ItemBaseType.Fragment)
				dayGiftListItem.Controls["UILabel_Amount"].gameObject:SetActive(true)
				dayGiftListItem.Data = items[i]
            end
			
			activecode = ConfigManager.getConfigData("qqclubmember", 3)
        items = BonusManager.GetItems(activecode.items)
            for i = 1, #items do
                local dayGiftListItem = fields.UIList_Reward02:AddListItem()
				printyellow("texture"..items[i]:GetTextureName());
                dayGiftListItem:SetIconTexture(items[i]:GetTextureName())
                dayGiftListItem.Controls["UILabel_Amount"].text = items[i]:GetNumber()
				dayGiftListItem.Controls["UISprite_Quality"].color = colorutil.GetQualityColor(items[i]:GetQuality())
				dayGiftListItem.Controls["UISprite_Fragment"].gameObject:SetActive(items[i]:GetBaseType() == ItemEnum.ItemBaseType.Fragment)
				dayGiftListItem.Controls["UILabel_Amount"].gameObject:SetActive(true)
				dayGiftListItem.Data = items[i]
            end
			
			activecode = ConfigManager.getConfigData("qqclubmember", 4)
			items = BonusManager.GetItems(activecode.items)
            for i = 1, #items do
                local dayGiftListItem = fields.UIList_Reward03:AddListItem()
				printyellow("texture"..items[i]:GetTextureName());
                dayGiftListItem:SetIconTexture(items[i]:GetTextureName())
                dayGiftListItem.Controls["UILabel_Amount"].text = items[i]:GetNumber()
				dayGiftListItem.Controls["UISprite_Quality"].color = colorutil.GetQualityColor(items[i]:GetQuality())
				dayGiftListItem.Controls["UISprite_Fragment"].gameObject:SetActive(items[i]:GetBaseType() == ItemEnum.ItemBaseType.Fragment)
				dayGiftListItem.Controls["UILabel_Amount"].gameObject:SetActive(true)
				dayGiftListItem.Data = items[i]
            end


            EventHelper.SetListClick(fields.UIList_Reward01, function(listItem)
				ItemIntroduct.DisplayBriefItem( {item = listItem.Data} )
            end )
			
			EventHelper.SetListClick(fields.UIList_Reward02, function(listItem)
				ItemIntroduct.DisplayBriefItem( {item = listItem.Data} )
            end )
			
			EventHelper.SetListClick(fields.UIList_Reward03, function(listItem)
				ItemIntroduct.DisplayBriefItem( {item = listItem.Data} )
            end )
			
			local appurl = "http://imgcache.qq.com/club/act/2016/133076/64edf656ab.html?_wv=1&_wwv=4&from=game"
			EventHelper.SetClick(fields.UIButton_Acquire01,function()
				Application.OpenURL(appurl);
			end)
			
			EventHelper.SetClick(fields.UIButton_Acquire02,function()
				Application.OpenURL(appurl);
			end)
			
			EventHelper.SetClick(fields.UIButton_Acquire03,function()
				Application.OpenURL(appurl);
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