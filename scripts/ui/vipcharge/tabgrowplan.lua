local require        = require
local unpack         = unpack
local print          = print
local format		 = string.format
local UIManager      = require("uimanager")
local network        = require("network")
local BonusManager   = require("item.bonusmanager")
local ItemIntroduct  = require("item.itemintroduction")
local ItemEnum       = require("item.itemenum")
local CheckCmd       = require("common.checkcmd")
local ConfigManager  = require("cfg.configmanager")
local WelfareManager = require("ui.welfare.welfaremanager")
local VipChargeManager = require ("ui.vipcharge.vipchargemanager")
local EventHelper    = UIEventListenerHelper

local gameObject
local name
local fields

local function InitGrowPlanList(planLevel)
    if fields.UIList_GrowPlan.Count == 0 then
		local growPlanData = WelfareManager.GetGrowPlanData()
        local growPlanConfigData = ConfigManager.getConfig("growplan")
		--购买当前成长计划时候登陆的天数
		local startDayIndex = 1
		local daycount = 0
		for chargeId, chargeData in pairs(growPlanData.ChargeProductList) do
			if chargeData.growplantype == planLevel then 
				daycount = chargeData.totalday
				startDayIndex = chargeData.startdayindex
			end
		end

		local bAllReceived = true
		for day = 1,daycount do
			if growPlanData.bReceivedDays[startDayIndex + day - 1] == false then
				bAllReceived = false
				break
			end
		end
		if bAllReceived then 
			planLevel = planLevel + 1
			if planLevel <= growPlanData.MaxGrowPlanLevel then 
				
				for chargeId, chargeData in pairs(growPlanData.ChargeProductList) do
					if chargeData.growplantype == planLevel then 
						daycount = chargeData.totalday
						startDayIndex = chargeData.startdayindex
						break
					end
				end
			else 
				-- 全部档成长计划均领取完毕,依然显示最后的成长
				-- daycount = 0
				planLevel = growPlanData.MaxGrowPlanLevel
			end
		end
		-- 初始化成长计划标题
		if planLevel <= growPlanData.MaxGrowPlanLevel then
			fields.UILabel_GrowPlanStatus.text = LocalString.Welfare_GrowPlan_PlanNames[planLevel]
		end

		for day = 1,daycount do
			local listItem = fields.UIList_GrowPlan:AddListItem()

			-- child list
			local items = BonusManager.GetItemsOfBonus( { bonustype = "cfg.bonus.GrowPlan", csvid = (startDayIndex + day - 1) })
            local curGrowPlanConfigData = growPlanConfigData[startDayIndex + day - 1]
			-- 初始化数据
			local dayGiftList = listItem.Controls["UIList_GrowPlanDayGifts"]
			for i = 1, #items do
				local dayGiftListItem = dayGiftList:AddListItem()
				dayGiftListItem:SetIconTexture(items[i]:GetTextureName())
				dayGiftListItem.Controls["UILabel_Amount"].text = items[i]:GetNumber()
				dayGiftListItem.Controls["UISprite_Quality"].color = colorutil.GetQualityColor(items[i]:GetQuality())
				dayGiftListItem.Controls["UISprite_Fragment"].gameObject:SetActive(items[i]:GetBaseType() == ItemEnum.ItemBaseType.Fragment)
				dayGiftListItem.Controls["UISprite_Get"].gameObject:SetActive(false)
				dayGiftListItem.Data = items[i]
			end

			listItem:SetText("UILabel_GrowPlanLevel", format(LocalString.Welfare_GrowPlan_RequireLevel, curGrowPlanConfigData.requirelvl.level))
			local buttonReceive = listItem.Controls["UIButton_Receive"]

            local bValidated = CheckCmd.CheckData({ data = curGrowPlanConfigData.requirelvl,showsysteminfo = false, num = 1 })
			-- 已经购买当前级别成长计划
			if growPlanData.CurGrowPlanLevel == planLevel then
				-- 领取过，关闭领取按钮
				if growPlanData.bReceivedDays[startDayIndex + day - 1] then
					-- UITools.SetButtonEnabled(buttonReceive,false)
					buttonReceive.isEnabled = false
					listItem:SetText("UILabel_Receive", LocalString.Welfare_ButtonStatus_HasReceived)
					-- 设置为已经领取状态
					for i = 1,dayGiftList.Count do
						local dayGiftListItem = dayGiftList:GetItemByIndex(i-1)
						dayGiftListItem.Controls["UISprite_Get"].gameObject:SetActive(true)
					end
				else
					-- 没领取过
					listItem:SetText("UILabel_Receive", LocalString.Welfare_ButtonStatus_NotReceived)
					-- 已购买且达到领取等级要求
					--if bValidated then 
						buttonReceive.isEnabled = true
					--else
						--buttonReceive.isEnabled = false
					--end
				end
			else
				-- 未购买当前级别成长计划
				listItem:SetText("UILabel_Receive", LocalString.Welfare_ButtonStatus_NotReceived)
				buttonReceive.isEnabled = false
			end

			EventHelper.SetClick(buttonReceive, function()
				local planLevel = (WelfareManager.GetGrowPlanData()).CurGrowPlanLevel
                local bValidated = CheckCmd.CheckData({ data = curGrowPlanConfigData.requirelvl,showsysteminfo = true, num = 1 })

				if planLevel ~= 0 and bValidated then 
					local msg = lx.gs.bonus.msg.CGetGrowPlanGift( { growplantype = planLevel,giftindx = (startDayIndex + day - 1) })
					network.send(msg)
				end
			end )

			EventHelper.SetListClick(dayGiftList, function(listItem)
				ItemIntroduct.DisplayBriefItem( {item = listItem.Data} )
			end )
		end
		return bAllReceived
	end
