local print             = print
local require           = require
local scenemanager      = require "scenemanager"
local defineenum        = require "defineenum"
local CharacterType     = defineenum.CharacterType
local CharState         = defineenum.CharState
local WorkType          = defineenum.WorkType
local mathutils         = require "common.mathutils"
local utils             = require "common.utils"
local WorkManager       = require "character.work.workmanager"
local AnimationManager  = require "character.animationmanager"
local event             = require "character.event.event"
local AttackActionFsm   = require "character.ai.attackactionfsm"
local BeAttackActionFsm = require "character.ai.beattackactionfsm"
local Buff              = require "character.characterbuff"
local HumanoidAvatar    = require "character.avatar.humanoidavatar"
local PathFlyManager    = require "character.pathfly.pathflymanager"
local ResourceLoadType  = define.ResourceLoadType
local uimanager         = require "uimanager"
local ListenerGroup     = require "character.listener.listenergroup"
local ShadowObjectManager   = require"character.footinfo.shadowobjmanager"
local CharaterTransformSync     = require "character.transformsync.charatertransformsync"
local CharacterShapeShift   = require("character.components.charactershapeshift")


local EctypeManager
local TeamManager
local OutFightTime = 5

utils.get_or_create("character").Character = Class:new()
require "character.character_action" --particle class Character for Action
require "character.character_load"
local Character = utils.get_or_create("character").Character

function Character:__new()
    EctypeManager               = require"ectype.ectypemanager"
    TeamManager                 = require"ui.team.teammanager"
    self.m_Type                 = CharacterType.Character


    self.WorkMgr                = WorkManager:new(self)
    self.AnimationMgr           = AnimationManager:new()
    self.EventQuene             = event.EventQuene:new(self)
    self.AttackActionFsm        = AttackActionFsm:new(self)
    self.BeAttackActionFsm      = BeAttackActionFsm:new(self)
    self.m_Effect               = Buff:new(self)
    self.m_Avatar               = HumanoidAvatar:new(self)
    self.m_ListenerGroup        = ListenerGroup:new(self)
    self.m_ShapeShift           = CharacterShapeShift:new(self) --变身

    self:CreateSkillRange()
    self.m_TransformSync        = self:CreateTransformSync()


    self.m_Attributes           = {}

    self.m_AnimSelectType       = cfg.skill.AnimTypeSelectType.Default --动作筛选
    self.m_outDated             = false
    self.m_IsDestroy            = false
    self.m_TargetScale          = nil

    self:reset()
end

function Character:CreateTransformSync()
    return CharaterTransformSync:new(self)
end


function Character:reset()
    -- print("<color=yellow>Character:reset()</color>")
    self.m_Id                     = 0
    self.m_CsvId                  = 0
    self.m_CharacterModelData     = nil --默认模型
    self.m_DressModelData         = nil --穿过时装的模型
    self.m_Object                 = nil
    self.m_ShadowObject           = nil
    self.m_Level                  = 1
    self.m_Name                   = nil
    self.m_ObjectSetName          = nil
    self.m_sfxScale               = nil
    self.m_TransformControl       = nil

    self.m_Attributes[cfg.fight.AttrId.MOVE_SPEED] = 5
    self.m_Attributes[cfg.fight.AttrId.MP_VALUE] = 0
    self.m_Attributes[cfg.fight.AttrId.MP_FULL_VALUE] = 1
    self.m_Attributes[cfg.fight.AttrId.HP_VALUE] = 0
    self.m_Attributes[cfg.fight.AttrId.HP_FULL_VALUE] = 1

    self.m_Jumpheigt              = 0
    self.m_Pos                    = Vector3.zero
    self.m_OldPos                 = Vector3.zero
    self.m_Rotation               = Quaternion.identity
   -- self.m_Dir                    = Vector3(1, 0, 0)
    self.m_Height                 = 1.7
    self.m_OffsetY                = 0
    self.m_State                  = CharState.None
    self.m_Gravity                = 15
    self.m_JumpHeight             = 2
    self.m_SkillStopMoveBeginTime = 0
    self.m_SkillStopMoveDuration  = 0
    self.WorkMgr:reset(self)
    self.AnimationMgr:reset()
    self:ResetAction()
    self.EventQuene:Clear()
    self.SkillRange             = nil
    self.m_TargetId               = nil --选择目标
    --    self.m_IsMoving         = false
    self.m_IsFighting             = false
    -- 是否才处于战斗状态
    self.m_FightTime              = 0
    -- FightCmpt
    self.m_AttachBones            = {}
    --战斗力
    self.m_Power                  = 7001
    --是否处于轨迹飞行中
    self.m_PathFlyState           = false
    self.m_Areocraft              = nil
	self.m_Title 		            = nil		--称号

    self.m_Born                   = false
    self.m_Visiable               = true
    self.m_BindEffectId           = -1
    self.m_TargetPos              = Vector3.zero

end


