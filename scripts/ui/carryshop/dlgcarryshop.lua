local unpack = unpack
local UIManager = require"uimanager"
local EventHelper = UIEventListenerHelper
local ItemIntroduct = require("item.itemintroduction")
local BonusManager = require("item.bonusmanager")
local ItemManager = require("item.itemmanager")
local ShopManager = require("shopmanager")
local CheckCmd = require("common.checkcmd")
local network = require("network")

local name
local gameObject
local fields 

local function destroy()
end

local function DisplayOneItem(listitem,item,itemconfig)                  --show药店的物品
	--listitem.Controls["UILabel_ShopItemName"].text = item.introduce                 -- 名称
	listitem.Controls["UILabel_ShopItemName"].text = itemconfig:GetName()
	
	local currency = ItemManager.GetCurrencyData(item.cost)
	listitem.Controls["UISprite_Currency_Icon"].spriteName = currency:GetIconName()
	listitem.Controls["UILabel_ShopItemUnitPrice"].text = currency:GetNumber()  --item.cost.amount            -- 价格
--	printyellow("DisplayOneItem",itemconfig:GetTextureName())
	local params = {}
	params.notShowAmount = true
	BonusManager.SetRewardItem(listitem,itemconfig,params)
	listitem.Controls["UITexture_Icon"]:SetIconTexture(itemconfig:GetTextureName()) -- 图片

	listitem.Controls["UISprite_Quality"].color = colorutil.GetQualityColor(itemconfig:GetQuality())
	if item.bindtype.bindtype == cfg.item.EItemBindType.BOUND then 
		listitem.Controls["UISprite_Binding"].gameObject:SetActive(true)
	end
end

local function show(params)
	local items = params.items
	fields.UIList_Shop:Clear()
	for _,item in ipairs(items) do
--		printyellow("item id ",item.id)
		local listitem = fields.UIList_Shop:AddListItem()
		local remainingNum, limitType = ShopManager.GetShopItemRemainingNumAndLimitType(item)
		local itemconfig = ItemManager.CreateItemBaseById(item.itemid.itemid, nil, remainingNum > 0 and remainingNum or 0)
		DisplayOneItem(listitem,item,itemconfig)
		EventHelper.SetClick(listitem, function()
			-- show item details 
			
			local buyFunc = function(params)
				local validate, info = CheckCmd.Check( { moduleid = cfg.cmd.ConfigId.MALL, cmdid = item.id, num = params.num, showsysteminfo = true })
				if validate then
					ShopManager.SendCCommand( { moduleid = cfg.cmd.ConfigId.MALL, cmdid = item.id, num = params.num })
				end
			end

			local params = {
				item = itemconfig,
				variableNum = true,
				--price = currency:GetNumber(),
				--priceType = currency:GetDetailType2(),
				price = item.cost.amount,
				priceType = item.cost.currencytype,
				buttons =
				{
					{ display = true, text = LocalString.ShopAlert_Buy, callFunc = buyFunc },
					{ display = false, text = "", callFunc = nil },
					{ display = false, text = "", callFunc = nil },
				}
			}
			ItemIntroduct.DisplayItem(params)
		end)
	end
end

local function hide()
end

local function refresh(params)
end

local function onmsg_SCommand(msg)
	if msg.cmdid then
		printyellow("onmsg_SCommand")
		UIManager.refresh("dlguimain")
	end
end

local function init(params)
	name, gameObject, fields = unpack(params)
	network.add_listeners({

		{"lx.gs.cmd.msg.SCommand",onmsg_SCommand},

	})
	EventHelper.SetClick(fields.UIButton_Close,function()
		UIManager.hidedialog(name)
	end)
end

return {
	init = init,
	hide = hide,
	show = show,
	refresh = refresh,
	destroy = destroy,
}