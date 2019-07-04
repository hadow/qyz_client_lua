local NetWork = require("network")
local CheckCmd = require("common.checkcmd")
local DefineEnum = require("defineenum")
local ConfigManager=require("cfg.configmanager")
local UIManager = require("uimanager")
local AttributeHelper = require("attribute.attributehelper")
local Format = string.format

local LEVELPERIOD = cfg.pureair.LuckyValue.LEVEL_LIMIT
local AWAKEPERIOD = cfg.pureair.LuckyValue.AWAKE_LIMIT
local STARPERIOD = cfg.pureair.LuckyValue.STAR_LIMIT

local m_PureAirInfo = {}

--升级
local function SendCAirLevelUp(airType)
    local msg=lx.gs.pureair.msg.CAirLevelUp({airtype = airType})
    NetWork.send(msg)
end
--升星
local function SendCAirStarUp(airType)
    local msg=lx.gs.pureair.msg.CAirStarUp({airtype = airType})
    NetWork.send(msg)
end
--升重
local function SendCAirEvolve(airType)
    local msg=lx.gs.pureair.msg.CAirEvolve({airtype = airType})
    NetWork.send(msg)
end
--觉醒
local function SendCAirAwake(airType)
    local msg=lx.gs.pureair.msg.CAirAwake({airtype = airType})
    NetWork.send(msg)
end
--初始信息
local function OnMsg_SAirInfo(msg)
    m_PureAirInfo = msg.details
end

--升级
local function OnMsg_SAirLevelUp(msg)   
    if m_PureAirInfo[msg.airtype] then
        if m_PureAirInfo[msg.airtype].normalluckyvalue then
            if m_PureAirInfo[msg.airtype].normalluckyvalue < msg.luckyvalue then
                UIManager.ShowSystemFlyText(LocalString.PureAir_LevelLuckValueUp)
            end
        end
        m_PureAirInfo[msg.airtype].normalluckyvalue = msg.luckyvalue
        if m_PureAirInfo[msg.airtype].normallevl then
            if m_PureAirInfo[msg.airtype].normallevl < msg.nextlevel then
                UIManager.ShowSystemFlyText(LocalString.DlgSkill_UpgradeSuccess)
            end
        end
        m_PureAirInfo[msg.airtype].normallevl = msg.nextlevel
    end
    if UIManager.isshow("pureair.tabpureair") then
        UIManager.refresh("pureair.tabpureair",{type = DefineEnum.PuerAirOperType.LEVEL})
        local dlgDialog = require("ui.dlgdialog")
        dlgDialog.RefreshRedDot("pureair.dlgpureair")
    end
    
end

--觉醒
local function OnMsg_SAirAwake(msg)
    if m_PureAirInfo[msg.airtype] then
        if m_PureAirInfo[msg.airtype].awakeluckyvalue then
            if m_PureAirInfo[msg.airtype].awakeluckyvalue < msg.luckyvalue then
                UIManager.ShowSystemFlyText(LocalString.PureAir_AwakeLuckValueUp)
            end
        end
        m_PureAirInfo[msg.airtype].awakeluckyvalue = msg.luckyvalue
        if m_PureAirInfo[msg.airtype].awakelevel then
            if m_PureAirInfo[msg.airtype].awakelevel < msg.nextawakelevel then
                UIManager.ShowSystemFlyText(LocalString.PureAir_AwakeSuccess)
            end
        end
        m_PureAirInfo[msg.airtype].awakelevel = msg.nextawakelevel
    end    
    if UIManager.isshow("pureair.tabpureair") then
        UIManager.refresh("pureair.tabpureair",{type = DefineEnum.PuerAirOperType.AWAKE})
        local dlgDialog = require("ui.dlgdialog")
        dlgDialog.RefreshRedDot("pureair.dlgpureair")
    end
end

--升华
local function OnMsg_SAirStarUp(msg)
    if m_PureAirInfo[msg.airtype] then
        m_PureAirInfo[msg.airtype].starlevel = msg.nextstarlevel
    end
    if UIManager.isshow("pureair.tabpureair") then
        UIManager.refresh("pureair.tabpureair",{type = DefineEnum.PuerAirOperType.STAR})
        local dlgDialog = require("ui.dlgdialog")
        dlgDialog.RefreshRedDot("pureair.dlgpureair")
    end
end

