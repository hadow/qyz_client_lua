local DefineEnum = require "defineenum"
local Define = require "define"
local AnimType=Define.AnimType
local WorkType = DefineEnum.WorkType
local CharState = DefineEnum.CharState
local Work = require "character.work.work"
local MathUtils = require "common.mathutils"
local CharacterType=DefineEnum.CharacterType
local SceneMgr=require "scenemanager"
--local AudioManager = require"audiomanager"

local MoveWork = Class:new(Work)

function MoveWork:__new()
    Work.__new(self)
    self:reset()
    self.type = WorkType.Move
end

function MoveWork:reset()
    Work.reset(self)
    self.m_Dir = Vector3.zero
    self.Target = Vector3.zero
  --  self.SkillTarget = nil
    -- Character
  --  self.ToCastSkill = nil
    -- Skill
    self.YUpdateEnd = true
    self.Speed = 5
    self.NewSpeed = nil
end

function MoveWork:CanDo()
    if not Work.CanDo(self) then
        return false
    end
    return self.Character:CanMove()
 --   if not self.Character:CanMove() then
 --       return false
  --  end

  --  return true
end



function MoveWork:OnStart()
    Work.OnStart(self)
    local charPos = self.Character:GetRefPos()
    self.m_Dir = Vector3(self.Target.x - charPos.x, 0, self.Target.z - charPos.z).normalized
    self.Character:SetRotation(self.m_Dir)

    if self.NewSpeed ~= nil then
        self.Speed = self.NewSpeed
    else
        self.Speed = self.Character.m_Attributes[cfg.fight.AttrId.MOVE_SPEED]
    end
    self:PlayRunAnimation()
end



function MoveWork:OnEnd()  
    Work.OnEnd(self)
    if (self.Character:IsRole()) or ((self.Character:IsMount()) and (self.Character:PlayerIsRole())) then
        self.Character.m_TransformSync:SendStop()
    end
end

function MoveWork:OnUpdate()

    Work.OnUpdate(self)
    if self.Character:HasState(CharState.Air) then
        self:UpdatePosY()
    end
    self:UpdatePos()
end 

function MoveWork:NeedPlayRunAnimation() 
    if self.Character:IsJumping() or self.Character:IsAttacking() then
        return false
    end 

    if self.Character:IsMonster() then
        if self.Speed >3 then
            return not self.Character:IsPlayingAction(cfg.skill.AnimType.RunFight)
        else 
            return not self.Character:IsPlayingAction(cfg.skill.AnimType.Walk)
        end
    elseif self.Character:IsPlayer() and self.Character:IsRiding() then
        return false
    end

    return not self.Character:IsPlayingRun()
end 

function MoveWork:PlayRunAnimation()
    if not self:NeedPlayRunAnimation() then
        return 
    end 

    if self.Character:IsMonster() then
        if self.Speed >3 then
            self.Character:PlayLoopAction(cfg.skill.AnimType.RunFight)
        else 
            self.Character:PlayLoopAction(cfg.skill.AnimType.Walk)
        end
    elseif self.Character:IsMount() then
        self.Character:PlayRunWithPlayer()
    else
        if not self.Character:IsPlayingRun() then
            if self.Character.m_IsFighting then
                self.Character:PlayLoopAction(cfg.skill.AnimType.RunFight)
            else
                self.Character:PlayLoopAction(cfg.skill.AnimType.Run)
            end
        end
    end
    
end

function MoveWork:ResumeWork()
    self:PlayRunAnimation()
end 

function MoveWork:UpdatePosY()
    
    local RealDisY = self.Target.y - self.Character:GetRefPos().y
    if math.abs(RealDisY) > 0.1 then
        local moveDis = self.Speed * Time.deltaTime
        local offsetY = MathUtils.TernaryOperation(moveDis >= math.abs(RealDisY), RealDisY, moveDis * RealDisY / math.abs(RealDisY))
        self.Character.m_OffsetY = self.Character.m_OffetY + offsetY
        --self.Character:GetPos() = self.Character:GetPos() + Vector3(0, offsetY, 0)
        self.YUpdateEnd = false
    else
        self.YUpdateEnd = true
    end
end

-- function MoveWork:GetShiftlDir()
--     local x=math.sqrt(math.pow(self.m_Dir.z,2)/(math.pow(self.m_Dir.x,2)+math.pow(self.m_Dir.z,2)))
--     local verVec1=Vector3(x,0,-(x*self.m_Dir.x/self.m_Dir.z))
--     local verVec2=Vector3(-x,0,(x*self.m_Dir.x/self.m_Dir.z))
--     local vec1=Vector3.Slerp(self.m_Dir,verVec1,0.5)
--     local vec2=Vector3.Slerp(self.m_Dir,verVec2,0.5)
--     return vec1,vec2
-- end

-- function MoveWork:ChangeDir(charPos)
--     if ((self.m_Dir.x~=0) and (self.m_Dir.z~=0)) then
--         local vec1,vec2=self:GetShiftlDir()
--         local newPos1=charPos + vec1 * self.Speed * Time.deltaTime
--         local newPos2=charPos + vec2 * self.Speed * Time.deltaTime
--         local height1 = SceneMgr.GetHeight(newPos1)
--         local height2 = SceneMgr.GetHeight(newPos2)
--         local heightSelf = SceneMgr.GetHeight(charPos)
--         if ((height1>cfg.map.Scene.HEIGHTMAP_MIN) and math.abs(height1-heightSelf)<0.15) then
--             self.m_Dir=vec1
--         elseif ((height2>cfg.map.Scene.HEIGHTMAP_MIN) and math.abs(height2-heightSelf)<0.15) then
--             self.m_Dir=vec2
--         end
--     end
-- end

function MoveWork:UpdatePos()
    local vecPos = Vector3.zero
    local charPos = self.Character:GetRefPos()


    if MathUtils.DistanceOfXoZ(charPos, self.Target) < self.Speed * Time.deltaTime then
        vecPos = Vector3(self.Target.x, charPos.y, self.Target.z)
        self:End()
    else
        vecPos = charPos + self.m_Dir * self.Speed * Time.deltaTime
    end
    if self.Character:IsRole() or (self.Character:IsMount() and self.Character:PlayerIsRole()) then
        if self.Character:IsNavigating() then
            if (not self.Character:CanReach(vecPos)) then
                self.Character:stop()
             --   self:ChangeDir(charPos)
                vecPos=charPos
                return
            end
        else
            if (not self.Character:CanMoveTo(vecPos)) then
            --    self:ChangeDir(charPos)
             --   printyellow("Role CanMove False")
                vecPos=charPos
                return
            end
        end
    end

    --printyellow("move setpos",vecPos)
    self.Character:SetPos(vecPos)
end



return MoveWork
