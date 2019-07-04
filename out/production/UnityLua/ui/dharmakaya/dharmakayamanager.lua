local NetWork = require("network")
local ConfigManager=require("cfg.configmanager")
local UIManager = require("uimanager")
local LimitManager = require("limittimemanager")
local PlayerRole = require("character.playerrole")
local Format = string.format

local ROUNDNUM = 7
local PULSENUM = 3
local THREEPULSEFRAMENORMALSPRITE = "Sprite_FaShen"
local THREEPULSEFRAMEGRAYSPRITE = "Sprite_FaShen_Gray"
local THREEPULSENORMALSPRITE =
{
    [0] = "Sprite_FaShen_1", 
    [1] = "Sprite_FaShen_2", 
    [2] = "Sprite_FaShen_3", 
}
local THREEPULSEGRAYSPRITE =
{
    [0] = "Sprite_FaShen_1_Gray", 
    [1] = "Sprite_FaShen_2_Gray", 
    [2] = "Sprite_FaShen_3_Gray", 
}

local m_CurBreakType = lx.gs.magicbody.msg.CBreakUp.XUNIBI
local m_BodyInfos = {}

local function SendCLevelUp(bodyId,pointId,upType)
    local msg=lx.gs.magicbody.msg.CLevelUp({bodyid = bodyId,pointid = pointId,uptype = upType})
    NetWork.send(msg)
end

local function SendCBreakUp(bodyId,pointId,upType)
    m_CurBreakType = upType
    local msg=lx.gs.magicbody.msg.CBreakUp({bodyid = bodyId,pointid = pointId,uptype = upType})
    NetWork.send(msg)
end

local function SendCTranslate(costType,bodyId,frompointId,topointId)
    local msg=lx.gs.magicbody.msg.CTranslate({costtype = costType,bodyid = bodyId,frompointid = frompointId,topointid = topointId})
    NetWork.send(msg)
end

local function OnMsg_SLevelUp(msg)
    if m_BodyInfos[msg.bodyid] then
        if m_BodyInfos[msg.bodyid].pointsinfo[msg.pointid] == nil then
            m_BodyInfos[msg.bodyid].pointsinfo[msg.pointid] = {}           
        end
        m_BodyInfos[msg.bodyid].pointsinfo[msg.pointid].normallevl = msg.nextlevel
    end
    UIManager.refresh("dharmakaya.dlgdharmakayaupdateattribute",{levelUp = true})
    if UIManager.isshow("dharmakaya.dlgdharmakaya") then
        UIManager.refresh("dharmakaya.dlgdharmakaya")
    end
end

local function GetExpByBreakType(type)
    local exp
    local config = ConfigManager.getConfig("dharmakayaconfig")
    if type == lx.gs.magicbody.msg.CBreakUp.XUNIBI then
        exp = config.normalbreakcost.giveexp
    elseif type == lx.gs.magicbody.msg.CBreakUp.YUANBAO then
        exp = config.highbreakcost.giveexp
    end
    return exp
end

local function OnMsg_SBreakUp(msg)
    if m_BodyInfos[msg.bodyid] then
        if m_BodyInfos[msg.bodyid].pointsinfo[msg.pointid] == nil then
            m_BodyInfos[msg.bodyid].pointsinfo[msg.pointid] = {normallevl = 0,attr = {}}
        end
        m_BodyInfos[msg.bodyid].pointsinfo[msg.pointid].breaklevel = msg.newlevel
        local exp = GetExpByBreakType(m_CurBreakType)
        UIManager.ShowSystemFlyText(Format(LocalString.Dharmakaya_ExpUp,(exp * msg.criticaltime)))
        m_BodyInfos[msg.bodyid].pointsinfo[msg.pointid].curexp = msg.newexp        
        m_BodyInfos[msg.bodyid].pointsinfo[msg.pointid].criticaltime = msg.criticaltime
    end
    UIManager.refresh("dharmakaya.dlgdharmakayaupdateattribute")
    if UIManager.isshow("dharmakaya.dlgdharmakaya") then
        UIManager.refresh("dharmakaya.dlgdharmakaya")
    end