--升重
local function OnMsg_SAirEvolve(msg)
    if m_PureAirInfo[msg.airtype] then
        m_PureAirInfo[msg.airtype].laylevel = msg.nextevolvelevel
    end 
    if UIManager.isshow("pureair.tabpureair") then
        UIManager.refresh("pureair.tabpureair")
        local dlgDialog = require("ui.dlgdialog")
        dlgDialog.RefreshRedDot("pureair.dlgpureair")
    end
end

local function OnMsg_SSyncAirAttrs(msg)
    if m_PureAirInfo[lx.gs.pureair.msg.AirDetail.HUMAN_TYPE] then
        m_PureAirInfo[lx.gs.pureair.msg.AirDetail.HUMAN_TYPE].attr = msg.roleattrs
    end 
    if m_PureAirInfo[lx.gs.pureair.msg.AirDetail.PET_TYPE] then
        m_PureAirInfo[lx.gs.pureair.msg.AirDetail.PET_TYPE].attr = msg.petattrs
    end 
    if UIManager.isshow("pureair.tabpureair") then
        UIManager.refresh("pureair.tabpureair")
        local dlgDialog = require("ui.dlgdialog")
        dlgDialog.RefreshRedDot("pureair.dlgpureair")
    end
end

local function GetPureAirByType(type)
    return m_PureAirInfo[type]
end

local function GetPureAirLevelAttr(type)
    local info = m_PureAirInfo[type]
    local attr
    if info then
        local allLevelInfo = ConfigManager.getConfig("pureairlevel")
        local humanAirLevelList
        if type == lx.gs.pureair.msg.AirDetail.HUMAN_TYPE then
            humanAirLevelList = allLevelInfo.humanairlevel
        elseif type == lx.gs.pureair.msg.AirDetail.PET_TYPE then
            humanAirLevelList = allLevelInfo.petairlevel
        end    
        attr = humanAirLevelList[info.normallevl + 1]
    end
    return attr
end


local function GetPureAirAwakeAttr(type)
    local info = m_PureAirInfo[type]
    local attr
    if info then
        local allAwakeInfo = ConfigManager.getConfig("pureawake")
        local humanAirAwakeList
        if type == lx.gs.pureair.msg.AirDetail.HUMAN_TYPE then
            humanAirAwakeList = allAwakeInfo.humanairawake
        elseif type == lx.gs.pureair.msg.AirDetail.PET_TYPE then
            humanAirAwakeList = allAwakeInfo.petairawake
        end
        attr = humanAirAwakeList[info.awakelevel + 1]
    end
    return attr
end

local function GetPureAirStarAttr(type)
    local info = m_PureAirInfo[type]
    local attr
    if info then
        local allStarInfo = ConfigManager.getConfig("pureairsublime")
        local humanAirStarList
        if type == lx.gs.pureair.msg.AirDetail.HUMAN_TYPE then
            humanAirStarList = allStarInfo.humanairsublime
        elseif type == lx.gs.pureair.msg.AirDetail.PET_TYPE then
            humanAirStarList = allStarInfo.petairsublime
        end
        attr = humanAirStarList[info.starlevel + 1]
    end
    return attr
end

local function GetAirLayInfo(type)
    local layConfig = ConfigManager.getConfig("layconfig")
    local specialLayConfig
    local attr
    if type == lx.gs.pureair.msg.AirDetail.HUMAN_TYPE then
        specialLayConfig = layConfig.humanairlay
    elseif type == lx.gs.pureair.msg.AirDetail.PET_TYPE then
        specialLayConfig = layConfig.petairlay
    end
    for _,layInfo in pairs(specialLayConfig) do
        if layInfo.lay == (m_PureAirInfo[type].laylevel + 1) then
            attr = layInfo
            break
        end
    end
    return attr
end

local function GetTextByAttr(attr)
    local result = ""
    local info = ConfigManager.getConfigData("statustext", attr)
    if info then
        result = info.text
    end
    return result
end

local function GetTotalAttr(type)
    local result = ""
    if m_PureAirInfo[type] then
        for attrId,value in pairs(m_PureAirInfo[type].attr) do
            result = result .. GetTextByAttr(attrId) .. ": +" .. AttributeHelper.GetAttributeValueString(attrId,value) .. "\n"
        end
    end
    return result
end

local function GetDes()
    local layConfig = ConfigManager.getConfig("layconfig")
    return layConfig.des
end

