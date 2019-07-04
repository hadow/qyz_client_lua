-- local PlayerRole = require "character.playerrole"
local print          = print
local require        = require

local gameevent      = require "gameevent"
local network        = require "network"
local Player         = require "character.player"
local CameraManager  = require "cameramanager"
local DefineEnum     = require "defineenum"
local Navigation     = require "character.navigation.navigationcontroller"
local PetManager     = require "character.pet.petmanager"
local MapManager     = require "map.mapmanager"
local GroundProbe    = require "character.groundprobe.groundprobe"
local SceneManager   = require "scenemanager"
local UIManager      = require "uimanager"
local CharacterMapInfo  = require "character.map.charactermapinfo"
local CharacterAudioSourceManager = require "character.characteraudiosourcemanager"
local scenestripping = require"scenestripping"
local RoleTransformSync = require "character.transformsync.roletransformsync"
local defineenum    = require "defineenum"
local autoaievents  = defineenum.AutoAIEvent
local RideManager
local EctypeManager
local RoleSkillFsm




local PlayerRole = Class:new(Player)

function PlayerRole:__new()
    Player.__new(self)
    self.m_Type                   = DefineEnum.CharacterType.PlayerRole
    EctypeManager               = require"ectype.ectypemanager"
    RoleSkillFsm                = require "character.ai.roleskillfsm"
    RideManager                 = require "ui.ride.ridemanager"

    self.m_EctypeInfo           = {}
    self.m_Follow               = false
    self.m_CanMove              = true
    self.m_RoleSkillFsm         = RoleSkillFsm:new()
    self.m_Ranks                = {}
    self.m_Currencys            = {}
    self.m_Navigation           = Navigation:new(self)
    self.m_ChangingMap          = false
    self.m_MoveTime             = cfg.equip.Riding.RECOVERRIDE_TIME
    self.m_TodayKillMonsterExtraExp = 0
    self.m_GroundProbe          = GroundProbe:new(self)
    self.m_BattlePetCount       = 0
    self.m_Pets                 = {}
    self.m_OfflineTime          = 0
    self.m_OfflineExp           = 0
    self.m_worldlevel           = 0
    self.m_worldlevelrate       = 0



    self.m_PathFlyState         = false
    self.m_MapInfo  = CharacterMapInfo:new()
    self.m_CharacterAudioSourceManager         = CharacterAudioSourceManager:new() --自带音效
end

function PlayerRole:init(roleinfo,roledetail)
    self.m_Name     = roleinfo.rolename
    self.m_Level    = roleinfo.level
    self.m_RealLevel= roledetail.level
    -- self.m_Exp      = roledetail.exp
    self.m_VipExp   = roledetail.vipexp
    self.m_VipLevel = roledetail.viplevel
    self.m_Currencys= roledetail.currencys
    self.m_Currencys= roledetail.currencys
    self.m_FamilyID = roledetail.familyid
    self.m_Power    = roledetail.combatpower
    self.m_CreateTime = roledetail.creatroletime and math.floor(roledetail.creatroletime/1000) or 0
    self.m_TodayKillMonsterExtraExp = roledetail.todaytotaladdmonsterexp
    self.m_worldlevel     = roledetail.worldlevel
    self.m_worldlevelrate = roledetail.worldlevelrate
    self.m_bNeedRefreshPKStateIcon  = false
    Player.init(self, roleinfo.roleid, roleinfo.profession,roledetail.gender,true)
    --self.m_ChangingMap = false
    local DlgUIMain_RoleInfo = require "ui.dlguimain_roleinfo"
    DlgUIMain_RoleInfo.refresh()
end

function PlayerRole:CreateTransformSync()
    return RoleTransformSync:new(self)
end


function PlayerRole:Instance()
    local o = _G.PlayerRole
    if o then return o end
    o = PlayerRole:new()
    _G.PlayerRole = o
    return o
end

function PlayerRole:RefreshPKStateIcon()
    if UIManager.isshow("dlguimain") then
        UIManager.call("dlguimain","RefreshPKStateIcon")
        self.m_bNeedRefreshPKStateIcon = false
    else
        self.m_bNeedRefreshPKStateIcon = true
    end
end

function PlayerRole:OnLoaded(go)
    Player.OnLoaded(self, go)
    self.m_GroundProbe:OnLoaded(self.m_Object)
    self.m_CharacterAudioSourceManager:init(self)
