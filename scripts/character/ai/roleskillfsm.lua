-- local RoleSkillFsm  = require "character.ai.roleskillfsm"
local PlayerRole       = require "character.playerrole"
local RoleSkill        = require "character.skill.roleskill"
local AttackActionFsm  = require "character.ai.attackactionfsm"
local DlgUIMain_Combat = require "ui.dlguimain_combat"
local gameevent        = require "gameevent"
local mathutils        = require "common.mathutils"
local Fsm              = require "character.ai.fsm"
local defineenum        = require "defineenum"
local autoaievents      = defineenum.AutoAIEvent

local RoleSkillFsm = Class:new(Fsm)

RoleSkillFsm.FsmState = enum{
    "None",
    "WalkToTarget",
    "Attacking",
    "WaitForNextSkill",
}

function RoleSkillFsm:__new()
    self:reset()
    self.m_CurrentState       = self.FsmState.None        --当前状态
    self.m_CurrentPlayerSkillData = nil                    --当前按下的技能
end

function RoleSkillFsm:reset()
    if Local.LogModuals.Skill then
    printyellow("RoleSkillFsm:reset()")
    end
    Fsm.reset(self)
    self.m_CurrentPlayerSkillData = nil                    --当前按下的技能
    self:SetState(self.FsmState.None)
end


function RoleSkillFsm:SetState(state)
    if Local.LogModuals.Skill then
    printyellow("RoleSkillFsm SetState" ,utils.getenumname(self.FsmState,state))
    end
    self.m_CurrentState = state
    self:ResetElapsedTime()
end

function RoleSkillFsm:GetState()
    return self.m_CurrentState
end

function RoleSkillFsm:ShowTips()

end


function RoleSkillFsm:Update()
    Fsm.Update(self)
    --WalkToTarget
    if self.m_CurrentState == self.FsmState.WalkToTarget then
        self:UpdateWalkToTargetState()
        --Attacking
    elseif self.m_CurrentState == self.FsmState.Attacking then
        self:UpdateAttackingState()
        --WaitForNextSkill
    elseif self.m_CurrentState == self.FsmState.WaitForNextSkill then
        self:UpdateWaitForNextSkillState()

    end
end

function RoleSkillFsm:NavigateTo(targetpos)
    local mapid, currenttargetpos = PlayerRole:Instance():GetNavigateTarget()
    if currenttargetpos == nil or mathutils.DistanceOfXoZ(targetpos, currenttargetpos)>3 then
        if not PlayerRole:Instance():CanReach(targetpos) then
            return false
        end
        PlayerRole:Instance():navigateTo({targetPos = targetpos,notStopAutoFight = true})
        --printyellow("NavigateTo",targetpos.x,targetpos.z)
    end
    return true
end


function RoleSkillFsm:UpdateWalkToTargetState()
    local attackTarget = PlayerRole:Instance():GetTarget()
    if  attackTarget == nil then
   --     printyellow("skillTarget is Dead!")
        self:reset()
        local autoai = require "character.ai.autoai"
        
        if Local.LogModuals.AutoAI then
            print("+++++++target is nil............")
        end
       
        autoai.OnEvent(autoaievents.nomonster)
        return
    end
    if mathutils.DistanceOfXoZ(PlayerRole:Instance():GetRefPos(), attackTarget:GetRefPos()) >
        self.m_CurrentPlayerSkillData:GetCurrentAction().attackrange +
        attackTarget:GetBodyRadius()  then
        --printyellow(mathutils.DistanceOfXoZ(self.Pos, attackTarget.Pos))
        --printyellow("RoleSkillFsm moveTo")
        if not self:NavigateTo(attackTarget.m_Pos) then
            self:reset()

--            local autoai = require "character.ai.autoai"
            print("+++++++ can not nav to...........")
--            autoai.OnEvent("skillover")

            return
        end
    else
        if PlayerRole:Instance():IsMoving() then
            PlayerRole:Instance():stop()
        end
        --local TargetPos = Vector3(attackTarget.Pos.x,PlayerRole:Instance().Pos.y,attackTarget.Pos.z)
        --PlayerRole:Instance().Object.transform:LookAt(Vector3(attackTarget.Pos.x,PlayerRole:Instance().Pos.y,attackTarget.Pos.z))
        local dir = Vector3(attackTarget.m_Pos.x - PlayerRole:Instance().m_Pos.x,0,attackTarget.m_Pos.z - PlayerRole:Instance().m_Pos.z).normalized
        PlayerRole:Instance():SetRotationImmediate(dir)
        self:Attack()
    end
end