local function CanOper(type)
    local levelResult = true
    local levelAttr = GetPureAirLevelAttr(type)  
    local pureAirInfo = GetPureAirByType(type)
    if (pureAirInfo.normallevl % LEVELPERIOD == 0) and ((pureAirInfo.normallevl / LEVELPERIOD) == pureAirInfo.laylevel) then
        levelResult = false
    elseif levelAttr then   
        for _,condition in pairs(levelAttr.cost) do     
            if CheckCmd.CheckData({data = condition}) == false then  
                levelResult = false            
                break
            end
        end
    end
    if levelResult then
        return true
    end
    local awakeResult = true
    local awakeAttr = GetPureAirAwakeAttr(type)
    if (pureAirInfo.awakelevel % AWAKEPERIOD == 0) and ((pureAirInfo.awakelevel / AWAKEPERIOD) == pureAirInfo.laylevel) then
        awakeResult = false
    elseif awakeAttr then
        for _,condition in pairs(awakeAttr.cost) do    
            if CheckCmd.CheckData({data = condition}) ~= true then
                awakeResult = false
                break
            end           
        end
    end
    if awakeResult then
        return true
    end
    local breakResult = true
    if (pureAirInfo.starlevel % STARPERIOD == 0) and ((pureAirInfo.starlevel / STARPERIOD) == pureAirInfo.laylevel) then
        local layAttr = GetAirLayInfo(0)
        if layAttr then
            local result = true
            for _,condition in pairs(layAttr.upcost) do  
                if CheckCmd.CheckData({data = condition}) ~= true then
                    breakResult = false 
                    break
                end                                                
            end
            if breakResult then
                if CheckCmd.CheckData({data = layAttr.rolelvlimit}) ~= true then
                    breakResult = false
                elseif (pureAirInfo.normallevl < layAttr.purelvlimit) or (pureAirInfo.awakelevel < layAttr.awakelimit) or (pureAirInfo.starlevel < layAttr.starlimit) then
                    breakResult = false
                end
            end
        else
            breakResult = false 
        end
    else
        local starAttr = GetPureAirStarAttr(type)
        local levelLimit = (starAttr.purelvlimit % LEVELPERIOD ~= 0) and (starAttr.purelvlimit % LEVELPERIOD) or LEVELPERIOD
        local awakeLimit = (starAttr.awakelimit % AWAKEPERIOD ~= 0) and (starAttr.awakelimit % AWAKEPERIOD) or AWAKEPERIOD
        for _,condition in pairs(starAttr.cost) do         
            if CheckCmd.CheckData({data = condition}) ~= true then
                breakResult = false 
                break
            end
        end        
        if breakResult then
            if (starAttr.purelvlimit > pureAirInfo.normallevl) or (starAttr.awakelimit > pureAirInfo.awakelevel) then
                breakResult = false
            end   
        end                
    end
	printyellow("breakResult:",breakResult)
    return breakResult
end

local function UnRead1()
    return CanOper(0)
end

local function UnRead2()
    return CanOper(1)
end

local function UnRead()
    return CanOper(0) and CanOper(1)
end

local function init()
    NetWork.add_listeners({
       {"lx.gs.pureair.msg.SAirInfo", OnMsg_SAirInfo },  
       {"lx.gs.pureair.msg.SAirLevelUp", OnMsg_SAirLevelUp},  
       {"lx.gs.pureair.msg.SAirAwake", OnMsg_SAirAwake},  
       {"lx.gs.pureair.msg.SAirStarUp", OnMsg_SAirStarUp},  
       {"lx.gs.pureair.msg.SAirEvolve", OnMsg_SAirEvolve},  
       {"lx.gs.pureair.msg.SSyncAirAttrs", OnMsg_SSyncAirAttrs},
    })   
end

return
{
    init = init,
    SendCAirLevelUp = SendCAirLevelUp,
    SendCAirStarUp = SendCAirStarUp,
    SendCAirEvolve = SendCAirEvolve,
    SendCAirAwake = SendCAirAwake,
    GetPureAirByType = GetPureAirByType,
    GetPureAirStarAttr = GetPureAirStarAttr,
    GetPureAirAwakeAttr = GetPureAirAwakeAttr,
    GetPureAirLevelAttr = GetPureAirLevelAttr,
    GetAirLayInfo = GetAirLayInfo,
    GetTotalAttr = GetTotalAttr,
    GetTextByAttr = GetTextByAttr,
    GetDes = GetDes,
    UnRead1 = UnRead1,
    UnRead2 = UnRead2,
    UnRead = UnRead,
    LEVELPERIOD = LEVELPERIOD,
    AWAKEPERIOD = AWAKEPERIOD,
    STARPERIOD = STARPERIOD,
}