function Character:ChangeAttr(ppt)
    for attrType, attrValue in pairs(ppt) do
        self.m_Attributes[attrType] = attrValue
    end

    -- local attrMap = cfg.fight.AttrId
    -- for i,v in pairs(cfg.fight.AttrId) do
    --     self.m_Attributes[v] = ppt[v] or self.m_Attributes[v]
    -- end
    if ppt[cfg.fight.AttrId.MODEL_SCALE] then
        self:SetBuffScale(ppt[cfg.fight.AttrId.MODEL_SCALE])
    end
    if self.m_HeadInfo then
        self.m_HeadInfo:OnAttributeChange()
    end
    self.m_ListenerGroup:OnAttributeChange()
    --local uimanager = require "uimanager"
    if self:IsPlayer() and uimanager.isshow("dlguimain") then
        local DlgUIMain_Team = require("ui.dlguimain_team")
        DlgUIMain_Team.RefreshTeamMemberHp({id = self.m_Id})
    end
end

-- function Character:ChangeHP(v)
--     self.m_Attributes[cfg.fight.AttrId.HP_VALUE] = v
--     if self.m_HeadInfo then
--         self.m_HeadInfo:OnAttributeChange()
--     end
--     local uimanager = require "uimanager"
--     if uimanager.isshow("dlguimain") then
--         uimanager.call("dlguimain","RefreshTeamMemberHp",{id=self.m_Id})
--     end
--     self.m_ListenerGroup:OnAttributeChange()
-- end

function Character:ChangeTitle(titleid)
    local TitleManager = require "ui.title.titlemanager"
    if titleid ~= nil and titleid > 0 then
        self.m_Title = TitleManager.Title:new(titleid, true)
        if self:IsPlayer() then
            self.m_Title:SetCharacter(self)
        end
    else
        self.m_Title = nil
    end

    if self.m_HeadInfo then
        self.m_HeadInfo:OnChangeTitle()
    end

end

function Character:SetLoverName(name)
    self.m_LoverName = name
    if self.m_HeadInfo then
        self.m_HeadInfo:OnChangeTitle()
    end
end


function Character:SetParent(obj)
    if self.m_Object then
      if obj then
          self.m_Object.transform.parent = obj.transform
      else
          local managerObject = CharacterManager.GetCharacterManagerObject()
          self.m_Object.transform.parent = managerObject.transform
      end
    end
end

function Character:OnEffectChange()
    self.m_ListenerGroup:OnEffectChange()
end

function Character:TransformUpdate()
    self.m_TransformControl:UpdateTransform(self.m_Pos,self.m_Rotation)
end


function Character:update()
    --status.BeginSample("m_Avatar:Update")
    self.m_Avatar:Update()
    self.m_Effect:Update()
    self.m_ShapeShift:OnUpdate()
    --status.EndSample()
    -- =============================================================
    --status.BeginSample("SwitchToOutFightState")
    if self.m_IsFighting then
        if self.m_FightTime > OutFightTime then
            self:SwitchToOutFightState()
        end
        self.m_FightTime = self.m_FightTime + Time.deltaTime
    end
    --status.EndSample()


    if self.m_Object then
        --status.BeginSample("EventQuene")
        self.EventQuene:Update()
        --status.EndSample()
        --status.BeginSample("WorkMgr")
        self.WorkMgr:Update()
        --status.EndSample()
        --status.BeginSample("BeAttackActionFsm")
        self.BeAttackActionFsm:Update()
        --status.EndSample()
        --status.BeginSample("AttackActionFsm")
        self.AttackActionFsm:Update()
        --status.EndSample()
        --status.BeginSample("UpdateAction")
        self:UpdateAction()
        --status.EndSample()

        --[[这个函数需要最后更新]]
        --status.BeginSample("TransformUpdate")
        if not self.m_Mount and self.m_TransformControl then
            self:TransformUpdate()
        end
        --status.EndSample()
        if self.m_Areocraft ~= nil then
            --status.BeginSample("m_Areocraft")
            self.m_Areocraft:update()
            --status.EndSample()
        end
        if self.m_TargetScale then
            self.m_Object.transform.localScale = self.m_TargetScale
            self.m_TargetScale = nil
        end
    end



end

function Character:lateUpdate()
    self.m_TransformSync:LateUpdate()
end


function Character:remove()
    self.m_Effect:Clear()
    self:release()
    self:reset()
    return
end

--此函数中不要写其他逻辑，Monster类会重写
function Character:DestroyObject()




    if self.m_Object then
        GameObject.Destroy(self.m_Object)
        self.m_Object = nil
    end

  --  if self.m_Avatar then
    self.m_Avatar:UnEquip(HumanoidAvatar.EquipType.ARMOUR)
  --  end
end

function Character:ReleaseModel()

    if self.m_HeadInfo then
        local dlgHead =require"ui.dlgmonster_hp"
        dlgHead.Remove(self)
        self.m_HeadInfo = nil
    end

   -- if self.m_Effect then
        self.m_Effect:Clear()
   -- end

  --  if self.m_Avatar then
        self.m_Avatar:UnEquip(HumanoidAvatar.EquipType.WEAPON)
  --  end
    if self.m_ShadowObject then
        --printyellow("self.m_ShadowObject")
        self.m_ShadowObject.transform.parent = nil
        if not ShadowObjectManager.PushObject(self.m_ShadowObject) then
            GameObject.DestroyImmediate(self.m_ShadowObject)
        end
        self.m_ShadowObject = nil
    end
    self:ReleaseBindEffect()
    self:DestroyObject()
end

