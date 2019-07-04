local defineenum = require "defineenum"
local JumpType = defineenum.JumpType
local WorkType =defineenum.WorkType
local Work = require "character.work.work"
local mathutils = require "common.mathutils"

local MAXJUMPCOUNT =1
local FsmState = enum
{
    "None",
    "Jump",
    "JumpLoop",
    "JumpEnd",
}


local JumpWork = Class:new(Work)
function JumpWork:__new()
    Work.__new(self)
    self:reset()
    self.type = WorkType.Jump
end

function JumpWork:reset()
    Work.reset(self)
    self.JumpCount = 0
    self.InitVelocity = 0
    self.ElapseTime = 0
    self.InitPosHeight = 0
    self.MaxPosHeight = 0
    self.OnGround = true
    self.Type = WorkType.Jump
    self.JumpCount = 0
    self.Gravity  = 9.8
    self.JumpType = JumpType.Normal
    self.IsFighting = false
    self.IsPlayingEnd = false
    self:SetState(FsmState.None)
end

function JumpWork:SetState(state)
    if Local.LogModuals.Skill then
    printyellow("JumpWork:SetState(state)",utils.getenumname(FsmState,state))
    end
    self.CurrentState =state
    self.UpdateStateNextFrame = true
end

function JumpWork:GetGravity()
    if self.Character then
        return mathutils.TernaryOperation(self.Character.m_Gravity >0 ,self.Character.m_Gravity,9.8)
    end
    return 9.8
end

function JumpWork:CanMutiJump()
    return MAXJUMPCOUNT >1 and self.JumpCount < MAXJUMPCOUNT
end


function JumpWork:OnStart()
    Work.OnStart(self)
    --printyellow("JumpWork OnStart")
    self.Gravity  = self:GetGravity()
    if self.JumpType == JumpType.Normal then
        self.JumpCount = self.JumpCount+1
        self.InitVelocity = math.sqrt(2* self.Character.m_JumpHeight * self.Character.m_Gravity)
    elseif self.JumpType == JumpType.Fall then
        if self.Character.m_Pos.y<= self.Character:GetGroundHeight(nil) then
            self.Character.m_Pos.y = self.Character:GetGroundHeight(nil)
            self.OnGround = true
            self:End()
            return
        end
        self.InitVelocity = 0
        self.MaxPosHeight = self.Character.m_Pos.y
    end

    self.ElapseTime = 0
    self.IsPlayingEnd = false
    self.InitPosHeight = self.Character.m_Pos.y
    self.OnGround = false
    self:SwitchToJumpState()
end

function JumpWork:OnEnd()
    Work.OnEnd(self)
    --printyellow("JumpWork OnEnd")
    self.JumpCount = 0
    self.OnGround = true
end


function JumpWork:OnUpdate()
    Work.OnUpdate(self)
   
    
    if self.JumpType == JumpType.Normal and self.JumpCount == 1 or self.JumpType == JumpType.Fall  then
        if not self.OnGround then
            self.ElapseTime = self.ElapseTime + Time.deltaTime
            -- jump up
            if self.ElapseTime <= self.InitVelocity / self.Gravity then
                self.Character.m_Pos.y = self.InitPosHeight + self.InitVelocity * self.ElapseTime  - 0.5 * self.Gravity * self.ElapseTime* self.ElapseTime
                self.MaxPosHeight = self.Character.m_Pos.y
                --jump down
            else
                local deltaTime = self.ElapseTime - self.InitVelocity /self.Gravity
                self.Character.m_Pos.y = self.MaxPosHeight - 0.5 * self.Gravity *deltaTime*deltaTime
                if self.CurrentState ~= FsmState.JumpEnd and self.Character.m_Pos.y - self.Character:GetGroundHeight(nil) <1.5 then
                    self:SwitchToJumpEndState()
                return
            end
            end
            if self.Character.m_Pos.y<= self.Character:GetGroundHeight(nil) then
                self.OnGround = true
                self.Character.m_Pos.y = self.Character:GetGroundHeight(nil)
                return
            end

        end
        
        self:UpdateState()

    end
end


function JumpWork:UpdateState()
    if self.UpdateStateNextFrame then
        self.UpdateStateNextFrame = false
        return
    end
    --Jump
    if self.CurrentState == FsmState.Jump then
        self:UpdateJumpState()
        --JumpLoop
    elseif self.CurrentState == FsmState.JumpLoop then
        self:UpdateJumpLoopState()
        --JumpEnd
    elseif self.CurrentState == FsmState.JumpEnd then
        self:UpdateJumpEndState()
    end
end

function JumpWork:UpdateJumpState()
    if not self.Character:IsPlayingJump() then
        self:SwitchToJumpLoopState()
    end
end


function JumpWork:UpdateJumpLoopState()
    if self.OnGround then
        self:SwitchToJumpEndState()
    end
end

function JumpWork:UpdateJumpEndState()
    --printyellow("JumpWork:UpdateJumpEndState()")
    if self.OnGround then
        if self.Character:IsMoving() or not self.Character:IsPlayingJumpEnd() then
            self:End()
            self:SetState(FsmState.None)
        end
    end
end

function JumpWork:SwitchToJumpState()
    if self.IsFighting then
        self.Character:PlayAction(cfg.skill.AnimType.JumpFight)
    else
        self.Character:PlayAction(cfg.skill.AnimType.Jump)
    end
    self:SetState(FsmState.Jump)
end


function JumpWork:SwitchToJumpLoopState()
    if self.IsFighting then
        self.Character:PlayLoopAction(cfg.skill.AnimType.JumpLoopFight)
    else
        self.Character:PlayLoopAction(cfg.skill.AnimType.JumpLoop)
    end
    self:SetState(FsmState.JumpLoop)
end

function JumpWork:SwitchToJumpEndState()
    --[[
    if self:IsPlayer() then 
        if self.IsFighting then
            self.Character:CrossFadeAction(cfg.skill.AnimType.JumpEndFight)
        else
            self.Character:CrossFadeAction(cfg.skill.AnimType.JumpEnd)
        end
    else 
        if self.IsFighting then
            self.Character:PlayAction(cfg.skill.AnimType.JumpEndFight)
        else
            self.Character:PlayAction(cfg.skill.AnimType.JumpEnd)
        end
    end
    --]]
    if self.IsFighting then
            self.Character:PlayAction(cfg.skill.AnimType.JumpEndFight)
        else
            self.Character:PlayAction(cfg.skill.AnimType.JumpEnd)
        end
    
    self:SetState(FsmState.JumpEnd)

end

return JumpWork