end

local function OnMsg_STranslate(msg)
    if m_BodyInfos[msg.bodyid] then
        if m_BodyInfos[msg.bodyid].pointsinfo[msg.frompointid] then
            m_BodyInfos[msg.bodyid].pointsinfo[msg.frompointid] = nil
        end
        if m_BodyInfos[msg.bodyid].pointsinfo[msg.topointid] == nil then
            m_BodyInfos[msg.bodyid].pointsinfo[msg.topointid] = {}
        end
        m_BodyInfos[msg.bodyid].curspecialpoint = msg.topointid
		    m_BodyInfos[msg.bodyid].pointsinfo[msg.topointid].id = msg.topointid
        m_BodyInfos[msg.bodyid].pointsinfo[msg.topointid].breaklevel = msg.tobreaklevel
        m_BodyInfos[msg.bodyid].pointsinfo[msg.topointid].normallevl = msg.tonormallevel
        m_BodyInfos[msg.bodyid].pointsinfo[msg.topointid].curexp = msg.toexp
        UIManager.ShowSystemFlyText(LocalString.Dharmakaya_TranslateSuccess)
        UIManager.hide("dharmakaya.dlgdharmakayaupdateattribute")
        if UIManager.isshow("dharmakaya.dlgdharmakaya") then
            UIManager.refresh("dharmakaya.dlgdharmakaya")
        end
    end
end

local function OnMsg_SSyncAttrs(msg)
    if m_BodyInfos[msg.bodyid] then
        m_BodyInfos[msg.bodyid].extraattr = msg.attrs
        for id,attrDetail in pairs(msg.eachattrs) do
            if m_BodyInfos[msg.bodyid].pointsinfo[id] then
                m_BodyInfos[msg.bodyid].pointsinfo[id].attr = attrDetail.attr
            else
                m_BodyInfos[msg.bodyid].pointsinfo[id] = {}
                m_BodyInfos[msg.bodyid].pointsinfo[id].attr = attrDetail.attr
            end
        end
    end
    if UIManager.isshow("dharmakaya.dlgdharmakayaupdateattribute") then
        UIManager.refresh("dharmakaya.dlgdharmakayaupdateattribute")
    end
end

local function OnMsg_SStateLevelUpNotify(msg)
    if m_BodyInfos[msg.bodyid] then
        m_BodyInfos[msg.bodyid].statelevel = msg.newlevel
    end
end

local function OnMsg_SMagicBodyInfo(msg)
    m_BodyInfos = msg.bodyinfos
end

local function GetStateProperty(bodyId)
    local result
    local configInfo = ConfigManager.getConfig("dharmakayaconfig")
    local levelState = configInfo.stateinfo[m_BodyInfos[bodyId].statelevel]
    if levelState then
        result = levelState.getproperty[bodyId + 1]
    end
    return result
end

local function GetNextStateNeedLevel(bodyId)
    local result
    local configInfo = ConfigManager.getConfig("dharmakayaconfig")
    local levelState = configInfo.stateinfo[m_BodyInfos[bodyId].statelevel + 1]
    if levelState then
        result = levelState.decs
    end
    return result
end

local function GetPointConfigInfo(pointId)
    local result
    local dharmakayaConfig = ConfigManager.getConfig("dharmakayaconfig")
    local pointConfigs = dharmakayaConfig.pointconfig
    for _,pointConfig in pairs(pointConfigs) do
        if pointConfig.num == pointId then
            result = pointConfig
            break
        end
    end
    return result
end

local function GetPointName(bodyId,pointId)
    local name = ""
    local pointInfo = GetPointConfigInfo(pointId)
    if pointInfo and pointInfo.clientsource then
        name = pointInfo.clientsource[bodyId + 1].name
    end
    return name
