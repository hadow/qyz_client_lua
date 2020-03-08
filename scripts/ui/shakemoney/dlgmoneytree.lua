local unpack = unpack
local string = string
local EventHelper = UIEventListenerHelper
local ConfigManager = require("cfg.configmanager")
local PlayerRole = require "character.playerrole"
local LimitManager = require "limittimemanager"
local VipChargeManager = require"ui.vipcharge.vipchargemanager"
local UIManager = require "uimanager"
local NetWork = require "network"
local moneytreemanager = require "ui.shakemoney.moneytreemanager"

local name
local gameObject
local fields
--local receinexunibi = 0 
--local criticalnum = 0

local function hide(name)
end

local function ShowReminder1(dlgfields) --重置次数用完并且不满级
	dlgfields.UIGroup_Content_Three.gameObject:SetActive(false)
	dlgfields.UIGroup_TextWarp.gameObject:SetActive(false)
	dlgfields.UIGroup_Compare.gameObject:SetActive(false)
	dlgfields.UIGroup_TextWarp2.gameObject:SetActive(false)
	dlgfields.UIGroup_Button_1.gameObject:SetActive(false)
	dlgfields.UIGroup_Button_2.gameObject:SetActive(true)
	dlgfields.UIGroup_Resource.gameObject:SetActive(false)
	dlgfields.UIGroup_Reminder_Full.gameObject:SetActive(true)
	dlgfields.UIGroup_ItemUse.gameObject:SetActive(false)
	dlgfields.UILabel_Content_Single2.gameObject:SetActive(false)
	dlgfields.UILabel_Content_Single3.gameObject:SetActive(false)
	dlgfields.UILabel_Title.text           = LocalString.TipText
	local str1 
	if Local.HideVip then str1 = "" else str1 = LocalString.ShakeMoneyTree_NoticeOne_VipTip end 
	dlgfields.UILabel_Content_Single1.text = LocalString.ShakeMoneyTree_NoticeOne ..str1
	dlgfields.UILabel_Return.text          = LocalString.SureText
	dlgfields.UILabel_Sure.text            = LocalString.CancelText
	EventHelper.SetClick(dlgfields.UIButton_Return,function ()
		VipChargeManager.ShowVipChargeDialog()
		UIManager.hide(name)
		UIManager.hide("common.dlgdialogbox_common")

	end)

	EventHelper.SetClick(dlgfields.UIButton_Sure,function ()

		UIManager.hide("common.dlgdialogbox_common")
	end)
	
end

local function ShowReminder2(dlgfields) --重置次数用完并且满级（极端情况)
	dlgfields.UIGroup_Content_Three.gameObject:SetActive(false)
	dlgfields.UIGroup_TextWarp.gameObject:SetActive(false)
	dlgfields.UIGroup_Compare.gameObject:SetActive(false)
	dlgfields.UIGroup_TextWarp2.gameObject:SetActive(false)
	dlgfields.UIGroup_Button_1.gameObject:SetActive(false)
	dlgfields.UIGroup_Button_2.gameObject:SetActive(true)
	dlgfields.UIGroup_Resource.gameObject:SetActive(false)
	dlgfields.UIGroup_Reminder_Full.gameObject:SetActive(true)
	dlgfields.UIGroup_ItemUse.gameObject:SetActive(false)
	dlgfields.UILabel_Content_Single2.gameObject:SetActive(false)
	dlgfields.UILabel_Content_Single3.gameObject:SetActive(false)
	dlgfields.UILabel_Title.text           = LocalString.TipText
	dlgfields.UILabel_Content_Single1.text = LocalString.ShakeMoneyTree_NoticeTwo
	dlgfields.UILabel_Return.text          = LocalString.SureText
	dlgfields.UILabel_Sure.text            = LocalString.CancelText
	EventHelper.SetClick(dlgfields.UIButton_Return,function ()
		UIManager.hide("common.dlgdialogbox_common")

	end)

	EventHelper.SetClick(dlgfields.UIButton_Sure,function ()
		UIManager.hide("common.dlgdialogbox_common")
	end)
	