function Character:release()
    -- if self.m_TalismanController then
    --     self.m_TalismanController:OnDestroy()
    -- end
    self.m_IsDestroy  = true
    self:ReleaseModel()
    self.m_HeadInfo = nil
    self:HideSkillRange()
    if self.m_ListenerGroup then
        self.m_ListenerGroup:OnDestroy()
        self.m_ListenerGroup = nil
    end
    if self.m_Areocraft then
        self.m_Areocraft:remove()
    end
end

function Character:SetPos(vecPos)
    if vecPos then
        if self.m_WalkInSky then
            --vecPos.y=scenemanager.GetHeight1(vecPos)
            self.m_Pos = Vector3(vecPos.x, scenemanager.GetHeight1(vecPos), vecPos.z)
        else
            local height = self:GetGroundHeight(vecPos)
            if height and (height>cfg.map.Scene.HEIGHTMAP_MIN) then
                --vecPos.y = height + self.m_OffsetY
                self.m_Pos = Vector3(vecPos.x, height + self.m_OffsetY, vecPos.z)
            else
                self.m_Pos = Vector3(vecPos.x, vecPos.y, vecPos.z)
            end
        end
    --    if vecPos then
        --self.m_Pos = Vector3(vecPos.x, vecPos.y, vecPos.z)
   --     end
    end
end

-- function Character:SetPosCorrectly(vecPos)
--     if vecPos == nil then
--         return
--     end
--     self.m_Pos = vecPos
-- end

--local t_pos = Vector3.zero
function Character:GetPos()
    return Vector3(self.m_Pos.x,self.m_Pos.y,self.m_Pos.z)
end

function Character:GetRefPos()
    return self.m_Pos
end

function Character:LookAt(target)
    local dir = Vector3(target.x - self:GetRefPos().x, 0, target.z - self:GetRefPos().z).normalized
    self:SetRotationImmediate(dir)
end

function Character:SetRotation(dir)
    if dir ~= Vector3.zero then
        local rotation = Quaternion.LookRotation(dir, Vector3.up)
        self.m_Rotation = rotation
    end
end

function Character:GetRotation()
    return self.m_Rotation
end

function Character:GetForward()
    return self.m_Rotation*Vector3.forward
end

function Character:SetRotationImmediate(dir)
    if dir ~= Vector3.zero then
        self:SetRotation(dir)
        if self.m_Object then
            self.m_Object.transform.rotation = Quaternion.LookRotation(dir, Vector3.up)
        end
    end
end

function Character:SetScale(scale)
    local s = scale
    if self.m_ModelData and self.m_ModelData.modelscale then
        s = s * self.m_ModelData.modelscale
    end
    -- if self.m_Object then
        -- self.m_Object.transform.localScale = Vector3(s,s,s)
        self.m_TargetScale = Vector3(s,s,s)
    -- end
end

function Character:SetBuffScale(scale)
    self:SetScale(1+scale)

end

function Character:SetUIScale(scale)
    local s = scale
    if self.m_ModelData and self.m_ModelData.uimodelscalemodify then
        s = s * self.m_ModelData.uimodelscalemodify
    end
    if self.m_Object then
        self.m_Object.transform.localScale = Vector3(s,s,s)
    end
end

function Character:SetSfxScale(scale)
    if scale then
        self.m_sfxScale = scale
    else
        self.m_sfxScale = 1
    end
end

function Character:IsUIPlayer()
    return self:IsPlayer() and self:IsUIModel()
end

function Character:UIScaleModify()
    local s = 1
    if self.m_ModelData then
        s =  self.m_ModelData.uimodelscalemodify
    end
    if self.m_Object then
        self.m_Object.transform.localScale = Vector3(s,s,s)
    end
end

function Character:SetEulerAngle(eulerAngle)
    if eulerAngle ~= Vector3.zero then
        self.m_Rotation = Quaternion.Euler(eulerAngle.x,eulerAngle.y,eulerAngle.z)
    end
end

function Character:SetEulerAngleImmediate(eulerAngle)
    if eulerAngle ~= Vector3.zero then
        self:SetEulerAngle(eulerAngle)
        if self.m_Object then
            self.m_Object.transform.rotation = Quaternion.Euler(eulerAngle.x,eulerAngle.y,eulerAngle.z)
        end
    end
end

function Character:GetGroundHeight(pos)
    -- printyellow(pos)
    -- if self.m_Object then
    --     local ret = scenemanager.GetHeight(pos or self.m_Object.transform.position)
    --     return ret
    -- else
        -- printyellow("self.m_Pos",self.m_Pos)
        local ret = scenemanager.GetHeight(pos or self.m_Pos)
        return ret
   -- end
end

-- function Character:UpdateY()
--     self.m_Pos = Vector3(self.m_Pos.x, self:GetGroundHeight(nil), self.m_Pos.z)
-- end

-- function Character:IsOnGround()
--     local curHeight = self:GetGroundHeight(self.m_Pos) + self.m_OffsetY
--     return math.abs(curHeight - self.m_Pos.y) < 0.001
-- end
-- wait for add
function Character:CanMove()
    if IsNull(self.m_Object) then
        return false
    end
    -- if self.WorkMgr == nil then
    --     return false
    -- end
    -- if self.AnimationMgr == nil then
    --     return false
    -- end
    -- if self.AttackActionFsm == nil then
    --     return false
    -- end
    if self.m_Attributes[cfg.fight.AttrId.MOVE_SPEED] == 0 then
        return false
    end
    if not self.m_Effect:CanMove() then
        return false
    end
    if self:IsPathFlying() == true then
        return false
    end
    -- printyellow("self.AttackActionFsm:CanMove()",self.AttackActionFsm:CanMove())
    return self.AttackActionFsm:CanMove()
