local NavigationHelper  = require("character.navigation.navigationhelper.navigationhelper")
local StateDelay        = require("character.navigation.navigationstate.statedelay")
local StateEndSet       = require("character.navigation.navigationstate.stateendset")
local StateNavToMap     = require("character.navigation.navigationstate.statenavtomap")
local StateNavToPos     = require("character.navigation.navigationstate.statenavtopos")
local StateStartSet     = require("character.navigation.navigationstate.statestartset")
local UIManager         = require("uimanager")

local NavigationStateType = {
    Stop = 0,
    Create = 1,
    Start = 2,
}


local NavigationController = Class:new()

function NavigationController:__new(player)
    self.m_Player = player
    self.m_Params = nil
    self.m_ParamsForSave = nil
    self.m_NavMode = nil
    self.m_DefaultNavMode =(((cfg.role.Const.LOCAL_NAVMESH == 1) and true) or false)
    self:Reset()
end

function NavigationController:GetNavMode()
    return self.m_DefaultNavMode
end

function NavigationController:Reset()
    self.m_NavigationState  = NavigationStateType.Stop
    self.m_StateList        = {}
    self.m_Callback         = { End = nil, Stop = nil, }
    self.m_Target           = { MapId = nil, Position = nil}
    self.m_CurrentState     = nil
    self.m_IsPause          = false
    self.m_LocalMode        = self:GetNavMode()
    self.m_Params           = nil
    self.m_NavMode          = nil
end

function NavigationController:SetNavMode(isLocal)
    self.m_DefaultNavMode = isLocal
end

function NavigationController:StartNavigate(params)
    self.m_Params = params
    self.m_ParamsForSave = params
end

function NavigationController:StartNavigate2(params)
   --printyellowmodule( Local.LogModuals.Navigate,"StartNavigate2")
--[[ {   targetPos = 目标位置, callback = 导航结束后的回调函数, newStopLength = 距离目标点的停止距离, isAdjustByRideState = 根据骑乘状态调整停止距离,
        mapId = 目标地图, lineId, navMode = 导航模式(), endDir = 结束方向,stopCallback = 终止会掉,
        lengthCallback = {[1] = {length = xxx,callback = function()},[2] = {length = xxx,callback = function() }} 一定距离时调用,
        isShowAlert = 是否显示弹窗（默认显示）
        }
--]]
    --检测输入参数

    self:Reset()
    local para = NavigationHelper.CheckParams(params,self.m_Player)
    if para == nil then
        return
    end

    --[[
        重设置之后的参数
        targetPos = 目标地点，endDir = 结束时人物转角， mapId, lineId= 目标地图，endCallback = 结束回调，stopCallback = 终止回调
    ]]
    self.m_Callback.End     = para.endCallback    or function() end
    self.m_Callback.Stop    = para.stopCallback   or function() end
    self.m_Target.MapId     = para.mapId
    self.m_Target.Position  = para.targetPos
    self.m_NavMode          = para.mode
    --[[
        第一种情况：同图导航
    ]]
    if para.mode == 0 then
        --printyellowmodule( Local.LogModuals.Navigate,"params.mode 0 同图导航，目标点：" .. tostring(para.targetPos))
        table.insert(self.m_StateList,
                    StateStartSet:new(self, para.mapId, para.lineId, false))             --起始设置
        table.insert(self.m_StateList,
                    StateNavToPos:new(self, para.targetPos, para.stopLength, para.isAdjustByRideState, para.lengthCallback, self.m_LocalMode))            --传送至目标地图
        table.insert(self.m_StateList,
                    StateEndSet:new(self, para.endDir))                                  --设置结束人物状态
    --[[
        第二种情况：直接传送式跨图导航
    ]]
    elseif para.mode == 1 then
        --printyellowmodule( Local.LogModuals.Navigate,"params.mode 1 直接传送式跨图导航，目标点：".. tostring(para.targetPos))
        table.insert(self.m_StateList,
                    StateStartSet:new(self, para.mapId, para.lineId, para.isShowAlert))  --起始设置
        table.insert(self.m_StateList,
                    StateNavToMap:new(self, true, para.mapId, para.lineId, nil))         --传送至目标地图
--        table.insert(self.m_StateList, StateDelay:new(self, 0))                                             --等待
        table.insert(self.m_StateList,
                    StateNavToPos:new(self, para.targetPos, para.stopLength, para.isAdjustByRideState,para.lengthCallback, self.m_LocalMode))            --移动至目标地点
        table.insert(self.m_StateList,
                    StateEndSet:new(self, para.endDir))                                  --设置结束人物状态
    --[[
        第三种情况：临近地图跑步至传送点
    ]]
    elseif para.mode == 2 then
        --printyellowmodule( Local.LogModuals.Navigate, "params.mode 2 临近地图跑步至传送点，目标点：".. tostring(para.targetPos))
        table.insert(self.m_StateList,
                    StateStartSet:new(self, para.mapId, para.lineId, false))             --起始设置
        table.insert(self.m_StateList,
                    StateNavToPos:new(self, para.portalPos, nil, false,nil,self.m_LocalMode))                        --传送至传送点
        table.insert(self.m_StateList,
                    StateNavToMap:new(self, false, para.mapId, para.lineId, para.portalId)) --传送至目标地图
