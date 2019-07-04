local utils         = require("common.utils")
local network       = require("network")
local ItemEnum      = require("item.itemenum")
local ConfigManager = require("cfg.configmanager")
local BagManager    = require("character.bagmanager")

local g_GemstonesData
local g_CurEquipSlot = 1

-- 排序：品质=>>等级
local function sort(gem1,gem2)
	if (not gem1) or (not gem2) then
		return true
	end
	if gem1:GetQuality() == gem2:GetQuality() then
		if gem1:GetLevel() == gem2:GetLevel() then
			return true
		else
			return (gem1:GetLevel() > gem2:GetLevel())
		end
	else
		return (gem1:GetQuality() > gem2:GetQuality())
	end
end

local function GetBagSlot(equipSlot, gemstoneSlot)
    return(equipSlot - 1) * 4 + gemstoneSlot
end

local function GetCurBagSlot(gemstoneSlot)
    return(g_CurEquipSlot - 1) * 4 + gemstoneSlot
end 

local function GetGemstoneDataByGemSlot(gemstoneSlot)
    local bagSlot = GetCurBagSlot(gemstoneSlot)
    return g_GemstonesData[bagSlot]
end 

local function GetAllowedGemstonePropertyText(gemstoneSlot)
    local gemstoneData = GetGemstoneDataByGemSlot(gemstoneSlot)
	local propertyTexts = ConfigManager.getConfig("gemstonetypes2propertytext")
	local propTextList = {}
	if (gemstoneData.gemstonetype1 ~= cfg.Const.NULL and gemstoneData.gemstonetype2 ~= cfg.Const.NULL) then
		for _,textData in ipairs(propertyTexts) do
			if (gemstoneData.gemstonetype1 == textData.gemstonetype1 and gemstoneData.gemstonetype2 == textData.gemstonetype2) then
				for _,propText in ipairs(textData.allowedproptexts) do
					propTextList[#propTextList + 1] = propText
				end
			end
		end
	elseif (gemstoneData.gemstonetype1 ~= cfg.Const.NULL and gemstoneData.gemstonetype2 == cfg.Const.NULL) then
		for _,textData in ipairs(propertyTexts) do
			if (gemstoneData.gemstonetype1 == textData.gemstonetype1) then
				for _,propText in ipairs(textData.allowedproptexts) do
					propTextList[#propTextList + 1] = propText
				end
			end
		end
	end
	return propTextList
end
  
-- 每个slot有特定类型的宝石，具体见GemStoneConfig配置
local function GetGemstonesInBagByGemSlot(gemstoneSlot)
    local gemstonesInBag = { }
    local gemstones = BagManager.GetItemByType(cfg.bag.BagType.ITEM, ItemEnum.ItemType.Gemstone)
    local gemstoneData = GetGemstoneDataByGemSlot(gemstoneSlot)
    if gemstoneData then 
        for _, gemstone in ipairs(gemstones) do
            if (gemstoneData.gemstonetype1 == cfg.Const.NULL and gemstoneData.gemstonetype2 == cfg.Const.NULL)
                or(gemstoneData.gemstonetype1 == cfg.Const.NULL and gemstoneData.gemstonetype2 == gemstone:GetGemstoneType2())
                or(gemstoneData.gemstonetype1 == gemstone:GetGemstoneType1() and gemstoneData.gemstonetype2 == cfg.Const.NULL)
                or(gemstoneData.gemstonetype1 == gemstone:GetGemstoneType1() and gemstoneData.gemstonetype2 == gemstone:GetGemstoneType2()) then

                gemstonesInBag[#gemstonesInBag + 1] = gemstone
            end
        end
    end
    utils.table_sort(gemstonesInBag,sort)
    return gemstonesInBag
end

local function SetEquipSlot(slot)
    if type(slot) ~= "number" or slot < 1 or slot > 8 then 
        logError("GemstoneManager:func->SetEquipSlot,params->slot: not 'number' or out of range")
        return
    end
    g_CurEquipSlot = slot
end

local function GetEquipSlot()
    return g_CurEquipSlot
end

local function init()
    g_GemstonesData = ConfigManager.getConfig("gemstoneconfig")
end

return {
    init                       = init,
    GetBagSlot                 = GetBagSlot,
    GetCurBagSlot              = GetCurBagSlot,
    SetEquipSlot               = SetEquipSlot,
    GetEquipSlot               = GetEquipSlot,
    GetGemstoneDataByGemSlot   = GetGemstoneDataByGemSlot,
    GetGemstonesInBagByGemSlot = GetGemstonesInBagByGemSlot,
	GetAllowedGemstonePropertyText = GetAllowedGemstonePropertyText,
}