end

function Character:CanRotate()
    if IsNull(self.m_Object) then
        return false
    end
    -- if self.WorkMgr == nil then
    --     return false
    -- end
    -- if self.AnimationMgr == nil then
    --     return false
    -- end
    -- if self.AttackActionFsm == nil then
    --     return false
    -- end

    return self.AttackActionFsm:CanRotate()

end

function Character:MoveTo(position, speed)
    if not self:IsDead() then
        self.m_TargetPos = position
        self.EventQuene:CreateMoveEvent(self,position, speed)
   --     local move = event.MoveEvent:new(self,{TargetPos = position, Speed = speed})
   --     self.EventQuene:Push(move)
    end
end

function Character:CanMoveTo(targetPos)
    local canMove=false
    local bMove=true
    local EctypeManager     = require"ectype.ectypemanager"
    if EctypeManager.IsInEctype() then
        bMove = EctypeManager.CheckPosition(targetPos)
    end
    if self.m_WalkInSky then
        canMove = (scenemanager.GetHeight1(targetPos)>cfg.map.Scene.HEIGHTMAP_MIN) and ((self:GetGroundHeight(targetPos)<cfg.map.Scene.HEIGHTMAP_MIN) or (math.abs(self:GetGroundHeight(targetPos)-scenemanager.GetHeight1(targetPos))>5)) and (math.abs(scenemanager.GetHeight1(targetPos)-scenemanager.GetHeight1(self.m_Pos))<0.75*mathutils.DistanceOfXoZ(self.m_Pos, targetPos))
    else
        if (self:GetGroundHeight(targetPos)>cfg.map.Scene.HEIGHTMAP_MIN) then
            if self:IsJumping() then
                canMove = true
            else
                canMove= true
                --canMove = math.abs(self:GetGroundHeight(targ9etPos)-self:GetGroundHeight(self:GetPos()))<(0.75*mathutils.DistanceOfXoZ(self:GetPos(), targetPos))

                --printyellow("zz",math.abs(self:GetGroundHeight(targetPos)-self:GetGroundHeight(self:GetPos())),(0.75*mathutils.DistanceOfXoZ(self:GetPos(), targetPos)))
            end
        end
    end
    return canMove and bMove
end

function Character:Death(b)
    if self:IsPathFlying() then
        self:StopPathFly()
    end
    self.m_Effect:Clear()
    local dead = event.DeadEvent:new(self,{isDead = b})
    self.EventQuene:Push(dead)
    self.m_ListenerGroup:OnDeath()
    if self.m_HeadInfo then
        self.m_HeadInfo:ShowHpProgress(false)
    end
    self.m_ShapeShift:OnDeath()
end

function Character:Revive()
    local revive = event.ReviveEvent:new(self,{})
    self.EventQuene:Push(revive)
    if self.m_Type == CharacterType.PlayerRole then
        self.m_MoveTime = cfg.equip.Riding.RECOVERRIDE_TIME
    end
    self.m_ShapeShift:OnRevive()
end

function Character:CanJump()
    if self:IsWorkState(WorkType.Dead) or
        self:IsAttacking() or
        self:IsWorkState(WorkType.Relive) or
        self:HasState(CharState.Vertigo) or
        self:HasState(CharState.Freeze) or
        self:HasState(CharState.Lock) or
        self:IsPathFlying() or
        not self.m_Effect:CanMove()
        then
        return false
    end
    return true
end

function Character:PlayFreeAction(anim)
    if self:IsJumping()
            or self:IsAttacking()
            or self:IsBeAttacked()
            or (self:IsPlayer() and self:IsRiding())
            or self:IsDead()
            or self:IsPathFlying()
            then
        return
    end
    --self.WorkMgr.JudgeNeedIdle = false
    self.WorkMgr:StopWork(WorkType.Move)
    local freeAction = event.FreeActionEvent:new(self,{AnimName = anim})
    self.EventQuene:Push(freeAction)
end


function Character:Jump()
    if self:CanJump() then
        local jump = event.JumpEvent:new(self,{IsFighting = self.m_IsFighting})
        self.EventQuene:Push(jump)
    end
end

function Character:SwitchPathFlyState(isPathFlayState)
    self.m_PathFlyState = isPathFlayState
end


function Character:sync_SPathFlyBegin(startPos, curveId, targetPos, portalId)
    if self.m_Areocraft then
        self.m_Areocraft:remove()
        self.m_Areocraft = nil
    end
    local height = scenemanager.GetHeight(targetPos)

    self:SwitchPathFlyState(true)
    self.m_Areocraft = PathFlyManager.LoadAerocraft(self, function(obj)
        local pathCurve = PathFlyManager.GetPathCurve(curveId)
        local pathfly = event.PathFlyEvent:new(self,{ PathCurve = pathCurve, EndPosition = Vector3(targetPos.x, height, targetPos.z) })
        self.EventQuene:Push(pathfly)
    end)
    if self.m_HeadInfo then
        self.m_HeadInfo:Hide()
    end
