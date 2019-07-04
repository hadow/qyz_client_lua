local print         = print
local require       = require
local math          = math
local os            = os
local format        = string.format
local network       = require("network")
local gameevent     = require("gameevent")
local timeutils     = require("common.timeutils")
local UIManager     = require("uimanager")
local ItemEnum      = require("item.itemenum")
local ConfigManager = require("cfg.configmanager")
local PlayerRole    = require("character.playerrole")
local ItemManager   = require("item.itemmanager")
local PetManager    = require("character.pet.petmanager")
local BonusManager  = require("item.bonusmanager")
local BagManager    = require("character.bagmanager")
local CheckCmd      = require("common.checkcmd")
local login         = require("login")
local auth			= require "auth"

local MONTH_CARD_DAYS = 30

-- 苹果版本审核tab隐藏列表
local HiddenTabs = { }


--全局数据
-- 新手礼包
local g_NewPlayerGift
-- 每日签到
local g_SignInData
-- 连续登陆
local g_ContinueLoginData
-- 每日在线
local g_DailyOnlineData
-- 超值月卡
local g_MonthCardData
-- 成长计划
local g_GrowPlanData
-- 许愿
local g_WishData
-- 体力
local g_AddStrengthData
-- vip积分返还
local g_PayReturnData

-- 初始化全部福利数据
local function InitWelfareData()
	-- 新手礼包
	g_NewPlayerGift =
	{
		ReceivedDays = { },
		LoginDays    = 0,
		DayList		 = { },
	}
	-- 每日签到
	g_SignInData =
	{
		bSignedDays = { },
		-- TotalDays   = 0,
		bTodaySignedIn = false,
		-- AddSignTime = 0,
	}
	-- 连续登陆
	g_ContinueLoginData =
	{
		LoginDayNum   = 0,
		LeftGiftNum   = 0,
		bReceivedIds  = { },
	}
	-- 每日在线
	g_DailyOnlineData =
	{
		bReceivedGift      = { },
		TimeTypeList       = { },
		DailyOnlineSeconds = 0,
	}
	-- 超值月卡
	g_MonthCardData =
	{
		bBoughtCard  = false,
		LeftDayNum   = 0,
		ReceivedDays = { },
	}
	-- 成长计划
	g_GrowPlanData =
	{
		CurGrowPlanLevel  = 0,
		bReceivedDays = { },
		ChargeProductList = { },
		MaxGrowPlanLevel = 0,
	}

	-- 许愿
	g_WishData =
	{
		SelectedPet  = nil,
		UsedWishTime = 0,
	}

	-- 体力
	g_AddStrengthData =
	{
		bHasAteLunch  = false,
		bHasAteDinner = false,
	}
	-- vip积分返还
	g_PayReturnData =
	{
		bHasGotPayReturn = false,
		VipPointNum = 0,
		YuanBaoNum = 0,
		BindYuanBaoNum = 0,
	}
end
-- 与initdata缺少g_PayReturnData数据
-- g_PayReturnData数据不需要0点刷新
local function ResetWelfareData()
	-- 新手礼包
	g_NewPlayerGift =
	{
		ReceivedDays = { },
		LoginDays    = 0,
		DayList		 = { },
	}
	-- 每日签到
	g_SignInData =
	{
		bSignedDays = { },
		-- TotalDays   = 0,
		bTodaySignedIn = false,
		-- AddSignTime = 0,
	}
	-- 连续登陆
	g_ContinueLoginData =
	{
		LoginDayNum   = 0,
		LeftGiftNum   = 0,
		bReceivedIds  = { },
	}
	-- 每日在线
	g_DailyOnlineData =
	{
		bReceivedGift      = { },
		TimeTypeList       = { },
		DailyOnlineSeconds = 0,
	}
	-- 超值月卡
	g_MonthCardData =
	{
		bBoughtCard  = false,
		LeftDayNum   = 0,
		ReceivedDays = { },
	}
	-- 成长计划
	g_GrowPlanData =
	{
		CurGrowPlanLevel  = 0,
		bReceivedDays = { },
		ChargeProductList = { },
		MaxGrowPlanLevel = 0,
	}

	-- 许愿
	g_WishData =
	{
		SelectedPet     = nil,
		UsedWishTime    = 0,
	}

	-- 体力
	g_AddStrengthData =
	{
		bHasAteLunch  = false,
		bHasAteDinner = false,
	}