end

local function GetBreakProperty(bodyId)
    local result = {}
    local i = 1
    if m_BodyInfos[bodyId] then
        if m_BodyInfos[bodyId].pointsinfo then
            for _,pointInfo in pairs(m_BodyInfos[bodyId].pointsinfo) do
                local breakThroughConfig = ConfigManager.getConfig("dharmakayabreakthrough")
                local propertyRate
                for _,breakThrough in pairs(breakThroughConfig) do
                    if breakThrough.breakthroughlevel == pointInfo.breaklevel then
                        propertyRate = breakThrough.propertyaddrate
                        break
                    end
                end
                if propertyRate then
                    result[i] = Format(LocalString.Dharmakaya_BreakProperty,GetPointName(bodyId,pointInfo.id),propertyRate * 100)
                    i = i + 1
                end
            end
        end
    end
    return result
end

local function GetActiveThreePulseLevel()
    local config = ConfigManager.getConfig("dharmakayaconfig")
    return config.advunlockneedlevel
end

local function HaveThreePulse(bodyInfo)
    local result = true
    for i = ROUNDNUM,(ROUNDNUM + PULSENUM - 1) do
        if bodyInfo[i] then
            result = false
            break
        end
    end
    return result
end

local function IsAllRoundToLevel(bodyId)
    local result = false   
    local pointsInfo = m_BodyInfos[bodyId].pointsinfo
    if pointsInfo then
        local num = 0
        for i = 0,(ROUNDNUM - 1) do
            if pointsInfo[i] then
                if pointsInfo[i].normallevl and (pointsInfo[i].normallevl >= GetActiveThreePulseLevel()) then
                    num = num + 1
                end
            end
        end
        if num == ROUNDNUM then
            result = true
        end
    end
    return result
end

local function GetUnLockNeedLevel(bodyId,pointId)
    local unlockNeedLevel = 0
    local config = ConfigManager.getConfig("dharmakayaconfig")
    for _,info in pairs(config.pointconfig) do
        if info.num == pointId then
            unlockNeedLevel = info.unlockneedlevel
            break
        end
    end
    return unlockNeedLevel
end

local function IsOpenPoint(bodyId,pointId)
    local result = false
    if pointId == 0 then
        result = true
    elseif pointId <= (ROUNDNUM - 1) then
        if m_BodyInfos[bodyId] then
            local pointsInfo = m_BodyInfos[bodyId].pointsinfo
            if pointsInfo then
                if pointsInfo[pointId - 1] then
                    local pointConfig = GetPointConfigInfo(pointId)
                    if pointConfig.unlockneedlevel <= pointsInfo[pointId - 1].normallevl then
                        result = true
                    end
                end
            end
        end
    else
        if m_BodyInfos[bodyId] then
            local pointsInfo = m_BodyInfos[bodyId].pointsinfo
            if pointsInfo then
                if (m_BodyInfos[bodyId].curspecialpoint == pointId) or (pointsInfo[pointId]) then
                    result = true
                elseif HaveThreePulse(pointsInfo) then
                    if IsAllRoundToLevel(bodyId) then
                        result = true
                    end
                end
            end            
        end
    end
    return result
end

local function GetKeyUpLevel()
    local dharmakayaConfig = ConfigManager.getConfig("dharmakayaconfig")
    return dharmakayaConfig.conlevelup
end