function RoleSkillFsm:UpdateAttackingState()
    if self.m_CurrentPlayerSkillData then
        --print("self.elapsedTime",self.elapsedTime ,"self.m_CurrentPlayerSkillData:GetNextExpireSkillCD()",self.m_CurrentPlayerSkillData:GetCurrentSkill():GetNextExpireSkillCD())
        local currentaction = self.m_CurrentPlayerSkillData:GetCurrentAction()
        if currentaction == nil or
           self.elapsedTime > currentaction.endattackingtime +self.m_CurrentPlayerSkillData:GetNextExpireSkillCD() then
            --self.m_CurrentPlayerSkillData:BeginCD()
            self.m_CurrentPlayerSkillData:ResetToFirstSkill()
            self:reset()

            local autoai = require "character.ai.autoai"
            if Local.LogModuals.AutoAI then
                print("+++++++action is nil or time > ............currentaction", currentaction)
            end
            autoai.OnEvent(autoaievents.skillover)
        end
    else
        self:reset()
--        local autoai = require "character.ai.autoai"
--        print("+++++++update attack skilldata is nil ............")
--        autoai.OnEvent("skillover")
    end

end

function RoleSkillFsm:UpdateWaitForNextSkillState()
    if self.m_CurrentPlayerSkillData then
        --print("self.elapsedTime",self.elapsedTime ,"self.m_CurrentPlayerSkillData:GetNextExpireSkillCD()",self.m_CurrentPlayerSkillData:GetCurrentSkill():GetNextExpireSkillCD())
        if self.m_CurrentPlayerSkillData:GetNextSkill() == nil or
           self.elapsedTime > self.m_CurrentPlayerSkillData:GetNextExpireSkillCD() then
            --self.m_CurrentPlayerSkillData:BeginCD()
            self.m_CurrentPlayerSkillData:ResetToFirstSkill()
            self:reset()

--            local autoai = require "character.ai.autoai"
--            print("+++++++next skill is nil now............")
--            autoai.OnEvent("skillover")
        end
    else
        self:reset()
--        local autoai = require "character.ai.autoai"
--        print("+++++++wait for next skill, skill data is nil   ............")
--        autoai.OnEvent("skillover")
    end
end


function RoleSkillFsm:CanAttack(playerskilldata)
    if playerskilldata == nil then
        return false
    end
    if Local.LogModuals.Skill then
    printyellow("playerskilldata.m_LeftCD",tostring(playerskilldata.m_LeftCD))
    end
    if self.m_CurrentState  == self.FsmState.Attacking then
        if playerskilldata:CanAttack() then
            return not playerskilldata:GetCurrentSkill():IsNormal() and self.m_CurrentPlayerSkillData:GetCurrentSkill():IsNormal()
        end
    elseif self.m_CurrentState  == self.FsmState.WaitForNextSkill then
        if self.m_CurrentPlayerSkillData.m_SkillSlotIndex == playerskilldata.m_SkillSlotIndex then
            return playerskilldata:CanAttackNext()
        else
            return playerskilldata:CanAttack()
        end
    elseif self.m_CurrentState  == self.FsmState.WalkToTarget then
        if self.m_CurrentPlayerSkillData.m_SkillSlotIndex == playerskilldata.m_SkillSlotIndex then
            return false
        else
            return self.m_CurrentPlayerSkillData:GetCurrentSkill():IsNormal() and not playerskilldata:GetCurrentSkill():IsNormal() and playerskilldata:CanAttack()
        end
    else
        return playerskilldata:CanAttack()
    end

    return false
end

function RoleSkillFsm:TryToAttack(playerskilldata)
    if self.m_CurrentPlayerSkillData then
        if self.m_CurrentPlayerSkillData.m_SkillSlotIndex == playerskilldata.m_SkillSlotIndex then
            self.m_CurrentPlayerSkillData:PlayNextSkill()
        else
            self.m_CurrentPlayerSkillData:ResetToFirstSkill()
        end
    end
    self.m_CurrentPlayerSkillData = playerskilldata
    local relation =  self.m_CurrentPlayerSkillData:GetCurrentSkill():GetRelation()
    if(self.m_CurrentPlayerSkillData:GetCurrentAction().needtarget) then
        local target = PlayerRole:Instance():GetTargetToAttack(relation)
        if target == nil then
            self:reset()
--            local autoai = require "character.ai.autoai"
            print("+++++++target is nil now............")
--            autoai.OnEvent("nomonster")
            local UIManager = require("uimanager")
            UIManager.ShowSystemFlyText(LocalString.FlyText_NoTarget)
            --printyellow("There is no Target!")
            return
        end
        PlayerRole:Instance():SetTarget(target)
        self:SetState(self.FsmState.WalkToTarget)
    else
        if cfg.role.Const.SMART_ATTACK>0 then
            --智能施法
            local target = PlayerRole:Instance():GetTargetToAttack(relation)
            if target == nil then
                self:Attack()
            else
                PlayerRole:Instance():SetTarget(target)
                self:SetState(self.FsmState.WalkToTarget)
            end
        else
            --非智能施法，技能可能打空
            self:Attack()
        end
    end