end

-- 成长计划界面
local function RefreshGrowPlan()
    local growPlanData = WelfareManager.GetGrowPlanData()
	local planLevel = growPlanData.CurGrowPlanLevel
	local bonusConfig = ConfigManager.getConfig("bonusconfig")

	fields.UIList_GrowPlan:Clear()
	local bAllReceived = InitGrowPlanList(planLevel)

	if bAllReceived then 
		planLevel = planLevel + 1
		fields.UIButton_BuyGrowPlan.gameObject:SetActive(true)
	else 
		fields.UIButton_BuyGrowPlan.gameObject:SetActive(false)
	end
	local chargeData = nil
	for chargeId, data in pairs(growPlanData.ChargeProductList) do
		if data.growplantype == planLevel then 
			chargeData = data
			break
		end
	end
	--  local yuanBaoNum = 0
	--  local bindYuanBaoNum = 0
	--  local limitLevel = bonusConfig.growplanmaxlvl[1]
	if chargeData then
		--  limitLevel = bonusConfig.growplanmaxlvl[chargeData.growplantype] 
		fields.UIButton_BuyGrowPlan.isEnabled = true
		--  local growPlanData = ConfigManager.getConfig("growplan")
        --	for day = chargeData.startdayindex,(chargeData.totalday + chargeData.startdayindex -1) do 
        --		local bonusItems = BonusManager.GetItemsOfSingleBonus(growPlanData[day].bonuslist)
        --		for _,item in ipairs(bonusItems) do
        --			if item:GetDetailType2() == cfg.currency.CurrencyType.YuanBao then 
        --				yuanBaoNum = yuanBaoNum + item:GetNumber()
        --			end
        --			if item:GetDetailType2() == cfg.currency.CurrencyType.BindYuanBao then 
        --				bindYuanBaoNum = bindYuanBaoNum + item:GetNumber()
        --			end
        --		end
        --	end
	else
		--全部档位成长计划购买完毕
		fields.UIButton_BuyGrowPlan.isEnabled = false
		
	end
	
	EventHelper.SetClick(fields.UIButton_BuyGrowPlan, function()
		if chargeData then 
            local params = { }
            params.title = LocalString.Welfare_GrowPlan_Tips
			params.content = LocalString.Welfare_GrowPlan_Content
            params.callBackFunc = function() 
				if chargeData then 
                    VipChargeManager.SendCGetApporder(chargeData.chargeid)
				end
			end
            params.buttonText = LocalString.Welfare_GrowPlan_Buy
            UIManager.ShowSingleAlertDlg(params)
		end
    end )
end

local function OnGetGrowPlanGift(params)
    local growPlanData = WelfareManager.GetGrowPlanData()
	if growPlanData.CurGrowPlanLevel == params.growplantype then
		local totalDayCount = 0
		local startDayIndex = 1
		for chargeId, chargeData in pairs(growPlanData.ChargeProductList) do
			if chargeData.growplantype == growPlanData.CurGrowPlanLevel then 
				totalDayCount = chargeData.totalday
				startDayIndex = chargeData.startdayindex
			end
		end 

        local listItem = fields.UIList_GrowPlan:GetItemByIndex(params.giftindx - startDayIndex)
        local buttonReceive = listItem.Controls["UIButton_Receive"]
        -- UITools.SetButtonEnabled(buttonReceive,false)
		buttonReceive.isEnabled = false
		local dayGiftList = listItem.Controls["UIList_GrowPlanDayGifts"]
						
		for i = 1,dayGiftList.Count do
			local dayGiftListItem = dayGiftList:GetItemByIndex(i-1)
			dayGiftListItem.Controls["UISprite_Get"].gameObject:SetActive(true)
		end
        listItem:SetText("UILabel_Receive", LocalString.Welfare_ButtonStatus_HasReceived)

		local bAllReceived = true
		for day = 1,totalDayCount do
			if growPlanData.bReceivedDays[startDayIndex + day - 1] == false then
				bAllReceived = false
				break
			end
		end
		if bAllReceived then 
			if growPlanData.CurGrowPlanLevel < growPlanData.MaxGrowPlanLevel then
				RefreshGrowPlan()
			end 
		end
		-- 刷新红点
		if UIManager.isshow("dlgdialog") then 
			UIManager.call("dlgdialog","RefreshRedDot","vipcharge.dlgrecharge")
		end
	end

end

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
	--print(name, "refresh")
	RefreshGrowPlan()
	-- 刷新红点
	if UIManager.isshow("dlgdialog") then 
		UIManager.call("dlgdialog","RefreshRedDot","vipcharge.dlgrecharge")
	end
end

local function update()
	--print(name, "update")
end

local function uishowtype()
    return UIShowType.Refresh
end

local function init(params)
  name, gameObject, fields = unpack(params)

end

return {
  init              = init,
  show              = show,
  hide              = hide,
  update            = update,
  destroy           = destroy,
  refresh           = refresh,
  uishowtype        = uishowtype,
  OnGetGrowPlanGift = OnGetGrowPlanGift,
}