end

-- region msg
-- 新手礼包
local function OnMsg_SNewGift(msg)
    table.insert(g_NewPlayerGift.ReceivedDays, msg.newgiftid)
    -- 奖励内容飘字
    local bonusItems = BonusManager.GetItemsOfBonus( { bonustype = "cfg.bonus.BeginnerBonus", csvid = msg.newgiftid })
	UIManager.show("common.dlgdialogbox_itemshow",{ itemList = bonusItems })
	if UIManager.isshow("welfare.dlgwelfare") then
		UIManager.call("welfare.dlgwelfare", "ShowNewPlayerGift")
		-- 刷新红点提示
		UIManager.call("welfare.dlgwelfare", "RefreshRedDot")
	end
end

-- 每月签到
local function OnMsg_SSign(msg)
	--    if msg.signtype == cfg.bonus.SignType.ADD_SIGN then
	--        g_SignInData.AddSignTime = g_SignInData.AddSignTime + 1
	--    end
	g_SignInData.bTodaySignedIn = true
    g_SignInData.bSignedDays[msg.signdate] = true
    -- 奖励内容飘字
    local bonusItems = BonusManager.GetItemsOfServerBonus(msg.signgift)
	UIManager.show("common.dlgdialogbox_itemshow",{ itemList = bonusItems })
	if UIManager.isshow("welfare.dlgwelfare") then
		UIManager.call("welfare.dlgwelfare", "ShowSignInPage")
		-- 刷新红点提示
		UIManager.call("welfare.dlgwelfare", "RefreshRedDot")
	end
end

-- 连续登陆
local function OnMsg_SContinueLoginGift(msg)
	if Local.LogManager then
    	print("OnMsg_SContinueLoginGift")
    end
    g_ContinueLoginData.LeftGiftNum = msg.lefttimes
	g_ContinueLoginData.bReceivedIds[msg.boxid] = true
    local bonusItems = BonusManager.GetItemsOfServerBonus(msg.logingift)
	UIManager.show("common.dlgdialogbox_itemshow",{ itemList = bonusItems })

	if UIManager.isshow("welfare.dlgwelfare") then
		UIManager.call("welfare.dlgwelfare", "OnGetContinueLoginGift",msg)
		-- 刷新红点提示
		UIManager.call("welfare.dlgwelfare", "RefreshRedDot")
	end
end

