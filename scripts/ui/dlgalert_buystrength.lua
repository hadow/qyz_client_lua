local Unpack = unpack
local Format = string.format
local UIManager = require("uimanager")
local BagManager = require("character.bagmanager")
local BonusManager = require("item.bonusmanager")
local PlayerRole = require("character.playerrole"):Instance()
local EventHelper = UIEventListenerHelper

local m_GameObject
local m_Name
local m_Fields

local function SetButton(isUse)
    if isUse then
        m_Fields.UILabel_Buy.text=LocalString.BagAlert_Use
        EventHelper.SetClick(fields.UIButton_Buy,function()
        end)
    else
        m_Fields.UILabel_Buy.text=LocalString.Exchange_Buy
        EventHelper.SetClick(fields.UIButton_Buy,function()
        end)
    end
end

local function DisplayIntro(isUse,itemData)
    if isUse then
        m_Fields.UISprite_CostBackground.gameObject:SetActive(false)
    else
        m_Fields.UILabel_Cost.text=itemData:GetPrice()
    end
    m_Fields.UILabel_Discription.text=itemData:GetIntroduction()
    BonusManager.SetRewardItem(m_Fields.UIGroup_Slots,itemData)
    m_Fields.UILabel_StrengthAmount=PlayerRole:GetCurrency(cfg.currency.CurrencyType.TiLi).."/"
end

local function show(params)
    DisplayIntro(params.isUse,params.itemData)
    SetButton(params.isUse)
end

local function refresh()
end

local function init(params)
    m_Name, m_GameObject, m_Fields = Unpack(params)

    UIManager.SetAnchor(fields.UISprite_Black)
end

return{
    init = init,
    refresh = refresh,
    show = show,
}