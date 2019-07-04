local require          = require
local unpack           = unpack
local print            = print
local format           = string.format
local UIManager        = require("uimanager")
local network          = require("network")
local BonusManager     = require("item.bonusmanager")
local ItemManager      = require("item.itemmanager")
local ItemIntroduct    = require("item.itemintroduction")
local ItemEnum         = require("item.itemenum")
local ConfigManager    = require("cfg.configmanager")
local WelfareManager   = require("ui.welfare.welfaremanager")
local EventHelper      = UIEventListenerHelper

local gameObject
local name
local fields

local MONTH_CARD_DAYS = 30


local function InitMonthCardList()
	if fields.UIList_MonthCard.Count == 0 then
		for day = 1, MONTH_CARD_DAYS do
			-- 365天，待定
			local items = BonusManager.GetItemsOfBonus( { bonustype = "cfg.bonus.MonthlyCard", csvid = day })
			local listItem = fields.UIList_MonthCard:AddListItem()
			listItem:SetText("UILabel_MonthCard_DayCount", format(LocalString.Welfare_Day, day))
			listItem.Controls["UISprite_Select"].gameObject:SetActive(false)
			listItem:SetIconTexture(items[1]:GetTextureName())
			listItem.Controls["UISprite_Quality"].color = colorutil.GetQualityColor(items[1]:GetQuality())
			listItem.Controls["UISprite_Fragment"].gameObject:SetActive(items[1]:GetBaseType() == ItemEnum.ItemBaseType.Fragment)
			listItem.Controls["UILabel_Amount"].text = items[1]:GetNumber()
			listItem.Data = items[1]
		end

		EventHelper.SetListClick(fields.UIList_MonthCard, function(listItem)
			ItemIntroduct.DisplayBriefItem( { item = listItem.Data })
		end )
	end
end