--        table.insert(self.m_StateList, StateDelay:new(self, 0))                                             --等待
        table.insert(self.m_StateList,
                    StateNavToPos:new(self, para.targetPos, para.stopLength,para.isAdjustByRideState,para.lengthCallback, self.m_LocalMode))            --移动至目标地点
        table.insert(self.m_StateList,
                    StateEndSet:new(self, para.endDir))                                  --设置结束人物状态
    elseif para.mode == 3 then
            
    end

    self.m_NavigationState = NavigationStateType.Create
end

function NavigationController:Update()
    if self.m_IsPause == true then
        return
    end

    if self.m_Params then
        --printyellowmodule( Local.LogModuals.Navigate,"canmove",self.m_Player:CanMove())
        if self.m_Player:CanMove() == true then
            self:StartNavigate2(self.m_Params)
            self.m_Params = nil
        end
    end

    if self.m_NavigationState < NavigationStateType.Create then
        return
    end
 --   printyellow("NavigationController Loop")

    if self.m_CurrentState == nil then
      --  printyellow("self.m_StateList",#self.m_StateList)
        if #self.m_StateList <= 0 then
            self:EndNavigate()
            return
        else
            self.m_CurrentState = self.m_StateList[1]
            table.remove(self.m_StateList, 1)
        --    printyellow("###########", self.m_CurrentState.m_Type)
            self.m_CurrentState:Start()

        end
    else
        if not self.m_CurrentState:IsEnd() then
            self.m_CurrentState:Update()
        else
            self.m_CurrentState = nil
        end
    end


end
--=============================================================================================
--[[
    导航开始、结束
]]
function NavigationController:OnStart()
   -- printyellow("OnStart")
    self.m_NavigationState = NavigationStateType.Start
    if self.m_Player:IsRole() then
        UIManager.call("dlguimain","SetTargetHoming",{pathFinding=true})
    end
end

function NavigationController:OnEnd()
    self.m_NavigationState = NavigationStateType.Stop
    --self:Reset()
    if UIManager.isshow("dlguimain") then
        UIManager.call("dlguimain","CloseTargetHoming")
    end
end
--=============================================================================================
function NavigationController:OnEnterMap(mapId)
    --printyellow("..........................................")
    if self:IsNavigating() == false then
        return
    end
    if mapId == nil or self.m_Target.MapId ~= mapId then
        
        self:StopNavigate()
    end
end
--=============================================================================================
--[[
    暂停、重新开始、结束、停止导航
]]
function NavigationController:PauseNavigate()
    self.m_IsPause = true
end

function NavigationController:RestartNavigate(isReset)
    self.m_IsPause = false
    if isReset == true then
        self:StartNavigate(self.m_ParamsForSave)
    end
end

function NavigationController:EndNavigate()
    if self.m_Callback ~= nil and self.m_Callback.End ~= nil then
        --printyellowmodule( Local.LogModuals.Navigate,"结束时回调")
        self.m_Callback.End()
    end
    self:OnEnd()
    --printyellowmodule( Local.LogModuals.Navigate,"导航正常结束")
end

function NavigationController:StopNavigate()
    if self.m_Callback ~= nil and self.m_Callback.Stop ~= nil then
        --printyellowmodule( Local.LogModuals.Navigate,"停止时回调")
        self.m_Callback.Stop()
    end
    self:OnEnd()
    local TaskManager=require"taskmanager"
    TaskManager.SetExecutingTask(0)
    --printyellowmodule( Local.LogModuals.Navigate,"导航中断")
end

function NavigationController:IsPaused()
    return self.m_IsPause
end

function NavigationController:IsNavigating()
  --  printyellow("IsNavigating",self.m_NavigationState,(((self.m_NavigationState == 2) and true) or false))
    return (((self.m_NavigationState == 2) and true) or false)
end

function NavigationController:GetTargetInfo()
    if self:IsNavigating() then
        return self.m_ParamsForSave.mapId,self.m_ParamsForSave.targetPos
    end
    return nil,nil
end

function NavigationController:GetTargetParams()
    if self:IsNavigating() then
        return self.m_ParamsForSave
    end
    return nil
end

function NavigationController:Restart()
    if self.m_ParamsForSave then
        self.m_Params = self.m_ParamsForSave
    end
end


return NavigationController