end

function PlayerRole:GetCurrency(currencytype)
    if self.m_Currencys and self.m_Currencys[currencytype] then
        return self.m_Currencys[currencytype]
    end
    return 0
end

function PlayerRole:StopMoveOperations()
    self.m_CanMove = false
    UIManager.call("dlgjoystick","JoyStickEnable",false)
end

function PlayerRole:ResumeMoveOperations()
    self.m_CanMove = true
    UIManager.call("dlgjoystick","JoyStickEnable",true)
end

function PlayerRole:StopSkillsOperations()
    local uimain = require"ui.dlguimain"
    uimain.StopSkillsOperations()
end

function PlayerRole:ResumeSkillsOperations()
    local uimain = require"ui.dlguimain"
    uimain.ResumeSkillsOperations()
end

function PlayerRole:sync_SEnter(msg)
    local UIManager=require"uimanager"
    if UIManager.isshow("dlguimain") then
        UIManager.call("dlguimain","RefreshMapName")
        UIManager.call("dlguimain","RefreshMiniMap")
    end

    self.WorkMgr:ReStartWorks()
    if self:IsAttacking() then
        self.AttackActionFsm:BreakCurrentSkill()
    end

    if self:IsBeAttacked() then
        self.WorkMgr:StopWork(DefineEnum.WorkType.BeAttacked)
    end
    self.m_GroundProbe:sync_Enter()
    self.m_GroundProbe:Reset()
end

function PlayerRole:sync_SEnterWorld(msg)
    self.m_Navigation:OnEnterMap(msg.worldid)
    self.m_MapInfo:EnterWorldMap(msg.mapid, msg.worldid, msg.lineid)
    self:sync_SEnter(msg)
end

function PlayerRole:sync_SEnterEctype(msg)
    self.m_Navigation:OnEnterMap(nil)
    self.m_MapInfo:EnterEctypeMap(msg.id, msg.ectypeid, msg.ectypetype )
    self:sync_SEnter(msg)
end

function PlayerRole:sync_SEnterFamilyStation(msg)
    self.m_Navigation:OnEnterMap(nil)
    self.m_MapInfo:EnterFamilyStation()
    self:sync_SEnter(msg)
end

function PlayerRole:sync_SNearbyPlayerEnter()
    --printyellow("PlayerRole:sync_SNearbyPlayerEnter")
    self.m_GroundProbe:sync_SNearbyPlayerEnter()
end


function PlayerRole:OnSceneLoaded()
    if self.m_GroundProbe then
        self.m_GroundProbe:OnSceneLoaded()
    end
    if (self:IsNavigating() or self:IsFlyNavigating()) and UIManager.isshow("dlguimain") then
        UIManager.call("dlguimain","SetTargetHoming",{pathFinding=true})
    end
end

function PlayerRole:GetMapId()
    return self.m_MapInfo and self.m_MapInfo:GetMapId() or 2
end

function PlayerRole:GetLineId()
    return self.m_MapInfo and self.m_MapInfo:GetLineId() or nil
end

function PlayerRole:CanReach(position)
    if EctypeManager.CheckPosition(position) then
        return true
    else
        return false
    end
end

function PlayerRole:CanMoveTo(pos)
    local hmapCan = Player.CanMoveTo(self,pos)
    local result = self.m_GroundProbe:CanMoveTo(pos)
    local canreach = self:CanReach(pos)
    --printyellow("CanMoveTo[hmapCan,result,canreach]",hmapCan,result,canreach)
    return hmapCan and result and canreach
end

function PlayerRole:SetNavigationMode(isLocal)
    self.m_Navigation:SetNavMode(isLocal)
end


function PlayerRole:GetReachablePosition(dst)

    local ret = EctypeManager.GetPos(dst)
    if not ret then
        dst = ret
    end

    return dst
end

function PlayerRole:GetNavMeshAgent()
    if self.m_GroundProbe then
        return self.m_GroundProbe:GetNavMeshAgent()
    else
        return nil
    end
end

