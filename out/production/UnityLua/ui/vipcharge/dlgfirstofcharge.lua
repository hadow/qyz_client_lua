local unpack = unpack
local print = print
local VoiceManager = VoiceManager
local EventHelper = UIEventListenerHelper

local uimanager = require("uimanager")
local network = require("network")
local login = require("login")
local NPC = require("character.npc")
local Player = require"character.player"
local ConfigManager = require "cfg.configmanager"
local BonusManager = require("item.bonusmanager")
local define = require "define"
local PlayerRole = require "character.playerrole"
local LimitManager = require "limittimemanager"
local VipChargeManager = require "ui.vipcharge.vipchargemanager"
local CgManager = require "ui.cg.cgmanager"

local fields
local gameObject
local name
local g_NPC
local g_FirstChargeType

local function OnNPCLoaded()
	local npcTrans = g_NPC.m_Object.transform
	npcTrans.parent = fields.UITexture_Model.gameObject.transform
	npcTrans.localRotation = Vector3.up*180
	g_NPC:UIScaleModify()
	npcTrans.localPosition = Vector3(0, -260, -100)
	ExtendedGameObject.SetLayerRecursively(g_NPC.m_Object, define.Layer.LayerUICharacter)
    g_NPC:Show()
	EventHelper.SetDrag(fields.UITexture_Model, function(o, delta)
		if g_NPC then
			local npcObj = g_NPC.m_Object
			if npcObj then
				local vecRotate = Vector3(0,  -delta.x, 0)
				npcObj.transform.localEulerAngles = npcObj.transform.localEulerAngles + vecRotate
			end
		end
	end )

end

local function GetLuXueQiCSVId()
	local mallnpc = ConfigManager.getConfig("mallnpc")
	local npcId
	for _,value in pairs (mallnpc) do
		if value.malltype == cfg.mall.MallType.FIRST_CHARGE then
			return value.cornucopianpc
		end
	end
	return nil
end

local function AddNPC()
	if g_NPC == nil then
		g_NPC = NPC:new()
--		local npcCfg = ConfigManager.getConfigData("mallnpc",firstChargeType)
--		local chargebonus = ConfigManager.getConfig("chargebonus")

--        local npcCsvId = cfg.bonus.ChargeBonus.chargeNPC
		local npcCsvId = GetLuXueQiCSVId()
		-- printyellow("npcCsvId",npcCsvId)
		g_NPC:RegisterOnLoaded(OnNPCLoaded)
		g_NPC:init(0, npcCsvId)

	end
end

local function destroy()
  --print(name, "destroy")
	if g_NPC then
		g_NPC:release()
		g_NPC = nil
	end
end

local function show()
  --print(name, "show")

	AddNPC()


end

local function hide()
  --print(name, "hide")
	if g_NPC then
		g_NPC:release()
		g_NPC = nil
	end
end

local function RefreshRewardItem()
	local firstcharge = ConfigManager.getConfig("firstcharge")
	local bonuslist = BonusManager.GetItemsByBonusConfig(firstcharge.bonus)
--	printyellow("fields.UIList_Rewards",fields.UIList_Rewards)
	fields.UIList_Rewards:Clear()
	for _,item in pairs(bonuslist) do
        local listItem=fields.UIList_Rewards:AddListItem()
--		local params = {}
--		params.notShowAmount = true
        BonusManager.SetRewardItem(listItem,item)

	end
end

local function refresh()
  --print(name, "refresh")
--	printyellow("wo yuan ba xin fang fei")
	RefreshRewardItem()
	if VipChargeManager.GetTotalCharge() < 600 then  --��1Ԫ�Ĳ���
		UITools.SetButtonEnabled(fields.UIButton_GetRewards.gameObject:GetComponent(UIButton),false)

	else
		if VipChargeManager.GetFirstPayUsed() == 1 then
			UITools.SetButtonEnabled(fields.UIButton_GetRewards.gameObject:GetComponent(UIButton),false)
			fields.UILabel_GetRewards.text = LocalString.Common_Receive
		else
			UITools.SetButtonEnabled(fields.UIButton_GetRewards.gameObject:GetComponent(UIButton),true)
		end
	end
    EventHelper.SetClick(fields.UIButton_GetRewards, function () --
		VipChargeManager.SendCBuyVipPackage(-1)
    end)
end

local function update()
	if g_NPC and g_NPC.m_Avatar then
		g_NPC.m_Avatar:Update()
	end
end

local function uishowtype()
	return UIShowType.Refresh
end

local function init(params)
     name, gameObject, fields = unpack(params)

	fields.UIButton_Return.gameObject:SetActive(false)
	fields.UITexture_AD:SetIconTexture("ICON_FirstOfCharge_BG01")

	EventHelper.SetClick(fields.UIButton_PlayVideo,function ()
--		print("wangliewangliewangliewangliewanglieroleroleroleplayplayplay")
		CgManager.PlayCG("xueqiwangyue.mp4",nil, 2)
	end)

    EventHelper.SetClick(fields.UIButton_Charge, function ()
        --uimanager.show("dlgmain_open")

        uimanager.showdialog("vipcharge.dlgrecharge")
    end)






end

return {
  init = init,
  show = show,
  hide = hide,
  update = update,
  destroy = destroy,
  refresh = refresh,
  uishowtype = uishowtype,
}