local function GetLevelUpCost(bodyId,pointId)
    local levelUpOneCost
    local keyUpgradeCost
    local level = 0
    if m_BodyInfos[bodyId].pointsinfo[pointId] then
        level = m_BodyInfos[bodyId].pointsinfo[pointId].normallevl
    end
    local levelConfig = ConfigManager.getConfig("nomallevel")
    local bodyLevelInfo
    local nextLevelInfo
    for _,info in pairs(levelConfig) do
        if info.id == bodyId then
            bodyLevelInfo = info
            for _,state in pairs(info.humanstate) do
                if state.level == (level + 1) then
                    nextLevelInfo = state
                    break
                end
            end
            break
        end
    end
    if nextLevelInfo then
        local keyUpLevel = GetKeyUpLevel()
        if pointId <= 6 then
            levelUpOneCost = nextLevelInfo.normalupcost            
            for i = 1,keyUpLevel do
                local nextLevelInfo = bodyLevelInfo.humanstate[level + i]
                if nextLevelInfo then
                    if keyUpgradeCost == nil then
                        keyUpgradeCost = {}
                    end
                    for _,condition in pairs(nextLevelInfo.normalupcost) do
                        if keyUpgradeCost[condition.currencytype] then
                            keyUpgradeCost[condition.currencytype] = keyUpgradeCost[condition.currencytype] + condition.amount
                        else
                            keyUpgradeCost[condition.currencytype] = condition.amount
                        end
                    end
                end
            end
        else
            levelUpOneCost = nextLevelInfo.advupcost
            for i = 1,keyUpLevel do
                local nextLevelInfo = bodyLevelInfo.humanstate[level + i]
                if nextLevelInfo then
                    if keyUpgradeCost == nil then
                        keyUpgradeCost = {}
                    end
                    for _,condition in pairs(nextLevelInfo.advupcost) do
                        if keyUpgradeCost[condition.currencytype] then
                            keyUpgradeCost[condition.currencytype] = keyUpgradeCost[condition.currencytype] + condition.amount
                        else
                            keyUpgradeCost[condition.currencytype] = condition.amount
                        end
                    end
                end
            end
        end
    end
    return levelUpOneCost,keyUpgradeCost
end

local function GetPointInfoById(bodyId,pointId)
    local result
    if m_BodyInfos[bodyId] then
        if m_BodyInfos[bodyId].pointsinfo[pointId] then
            result = m_BodyInfos[bodyId].pointsinfo[pointId]
        else
            if IsOpenPoint(bodyId,pointId) then
                result = {normallevl = 0,breaklevel = 0,curexp = 0 }
            end
        end 
    end 
    return result
end

local function GetBreakInfoByLevel(level)
    return ConfigManager.getConfigData("dharmakayabreakthrough",level)
end

local function GetNormalBreakCost()
    local dharmakayaConfig = ConfigManager.getConfig("dharmakayaconfig")
    return dharmakayaConfig.normalbreakcost
end

local function GetHighBreakCost()
    local dharmakayaConfig = ConfigManager.getConfig("dharmakayaconfig")
    return dharmakayaConfig.highbreakcost
end

local function GetNormalTranslateCost()
    local dharmakayaConfig = ConfigManager.getConfig("dharmakayaconfig")
    return dharmakayaConfig.normalcost
end

local function GetYuanBaoTranslateCost()
    local dharmakayaConfig = ConfigManager.getConfig("dharmakayaconfig")
    return dharmakayaConfig.yuanbaocost
end

local function GetBodyInfoById(bodyId)
    return m_BodyInfos[bodyId]
end

local function GetBreakFreeRemainTime(type)
    local dharmakayaConfig = ConfigManager.getConfig("dharmakayaconfig")
    local breakThroughData
    if type == 0 then
        breakThroughData = dharmakayaConfig.normalbreakcost
    elseif type == 1 then
        breakThroughData = dharmakayaConfig.highbreakcost
    end
    local vipTimes = breakThroughData.vipfree
    local vipLevel = PlayerRole:Instance().m_VipLevel
    local totalTime = 0
    local hasLevel = false
    local i = 0
    for id,value in pairs(vipTimes.entertimes) do
        if (vipLevel == (id - 1)) then
            totalTime = value
            hasLevel = true
            break
        end
        i = i + 1
    end
    if hasLevel ~= true then
        totalTime = vipTimes.entertimes[i] or 0
    end
    local limit = LimitManager.GetLimitTime(cfg.cmd.ConfigId.MAGIC_BODY_BREAK_UP,type)
    local remainTime
    if (limit == nil)  or (limit[cfg.cmd.condition.LimitType.DAY] == nil) then
        remainTime = totalTime
    else
        remainTime = totalTime - limit[cfg.cmd.condition.LimitType.DAY]
        if remainTime < 0 then
            remainTime = 0
        end
    end
    return remainTime,totalTime