--[[ {   targetPos = 目标位置, callback = 导航结束后的回调函数(导航完成时调用), newStopLength = 距离目标点的停止距离, isAdjustRideDis = 根据骑乘状态调整停止距离,
        mapId = 目标地图, navMode = 导航模式(1：直接跳转至目标地图， 2：步行至目标地图, 没有设置此参数默认为2), endDir = 结束方向, stopCallback = 中断回调(导航被中断时调用)
        lengthCallback = {[1] = {length = xxx,callback = function()},[2] = {length = xxx,callback = function() }} 一定距离时调用,
        isShowAlert = 是否显示弹窗（默认显示）
        notStopAutoFight = false,
        }
--]]

function PlayerRole:navigateTo(params)
    if params and params.notStopAutoFight == true then

    else
        UIManager.call("dlguimain","SwitchAutoFight",false)
        self.m_RoleSkillFsm:reset()
    end
    --printyellow("导航开始：目标：" .. tostring(params.targetPos))
    self.m_UnLoadMount=false

    if params.targetPos == nil or params.targetPos == Vector3(0,0,0) then
        --printyellow("未设置目标点,或者目标点是(0,0,0)")
        return
    end

    if self:IsFlying() then
        self.m_Mount:NavigateTo(params)
    else
        self.m_Navigation:StartNavigate(params)
    end

end

function PlayerRole:CanMove()
    if not self.m_CanMove then return false end
    return Player.CanMove(self)
end

function PlayerRole:CanAttack()
    local result = Player.CanAttack(self)
    return result and (not self.m_MapInfo:IsChangingScene())
end

function PlayerRole:moveTo(dst)
    if self:CanMove() == false then
        return
    end
  --  dst = self.m_GroundProbe:ResetTarget(dst)

    if self.m_Navigation:IsNavigating() then
        --printyellow("开始移动，导航终止")
        self.m_Navigation:StopNavigate()
        if self:IsRiding() then
            self.m_Mount:StopNavigate()
        end
    end
  --  local canReach = self.m_GroundProbe:CanReach(dst)
    if self:CanReach(dst) and self.m_Effect:CanMove() then
        if self:IsFlying() then
            self.m_TransformSync:SendMove(dst)
        else
            local result, hitPos = self.m_GroundProbe:CanMoveToWithHitPos(dst)
            if result == true then
                self.m_TransformSync:SendMove(dst)
            else
                self.m_TransformSync:SendMove(hitPos + (dst - hitPos).normalized * 0.5)
            end
        end
        return true
    end

    return false
end

function PlayerRole:stop(delta)
    --printyellow("stop")
    self.m_NavigateToWarp=nil
    if self.m_MountType ~= cfg.equip.RideType.NONE and self.m_Mount then
        self.m_Mount:stop(delta)
        --return
    end
    if self.m_Object then
        self.WorkMgr:StopWork(DefineEnum.WorkType.Move)
        if self.m_Navigation:IsNavigating() then
            --printyellow("人物动作停止，导航终止")
            self.m_Navigation:StopNavigate()
            if self:IsRiding() then
                self.m_Mount:StopNavigate()
            end
        end
    end
end

function PlayerRole:StopNavigate()
    if self:IsFlying() then
        if self.m_Mount:IsFlyNavigating() then
            local FlyNavigationManager=require"character.navigation.flynavigationmanager"
            FlyNavigationManager.ClearData()
            self.m_Mount:StopNavigate()
        end
    elseif self.m_Navigation:IsNavigating() then
        self.m_Navigation:StopNavigate()
        if self:IsRiding() then
            self.m_Mount:StopNavigate()
        end
    end
end

function PlayerRole:SetPos(pos)
    if self.m_PathFlyState == false then
        Player.SetPos(self,pos)
        self.m_Pos = self.m_GroundProbe:SetPos(self.m_Pos)
    else
        self.m_Pos = pos
    end
    scenestripping.UpdateOnRoleMove(self:GetMapId(), self.m_Pos)
end


function PlayerRole:GetTalisman()
    local TalismanManager = require("ui.playerrole.talisman.talismanmanager")
    local talisman = TalismanManager.GetCurrentTalisman()
    return talisman
end

