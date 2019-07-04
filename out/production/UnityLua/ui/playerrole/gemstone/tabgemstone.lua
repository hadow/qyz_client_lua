local unpack              = unpack
local print               = print
local format              = string.format
local UIManager           = require("uimanager")
local network             = require("network")
local ItemEnum            = require("item.itemenum")
local PlayerRole          = require("character.playerrole")
local EventHelper         = UIEventListenerHelper
local BagManager          = require("character.bagmanager")
local ItemIntroduct       = require("item.itemintroduction")
local ItemManager         = require("item.itemmanager")
local GemstoneManager     = require("ui.playerrole.gemstone.gemstonemanager")

local gameObject
local name
local fields

local g_SelectedItem

local function SetEquipBox()
	local equipSlot = GemstoneManager.GetEquipSlot()
	local playerEquip = BagManager.GetItemBySlot(cfg.bag.BagType.EQUIP_BODY,equipSlot)
	if not playerEquip then 
		fields.UITexture_Icon:SetIconTexture("null")
		fields.UISprite_Quality.color = Color(1,1,1,1)
		fields.UISprite_Binding.gameObject:SetActive(false)
		fields.UILabel_AnnealLevel.text = "+0"
		fields.UILabel_AnnealLevel.gameObject:SetActive(false)
		fields.UILabel_EquipTypeName.gameObject:SetActive(true)
		fields.UILabel_EquipTypeName.text = LocalString.EquipIndex2TypeName[equipSlot]
	else
		fields.UILabel_EquipTypeName.gameObject:SetActive(false)
		fields.UITexture_Icon:SetIconTexture(playerEquip:GetTextureName())
		fields.UISprite_Quality.color = colorutil.GetQualityColor(playerEquip:GetQuality())
		fields.UISprite_Binding.gameObject:SetActive(playerEquip:IsBound())
		if playerEquip:GetAnnealLevel() ~= 0 then 
			fields.UILabel_AnnealLevel.gameObject:SetActive(true)
			fields.UILabel_AnnealLevel.text = "+"..playerEquip:GetAnnealLevel()
		else
			fields.UILabel_AnnealLevel.text = "+0"
			fields.UILabel_AnnealLevel.gameObject:SetActive(false)
		end
	end
end

local function SetGemstonenInfo(listItem,gemstone)
	if not gemstone then 
		listItem.Controls["UILabel_Level"].text = "LV0"
		listItem.Controls["UILabel_Level"].gameObject:SetActive(false)
		listItem.Controls["UISprite_Binding"].gameObject:SetActive(false)
		listItem:SetIconTexture("null")
		listItem.Controls["UISprite_Quality"].color = Color(1,1,1,1)
	else
		listItem.Controls["UILabel_Level"].gameObject:SetActive(true)
		listItem.Controls["UILabel_Level"].text = "LV"..gemstone:GetLevel()
		listItem.Controls["UISprite_Binding"].gameObject:SetActive(gemstone:IsBound())
		listItem:SetIconTexture(gemstone:GetTextureName())
		listItem.Controls["UISprite_Quality"].color = colorutil.GetQualityColor(gemstone:GetQuality())
	end
end

local function RefreshGemstoneList()
    -- 清空属性列表
    fields.UILabel_GemstoneAttr.text = ""
	for gemstoneSlot = 1,fields.UIList_Gemstones.Count do
		local listItem = fields.UIList_Gemstones:GetItemByIndex(gemstoneSlot - 1)
		local gemstoneBagSlot = GemstoneManager.GetCurBagSlot(gemstoneSlot)
		local gemstoneData = GemstoneManager.GetGemstoneDataByGemSlot(gemstoneSlot)
		local curGemstone = BagManager.GetItemBySlot(cfg.bag.BagType.GEMSTONE,gemstoneBagSlot)
		local bHasOpened = ((gemstoneData.openlevel.level >= 0) and (PlayerRole:Instance():GetLevel() >= gemstoneData.openlevel.level))
		if bHasOpened and (not curGemstone) then 
			-- 槽位开启且无宝石
			listItem.Controls["UISprite_Add"].gameObject:SetActive(true)
			listItem.Controls["UILabel_NotOpen"].gameObject:SetActive(false)
			listItem.Controls["UILabel_OpenLevel"].gameObject:SetActive(false)
			SetGemstonenInfo(listItem)
		elseif bHasOpened and curGemstone then 
			-- 槽位开启且有宝石
			listItem.Controls["UISprite_Add"].gameObject:SetActive(false)
			listItem.Controls["UILabel_NotOpen"].gameObject:SetActive(false)
			listItem.Controls["UILabel_OpenLevel"].gameObject:SetActive(false)
			SetGemstonenInfo(listItem,curGemstone)
            local bReturn = true
			local attr = curGemstone:GetGemstoneAttr()
			if (gemstoneSlot == fields.UIList_Gemstones.Count) then bReturn = false end
			local attrText = ItemManager.GetAttrText(attr.AttrType, attr.AttrValue,true)
            attrText = format(LocalString.Gemstone_AttrText,curGemstone:GetName(),attrText)
			ItemManager.AddAttributeDescText(fields.UILabel_GemstoneAttr, bReturn, attrText)


		elseif gemstoneData.openlevel.level == cfg.Const.NULL then
			-- 槽位开启未开启  
			listItem.Controls["UISprite_Add"].gameObject:SetActive(false)
			listItem.Controls["UILabel_NotOpen"].gameObject:SetActive(true)
			listItem.Controls["UILabel_OpenLevel"].gameObject:SetActive(false)
			SetGemstonenInfo(listItem)
		elseif (gemstoneData.openlevel.level >= 0) and (PlayerRole:Instance():GetLevel() < gemstoneData.openlevel.level) then
			-- 未达到槽位开启等级
			listItem.Controls["UISprite_Add"].gameObject:SetActive(false)
			listItem.Controls["UILabel_NotOpen"].gameObject:SetActive(false)
			listItem.Controls["UILabel_OpenLevel"].gameObject:SetActive(true)
			listItem.Controls["UILabel_OpenLevel"].text = format(LocalString.Gemstone_CurSlot_OpenLevel,gemstoneData.openlevel.level)
			SetGemstonenInfo(listItem)  
		end
	end