local function RefreshMonthCard()

	local monthCardData = WelfareManager.GetMonthCardData()
	local bReceivedDays = { }
	for day = 1, MONTH_CARD_DAYS do
		bReceivedDays[day] = false
	end

	-- 标注已领取奖励的天
	for _, day in pairs(monthCardData.ReceivedDays) do
		bReceivedDays[day] = true
		local listItem = fields.UIList_MonthCard:GetItemByIndex(day - 1)
		listItem.Controls["UISprite_Select"].gameObject:SetActive(true)
	end

	local today = 1
	if monthCardData.LeftDayNum > 0 then
		if math.mod(monthCardData.LeftDayNum, MONTH_CARD_DAYS) == 0 then
			today = 1
		else
			today = MONTH_CARD_DAYS - math.mod(monthCardData.LeftDayNum, MONTH_CARD_DAYS) + 1
		end
	end
	-- 剩余天数
	fields.UILabel_MonthCard_LeftDays.text = monthCardData.LeftDayNum
	-- 奖励内容
	local items = BonusManager.GetItemsOfBonus( { bonustype = "cfg.bonus.MonthlyCard", csvid = today })
	fields.UITexture_DayGift_Icon:SetIconTexture(items[2]:GetTextureName())
	fields.UISprite_DayGift_Quality.color = colorutil.GetQualityColor(items[2]:GetQuality())
	fields.UILabel_DayGift_Amount.text = items[2]:GetNumber()
	-- 标题
	fields.UILabel_MonthCard_Title.text = format(LocalString.Welfare_MonthCard_Title, MONTH_CARD_DAYS, MONTH_CARD_DAYS *(items[2]:GetNumber()))

	if monthCardData.bBoughtCard then
		-- 月卡用户
		if bReceivedDays[today] then
			-- UITools.SetButtonEnabled(fields.UIButton_Receive ,false)
			fields.UIButton_Receive.isEnabled = false
			fields.UIGroup_uifx_kuang01.gameObject:SetActive(false)
			fields.UILabel_Receive.text = LocalString.Welfare_ButtonStatus_HasReceived
		else
			-- UITools.SetButtonEnabled(fields.UIButton_Receive ,true)
			fields.UIButton_Receive.isEnabled = true
			fields.UIGroup_uifx_kuang01.gameObject:SetActive(true)
			fields.UILabel_Receive.text = LocalString.Welfare_ButtonStatus_NotReceived
		end
		fields.UILabel_Renewal.text = LocalString.Welfare_MonthCard_Button_Renewal

		EventHelper.SetClick(fields.UIButton_Renewal, function()
			UIManager.ShowSingleAlertDlg(
			{
				title = LocalString.Welfare_MonthCard_Tip_Renewal,
				content = LocalString.Welfare_MonthCard_Content,
				-- 调用续期界
				callBackFunc = function()
					UIManager.hidedialog("vipcharge.dlgrecharge")
					local VipchargeManager = require "ui.vipcharge.vipchargemanager"
					VipchargeManager.ShowVipChargeDialog()
				end,
				buttonText = LocalString.Welfare_MonthCard_Tip_Renewal
			} )
		end )
	else
		-- 非月卡用户
		-- UITools.SetButtonEnabled(fields.UIButton_Receive ,false)
		fields.UIButton_Receive.isEnabled = false
		fields.UIGroup_uifx_kuang01.gameObject:SetActive(false)
		fields.UILabel_Receive.text = LocalString.Welfare_ButtonStatus_NotReceived
		fields.UILabel_Renewal.text = LocalString.Welfare_MonthCard_Button_Recharge

		EventHelper.SetClick(fields.UIButton_Renewal, function()
			UIManager.ShowSingleAlertDlg(
			{
				title = LocalString.Welfare_MonthCard_Tip_BuyMonthCard,
				content = LocalString.Welfare_MonthCard_Content,
				-- 调用充值界面
				callBackFunc = function()
					UIManager.hidedialog("vipcharge.dlgrecharge")
					local VipchargeManager = require "ui.vipcharge.vipchargemanager"
					VipchargeManager.ShowVipChargeDialog()
				end,
				buttonText = LocalString.Welfare_MonthCard_Buy
			} )
		end )
	end

	EventHelper.SetClick(fields.UIButton_Receive, function()

		if monthCardData.LeftDayNum > 0 and(not bReceivedDays[today]) then
			local msg = lx.gs.bonus.msg.CGetMonthCardGift( { date = today })
			network.send(msg)
		end
	end )

	EventHelper.SetClick(fields.UIButton_DayGiftBox, function()
		ItemIntroduct.DisplayBriefItem( { item = items[2] })
	end )

end

local function OnGetMonthCardGift(params)
	local listItem = fields.UIList_MonthCard:GetItemByIndex(params.date - 1)
	listItem.Controls["UISprite_Select"].gameObject:SetActive(true)
	-- UITools.SetButtonEnabled(fields.UIButton_Receive,false)
	fields.UIButton_Receive.isEnabled = false
	fields.UIGroup_uifx_kuang01.gameObject:SetActive(false)
	fields.UILabel_Receive.text = LocalString.Welfare_ButtonStatus_HasReceived
	-- 刷新红点
	if UIManager.isshow("dlgdialog") then 
		UIManager.call("dlgdialog","RefreshRedDot","vipcharge.dlgrecharge")
	end
end

local function destroy()
	-- print(name, "destroy")
end

local function show(params)
	-- print(name, "show")
end

local function hide()
	-- print(name, "hide")
end

local function refresh(params)
	-- print(name, "refresh")
	RefreshMonthCard()
	-- 刷新红点
	if UIManager.isshow("dlgdialog") then 
		UIManager.call("dlgdialog","RefreshRedDot","vipcharge.dlgrecharge")
	end
end

local function update()
	-- print(name, "update")
end

local function uishowtype()
	return UIShowType.Refresh
end

local function init(params)
	name, gameObject, fields = unpack(params)
	InitMonthCardList()
end

return {
	init               = init,
	show               = show,
	hide               = hide,
	update             = update,
	destroy            = destroy,
	refresh            = refresh,
	uishowtype         = uishowtype,
	OnGetMonthCardGift = OnGetMonthCardGift,
}