function PlayerRole:TransformUpdate()

    if self.m_PathFlyState == false and self:IsFlying() == false then
        --local heightY = self.m_GroundProbe:GetHeight()

        local probePos = self.m_GroundProbe:GetPos()
        local deltaY = 0
        if self:IsJumping() then
            deltaY = self.m_Pos.y - probePos.y
            deltaY = deltaY > 0 and deltaY or 0
        end
        deltaY = deltaY + self.m_OffsetY

        local vec = nil
        if self.m_GroundProbe:IsOnNavMesh() then
             vec = Vector3(probePos.x,probePos.y+deltaY, probePos.z)
        else
             vec = Vector3(self.m_Pos.x,self:GetGroundHeight(nil),self.m_Pos.z)
             self.m_GroundProbe:PositionCheck()
        end
       -- self.m_Object.transform.position = vec
       if self.m_TransformControl and vec~=nil then
            self.m_TransformControl:UpdateTransform(vec,self.m_Rotation)
       end

    else
       -- self.m_Object.transform.position = self.m_Pos
        self.m_TransformControl:UpdateTransform(self.m_Pos,self.m_Rotation)
    end
    if self.m_ShadowObject then
        local charPos = self:GetRefPos()
        local charHei = self:GetGroundHeight(nil)
        self.m_ShadowObject.transform.position = Vector3(charPos.x, charHei, charPos.z)
    end
end

function PlayerRole:update()

    self.m_RoleSkillFsm:Update()
    self.m_Navigation:Update()

    if self.m_bNeedRefreshPKStateIcon then
        self:RefreshPKStateIcon()
    end

    if self:AllowRide() then
        self:MoveToRide()
    end
    -- local TeamManager=require"ui.team.teammanager"

    -- if self.m_Follow then
    --     TeamManager.update()
    -- end
    if self.m_FallToDead then
        local isFalling=self:IsWorkState(WorkType.Jump)
        if not isFalling then
            self:Death()
            self.m_FallToDead=false
        end
    end

    Player.update(self)
    self.m_GroundProbe:Update()
end

function PlayerRole:lateUpdate()
    Player.lateUpdate(self)

end

function PlayerRole:GetNavimeshAgent()
    return self.m_GroundProbe:GetNavimeshAgent()
end


function PlayerRole:GetNavigateTarget()
    return self.m_Navigation:GetTargetInfo()
end

function PlayerRole:GetNaivgateParams()
    if self:IsNavigating() then
        return self.m_Navigation:GetTargetParams()
    elseif self:IsFlying() and self.m_Mount:IsFlyNavigating() then
        return self.m_Mount:GetNavigateTarget()
    end
end


function PlayerRole:OnEndPlaySkill(skillid)
    Player.OnEndPlaySkill(self,skillid)
    local skill = SkillManager.GetSkill(skillid)
    if skill and skill:HasMovement(self) then
        self.m_TransformSync:SendStop()  --有位移技能时同步位置给服务器
    end
end


function PlayerRole:SendAttack(skillid)
    --printyellow("SendAttack")
    local re = map.msg.CSkillPerform( { targetid = self:GetTargetId(), skillid = skillid, direction = self:GetForward() })
    network.send(re)
    self:PlaySkill(skillid)
end

function PlayerRole:SendOrient(delta)
    local re = map.msg.COrient( { orient = delta })
    network.send(re)
end

function PlayerRole:AllowRide()
    local result=false
    result = (not EctypeManager.IsInEctype()) and (MapManager.AllowRide()) and (RideManager.GetActivedRide()) and (not self:IsRiding()) and (self.m_UnLoadMount~=true)
    return result
end

function PlayerRole:CanRide()
    local DlgCombat=require"ui.dlguimain_combat"
    return (not EctypeManager.IsInEctype()) and (MapManager.AllowRide()) and (not self:IsBeAttacked()) and (not self:IsDead()) and (not self:IsAttacking()) and (not self.m_IsFighting) and (not self:IsRelive()) and (not DlgCombat:IsAutoFight())
end

function PlayerRole:CanLand()
    local result=true
    if self.m_Mount then
        result=self.m_Mount:CanLand()
    end
    return result
end

function PlayerRole:CancelRiding(params)
    if PlayerRole:Instance():CanLand() then
        if params then
            self.m_DownToAttackSkill=params.downToAttack
            self.m_DownToAutoFight=params.downToAutoFight
        end
--        if UIManager.isshow("dlguimain") then
--            local DlgUIMain_Combat=require"ui.dlguimain_combat"
--            DlgUIMain_Combat.SetRidingState(false)
--        end
        Player.CancelRiding(self)
        self.m_MoveTime=cfg.equip.Riding.RECOVERRIDE_TIME
    else
        UIManager.ShowSystemFlyText(LocalString.Ride_CanNotLand)
    end
