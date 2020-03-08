local unpack            = unpack
local print             = print
local format            = string.format
local math              = math
local EventHelper       = UIEventListenerHelper
local uimanager         = require("uimanager")
local network           = require("network")
local avatarmanager     = require("roleheadavatarmanager")
local PlayerRole
local gameObject
local name
local fields

local function destroy()
    -- print(name, "destroy")
end

local function UpdateAttributes()
    local playerRole = PlayerRole.Instance()
    if playerRole.m_Attributes[cfg.fight.AttrId.HP_VALUE]
        and playerRole.m_Attributes[cfg.fight.AttrId.MP_VALUE]
        and playerRole.m_Attributes[cfg.fight.AttrId.HP_FULL_VALUE]
        and playerRole.m_Attributes[cfg.fight.AttrId.MP_FULL_VALUE] then
        local percentHP = playerRole.m_Attributes[cfg.fight.AttrId.HP_VALUE] / playerRole.m_Attributes[cfg.fight.AttrId.HP_FULL_VALUE] or 1
        local percentMP = playerRole.m_Attributes[cfg.fight.AttrId.MP_VALUE] / playerRole.m_Attributes[cfg.fight.AttrId.MP_FULL_VALUE] or 1
        fields.UIProgressBar_RoleHP.value = percentHP
        fields.UIProgressBar_MP.value = percentMP
        fields.UILabel_RoleHP.text = tostring(math.ceil(percentHP * 100)) .. "%"
        fields.UILabel_MP.text = tostring(math.ceil(percentMP * 100)) .. "%"
    end
end

local listenerKey = "uimain_roleinfo"
local function show(params)
    -- print(name, "show")
    UpdateAttributes()
    PlayerRole:Instance().m_ListenerGroup:AddAttributeListener(listenerKey, function(lsnChar)
        --printyellow("CALLBACK UIMAIN")
        UpdateAttributes()
    end, false)
end

local function hide()
    PlayerRole:Instance().m_ListenerGroup:RemoveAttributeListener(listenerKey)
end

local function update()
    -- print(name, "update")
end

local function RefreshRoleInfo()
    if uimanager.isshow("dlguimain") then
        --printyellow("~~~~~~~~~~~~~refresh playerrole info~!!!!")
        local playerRole = PlayerRole:Instance()
        local expRate = (playerRole.Instance():GetCurrency(cfg.currency.CurrencyType.JingYan) or 0) / (ConfigManager.getConfigData("exptable", playerRole.m_Level).exp or 1)
        fields.UILabel_Vip.text = tostring(playerRole.m_VipLevel)
        fields.UILabel_HeroName.text = playerRole.m_Name
        fields.UILabel_HeroLV.text = playerRole.m_Level
        fields.UIProgressBar_EXP.value = expRate
        --fields.UILabel_Vip.text = playerRole.m_VipLevel
        --fields.UISprite_HeroHead.spriteName = playerRole:GetHeadIcon()
        fields.UITexture_HeroHead.mainTexture = avatarmanager.getavatar()
        --prologue
        local PrologueManager = require"prologue.prologuemanager"
        if PrologueManager.IsInPrologue() then
            fields.UILabel_FightValue.text = PrologueManager.GetFightPower(playerRole.m_Profession)
        else
            fields.UILabel_FightValue.text = playerRole.m_Power
        end
    end
end

local function refresh(params)
    RefreshRoleInfo()
end



local function init(iName,iGameObject,iFields)
    name            = iName
    gameObject      = iGameObject
    fields          = iFields
    PlayerRole      = require "character.playerrole"
end

return {
    init = init,
    show = show,
    hide = hide,
    update = update,
    destroy = destroy,
    refresh = refresh,
    UpdateAttributes = UpdateAttributes,
    RefreshRoleInfo = RefreshRoleInfo,
}