end

local function GetAllProperty(bodyId,pointId)
    local bodyInfo = GetBodyInfoById(bodyId)
    local attr = {}
    if bodyInfo.pointsinfo[pointId] then
        attr = bodyInfo.pointsinfo[pointId].attr
    end
    return attr
end

local function GetNextLevelProperty(bodyId,pointId)
    local result = {}
    local config = ConfigManager.getConfig("nomallevel")
    local pointInfo = GetPointInfoById(bodyId,pointId)
    for _, info in pairs(config) do
        if info.id == bodyId then
            for _,stateInfo in pairs(info.humanstate) do
                if stateInfo.level == (pointInfo.normallevl + 1) then
                    if stateInfo.getproperty[pointId + 1] then
                        for _,detail in pairs(stateInfo.getproperty[pointId + 1].gainability) do
                            result[detail.propertytype] = detail.value
                        end
                        break
                    end
                    break
                end 
            end
            break
        end        
    end
    return result
end

local function init()
    NetWork.add_listeners({
       {"lx.gs.magicbody.msg.SLevelUp", OnMsg_SLevelUp},  
       {"lx.gs.magicbody.msg.SBreakUp", OnMsg_SBreakUp},  
       {"lx.gs.magicbody.msg.STranslate", OnMsg_STranslate},  
       {"lx.gs.magicbody.msg.SSyncAttrs", OnMsg_SSyncAttrs},  
       {"lx.gs.magicbody.msg.SStateLevelUpNotify", OnMsg_SStateLevelUpNotify},  
       {"lx.gs.magicbody.msg.SMagicBodyInfo", OnMsg_SMagicBodyInfo},  
    })
end

return
{
    init = init,
    SendCLevelUp = SendCLevelUp,
    SendCBreakUp = SendCBreakUp,
    SendCTranslate = SendCTranslate,
    GetBodyInfoById = GetBodyInfoById,
    GetStateProperty = GetStateProperty,
    GetNextStateNeedLevel = GetNextStateNeedLevel,
    GetBreakProperty = GetBreakProperty,
    GetNextLevelProperty = GetNextLevelProperty,
    IsOpenPoint = IsOpenPoint,
    IsAllRoundToLevel = IsAllRoundToLevel,
    GetLevelUpCost = GetLevelUpCost,
    GetPointInfoById = GetPointInfoById,
    GetBreakInfoByLevel = GetBreakInfoByLevel,
    GetActiveThreePulseLevel = GetActiveThreePulseLevel,
    GetPointName = GetPointName,
    GetNormalBreakCost = GetNormalBreakCost,
    GetHighBreakCost = GetHighBreakCost,
    GetNormalTranslateCost = GetNormalTranslateCost,
    GetYuanBaoTranslateCost = GetYuanBaoTranslateCost,
    GetBreakFreeRemainTime = GetBreakFreeRemainTime,
    GetAllProperty = GetAllProperty,
    GetUnLockNeedLevel = GetUnLockNeedLevel,
    THREEPULSEFRAMENORMALSPRITE = THREEPULSEFRAMENORMALSPRITE,
    THREEPULSEFRAMEGRAYSPRITE = THREEPULSEFRAMEGRAYSPRITE,
    THREEPULSENORMALSPRITE = THREEPULSENORMALSPRITE,
    THREEPULSEGRAYSPRITE = THREEPULSEGRAYSPRITE,
    ROUNDNUM = ROUNDNUM,
    PULSENUM = PULSENUM,
}