end

--判断是否在导航中
function PlayerRole:IsNavigating()
    return self.m_Navigation:IsNavigating()
end

function PlayerRole:IsFlyNavigating()
    local result=false
    if self.m_Mount and self.m_Mount:IsFlyNavigating()==true then
        result=true
    end
    return result
end

function PlayerRole:IsFollowing()
    return self.m_Follow
end

function PlayerRole:CancelFollowing()
    if self.m_Follow==true then
        self.m_Follow=false
        if UIManager.isshow("dlguimain") then
            UIManager.call("dlguimain","CloseTargetHoming")
        end
    end
end

function PlayerRole:UpdateEctypeInfomation(msg)
    self.m_EctypeInfo = {}
    self.m_EctypeInfo.TowerInfos = msg.climbtowers
    self.m_EctypeInfo.StoryInfos = msg.storys
end

local test = false


function PlayerRole:MoveToRide()
    if self:CanRide() and (self:IsMoving()) then
        self.m_MoveTime=self.m_MoveTime-Time.deltaTime
        if self.m_MoveTime<=0 then
            self.m_MoveTime=cfg.equip.Riding.RECOVERRIDE_TIME
            --self:stop()
            RideManager.Ride(RideManager.GetActivedRide(),cfg.equip.RideType.WALK)
        end
    else
        self.m_MoveTime=cfg.equip.Riding.RECOVERRIDE_TIME
    end
end

function PlayerRole:RefreshRidingAction()
    if (self:IsRiding() and (not self:IsMoving())) then
        if self.m_Mount.m_RoleAction==1 then
            self:PlayLoopAction(cfg.skill.AnimType.StandFly)
        elseif self.m_Mount.m_RoleAction==2 then
            self:PlayLoopAction(cfg.skill.AnimType.StandRide)
        end
    end
end

function PlayerRole:Gold()
    return self.m_Currencys[cfg.currency.CurrencyType.XuNiBi] or 0
end

function PlayerRole:Ingot()
    return self.m_Currencys[cfg.currency.CurrencyType.YuanBao] or 0
end

function PlayerRole:LoadWeapon(dressid,equips)
    Player.LoadWeapon(self,equips)
end

function PlayerRole:GetTargetToAttack(relation)
    local target = self:GetTarget()
    if target and CharacterManager.CanAttack(target,relation) then
        return target
    else
        return CharacterManager.GetRoleNearestAttackableTarget(relation)
    end
end
function PlayerRole:SetTargetId(targetId)
    Player.SetTargetId(self,targetId)
    if UIManager.isshow("dlguimain") then
        UIManager.call("dlguimain","SetTarget",targetId)
    end
end
------------------------------------------------------------------------------------
function PlayerRole:SwitchPathFlyState(isPathFlayState)
    Player.SwitchPathFlyState(self, isPathFlayState)
    self.m_GroundProbe:SetActive(not isPathFlayState)
end


function PlayerRole:StartPathFly(id, endPosition, portalId)

    if  self:CanMove() == false or
        self:CanJump() == false or
        IsNull(self.m_Object) then
        return
    end
    if self:IsRiding() then
        self:CancelRiding()
        self:DeviatePlayerFromMount(false)
    end
    local portalIdValue = portalId or -1
    --printyellow("curveID: ", id)
    --self:sync_SPathFlyBegin(self:GetPos(), id, endPosition, portalIdValue)
    local re = map.msg.CCurveFlyBegin({portalid = portalIdValue, curposition = self:GetPos(), curveid = id,dstposition = endPosition })
    network.send(re)
end
function PlayerRole:sync_SPathFlyBegin(startPos, curveId, targetPos, portalId)
    Player.sync_SPathFlyBegin(self, startPos, curveId, targetPos, portalId)
end

function PlayerRole:sync_SPathFlyEnd(orient)
    Player.sync_SPathFlyEnd(self,orient)
end

function PlayerRole:OnPathFlyStart()
    Player.OnPathFlyStart(self)
    if self:IsNavigating() then
        self.m_Navigation:PauseNavigate()
    end
end

