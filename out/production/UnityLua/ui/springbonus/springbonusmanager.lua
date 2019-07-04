local NetWork = require("network")
local ConfigManager = require("cfg.configmanager")
local UIManager = require("uimanager")

local m_IsInPeriod
local m_BuyedBonusType = 0
local m_RecieveBonus = {}
local m_Data

local function OnMsg_SBonusInfo(msg)
    m_IsInPeriod = msg.isinspringbonus
    m_BuyedBonusType = msg.springbonustype
    m_RecieveBonus = msg.receivespringbonus
end

local function OnMsg_SBuySpringBonus(msg)
    m_BuyedBonusType = msg.bonustype
    UIManager.refresh("springbonus.dlgspringbonus")
end

local function OnMsg_SGetSpringBonus(msg)
    table.insert(m_RecieveBonus,msg.id)
    UIManager.refresh("springbonus.dlgspringbonus")
end

local function SendBuy(type)
    local msg = lx.gs.bonus.msg.CBuySpringBonus({bonustype = type})
    NetWork.send(msg)
end

local function SendGetBonus(id)
    local msg = lx.gs.bonus.msg.CGetSpringBonus({id = id})
    NetWork.send(msg)
end

local function BuyedBonusType()
    return m_BuyedBonusType
end

local function GetData()
    return m_Data
end

local function GetDataByType(type)
    local needData
    for _,data in pairs(m_Data.springbonus) do
        if data.id == type then
            needData = data
            break
        end
    end
    return needData
end

local function HasRecieved(id)
    local result = false
    for _,dateId in pairs(m_RecieveBonus) do
        if id == dateId then
            result = true
            break
        end
    end
    return result
end

local function CompareDate(date1)
    local result = false
    if date1 then
        if (tonumber(os.date("%Y")) > date1.year) or ((date1.year == tonumber(os.date("%Y"))) and (tonumber(os.date("%m")) > date1.month)) then
            result = true
        elseif (date1.month == tonumber(os.date("%m"))) then
            if (tonumber(os.date("%d")) >= date1.day) then
                result = true           
            end
        end
    end
    return result
end

local function UnRead()
    local result = false
    if m_BuyedBonusType ~= 0 then
        local typeData = GetDataByType(m_BuyedBonusType)
        for _,bonus in pairs(typeData.details) do
            if (HasRecieved(bonus.id) == false) and (CompareDate(bonus.starttime) == true) then
                result = true
                break
            end
        end
    end
    return result
end

local function IsInPeriod()
    return (m_IsInPeriod == 1)
end

local function init()
    m_Data = ConfigManager.getConfig("springbonus")
    NetWork.add_listeners( {
        { "lx.gs.bonus.msg.SBonusInfo",OnMsg_SBonusInfo},
        { "lx.gs.bonus.msg.SBuySpringBonus",OnMsg_SBuySpringBonus},
        { "lx.gs.bonus.msg.SGetSpringBonus",OnMsg_SGetSpringBonus},
    } )
end

return
{
    init = init,
    GetData = GetData,
    BuyedBonusType = BuyedBonusType,
    GetDataByType = GetDataByType,
    SendBuy = SendBuy,
    SendGetBonus = SendGetBonus,
    HasRecieved = HasRecieved,
    CompareDate = CompareDate,
    UnRead = UnRead,
    IsInPeriod = IsInPeriod,
}