end

local function GetFlyText(gemstoneSlot)
    local gemstoneData = GemstoneManager.GetGemstoneDataByGemSlot(gemstoneSlot)
    local text = ""
    if gemstoneData.gemstonetype1 == cfg.Const.NULL and gemstoneData.gemstonetype2 ~= cfg.Const.NULL then 
        text = format(LocalString.Gemstone_NoGemStoneInBag2,LocalString.Gemstone_Type2[gemstoneData.gemstonetype2])
    elseif gemstoneData.gemstonetype1 ~= cfg.Const.NULL and gemstoneData.gemstonetype2 == cfg.Const.NULL then
        text = format(LocalString.Gemstone_NoGemStoneInBag3,LocalString.Gemstone_Type1[gemstoneData.gemstonetype1])
    elseif gemstoneData.gemstonetype1 ~= cfg.Const.NULL and gemstoneData.gemstonetype2 ~= cfg.Const.NULL then
        text = format(LocalString.Gemstone_NoGemStoneInBag1,LocalString.Gemstone_Type2[gemstoneData.gemstonetype2],LocalString.Gemstone_Type1[gemstoneData.gemstonetype1])
    else
        text = LocalString.Gemstone_NoGemStoneInBag4
    end
    return text
end

local function destroy()
	--print(name, "destroy")
end

local function show(params)
	--print(name, "show")
end

local function hide()
	--print(name, "hide")
	GemstoneManager.SetEquipSlot(1)
end

local function refresh(params)
	--print(name, "refresh")
	SetEquipBox()
	RefreshGemstoneList()
end

local function update()
	--print(name, "update")
end

local function uishowtype()
	return UIShowType.Refresh
end

local function init(params)
	name, gameObject, fields = unpack(params)

	EventHelper.SetClick(fields.UIButton_GemstoneCompose,function()
        UIManager.showdialog("cornucopia.dlgcornucopia",nil,3)
	end)
	EventHelper.SetListClick(fields.UIList_Gemstones,function(listItem)
		
		local gemstoneBagSlot = GemstoneManager.GetCurBagSlot(listItem.Index + 1)
		local gemstoneData = GemstoneManager.GetGemstoneDataByGemSlot(listItem.Index + 1)
		local curGemstone = BagManager.GetItemBySlot(cfg.bag.BagType.GEMSTONE,gemstoneBagSlot)
		local bHasOpened = ((gemstoneData.openlevel.level >= 0) and (PlayerRole:Instance():GetLevel() >= gemstoneData.openlevel.level))
		if bHasOpened and (not curGemstone) then 
			-- 槽位开启且无宝石
            local gemstonesInBag = GemstoneManager.GetGemstonesInBagByGemSlot(listItem.Index + 1)
            --if #gemstonesInBag == 0 then
                --local flyText = GetFlyText(listItem.Index + 1)
                --UIManager.ShowSystemFlyText(flyText)
               --return 
            --end
			UIManager.show("playerrole.gemstone.dlgalert_gemstones",{gemstoneSlot = listItem.Index + 1})

		elseif bHasOpened and curGemstone then 
			-- 槽位开启且有宝石
			local gemstoneUnloadFunc = function()
				local msg = lx.gs.gemstone.msg.CUnloadGemstone( { pos = curGemstone:GetBagPos()})
				network.send(msg)
			end

			ItemIntroduct.DisplayBriefItem( {
				item = curGemstone,
				button = { display = true, text = LocalString.Gemstone_UnLoad, callFunc = gemstoneUnloadFunc },
			} )
		elseif gemstoneData.openlevel.level == cfg.Const.NULL then
			-- 槽位开启未开启  
			UIManager.ShowSystemFlyText(LocalString.Gemstone_CurSlot_NotOpen) 
		elseif (gemstoneData.openlevel.level >= 0) and (PlayerRole:Instance():GetLevel() < gemstoneData.openlevel.level) then
			-- 未达到槽位开启等级 
			UIManager.ShowSystemFlyText(format(LocalString.Gemstone_CurSlot_OpenLevel,gemstoneData.openlevel.level)) 
		end
	end)

end

return {
	init       = init,
	show       = show,
	hide       = hide,
	update     = update,
	destroy    = destroy,
	refresh    = refresh,
	uishowtype = uishowtype,
}