function PlayerRole:OnPathFlyEnd()
    local curOrient = Vector3(0,0,1)
    if self.m_Object then
        curOrient = self.m_Object.transform.forward
    end
    local re = map.msg.CCurveFlyEnd({orient = curOrient })
    network.send(re)
    --printyellow("===========CCurveFlyEnd")
    Player.OnPathFlyEnd(self)
    if self.m_Navigation:IsPaused() then
        self.m_Navigation:RestartNavigate(true)
    end
    self:SetPos(self.m_Pos)
end

function PlayerRole:OnLeaveMap()
    if self.WorkMgr then
        self.WorkMgr:StopWork(DefineEnum.WorkType.Move)
        self.WorkMgr:StopWork(DefineEnum.WorkType.PathFly)
    end
    if self.m_Areocraft then
        self.m_Areocraft:remove()
        self.m_Areocraft = nil
    end
end

function PlayerRole:Jump()
    if self.m_Mount and self.m_Mount:IsAttach() then
        local MountType = defineenum.MountType
        if self.m_Mount.m_MountState == MountType.Ride and self.m_Mount.m_RoleAction==2 then
            self.m_Mount:Jump()
        end
    else
        Player.Jump(self)
    end
end

---------------------回调函数Begin --------------------------------------------------
function PlayerRole:OnJoyStickMove(delta)
    self.m_RoleSkillFsm:OnJoyStickMove(delta)
	--local GameAI = require("character.ai.gameai")
	--GameAI.SetMovingJoyStickDelayTime(2)

    local autoai = require "character.ai.autoai"
    --print("+++++++skill over now............")
    autoai.OnEvent(autoaievents.joy)
end

function PlayerRole:OnJoyStickStop()
    local autoai = require "character.ai.autoai"
    --print("+++++++onjoystick stop............")
    autoai.OnEvent(autoaievents.nojoy)
end

function PlayerRole:NotifyAttackComplete(skillId, bCastCallBackSkill)
    Player.NotifyAttackComplete(self, skillId, bCastCallBackSkill)
    self.m_RoleSkillFsm:NotifyAttackComplete(bCastCallBackSkill)
end

function PlayerRole:NotifyAttackBeBroken(skillId)
    Player.NotifyAttackBeBroken(self, skillId)
    self.m_RoleSkillFsm:NotifyAttackBeBroken(skillId)
end

---------------------回调函数End --------------------------------------------------

function PlayerRole:AddBattlePet(pet)
    table.insert(self.m_Pets,pet)
    for idx,pet in pairs(self.m_Pets) do
        pet.m_PetAI:ResetConfig(s)
    end
end

function PlayerRole:RemoveBattlePet(pet)
    for idx,pet in pairs(self.m_Pets) do
        if petid == pet.m_Id then
            self.m_Pets[idx] = nil
            self.m_BattlePetCount = self.m_BattlePetCount - 1
        end
    end
end

function PlayerRole:OnBeAttacked(attacker,skill,TargetAction,attackInfo)
    Player.OnBeAttacked(self,attacker,skill,TargetAction,attackInfo)
    if attacker then
        if attacker:IsSimplified() then
            -- printyellow(attacker:GetName(),"ToComplete")
            attacker = attacker:ToComplete()
        end
        if self.m_Attacker then
            local atker = self:GetAttacker()
            if atker then
                return
            end
            self.m_Attacker = attacker
        else
            self.m_Attacker = attacker
        end
    end
end

function PlayerRole:GetAttacker()
    if not self.m_Attacker then return nil end
    local attackerid = self.m_Attacker.m_Id
    local attacker = CharacterManager.GetCharacter(attackerid)
    if attacker then return attacker end
    self.m_Attacker = nil
    return nil
end

function PlayerRole:ChangeAttr(ppt)

    Player.ChangeAttr(self,ppt)

    if UIManager.isshow("dlguimain") then
        UIManager.call("dlguimain","UpdateAttributes")
    end
    local DlgUIMain_RoleInfo = require "ui.dlguimain_roleinfo"
    DlgUIMain_RoleInfo.refresh()
    if UIManager.isshow("playerrole.roleinfo.tabroleinfo") then
        UIManager.refresh("playerrole.roleinfo.tabroleinfo")
    end
    self.m_GroundProbe:ChangeSpeed(self.m_Attributes[cfg.fight.AttrId.MOVE_SPEED])