end

function Character:sync_SPathFlyEnd(orient)
    self:SetEulerAngle(orient)
    if self.m_HeadInfo then
        self.m_HeadInfo:Show()
    end
end



function Character:StopPathFly()
    if self:IsPathFlying() then
        self.WorkMgr:StopWork(WorkType.PathFly)
        self:SwitchPathFlyState(false)
    end
end


function Character:OnPathFlyStart()
    if self.m_ShadowObject then
        self.m_ShadowObject.gameObject:SetActive(false)
    end
    if self.m_HeadInfo then
        self.m_HeadInfo:Hide()
    end
end

function Character:OnPathFlyEnd()
    self:SwitchPathFlyState(false)
    if self.m_ShadowObject then
        self.m_ShadowObject.gameObject:SetActive(true)
    end

    if self.m_Areocraft ~= nil then
        self.m_Areocraft:OnPathFlyEnd()
    end
    if self.m_HeadInfo then
        self.m_HeadInfo:Show()
    end
end

function Character:IsPathFlying()
    return self.m_PathFlyState
end

--[[
攻击目标
（1）	选择目标：
1：玩家点击了怪物模型；
2：玩家使用了需要目标的技能（totarget=true）
3：玩家使用了智能施法，系统帮玩家选择了目标
（2）	丢失目标：
1：目标死亡
2：目标脱离了选怪范围（role.xml）
PLAYER_SELECT_TARGET_RADIUS 选择目标距离
PLAYER_LOSE_TARGET_RADIUS 丢失目标距离
--]]
function Character:SetTargetId(targetId)
    self.m_TargetId = targetId

--    if self.m_TargetId~=nil then
--        printyellow("Character:SetTargetId()",self:GetTarget().m_Name)
--    else
--        printyellow("Character:SetTargetId(nil)")
--    end
end

function Character:OnSkillPerform(msg)
    if msg.retcode == lx.gs.SError.OK then
        self.m_Attributes[cfg.fight.AttrId.MP_VALUE] = msg.mp
        if not self:IsRole() then
            self:SetRotationImmediate(Vector3(msg.direction.x, 0, msg.direction.z))
            self:SetTargetId(msg.targetid)
            self:PlaySkill(msg.skillid)
        else
            local uimanager = require"uimanager"
            uimanager.call("dlguimain","UpdateAttributes")
        end
    else
        if self:IsRole() then
            -- RoleSkillLogic.Reset()
        end
    end
end

function Character:GetTargetId()
    return self.m_TargetId or 0
end

function Character:HasTarget()
    if self.m_TargetId ~= nil then
        local target = CharacterManager.GetCharacter(self.m_TargetId)
        if target == nil or target:IsDead() then
            self:SetTargetId(nil)
        else
--            printyellow("Character:HasTarget()",target.m_Name)
            return true
        end
    end
    return false
end

function Character:SetTarget(character)
    if character~=nil then
        --printyellow("target id ",character.m_id)
        self:SetTargetId(character.m_Id)
    end
end

function Character:GetTarget()
    if self:HasTarget() then
        return CharacterManager.GetCharacter(self.m_TargetId)
    end
    return nil
end

function Character:CanAttack()
    if self:IsDead() or self:IsRelive() --[[or self:IsBeAttacked()]] or self:IsJumping() or self.m_ShapeShift:IsResuming() then
        return false
    end

    if self:IsPathFlying() then
        return false
    end

    -- if self.AnimationMgr == nil or
    --     self.WorkMgr == nil or
    --     self.AttackActionFsm == nil then
    --     return false
    -- end
    return true
end



function Character:CanPlaySkill(skillId)
    if not self:CanAttack() then
        return false
    end
    local skill = SkillManager.GetSkill(skillId)
    if skill:IsNormal() then
        if not self.m_Effect:CanPlayNormalSkill() then
            return false
        end
    else
        if not self.m_Effect:CanPlaySkill() then
            return false
        end
    end

    if skill == nil or skill:GetAction(self) == nil then
        return false
    end
    return true
end

function Character:PlaySkill(skillId)
    --   print(skillId)
    if self.AttackActionFsm and self:CanPlaySkill(skillId) and not self:IsDead() then
        if self:IsAttacking() then
            self.AttackActionFsm:BreakCurrentSkill()
        end
        --self.WorkMgr.JudgeNeedIdle = false
        self.WorkMgr:StopWork(WorkType.Move)
        self.AttackActionFsm:SetAttackAction(skillId)

        local skill = SkillManager.GetSkill(skillId)
        local skillevent = event.SkillEvent:new(self,{Skill = skill})
        self.EventQuene:Push(skillevent)
        self:OnPlaySkill(skillId)
    end
end

function Character:BreakSkill(skillId)
    if self.AttackActionFsm then
        self.AttackActionFsm:BreakSkill(skillId)
    end
end

function Character:NotifyAttackBeBroken(skillId)
    self:OnEndPlaySkill(skillId)
end

function Character:NotifyAttackComplete(skillId, bCastCallBackSkill)
    self:OnEndPlaySkill(skillId)
end

function Character:OnPlaySkill(skillid)
    self:SwitchToFightState()
end

function Character:OnEndPlaySkill(skillid)
    self:SwitchToFightState()
