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
local rebornData = nil
local openType = 0 --0 活动关闭 1 活动开启投票阶段 2 投票关闭领奖阶段
local localOpenType = 0
local activityId = 0
local serverData = {
    allXFNum = 0,
    allDXNum = 0,
    m_XFNum =  0,
    m_DXNum = 0,
    handNum = 0,
    dayState = 0,
    finalState = 0,
    todayNum   = 0, 
}

local function getOpenState()
    return openType
end

local function getRedSpriteState()
    local res = false
    if rebornData then
        local times = serverData.todayNum
        if (BagManager.GetItemNumById(rebornData.needitem)>0 and times < rebornData.dailyup.num and getOpenState() == 1 ) or (serverData.dayState == 0 and serverData.handNum >= rebornData.gradeneedtimes) then
            res = true
        end
        if  serverData.finalState == 0 and getOpenState() == 2 then
            res = true
        end
    end
    return res
end

local function getLocalOpenState()
    return localOpenType
end

local function synchroOpenState()
    localOpenType = openType 
end

local function getActivityId()
    return  activityId
end

local function npcShowOrHide(npcid) --显示道玄和张小凡
    local res = false
    if npcid == rebornData.npcmsg1.npcid or npcid == rebornData.npcmsg2.npcid then
        if getOpenState() ==1 then
            res = true
        end
    end
    if npcid == rebornData.npcmsg1.winnpc  then
        if getOpenState() == 2 and serverData.allXFNum >= serverData.allDXNum then
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
    if rebornData then
        npcIsShow(rebornData.npcmsg1.npcid)
        npcIsShow(rebornData.npcmsg2.npcid)
        npcIsShow(rebornData.npcmsg1.winnpc) 
    end
end

local function OnMsg_SSyncRoleScore(msg)
    serverData.handNum = tonumber(msg.today)
    serverData.m_XFNum = tonumber(msg.npc1)
    serverData.m_DXNum = tonumber(msg.npc2)
    activityId = msg.activityid
    serverData.todayNum = tonumber(msg.today)
    serverData.dayState = tonumber(msg.dailystate)
    serverData.finalState = tonumber(msg.finalstate)

    if UIManager.isshow("resurgencebiyao.dlgresurgencebiyao") then
        UIManager.call("resurgencebiyao.dlgresurgencebiyao","refresh")
    end

    if UIManager.isshow("dlguimain") then
        UIManager.call("dlguimain","refresh")
    end
end

local function OnMsg_SSyncNPCScore(msg)
    serverData.allXFNum = tonumber(msg.npc1)
    serverData.allDXNum = tonumber(msg.npc2)
    openType = msg.stage
    activityId = msg.activityid
    printt(ConfigManager.getConfig("reborn"))
    rebornData = ConfigManager.getConfig("reborn")[activityId]
    if UIManager.isshow("resurgencebiyao.dlgresurgencebiyao") then
        UIManager.call("resurgencebiyao.dlgresurgencebiyao","refresh")
    end
    if UIManager.isshow("dlguimain") then
        UIManager.call("dlguimain","refresh")
    end
end

local function OnMsg_STakeDailyBonus(msg)
    if msg.activityid == activityId then
        serverData.dayState = 1
    end

    if UIManager.isshow("resurgencebiyao.dlgresurgencebiyao") then
        UIManager.call("resurgencebiyao.dlgresurgencebiyao","refresh")
    end

    if UIManager.isshow("dlguimain") then
        UIManager.call("dlguimain","refresh")
    end
end

local function OnMsg_STakeFinalBonus(msg)
    if msg.activityid == activityId then
        serverData.finalState = 1
    end
    
    if UIManager.isshow("resurgencebiyao.dlgresurgencebiyao") then
        UIManager.call("resurgencebiyao.dlgresurgencebiyao","refresh")
    end
    if UIManager.isshow("dlguimain") then
        UIManager.call("dlguimain","refresh")
    end
end

local function OnMsg_SDeliver(msg)
    serverData.handNum = tonumber(msg.today)
    serverData.m_XFNum = tonumber(msg.npc1)
    serverData.m_DXNum = tonumber(msg.npc2)
    activityId = msg.activityid
    serverData.todayNum = tonumber(msg.today)
    serverData.allXFNum = tonumber(msg.totalnpc1)
    serverData.allDXNum = tonumber(msg.totalnpc2)

    if UIManager.isshow("resurgencebiyao.dlgresurgencebiyao") then
        UIManager.call("resurgencebiyao.dlgresurgencebiyao","refresh")
    end
    if UIManager.isshow("dlguimain") then
        UIManager.call("dlguimain","refresh")
    end
end

local function getserverData()
    return serverData
end

local function init()
    --
	network.add_listeners({
        {"lx.gs.rebornbiyao.msg.SSyncRoleScore",OnMsg_SSyncRoleScore},
        {"lx.gs.rebornbiyao.msg.SSyncNPCScore",OnMsg_SSyncNPCScore},
        {"lx.gs.rebornbiyao.msg.STakeDailyBonus",OnMsg_STakeDailyBonus},
        {"lx.gs.rebornbiyao.msg.STakeFinalBonus",OnMsg_STakeFinalBonus},
        {"lx.gs.rebornbiyao.msg.SDeliver",OnMsg_SDeliver},
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
    isShowNpc     = isShowNpc,
    getActivityId = getActivityId
}	