end

function RoleSkillFsm:Attack()
    if self.m_CurrentPlayerSkillData == nil or self.m_CurrentPlayerSkillData:GetCurrentSkill() == nil then
        self:reset()
--        local autoai = require "character.ai.autoai"
--        print("+++++++current skill nil ............")
--        autoai.OnEvent("skillover")
        return
    end
    if Local.LogModuals.Skill then
    printyellow("RoleSkillFsm:Attack()",self.m_CurrentPlayerSkillData:GetCurrentSkill().skillid)
    end
    PlayerRole:Instance():SendAttack(self.m_CurrentPlayerSkillData:GetCurrentSkill().skillid)
    if self.m_CurrentPlayerSkillData:IsFirstSkill() then
        self.m_CurrentPlayerSkillData:BeginCD()
    end
    self:SetState(self.FsmState.Attacking)
end




function RoleSkillFsm:OnButtonCastSkill(index)
    local playerskilldata = RoleSkill.GetRoleSkillByIndex(index)
    if Local.LogModuals.Skill then
     printyellow("RoleSkillFsm:OnButtonCastSkill(index)",index,"skillid:",playerskilldata:GetCurrentSkill().skillid)
     printyellow("self:CanAttack(playerskilldata)",self:CanAttack(playerskilldata))
     end
     if self:CanAttack(playerskilldata) then
        self:TryToAttack(playerskilldata)
     else
        if playerskilldata==nil or playerskilldata:GetCurrentSkill() == nil then 
            logError("playerskilldata is nil")
--        elseif self.m_CurrentState == self.FsmState.Attacking then
--            DlgUIMain_Combat.ShowSkillTips(LocalString.DlgUIMain_Attacking)
        elseif  not PlayerRole:Instance():CanPlaySkill(playerskilldata:GetCurrentSkill().skillid) then 
            DlgUIMain_Combat.ShowSkillTips(LocalString.DlgUIMain_CannotAttack)
        elseif index ~= 0 then
            playerskilldata:ShowTips()
        end
     end
end

function RoleSkillFsm:OnJoyStickMove(delta)
    if self.m_CurrentState == self.FsmState.WalkToTarget then
        self:reset()
        return
    elseif self.m_CurrentState == self.FsmState.Attacking then
        if not PlayerRole:Instance():CanMove() and PlayerRole:Instance():CanRotate() then
            PlayerRole:Instance():SetRotation(delta)
            PlayerRole:Instance():SendOrient(delta)
        end
    end
end


function RoleSkillFsm:NotifyAttackComplete(bCastCallBackSkill)
    --print(self.m_CurrentPlayerSkillData)
    if self.m_CurrentPlayerSkillData == nil then
        return
    end
    if self.m_CurrentPlayerSkillData:GetNextSkill() then
        self:SetState(self.FsmState.WaitForNextSkill)
    else
        --self.m_CurrentPlayerSkillData:BeginCD()
        self.m_CurrentPlayerSkillData:ResetToFirstSkill()
        self:reset()
    end

    DlgUIMain_Combat.NotifyAttackComplete(self.m_CurrentPlayerSkillData)

	--local GameAI = require"character.ai.gameai"

	--GameAI.CastNormalAttack()

    local autoai = require "character.ai.autoai"
    --print("+++++++skill complete now............")
    autoai.OnEvent(autoaievents.skillover)

end


function RoleSkillFsm:NotifyAttackBeBroken(skillid)
    if self.m_CurrentPlayerSkillData~=nil and self.m_CurrentPlayerSkillData:HasSkill(skillid) then
        --self.m_CurrentPlayerSkillData:BeginCD()
        self.m_CurrentPlayerSkillData:ResetToFirstSkill()
        self:reset()


        local autoai = require "character.ai.autoai"
        if Local.LogModuals.AutoAI then
            print("+++++++skill be broken now............")
        end
        autoai.OnEvent(autoaievents.skillover)

    end
end



-----------------------------------------
---------自动挂机 Begin
-----------------------------------------
function RoleSkillFsm:TryToAttackBySkillId(skillid)
    local playerskilldata = RoleSkill.GetRoleSkill(skillid)
    if self:CanAttack(playerskilldata) then
        self:TryToAttack(playerskilldata)
        return true
    end
    return false
end


function RoleSkillFsm:CanAttackNext(skillid)
    local playerskilldata = RoleSkill.GetRoleSkill(skillid)
    if playerskilldata == nil then
        return false
    end
    return playerskilldata:CanAttackNext()
end

-----------------------------------------
---------自动挂机 End
-----------------------------------------






return RoleSkillFsm