end


local function RefreshTime()

	fields.UILabel_Times.text = (moneytreemanager.GetMaxBuyTime()- moneytreemanager.GetShakeTime()).."/"..moneytreemanager.GetMaxBuyTime()
end

local function RefreshDiamond()
	fields.UILabel_CostIngot.text = moneytreemanager.GetYuanBao(moneytreemanager.GetShakeTime())
	fields.UILabel_GetMoney.text = 	moneytreemanager.GetJinBi(moneytreemanager.GetShakeTime())
end

local function RefreshReceiveXunNiBiAndCriticalNum(params)
	
	if params.criticalnum == 0 then
		fields.UILabel_Critical.gameObject:SetActive(false)
	else
		fields.UILabel_Critical.gameObject:SetActive(true)
		fields.UILabel_Critical.text = string.format(LocalString.ShakeMoneyTree_CriticalNum,params.criticalnum)
	end

	fields.UILabel_GetMoneyEffect.text = string.format(LocalString.ShakeMoneyTree_GetMoney,params.receinexunibi)
end





local function SetMoneyTreeCoinEffect(b)
	local uiplaytweens = fields.UIButton_Buy.gameObject:GetComponents(UIPlayTween)
	for i = 1 , uiplaytweens.Length do
		if uiplaytweens[i].tweenTarget.name == "Tween_TreeShining" then
			uiplaytweens[i].enabled = b
		elseif  uiplaytweens[i].tweenTarget.name == "Tween_GetCoins" then
			uiplaytweens[i].enabled = b
		end 
	end
	fields.UIGroup_UIPartical.gameObject:SetActive(b)
end

local function IsNotEnoughYuanBao()
	if PlayerRole:Instance().m_Currencys[cfg.currency.CurrencyType.YuanBao] < moneytreemanager.GetYuanBao(moneytreemanager.GetShakeTime()) then
		return true
	else
		return false
	end
end

local function RefreshShakeMoneyTreeEffect()
    if moneytreemanager.GetShakeTime() == moneytreemanager.GetMaxBuyTime() or IsNotEnoughYuanBao() then	
		SetMoneyTreeCoinEffect(false)
	else
		SetMoneyTreeCoinEffect(true)
	end
end

local function show(params)
	--SetMoneyTreeCoinEffect(false)

	local shakemoney = ConfigManager.getConfig("shakemoneytree")

--	RefreshShakeMoneyTreeEffect()
--	RefreshTime()
--	RefreshDiamond()
	EventHelper.SetClick(fields.UIButton_Buy,function()
		if  IsNotEnoughYuanBao() then  --元宝不足
            UIManager.show("dlgalert_reminder_singlebutton",{content = LocalString.ShakeMoneyTree_LessThanYuanBao})
		elseif  moneytreemanager.GetShakeTime() == moneytreemanager.GetMaxBuyTime() then
			
			if PlayerRole:Instance().m_VipLevel == moneytreemanager.GetMaxVIPLevel() then  --重置次数用完并且满级（极端情况)
				UIManager.show("common.dlgdialogbox_common",{callBackFunc = ShowReminder2})
			else
				UIManager.show("common.dlgdialogbox_common",{callBackFunc = ShowReminder1})
			end
			
		else 
			
			local msg = lx.gs.bonus.msg.CShakeMoneyTree()
			NetWork.send(msg)
		end

	end)

	EventHelper.SetClick(fields.UIButton_Close,function()
--		printyellow("hide money tree")
		UIManager.hide(name)
	end)
end


local function refresh(params)
	RefreshShakeMoneyTreeEffect()
	RefreshTime()
	RefreshDiamond()
	if params then
		RefreshReceiveXunNiBiAndCriticalNum(params)
	end
end


local function init(params)
	name, gameObject, fields = unpack(params)

	UIManager.SetAnchor(fields.UISprite_Black)

end

local function uishowtype()
    return UIShowType.DestroyWhenHide
end

return {
	uishowtype = uishowtype,
	init =init,
	refresh = refresh,
	show = show,
	hide = hide,
}