end

-- function PlayerRole:ChangeHP(v)
--     Player.ChangeHP(self,v)
--     if UIManager.isshow("dlguimain") then
--         UIManager.call("dlguimain","UpdateAttributes")
--     end
--     local DlgUIMain_RoleInfo = require "ui.dlguimain_roleinfo"
--     DlgUIMain_RoleInfo.refresh()
--     if UIManager.isshow("playerrole.roleinfo.tabroleinfo") then
--         UIManager.refresh("playerrole.roleinfo.tabroleinfo")
--     end
-- end

function PlayerRole:ChangePKState(state)
    Player.ChangePKState(self,state)
    for _,character in pairs(CharacterManager.GetCharacters()) do
        if character:IsPlayer() or character:IsPet() then
            if CharacterManager.CanAttack(character) then
                printyellow("character",character.m_Name,"redname")
                character:RedName(true)
            else
                printyellow("character",character.m_Name,"whitename")
                character:RedName(false)
            end
        end
    end
    self:RefreshPKStateIcon()
    self:SetTargetId()
end

function PlayerRole:Play3dSound(audioname,priority,volume)
    self.m_CharacterAudioSourceManager:Play(audioname,priority,volume)
end

function PlayerRole:GetJoySpeed()
    local speed=5
    if self:IsRiding() then
        if self:IsFlying() then
            if self.m_Mount.m_FlySpeed then
                speed=speed*(self.m_Mount.m_FlySpeed/5)
            end
        else
            if self.m_Mount.m_PropData and self.m_Mount.m_PropData.speedbuff then
                speed=speed*(1+self.m_Mount.m_PropData.speedbuff/100)
            end
        end
    end
    return speed
end

function PlayerRole:ChangeName(name)
    Player.ChangeName(self,name)
    UIManager.call("dlguimain","RefreshRoleInfo")
end

function PlayerRole:NotifyProcessor(info)
    Player.NotifyProcessor(self, info)
    if info.m_Name == "PlotCutsceneStart" then
        self:stop()
    elseif info.m_Name == "PlotCutsceneEnd" then

    end
end

function PlayerRole:Death()
    if self.m_Mount and self.m_Mount.m_Object then
        local RideManager=require"ui.ride.ridemanager"
        RideManager.Ride(self.m_MountId,cfg.equip.RideType.NONE)
        if self.m_MountType == cfg.equip.RideType.WALK then
            self:DeviatePlayerFromMount(false)
        elseif self.m_MountType == cfg.equip.RideType.FLY then
            self:DeviatePlayerFromMount(true)
            local event = require "character.event.event"
            local jump = event.JumpEvent:new(self,{IsFighting = self.m_IsFighting,JumpType = defineenum.JumpType.Fall})
            self:PushEvent(jump)
            self.m_OffsetY = 0
            self.m_FallToDead = true
        end
    end
    Player.Death(self)
end

function PlayerRole:HaveRelationshipWithRole()
    return true
end

function PlayerRole:SetRideState()
    local MapManager=require"map.mapmanager"
    if (MapManager.AllowRide()) then
        if (self.m_Riding) then
            self.m_Riding=nil
            local RideManager=require"ui.ride.ridemanager"
            if self:CanRide() then
                RideManager.Ride(RideManager.GetActivedRide(),cfg.equip.RideType.WALK)
            else
                RideManager.Ride(0,cfg.equip.RideType.NONE)
            end
        end
        local FlyNavMgr=require"character.navigation.flynavigationmanager"
        FlyNavMgr.CheckIsNeedNav()
    else
        if (self.m_Riding) then
            self.m_Riding=nil
            local RideManager=require"ui.ride.ridemanager"
            RideManager.Ride(0,cfg.equip.RideType.NONE)
        end
    end
    local FlyNavMgr=require"character.navigation.flynavigationmanager"
    FlyNavMgr.CheckIsNeedLineNav()
    local WorldBossManager=require"ui.activity.worldboss.worldbossmanager"
    WorldBossManager.CheckIsNeedNav()
end

function PlayerRole:RemoveEffect(id)
    Player.RemoveEffect(self, id)
    --printyellow("remove effect playerrole...", id)
    local autoai = require "character.ai.autoai"

    autoai.OnEvent(autoaievents.skillover)
end

return PlayerRole
