local defineenum           = require "defineenum"
local WorkType             = defineenum.WorkType
local Fsm                  = require "character.ai.fsm"
local event                = require "character.event.event"
local SkillManager         = require "character.skill.skillmanager"
--local charactermanager
local CurveManager         = require "curvemanager"
local sceneManager         = require "scenemanager"

local BeAttackActionFsm = Class:new(Fsm)
function BeAttackActionFsm:__new(character)
    self:reset()
    self.BeAttacker = character
    --charactermanager = require "character.charactermanager"
end

BeAttackActionFsm.FsmState = enum{
        "None=0",
        "DelayedAction",
        "ReturnToReady",
        "FlyingInTheAir",
        "DropInTheAir",
        "DeadInTheAir",
        "ClimbingUp",
}

function BeAttackActionFsm:reset()
    Fsm.reset(self)
    self:SetState(BeAttackActionFsm.FsmState.None)
end

-- function BeAttackActionFsm:Init(character)
--     self.BeAttacker = character
-- end

function BeAttackActionFsm:SetBeAttackedAction(attacker,info)
    local targetaction = info.TargetAction
    self:reset()
    self.attacker = attacker
    self.targetaction = targetaction
    -- if self.attacker == nil or self.targetaction == nil then
    --     return
    -- end
    self:Start()
end

function BeAttackActionFsm:SetState(state)
    self.CurrentState = state
end

function BeAttackActionFsm:Start()
    Fsm.Start(self)
    self:SetState(self.FsmState.DelayedAction)
    self.elapsedTime=0
    if self.BeAttacker:IsIdle() then
        self:PlayHurtAnimation()
    end
    self.BeAttacker.WorkMgr:SetJudgeNeedIdle(false)  
end


function BeAttackActionFsm:PlayHurtAnimation()
    if self.BeAttacker.AnimationMgr then
        self.UpdateStateNextFrame = true
        if ((self.BeAttacker:IsPlayer()) and (self.BeAttacker:IsRiding())) then
            return
        end
        if not self.BeAttacker:IsPlayingAction(self.targetaction) then 
            self.BeAttacker:PlayAction(self.targetaction)
        end
    end
end

function BeAttackActionFsm:Update()
    Fsm.Update(self)
    if self.UpdateStateNextFrame then
        self.UpdateStateNextFrame = false
        return
    end
    if self.CurrentState == self.FsmState.DelayedAction then
        self:UpdateDelayedActionState()
    -- elseif self.CurrentState == self.FsmState.FlyingInTheAir then
    --     self:UpdateFlyingInTheAirState()
    -- elseif self.CurrentState == self.FsmState.ReturnToReady then
    --     self:UpdateReturnToReadyState()
    -- elseif self.CurrentState == self.FsmState.DropInTheAir then
    --     self:UpdateDropInTheAirState()
    -- elseif self.CurrentState == self.FsmState.ClimbingUp then
    --     self:UpdateClimbingUpState()
    end
end

function BeAttackActionFsm:UpdateDelayedActionState()
    if self.BeAttacker:IsDead() then
        self:SetState(self.FsmState.None)
        return
    end
    if not self.BeAttacker:IsPlayingAction(self.targetaction) then
        self.BeAttacker.WorkMgr:SetJudgeNeedIdle(true)
        self:SetState(self.FsmState.None)
    end
end

return BeAttackActionFsm