end




function Character:OnBeAttacked(attacker, skill, TargetAction, attackInfo)
    local info = event.BeAttackInfo:new()
    if attacker then
        info.AttackerId = attacker.m_Id
        info.AttackPosition = attacker.m_Pos
    end
    info.Skill = skill
    info.TargetAction = TargetAction
    info.DetailInfo = attackInfo
    local beattacked = event.BeAttackedEvent:new(self,{info = info} )
    --printyellow("beattacked")
    --printyellow("event queue count before",self.EventQuene:Count())
    self.EventQuene:Push(beattacked)
    --printyellow("event queue count after",self.EventQuene:Count())
    self:SwitchToFightState(attacker and attacker.m_Id or nil,self.m_Id)
end

function Character:IsWorkState(workType)
    return self.WorkMgr:IsWorking(workType)
end

function Character:IsIdle()
    return self:IsWorkState(WorkType.Idle)
end

function Character:IsDead()
    return self:IsWorkState(WorkType.Dead)
end

function Character:IsMoving()
    if self.m_Mount then
        return self.m_Mount:IsMoving()
    else
        return self:IsWorkState(WorkType.Move) or self:IsWorkState(WorkType.Fly)
    end
end

function Character:IsJumping()
    return self:IsWorkState(WorkType.Jump)
end

function Character:IsAttacking()
    return self.WorkMgr:IsWorkingSkill()
end

function Character:IsRelive()
    return self:IsWorkState(WorkType.Relive)
end

function Character:IsBeAttacked()
    return self.BeAttackActionFsm ~= nil and self.BeAttackActionFsm.CurrentState ~= BeAttackActionFsm.FsmState.None
end

function Character:HaveRelationshipWithRole()
    -- if self:IsRole() then
    --     return true
    -- elseif self:IsPlayer() then
    --     return TeamManager.IsTeamMate(character.m_Id)
    -- elseif self:IsPet() then
    --     local master = self:GetMaster()
    --     return TeamManager.IsTeamMate(master.m_Id) or master:IsRole()
    -- end
    -- return false
    -- if self:IsRole() then
    --      return true
    --  elseif self:IsPlayer() or self:IsPet() then
    --      local camp = self.m_Camp
    --      local PlayerRole = require"character.playerrole"
    --      local campRelationInfo = ConfigManager.getConfigData("camprelation",PlayerRole.Instance().m_Camp)
    --      return campRelationInfo[camp+1] == cfg.fight.Relation.FRIEND
    --  end
     return false
end

function Character:SwitchToFightState(attackerid,beattackerid)
    self.m_FightTime = 0
    self.m_IsFighting = true
    if attackerid and beattackerid then
        local attacker = CharacterManager.GetCharacter(attackerid)
        local beattacker = CharacterManager.GetCharacter(beattackerid)
        if attacker and beattacker then
            if attacker:HaveRelationshipWithRole() or beattacker:HaveRelationshipWithRole() then
                if attacker.m_HeadInfo then
                    attacker.m_HeadInfo:ShowHpProgress(true)
                end
                if beattacker.m_HeadInfo then
                    beattacker.m_HeadInfo:ShowHpProgress(true)
                end
            end
        end
    end
end

function Character:SwitchToOutFightState()
    self.m_FightTime = 0
    self.m_IsFighting = false
    if self:IsIdle() then
        --printyellow("PlayIdleAnimation")
        if self:IsPlayer() and (not self:IsRiding()) then
            self.WorkMgr:GetWork(WorkType.Idle):PlaySwordMotion()
        end
    elseif self:IsMoving() and not self:IsAttacking() and not self:IsJumping() then
        --printyellow("PlayRunAnimation")
        if not (self:IsPlayer() and self:IsRiding()) then
            self.WorkMgr:GetWork(WorkType.Move):PlayRunAnimation()
        end
    end
    if self.m_HeadInfo then
        self.m_HeadInfo:ShowHpProgress(false)
    end
end

function Character:IsFighting()
    return self.m_IsFighting
end

function Character:AddState(state)
    self.m_State = bit.bor(self.m_State, state)
end

function Character:RemoveState(state)
    self.m_State = bit.band(self.m_State, bit.bnot(state))
end

function Character:HasState(state)
    return bit.band(self.m_State, state) == state
end

function Character:IsRiding()
    return false
end

function Character:IsRolePet()
    return false
end

function Character:IsPet()
    return bit.band(self.m_Type, CharacterType.Pet) > 0
end

function Character:IsRole()
    return bit.band(self.m_Type, CharacterType.PlayerRole) > 0
end

function Character:IsPlayer()
    return bit.band(self.m_Type, CharacterType.Player) > 0 or bit.band(self.m_Type, CharacterType.PlayerRole) > 0
end

function Character:IsMonster()
    return bit.band(self.m_Type, CharacterType.Monster) > 0 or bit.band(self.m_Type, CharacterType.Boss) >0
end

function Character:IsBoss()
    return bit.band(self.m_Type, CharacterType.Boss) > 0
end

function Character:IsNpc()
    return bit.band(self.m_Type, CharacterType.Npc) > 0
end

function Character:IsMineral()
    return bit.band(self.m_Type, CharacterType.Mineral) > 0
end

function Character:IsFamilyCityTower()
    return false
