local unpack          = unpack
local print           = print
local format          = string.format
local UIManager       = require("uimanager")
local network         = require("network")
local ConfigManager   = require("cfg.configmanager")
local ItemManager     = require("item.itemmanager")
local CheckCmd        = require("common.checkcmd")
local GemstoneManager = require("ui.playerrole.gemstone.gemstonemanager")
local EventHelper     = UIEventListenerHelper

local gameObject
local name
local fields

local g_GemstonesInBag
local g_CurGemstone

local g_CurGemstoneSlot

local function InitGemstoneList(gemstones)
    fields.UIButton_LoadGemstone.isEnabled = true
    fields.UILabel_NoGemStoneInBag.gameObject:SetActive(false)
    if not gemstones or #gemstones == 0 then
        fields.UIButton_LoadGemstone.isEnabled = false
        fields.UILabel_NoGemStoneInBag.gameObject:SetActive(true)
        return
    elseif fields.UIList_Gemstones.Count == 0 then
        for _, gemstone in ipairs(gemstones) do
            local listItem = fields.UIList_Gemstones:AddListItem()
            listItem.Controls["UILabel_Amount"].text = gemstone:GetNumber()
            listItem.Controls["UILabel_Level"].text = "LV"..gemstone:GetLevel()
            listItem.Controls["UISprite_Binding"].gameObject:SetActive(gemstone:IsBound())
            listItem:SetIconTexture(gemstone:GetTextureName())
            listItem.Controls["UISprite_Quality"].color = colorutil.GetQualityColor(gemstone:GetQuality())
        end
    end
end

local function SetCurGemstoneBox(gemstone)
    if not gemstone then
        fields.UILabel_CurGemstone_Name.text = ""
        fields.UILabel_CurGemstone_Amount.text = "0"
        fields.UILabel_CurGemstone_Level.text = "LV0"
        fields.UISprite_CurGemstone_Binding.gameObject:SetActive(false)
        fields.UITexture_CurGemstone_Icon:SetIconTexture("null")
        fields.UISprite_CurGemstone_Quality.color = Color(1, 1, 1, 1)
        fields.UILabel_CurGemstone_Attribute.text = ""
    else
        fields.UILabel_CurGemstone_Name.text = gemstone:GetName()
        fields.UILabel_CurGemstone_Amount.text = gemstone:GetNumber()
        fields.UILabel_CurGemstone_Level.text = "LV"..gemstone:GetLevel()
        fields.UISprite_CurGemstone_Binding.gameObject:SetActive(gemstone:IsBound())
        fields.UITexture_CurGemstone_Icon:SetIconTexture(gemstone:GetTextureName())
        fields.UISprite_CurGemstone_Quality.color = colorutil.GetQualityColor(gemstone:GetQuality())
        fields.UILabel_CurGemstone_Attribute.text = ""
        local attr = gemstone:GetGemstoneAttr()
        local attrText = ItemManager.GetAttrText(attr.AttrType, attr.AttrValue)
        ItemManager.AddAttributeDescText(fields.UILabel_CurGemstone_Attribute, false, attrText)
    end
end



local function destroy()
    -- print(name, "destroy")
end

local function show(params)
    -- print(name, "show")
    g_CurGemstoneSlot = params.gemstoneSlot
    g_GemstonesInBag  = GemstoneManager.GetGemstonesInBagByGemSlot(g_CurGemstoneSlot)
    g_CurGemstone     = g_GemstonesInBag[1]
    SetCurGemstoneBox(g_CurGemstone)
    InitGemstoneList(g_GemstonesInBag)
    -- 设置窗口标题
    local gemstoneData = GemstoneManager.GetGemstoneDataByGemSlot(g_CurGemstoneSlot)
    if gemstoneData.gemstonetype1 == cfg.Const.NULL and gemstoneData.gemstonetype2 ~= cfg.Const.NULL then 
        fields.UILabel_Title.text = format(LocalString.Gemstone_Load_Title2,LocalString.Gemstone_Type2[gemstoneData.gemstonetype2])
    elseif gemstoneData.gemstonetype1 ~= cfg.Const.NULL and gemstoneData.gemstonetype2 == cfg.Const.NULL then
        fields.UILabel_Title.text = format(LocalString.Gemstone_Load_Title3,LocalString.Gemstone_Type1[gemstoneData.gemstonetype1])
    elseif gemstoneData.gemstonetype1 ~= cfg.Const.NULL and gemstoneData.gemstonetype2 ~= cfg.Const.NULL then
        fields.UILabel_Title.text = format(LocalString.Gemstone_Load_Title1,LocalString.Gemstone_Type2[gemstoneData.gemstonetype2],LocalString.Gemstone_Type1[gemstoneData.gemstonetype1])
    else
        fields.UILabel_Title.text = LocalString.Gemstone_Load_Title4
    end
	-- 设置可以镶嵌的宝石种类
	local allowedGemPropTexts = GemstoneManager.GetAllowedGemstonePropertyText(g_CurGemstoneSlot)
	local propText = allowedGemPropTexts[1] or ""
	for i = 2, #allowedGemPropTexts do
		propText = propText.."、"..allowedGemPropTexts[i]
	end
	fields.UILabel_AllowedGemstones.text = format(LocalString.Gemstone_Load_PropText,propText)
end

local function hide()
    -- print(name, "hide")
    fields.UIList_Gemstones:Clear()
end

local function refresh(params)
    -- print(name, "refresh")
end

local function update()
    -- print(name, "update")
end

local function init(params)
    name, gameObject, fields = unpack(params)

    UIManager.SetAnchor(fields.UISprite_Black)
    gameObject.transform.localPosition = Vector3(0, 0, -1000)

    EventHelper.SetClick(fields.UIButton_Gemstone_Close, function()
        UIManager.hide(name)
    end )
    EventHelper.SetListClick(fields.UIList_Gemstones, function(listItem)
        g_CurGemstone = g_GemstonesInBag[listItem.Index + 1]
        SetCurGemstoneBox(g_CurGemstone)
    end )
    EventHelper.SetClick(fields.UIButton_LoadGemstone, function()
        if g_CurGemstone then 
            local gemstoneBagSlot = GemstoneManager.GetCurBagSlot(g_CurGemstoneSlot)
            local msg = lx.gs.gemstone.msg.CLoadGemstone( { srcpos = g_CurGemstone:GetBagPos(), destpos = gemstoneBagSlot })
            network.send(msg)
        end
        UIManager.hide(name)
    end )


end

return {
    init    = init,
    show    = show,
    hide    = hide,
    update  = update,
    destroy = destroy,
    refresh = refresh,
}

