local PlayerRole 			= require "character.playerrole"
local network 				= require "network"
local ConfigMgr 			= require "cfg.configmanager"
local charactermanager = require "character.charactermanager"
local UIManager 			= require("uimanager")
local ItemManager			= require("item.itemmanager")
local ItemIntroduction		= require("item.itemintroduction")
local TimeUtils             = require "common.timeutils"
local BagManager            = require "character.bagmanager"
local LimitManager          = require "limittimemanager"
local rebornData
local openType = 0 --0 活动关闭 1 活动开启投票阶段 2 投票关闭领奖阶段
local localOpenType = 0
local serverData = {
    allPlayerOneNum = 0, --碧瑶
    allPlayerTwoNum = 0, --雪琪
    m_PlayerOne =  0,
    m_PlayerTwoNum = 0,
    handNum = 0,
    dayState = 0,
    finalState = 0, 
}

local function GetTimeByDate(newDate)  
    local t = os.time({year= newDate.year,month=newDate.month,day=newDate.day, hour=newDate.hour, min=newDate.minute, sec=newDate.second})
    return t
end

local function getOpenState()
    local nowTime = TimeUtils.GetServerTime()
    openType = 0
    if nowTime >= GetTimeByDate(rebornData.datetime.begintime) and nowTime< GetTimeByDate(rebornData.datetime.endtime) then
        openType = 1 
    end
    if nowTime >= GetTimeByDate(rebornData.awardtime.begintime) and nowTime< GetTimeByDate(rebornData.awardtime.endtime) then
        openType = 2 
    end
    return openType
end

local function getRedSpriteState()
    local res = false
    local times = LimitManager.GetDayLimitTime(cfg.cmd.ConfigId.NEW_YEAR_GIFT,0)
    if (BagManager.GetItemNumById(rebornData.needitem)>0 and times < rebornData.dailyup.num and getOpenState() == 1 ) or (serverData.dayState == 0 and serverData.handNum >= rebornData.gradeneedtimes) then
        res = true
    end
    if  serverData.finalState == 0 and getOpenState() == 2 then
        res = true
    end
    return res
end

local function getLocalOpenState()
    return localOpenType
end

local function synchroOpenState()
    localOpenType = openType 
end

local function npcShowOrHide(npcid) 
    local res = false
    if npcid == rebornData.npcmsg1.npcid or npcid == rebornData.npcmsg2.npcid then
        if getOpenState() ==1 then
            res = true
        end
    end
    if npcid == rebornData.npcmsg1.winnpc  then
        if getOpenState() == 2 and serverData.allPlayerOneNum >= serverData.allPlayerTwoNum then
            res = true
        end
    end
    return res
end

local function getLocalConfig()
    return rebornData
end

local function npcIsShow(npcid)
   local character = charactermanager.GetCharacterByCsvId(npcid)
    if character then
        if npcShowOrHide(npcid) then
            character:Show()
        else
            character:Hide()
        end
    end
end

local function isShowNpc()
    npcIsShow(rebornData.npcmsg1.npcid)
    npcIsShow(rebornData.npcmsg2.npcid)
    npcIsShow(rebornData.npcmsg1.winnpc) 
end

local function OnMsg_SNewYearSyncRoleScore(msg)
    serverData.handNum = tonumber(msg.today)
    serverData.m_PlayerOne = tonumber(msg.npc1)
    serverData.m_PlayerTwoNum = tonumber(msg.npc2)

    if UIManager.isshow("newyear.dlgnewyeargifts") then
        UIManager.call("newyear.dlgnewyeargifts","refresh")
    end

    if UIManager.isshow("dlguimain") then
        UIManager.call("dlguimain","refresh")
    end
end

local function OnMsg_SNewYearSyncNPCScore(msg)
    serverData.allPlayerOneNum = tonumber(msg.npc1)
    serverData.allPlayerTwoNum = tonumber(msg.npc2)
    if UIManager.isshow("newyear.dlgnewyeargifts") then
        UIManager.call("newyear.dlgnewyeargifts","refresh")
    end
    if UIManager.isshow("dlguimain") then
        UIManager.call("dlguimain","refresh")
    end
end

local function OnMsg_SNewYearSyncBonusState(msg)
    serverData.dayState = tonumber(msg.dailystate)
    serverData.finalState = tonumber(msg.finalstate)

    if UIManager.isshow("newyear.dlgnewyeargifts") then
        UIManager.call("newyear.dlgnewyeargifts","refresh")
    end

    if UIManager.isshow("dlguimain") then
        UIManager.call("dlguimain","refresh")
    end
end

local function getserverData()
    return serverData
end

local function init()
    rebornData = ConfigManager.getConfig("newyear")
    local nowTime = TimeUtils.GetServerTime()
    localOpenType = 0
    if nowTime >= os.time(rebornData.datetime.begintime) and nowTime<= os.time(rebornData.datetime.endtime) then
        localOpenType = 1 
    end
    if nowTime >= os.time(rebornData.awardtime.begintime) and nowTime<= os.time(rebornData.awardtime.endtime) then
        localOpenType = 2 
    end
	network.add_listeners({
        {"lx.gs.newyeargift.msg.SNewYearSyncRoleScore",OnMsg_SNewYearSyncRoleScore},
        {"lx.gs.newyeargift.msg.SNewYearSyncNPCScore",OnMsg_SNewYearSyncNPCScore},
        {"lx.gs.newyeargift.msg.SNewYearSyncBonusState",OnMsg_SNewYearSyncBonusState},
    })
end




return {
	init = init,
	refresh = refresh,
    getLocalConfig = getLocalConfig,
    getserverData = getserverData,
    getOpenState = getOpenState,
    npcShowOrHide = npcShowOrHide,
    getLocalOpenState = getLocalOpenState,
    synchroOpenState = synchroOpenState,
    getRedSpriteState = getRedSpriteState,
    isShowNpc     = isShowNpc
}	