end

function Character:IsMount()
    return bit.band(self.m_Type, CharacterType.Mount) > 0
end

function Character:IsDropItem()
    return bit.band(self.m_Type, CharacterType.DropItem) > 0
end

function Character:CreateSkillRange()
    if Local.ShowSkillRange then
        self.SkillRange = RangeCube()
    end
end

function Character:InitSkillRange(xlength, zlength, bottomheight, topheight, zoffset)
    if Local.ShowSkillRange and self.SkillRange then
        self.SkillRange:Init(xlength,
        zlength,
        bottomheight,
        topheight,
        Vector3(0, 0, zoffset),
        Color.red)
    end
end

function Character:ShowSkillRange(position, rotation)
    if Local.ShowSkillRange and self.SkillRange then
        --        printyellow("ShowSkillRange(position,rotation)")
        self.SkillRange:Show(position, rotation)
    end
end

function Character:HideSkillRange()
    if Local.ShowSkillRange and self.SkillRange then
        self.SkillRange:Release()
    end
end

function Character:RefreshAvatarObject()
    ExtendedGameObject.SetLayerRecursively(self.m_Object, define.Layer.LayerCharacter)
end

--****************************************
--输入 bonename ：string骨骼名称
--输出 bonetransform：Transform 骨骼Transform
--*****************************************
function Character:GetAttachBone(bonename, bReFind, rootBoneObject)
    if self.m_Object then
        if not bReFind and self.m_AttachBones[bonename] then
            return self.m_AttachBones[bonename]
        end

        if self:IsMount() and rootBoneObject ==nil then
            local bone =  LuaHelper.FindBone(self.m_Object,bonename,"bindingpoint")
            self.m_AttachBones[bonename] = bone
            return self.m_AttachBones[bonename]
        end

        local allBones
        if rootBoneObject then
            allBones = rootBoneObject:GetComponentsInChildren(UnityEngine.Transform,true)
        else
            allBones = self.m_Object:GetComponentsInChildren(UnityEngine.Transform,true)
        end

        for i = 1,allBones.Length do
            local bone = allBones[i]
            if bone.name == bonename then
                self.m_AttachBones[bonename] = bone
                return self.m_AttachBones[bonename]
            end
        end
    end
    return nil
end

--****************************************
--获取Character的基本属性接口

--*****************************************

function Character:GetPower()
    return self.m_Power
end

function Character:GetId()
    return self.m_Id
end

function Character:GetCsvId()
    return self.m_CsvId
end

function Character:GetName()
    return self.m_Name
end

function Character:GetLevel()
    return self.m_Level
end

function Character:GetParentModelData(modeldata)
    if modeldata then
        --return self.m_ModelData.headicon
        local model =  ConfigManager.getConfigData("modelactions",modeldata.modelname)
        if model~=nil then
            return ConfigManager.getConfigData("model",model.basemodelname)
        end
    end
    return nil
end
--头像
function Character:GetHeadIcon()
    local modeldata = self.m_ModelData
    while modeldata~=nil do
        if modeldata.headicon ~=nil and modeldata.headicon ~="" then
            return modeldata.headicon
        end
        modeldata = self:GetParentModelData(modeldata)
    end
    return ""
end
--半身像
function Character:GetPortrait()
    local modeldata = self.m_ModelData
    while modeldata~=nil do
        if modeldata.portrait ~=nil and modeldata.portrait ~="" then
            return modeldata.portrait
        end
        modeldata = self:GetParentModelData(modeldata)
    end
    return ""
end

--半身像
function Character:GetBodyRadius()
    if self.m_ModelData~=nil then
        return self.m_ModelData.bodyradius or 0
    end
    return 0
end

--self.m_ModelData

--*****************************************

function Character:Hide(hideHP)
    --printyellow("hide",tostring(hideHP))
    if self.m_HeadInfo then
        self.m_HeadInfo:HideHeadInfo()
    end
  --  if self.m_HpBar ~= nil then
   --     self.m_HpBar:SetActive(false)
   -- end
    if not hideHP then
        if self.m_Object ~= nil then
            self.m_Object:SetActive(false)
        end
    end
end

function Character:IsShowObj()
    if self.m_Object and self.m_Object.activeSelf then return true end
    return false
end

function Character:IsShowHp()
    if self.m_HpBar and self.m_HpBar.activeSelf then return true end
    return false
end

function Character:ShowHeadInfo()
    if self.m_HeadInfo then
        self.m_HeadInfo:ShowHeadInfo()
    end
end

function Character:HideHeadInfo()
    if self.m_HeadInfo then
        self.m_HeadInfo:HideHeadInfo()
    end
end

function Character:Show()
    if self.m_Object ~= nil then
        self.m_Object:SetActive(true)
    end
    if self.m_HeadInfo then
        self.m_HeadInfo:ShowHeadInfo()
    end
--self.m_TalismanController.m_Object
end

function Character:SetTalkContent(content)
    local uimanager = require"uimanager"
    uimanager.call("dlgheadtalking","Add",{content=content,target=self})
end