-- 每日在线奖励
local function OnMsg_SGetOnlineGift(msg)
	local bonusItems = { }
    for timeType, bonus in pairs(msg.onlinegift) do
        g_DailyOnlineData.bReceivedGift[timeType] = true
        local items = BonusManager.GetItemsOfServerBonus(bonus)
        for i = 1, #items do
	        bonusItems[#bonusItems + 1] = items[i]
        end
    end
	UIManager.show("common.dlgdialogbox_itemshow",{ itemList = bonusItems })
	if UIManager.isshow("welfare.dlgwelfare") then
		UIManager.call("welfare.dlgwelfare", "ShowDailyOnlinePage")
		-- 刷新红点提示
		UIManager.call("welfare.dlgwelfare", "RefreshRedDot")
	end
end

-- 超值月卡奖励
local function OnMsg_SGetMonthCardGift(msg)
    table.insert(g_MonthCardData.ReceivedDays, msg.date)
    local bonusItems = BonusManager.GetItemsOfServerBonus(msg.monthcardgift)
	UIManager.show("common.dlgdialogbox_itemshow",{ itemList = bonusItems })

	if UIManager.isshow("vipcharge.tabmonthcard") then
		UIManager.call("vipcharge.tabmonthcard", "OnGetMonthCardGift",msg)
	end
end

-- 成长计划
local function OnMsg_SGetGrowPlanGift(msg)
	if msg.growplantype == g_GrowPlanData.CurGrowPlanLevel then
		g_GrowPlanData.bReceivedDays[msg.giftindx] = true
		local bonusItems = BonusManager.GetItemsOfBonus( { bonustype = "cfg.bonus.GrowPlan", csvid = msg.giftindx })
		UIManager.show("common.dlgdialogbox_itemshow",{ itemList = bonusItems })
		if UIManager.isshow("vipcharge.tabgrowplan") then
			UIManager.call("vipcharge.tabgrowplan","OnGetGrowPlanGift",msg)
		end
	end
end

-- 许愿礼物
local function OnMsg_SGetWishGift(msg)
    local wishPetCsvId = g_WishData.SelectedPet:GetConfigId()
	g_WishData.UsedWishTime = g_WishData.UsedWishTime + 1
    -- g_WishData.SelectedPet  = nil
    local bonusItems = BonusManager.GetItemsOfBonus( { bonustype = "cfg.bonus.Wish", csvid = wishPetCsvId })
	UIManager.show("common.dlgdialogbox_itemshow",{ itemList = bonusItems })

	if UIManager.isshow("welfare.dlgwelfare") then
		UIManager.call("welfare.dlgwelfare", "ShowWishPage")
		-- 刷新红点提示
		UIManager.call("welfare.dlgwelfare", "RefreshRedDot")
	end
end

-- 吃包子
local function OnMsg_SEatBaozi(msg)
	if msg.eattype == lx.gs.bonus.msg.CEatBaozi.EAT_LUNCH or
		msg.eattype == lx.gs.bonus.msg.CEatBaozi.RE_EAT_LUNCH then

		g_AddStrengthData.bHasAteLunch = true
	end

	if msg.eattype == lx.gs.bonus.msg.CEatBaozi.EAT_DINNER or
		msg.eattype == lx.gs.bonus.msg.CEatBaozi.RE_EAT_DINNER then

		g_AddStrengthData.bHasAteDinner = true
	end

	--UIManager.ShowSystemFlyText(format(LocalString.Welfare_AddStrength_GetStrength,msg.addtili))
	if UIManager.isshow("welfare.dlgwelfare") then
		UIManager.call("welfare.dlgwelfare", "ShowAddStrengthPage")
		-- 刷新红点提示
		UIManager.call("welfare.dlgwelfare", "RefreshRedDot")
	end
end

-- 登陆获取全部数据
local function OnMsg_SBonusInfo(msg)
    -- 1.新手礼包数据
    g_NewPlayerGift.ReceivedDays = msg.receivednewgift
    g_NewPlayerGift.LoginDays    = msg.totallogindays
	g_NewPlayerGift.DayList		 = { }
	local days = ConfigManager.getConfig("beginnerbonus")
	for day in pairs(days) do
		table.insert(g_NewPlayerGift.DayList,day)
	end
	table.sort(g_NewPlayerGift.DayList)
    -- 2.每月签到数据
    -- g_SignInData.TotalDays       = msg.totaldays
    -- g_SignInData.AddSignTime     = msg.addsigntimes
    -- 签到的天列表,初始化
    g_SignInData.bSignedDays     = { }
	g_SignInData.bTodaySignedIn = (msg.hastodaysign == 1) and true or false
	-- 30天一循环
    for day = 1, 30 do
        g_SignInData.bSignedDays[day] = false
    end
    for _, day in pairs(msg.signedlist) do
        g_SignInData.bSignedDays[day] = true
    end

    -- 3.连续登陆数据
    g_ContinueLoginData.LoginDayNum = msg.continuedays
    g_ContinueLoginData.LeftGiftNum = msg.lefttimes
	-- 初始化数据
	for boxId = 1,8 do
		g_ContinueLoginData.bReceivedIds[boxId] = false
	end

	for _,boxId in pairs(msg.receivedconlogingift) do
		g_ContinueLoginData.bReceivedIds[boxId] = true
	end

    -- 4.每日在线数据
    local onlineBonus = ConfigManager.getConfig("onlinetimebonus")
    -- 初始化
    g_DailyOnlineData.TimeTypeList = { }
    for timeType in pairs(onlineBonus) do
        g_DailyOnlineData.bReceivedGift[timeType] = false
        table.insert(g_DailyOnlineData.TimeTypeList, timeType)
    end
    for _, timeType in pairs(msg.receivedtype) do
        g_DailyOnlineData.bReceivedGift[timeType] = true
    end
    table.sort(g_DailyOnlineData.TimeTypeList)
    g_DailyOnlineData.DailyOnlineSeconds = math.floor(msg.dailyonlinetime / 1000)

    -- 超值月卡数据
    if msg.monthcardplayer == 1 then
        g_MonthCardData.bBoughtCard = true
    else
        g_MonthCardData.bBoughtCard = false
    end
    g_MonthCardData.LeftDayNum = msg.monthcardleftday
    g_MonthCardData.ReceivedDays = msg.dates

    -- 成长计划数据
    local planData = ConfigManager.getConfig("growplan")
    for day in pairs(planData) do
        -- 初始化
        g_GrowPlanData.bReceivedDays[day] = false
    end
    g_GrowPlanData.CurGrowPlanLevel = msg.buygrowplantype
	g_GrowPlanData.ChargeProductList = { }
	local chargeData = ConfigManager.getConfig("charge")
	for chargeId,data in pairs(chargeData) do
		if data.class == "cfg.pay.GrowPlan" then
			g_GrowPlanData.ChargeProductList[chargeId] = data
			g_GrowPlanData.MaxGrowPlanLevel = math.max(g_GrowPlanData.MaxGrowPlanLevel,data.growplantype)
		end
	end

	if g_GrowPlanData.CurGrowPlanLevel == cfg.pay.GrowPlanType.FIRSTTYPE then
		for _, day in pairs(msg.threegifts) do
			g_GrowPlanData.bReceivedDays[day] = true
		end
	elseif g_GrowPlanData.CurGrowPlanLevel == cfg.pay.GrowPlanType.SECONDTYPE then
		for _, day in pairs(msg.fivegifts) do
			g_GrowPlanData.bReceivedDays[day] = true
		end
	elseif g_GrowPlanData.CurGrowPlanLevel == cfg.pay.GrowPlanType.THIRDTYPE then
		for _, day in pairs(msg.sevengifts) do
			g_GrowPlanData.bReceivedDays[day] = true
		end
	end
    -- 许愿数据
    g_WishData.UsedWishTime = msg.wishtimes
	g_WishData.SelectedPet	= nil
	-- 吃包子数据初始化
	g_AddStrengthData.bHasAteLunch = (msg.iseatlunch == 1) and true or false
	g_AddStrengthData.bHasAteDinner = (msg.iseatdinner == 1) and true or false
	-- 用于24点刷新界面
	if UIManager.isshow("welfare.dlgwelfare") then
		 UIManager.refresh("welfare.dlgwelfare")
	end
end

local function OnMsg_SUseCode(msg)
    if msg.retcode == gnet.ActivationCodeErr.ERR_SUCCESS then
        local bonusItems = BonusManager.GetItemsOfServerBonus(msg.bonus)
		UIManager.show("common.dlgdialogbox_itemshow",{ itemList = bonusItems })
    else
        UIManager.ShowSingleAlertDlg(
            {
                title = LocalString.TipText,
                content = login.getErrMsg(msg.retcode),
                callBackFunc = function() end,
                buttonText = LocalString.SureText
            } )
    end
end

local function OnMsg_SBuyMonthCardNotify(msg)
	g_MonthCardData.bBoughtCard  = true
	g_MonthCardData.LeftDayNum   = msg.monthcardleftdays
	UIManager.refresh("vipcharge.tabmonthcard")
	-- 刷新红点
	if UIManager.isshow("dlgdialog") then
		UIManager.call("dlgdialog","RefreshRedDot","vipcharge.dlgrecharge")
	end
end

local function OnMsg_SBuyGrowPlanNotify(msg)
	g_GrowPlanData.CurGrowPlanLevel = msg.growplantype
	g_GrowPlanData.bReceivedDays = { }
	local planData = ConfigManager.getConfig("growplan")
	-- 初始化数据
    for day in pairs(planData) do
        g_GrowPlanData.bReceivedDays[day] = false
    end
	UIManager.refresh("vipcharge.tabgrowplan")
end

local function OnMsg_SDayOver(msg)
	-- 清空福利数据
	ResetWelfareData()
	-- 重新获取数据
	network.create_and_send("lx.gs.bonus.msg.CBonusInfo")
end

local function OnMsg_SPayReturnInfo(msg)
	g_PayReturnData.bHasGotPayReturn = (msg.hasgotpayreturn == 1) and true or false
	g_PayReturnData.VipPointNum = msg.vipexp
	g_PayReturnData.YuanBaoNum = msg.yuanbao
	g_PayReturnData.BindYuanBaoNum = msg.bindyuanbao
end

local function OnMsg_SGetPayReturn()
	g_PayReturnData.bHasGotPayReturn = true
	UIManager.ShowSystemFlyText(format(LocalString.FlyText_Reward,g_PayReturnData.VipPointNum,LocalString.Welfare_RechargeReturn_VipPoints))
	if UIManager.isshow("welfare.dlgwelfare") then
		UIManager.call("welfare.dlgwelfare", "OnGetPayReturn")
	end
end
-- endregion msg

-- 获取新手礼包数据
local function GetNewPlayerGiftData()
    return g_NewPlayerGift
end

-- 获取每月签到数据
local function GetSignInData()
    return g_SignInData
end

-- 获取连续登陆数据
local function GetContinueLoginData()
    return g_ContinueLoginData
end

-- 获取每日在线数据
local function GetDailyOnlineData()
    return g_DailyOnlineData
end

-- 获取超值月卡数据

local function GetMonthCardData()
    return g_MonthCardData
end

-- 获取成长计划数据
local function GetGrowPlanData()
    return g_GrowPlanData
end
-- 获取许愿数据
local function GetWishData()
    return g_WishData
end
-- 获取体力相关数据
local function GetAddStrengthData()
	return g_AddStrengthData
end

local function GetLoginDays()
	return g_NewPlayerGift.LoginDays
end
-- 是否已获取积分返还
local function GetPayReturnData()
	return g_PayReturnData
end

local function GetHiddenTabs()
	return HiddenTabs
end

local function IsAllGrowPlansReceived()
	if g_GrowPlanData.CurGrowPlanLevel == g_GrowPlanData.MaxGrowPlanLevel then
		local daycount = 0
		local startDayIndex = 1
		for chargeId, chargeData in pairs(g_GrowPlanData.ChargeProductList) do
			if chargeData.growplantype == g_GrowPlanData.CurGrowPlanLevel then
				daycount = chargeData.logindaynum
				startDayIndex = chargeData.startdayindex
			end
		end

		local bAllReceived = true
		for day = 1,daycount do
			if g_GrowPlanData.bReceivedDays[startDayIndex+day-1] == false then
				bAllReceived = false
				break
			end
		end
		return bAllReceived
	end
	return false
end

-- 红点提示
-- 新手礼包
local function UnRead_NewPlayerGiftPage()
    --有未领取的奖励
    local bReceivedDays = { }
    for _, day in pairs(g_NewPlayerGift.ReceivedDays) do
        bReceivedDays[day] = true
    end
    for _, day in ipairs(g_NewPlayerGift.DayList) do
		if day <= g_NewPlayerGift.LoginDays and (not bReceivedDays[day]) then
			return true
		end
    end
    return false
end

-- 每月签到
local function UnRead_SignInPage()
    -- 未签到
    return (not g_SignInData.bTodaySignedIn)
end
-- 连续登陆
local function UnRead_ContinueLoginPage()
    if g_ContinueLoginData.LeftGiftNum > 0 then
        return true
    end
    return false
end

-- 每日在线
local function UnRead_DailyOnlinePage()
    -- 有未领取的奖励
    for _,timeType in ipairs(g_DailyOnlineData.TimeTypeList) do
        if (not g_DailyOnlineData.bReceivedGift[timeType]) and (g_DailyOnlineData.DailyOnlineSeconds >= timeType) then
            return true
        end
    end
    return false
end
-- 超值月卡
local function UnRead_MonthCard()
	if g_MonthCardData.bBoughtCard and g_MonthCardData.LeftDayNum > 0 then
		local today = 1
		if g_MonthCardData.LeftDayNum > 0 then
			if math.mod(g_MonthCardData.LeftDayNum, MONTH_CARD_DAYS) == 0 then
				today = 1
			else
				today = MONTH_CARD_DAYS - math.mod(g_MonthCardData.LeftDayNum, MONTH_CARD_DAYS) + 1
			end
		end
		-- 初始化数据
		local bReceivedDays = {}
		for day = 1, MONTH_CARD_DAYS do
			bReceivedDays[day] = false
		end
		for _, day in pairs(g_MonthCardData.ReceivedDays) do
			bReceivedDays[day] = true
		end

		if (not bReceivedDays[today]) then
			return true
		else
			return false
		end
	else
		return false
	end
end
-- 成长计划
local function UnRead_GrowPlan()
	local daycount = 0
	local startDayIndex = 1
	for chargeId, chargeData in pairs(g_GrowPlanData.ChargeProductList) do
		if chargeData.growplantype == g_GrowPlanData.CurGrowPlanLevel then
			daycount = chargeData.totalday
			startDayIndex = chargeData.startdayindex
		end
	end

    local growPlanConfigData = ConfigManager.getConfig("growplan")
	for day = 1,daycount do
        local bValidated = CheckCmd.CheckData({ data = (growPlanConfigData[startDayIndex+day-1]).requirelvl,showsysteminfo = false, num = 1 })
		if bValidated and (not g_GrowPlanData.bReceivedDays[startDayIndex+day-1]) then
			return true
		end
	end
	return false
end

-- 许愿
local function UnRead_WishPage()
    -- 1.可以许愿 2.许愿后奖励未领取
    local bonusConfig = ConfigManager.getConfig("bonusconfig")
    local vipWishLimitNum = bonusConfig.viptimes[PlayerRole:Instance().m_VipLevel + 1]
	local leftWishPropNum = BagManager.GetItemNumById(bonusConfig.vowitem)
	if (g_WishData.UsedWishTime < vipWishLimitNum and leftWishPropNum > 0) then
	    return true
	end
    return false
end
-- 吃包子
local function UnRead_AddStrengthPage()
	local timeNow = timeutils.TimeNow()
	local nowSecs = timeutils.getSeconds({days = 0,hours = timeNow.hour ,minutes = timeNow.min,seconds = timeNow.sec})
	local lunchData = ConfigManager.getConfigData("baozi",cfg.bonus.MealType.LUNCH)
	local dinnerData = ConfigManager.getConfigData("baozi",cfg.bonus.MealType.DINNER)

	local lunchStartSecs = timeutils.getSeconds({ days = 0,hours = lunchData.starthour ,minutes = lunchData.startminute,seconds = 0})
	local dinnerStartSecs = timeutils.getSeconds({ days = 0,hours = dinnerData.starthour ,minutes = dinnerData.startminute,seconds = 0})

	-- 没吃午餐或者没有补餐
	if nowSecs >= lunchStartSecs and (not g_AddStrengthData.bHasAteLunch) then
		return true
	end
	-- 没吃晚餐或者没有补餐
	if nowSecs >= dinnerStartSecs and (not g_AddStrengthData.bHasAteDinner) then
		return true
	end
    return false
end

-- 兑换码
local function UnRead_ExchangeID()
	return false
end
-- 封测充值返还界面
local function UnRead_RechargeReturn()
	return false
end

local UnReadPageList =
{
    [1] = UnRead_NewPlayerGiftPage,
    [2] = UnRead_SignInPage,
    [3] = UnRead_ContinueLoginPage,
    [4] = UnRead_DailyOnlinePage,
    [5] = UnRead_WishPage,
    [6] = UnRead_AddStrengthPage,
	[7] = UnRead_ExchangeID,
	[8] = UnRead_RechargeReturn,
}

-- 福利页签的单独红点提示函数
local function UnReadSingle()
	for pageIndex = 1,#UnReadPageList do
		local bUnRead = false
		if not HiddenTabs[i] then
			bUnRead = UnReadPageList[pageIndex]()
		end
		if bUnRead then return true end
	end
	return false
end

-- dlguimain红点提示函数
local function UnRead()
    if UnReadSingle() then
        return true
    end

    return false
end

local function second_update()
    -- 每日在线
    g_DailyOnlineData.DailyOnlineSeconds = g_DailyOnlineData.DailyOnlineSeconds + 1

end


local function Release()
	InitWelfareData()
end

local function OnLogout()
    Release()
end

local function init()

    gameevent.evt_second_update:add(second_update)
    gameevent.evt_system_message:add("logout", OnLogout)
	InitWelfareData()
    network.add_listeners( {
        { "lx.gs.bonus.msg.SNewGift", OnMsg_SNewGift },
        { "lx.gs.bonus.msg.SSign", OnMsg_SSign },
        { "lx.gs.bonus.msg.SContinueLoginGift", OnMsg_SContinueLoginGift },
        { "lx.gs.bonus.msg.SGetOnlineGift", OnMsg_SGetOnlineGift },
        { "lx.gs.bonus.msg.SGetMonthCardGift", OnMsg_SGetMonthCardGift },
        { "lx.gs.bonus.msg.SGetGrwoPlanGift", OnMsg_SGetGrowPlanGift },
        { "lx.gs.bonus.msg.SGetWishGift", OnMsg_SGetWishGift },
        { "lx.gs.bonus.msg.SBonusInfo", OnMsg_SBonusInfo },
        { "lx.gs.bonus.msg.SEatBaozi", OnMsg_SEatBaozi },
		{ "lx.gs.pay.SBuyMonthCardNotify", OnMsg_SBuyMonthCardNotify},
		{ "lx.gs.pay.SBuyGrowPlanNotify", OnMsg_SBuyGrowPlanNotify},
        { "lx.gs.role.msg.SUseCode", OnMsg_SUseCode },
		{ "lx.gs.role.msg.SDayOver", OnMsg_SDayOver },
		{ "lx.gs.pay.SPayReturnInfo", OnMsg_SPayReturnInfo },
		{ "lx.gs.pay.SGetPayReturn", OnMsg_SGetPayReturn },
    } )
	if Local.HideVip then
		-- 隐藏兑换码和积分返还界面
		HiddenTabs = { [7] = true,[8] = true,}
	end


end

return {

    init                   = init,
    UnRead                 = UnRead,
    UnReadPageList         = UnReadPageList,
    GetNewPlayerGiftData   = GetNewPlayerGiftData,
	IsAllGrowPlansReceived = IsAllGrowPlansReceived,
    GetSignInData          = GetSignInData,
    GetContinueLoginData   = GetContinueLoginData,
    GetDailyOnlineData     = GetDailyOnlineData,
    GetMonthCardData       = GetMonthCardData,
    GetGrowPlanData        = GetGrowPlanData,
    GetWishData            = GetWishData,
	GetAddStrengthData	   = GetAddStrengthData,
    GetLoginDays           = GetLoginDays,
    Release                = Release,
    UnReadSingle           = UnReadSingle,
	UnRead_GrowPlan		   = UnRead_GrowPlan,
	UnRead_MonthCard	   = UnRead_MonthCard,
	GetPayReturnData	   = GetPayReturnData,
	GetHiddenTabs		   = GetHiddenTabs,
}