function Character:InitState(fightercommon,bLoadMap)
    self:SetPos(cloneVector3(fightercommon.position))
    self:SetRotationImmediate(Vector3(fightercommon.orient.x,0,fightercommon.orient.z))
    if fightercommon.isdead~=0 then
        self:Death(true)
    end
    if fightercommon.isrevive~=0 then
        self:Revive()
    end
    if fightercommon.transformeffectid and fightercommon.transformeffectid >0 then 
        self.m_ShapeShift:AddTransformEffect(fightercommon.transformeffectid,fightercommon.transformremaintime)
    end
    if self.m_Type == CharacterType.PlayerRole then
        if fightercommon.isdead == 0 then
            LuaHelper.CameraGrayEffect(false)
        end
    end
    if self.m_Type == CharacterType.PlayerRole and not bLoadMap then
        -- do nothing
    else
        if fightercommon.position and fightercommon.targetposition then
            if mathutils.DistanceOfXoZ(fightercommon.position, fightercommon.targetposition) > 0.5 then
                self.m_TransformSync:SyncMoveTo({position = fightercommon.position, target = fightercommon.targetposition,isplayercontrol = 0})
            end
        end
    end
end

function Character:RedName(b)
    if b then
        self:ShowName(LocalString.UnderGroundText.RedNameColor .. self.m_Name .. LocalString.ColorSuffix)
    else
        self:ShowName()
    end
    if self:IsPlayer() then
        local pets = CharacterManager.GetPlayerPets(self)
        for _,v in pairs(pets) do
            v:RedName(b)
        end
    end
end

function Character:ChangePKState(state)
    local CharacterManager = require"character.charactermanager"
    self.m_PKState = state
    if self:IsPlayer() or self:IsPet() then
        if CharacterManager.CanAttack(self) then
            self:RedName(true)
        else
            self:RedName(false)
        end
    end
end

function Character:ShowName(name)
    if self.m_HeadInfo then
        self.m_HeadInfo:ShowName(name)
    end
end

function Character:IsInCamera()
    if self.m_Object ~=nil then
        return LuaHelper.IsInCamera(self.m_Object.transform.position)
    end
    return false
end

function Character:IsVisiable()
    return self.m_Visiable
end

function Character:SetVisiable(visiable)
    --printyellow("Character:SetVisiable(visiable) begin",self.m_Id)
    if IsNull(self.m_Object) or self.m_Renderers == nil  or self.m_Renderers.Length == 0 then
        return
    end
    --printyellow("Character:SetVisiable(visiable)",self.m_Visiable,visiable)
    if self.m_Visiable ~= visiable then
        self.m_Visiable = visiable
        --printyellow("renderers SetActive",self.m_Id,self.m_Visiable)
        for i=1,self.m_Renderers.Length do
            --printyellow("renderers SetActive",self.m_Visiable)
            self.m_Renderers[i].gameObject:SetActive(self.m_Visiable)
        end
    end
end

function Character:IsLoaded()
    return not IsNull(self.m_Object)
end

function Character:IsActive()
    if self:IsLoaded()  then
        return self.m_Object.activeSelf
    end
    return false
end

function Character:SetActive(active)
    if self:IsLoaded() and self.m_Object.activeSelf ~= active then
        self.m_Object:SetActive(active)
    end
end

function Character:ChangeName(name)
    self.m_Name = name
    self:ShowName()
end

function Character:ChangeLevel(level)
    self.m_Level = level
    if self:IsRole() then
        local uimanager = require"uimanager"
        if uimanager.hasloaded("dlguimain") then
            uimanager.call("dlguimain","RefreshTaskList")
        end
        local ModuleLockManager=require"ui.modulelock.modulelockmanager"
        ModuleLockManager.OnPlayerLevelUp()
    end
end

function Character:ChangeVipLevel(level)
    self.m_VipLevel = level
    if self:IsRole()  and uimanager.hasloaded("dlguimain")  then
        uimanager.call("dlguimain","RefreshRoleInfo")
    end
    -- 主角刷新dlguimain
end

function Character:ClearEffect()
    self.m_Effect:Clear()
    self:OnEffectChange()
end

function Character:AddEffect(effect)
    self.m_Effect:AddEffect(effect)
    self:OnEffectChange()
end

function Character:RemoveEffect(effect)
    self.m_Effect:RemoveEffect(effect)
    self:OnEffectChange()
end

function Character:ChangeEquip(equips)
    self:ChangeArmour(nil,equips)
    self:LoadWeapon()
    if uimanager.isshow("playerrole.equip.tabequip") then
        uimanager.call("playerrole.equip.tabequip","RefreshModel")
    end
end

function Character:ChangeDress(dressid)
    self:ChangeArmour(dressid)
end

function Character:IsSimplified()
    return false
end

function Character:IsDestroy()
    return self.m_IsDestroy
end

function Character:GetMessage(ret)
    ret.fightercommon                   = {
        isdead            = self:IsDead(),
        isrevive          = 0,
        isborn            = 0,
        position          = self:GetPos(),
        orient            = self.m_Object.transform.forward,
        skills            = {},
        attrs             = self.m_Attributes,
        camp              = self.m_Camp,
    }
    if self:IsMoving() then
        ret.fightercommon.targetposition= self.m_TargetPos
    end
    ret.effects           = self.m_Effect:GetMessageEffects()
    return ret
end

function Character:HeadActive(b)
    if self.m_HeadInfo then
        self.m_HeadInfo:HeadActive(b)
    end
end

return Character
