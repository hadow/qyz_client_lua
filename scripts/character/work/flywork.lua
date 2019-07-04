local DefineEnum = require "defineenum"
local WorkType = DefineEnum.WorkType
local CharState = DefineEnum.CharState
local Work = require "character.work.work"
local MathUtils = require "common.mathutils"
local CharacterType=DefineEnum.CharacterType
local MountType=DefineEnum.MountType 
local SceneMgr=require "scenemanager"
local Define=require "define"

local MINDIS=0.0001

local FlyWork = Class:new(Work)

function FlyWork:__new()
    Work.__new(self)
    self:reset()
    self.type = WorkType.Fly
end

function FlyWork:reset()
    Work.reset(self)
    self.m_Dir = Vector3.zero
    self.Target = Vector3.zero
    self.SkillTarget = nil
    -- Character
    self.ToCastSkill = nil
    -- Skill
    self.YUpdateEnd = true
end

function FlyWork:CanDo()
    if not Work.CanDo(self) then
        return false
    end

    if not self.Character:CanMove() then
        return false
    end

    return true
end

function FlyWork:OnStart()
    Work.OnStart(self)   
    self.m_Speed=self.Character.m_Attributes[cfg.fight.AttrId.MOVE_SPEED]
    if (not (self.Character.m_MountState==defineenum.MountType.Up)) and (not self.Character.m_FlyNavDown) and ((math.abs(self.Target.x - self.Character:GetRefPos().x)>MINDIS) or (math.abs(self.Target.z - self.Character:GetRefPos().z)>MINDIS)) then 
        self.m_Dir=Vector3(self.Target.x - self.Character:GetRefPos().x, 0, self.Target.z - self.Character:GetRefPos().z).normalized
        self.Character:SetRotation(self.m_Dir)
    else
        self.m_Dir = Vector3(0, self.Target.y-self.Character:GetRefPos().y, 0).normalized
        if ((self.Target.y-self.Character:GetRefPos().y)>0) then
            self.m_Speed=self.Character.m_AscendSpeed
        else
            self.m_Speed=self.Character.m_DescendSpeed
        end
    end  
    --self.Character:PlayLoopAction(cfg.skill.AnimType.Fly)
    if self.Character.m_Type==CharacterType.Mount then
        local Mount=require "character.mount"
        if self.Character:IsAttach() then
            if not self.Character:IsPlayingAction(cfg.skill.AnimType.Run) then
                self.Character:PlayLoopAction(cfg.skill.AnimType.Run)
            end
            local PlayerRole=require "character.playerrole"
            if self.Character.m_RoleAction==1 then
                if not self.Character.m_Player:IsPlayingAction(cfg.skill.AnimType.Fly) then
                    self.Character.m_Player:PlayLoopAction(cfg.skill.AnimType.Fly)
                end
            elseif self.Character.m_RoleAction==2 then
                if not self.Character.m_Player:IsPlayingAction(cfg.skill.AnimType.RunRide) then
                    self.Character.m_Player:PlayLoopAction(cfg.skill.AnimType.RunRide) 
                end
            end     
        end
    end
end

function FlyWork:OnEnd()
    Work.OnEnd(self)   
    if self.Character.m_Type==CharacterType.Mount then
		local Mount=require "character.mount"
		if self.Character:IsAttach() then
			local PlayerRole=require "character.playerrole"
			--printyellow("FlyWork:OnEnd:self.character.m_RoleAction:",self.Character.m_RoleAction)
			if self.Character.m_RoleAction==1 then
				self.Character:PlayLoopAction(cfg.skill.AnimType.Run)
				self.Character.m_Player:PlayLoopAction(cfg.skill.AnimType.Fly)
			elseif self.Character.m_RoleAction==2 then
				--printyellow("OnEnd:setPlayerplaystate")
				self.Character:PlayLoopAction(cfg.skill.AnimType.Run)
				self.Character.m_Player:PlayLoopAction(cfg.skill.AnimType.RunRide) 
		    end     
		end
	end
end

function FlyWork:OnUpdate()
    Work.OnUpdate(self)
--    if self.Character:HasState(CharState.Air) then
--        self:UpdatePosY()
--    end
    self:UpdatePos()
end

--function FlyWork:UpdatePosY()
--    --printyellow("flywork:UpdatePosY")
--    local RealDisY = self.Target.y - self.Character.m_Pos.y
--    if math.abs(RealDisY) > 0.1 then
--        local moveDis = self.Character.m_FlySpeed * Time.deltaTime
--        local offsetY = MathUtils.TernaryOperation(moveDis >= math.abs(RealDisY), RealDisY, moveDis * RealDisY / math.abs(RealDisY))
--        self.Character.m_OffsetY = self.Character.m_OffetY + offsetY
--        --self.Character.Pos = self.Character.Pos + Vector3(0, offsetY, 0)
--        self.YUpdateEnd = false
--    else
--        self.YUpdateEnd = true
--    end
--end
function FlyWork:UpdatePos()
    --printyellow("flywork:UpdatePos")
    local vecPos = Vector3.zero
----    printyellow("self.Target",self.Target)
----    printyellow("self.character.m_Pos:",self.Character:GetPos())
--    if self.Character.m_Type==CharacterType.Mount then
--      --printyellow("Updatepos:mount")
--        if self.Character.m_Player.m_Type==CharacterType.PlayerRole then
----        printyellow("Updatepos:playerrole")
----        printyellow("self.m_Dir",self.m_Dir)
----        printyellow("FlyWorkupdatePos:self.Character.m_MountState:",self.Character.m_MountState)
--            if self.Character.m_FlyNav==true then
--          --printyellow("FlyWorkupdatepos:m_FlyNav")
--                vecPos = Vector3(self.Target.x, self.Character.m_Pos.y, self.Target.z)
--            elseif (self.Character.m_MountState==MountType.Up) or  ((not self.Character.m_Flying) and (self.Character.m_PressUp)) then
--          --printyellow("FlyWorkUpdatePos:up")
--                vecPos=self.Character:GetPos()
--                local ascendHeihgt,targetPosY=self.Character:CalUpHeight(vecPos)
--                local heightInMap=SceneMgr.GetHeight1(vecPos)
----          printyellow("FlyWorktargetPosY:",targetPosY)
----          printyellow("FlyWorkheightInMap:",heightInMap)
----          printyellow("FlyWorkself.Character.m_InitialHeightInFly:",self.Character.m_InitialHeightInFly)          
--                if self.Character.m_MountState==MountType.Up then
--                    if (targetPosY-heightInMap)>=self.Character.m_InitialHeightInFly then
--                        self.Character.m_OffsetY=self.Character.m_InitialHeightInFly              
--                        self.Character.m_MountState=MountType.Fly
--			                  self.Character:SendMountState(cfg.equip.RideType.FLY)
--                        self.Character.m_StopUp=true           
--                    else
--                        self.Character.m_OffsetY=targetPosY-heightInMap
--                    end			
--                else
--                    if targetPosY>=self.Character.m_HeightCeiling then
--                        self.Character.m_OffsetY=self.Character.m_HeightCeiling-heightInMap                
--                    else
--                        self.Character.m_OffsetY=targetPosY-heightInMap
--                    end
--                end
--		            vecPos.y=self.Character.m_OffsetY
--		            self.Character:moveTo(vecPos,self.m_AscendSpeed)
--            elseif (self.Character.m_MountState==MountType.Down) or  (self.Character.m_MountState==MountType.Land) or ((not self.Character.m_Flying) and (self.Character.m_PressDown)) then   
--                vecPos=self.Character:GetPos()
--                local targetPosY=self.Character:CalDownHeight(vecPos)  --绝对高度        
--                local relativeheight=self.Character:GetRelativeHeight(vecPos,targetPosY)
----          printyellow("UpdatePos:relativeheight:",relativeheight)
----          printyellow("UpdatePos:heightDif:",heightDif)
--                if self.Character.m_MountState==MountType.Down then
--                    if relativeheight<=self.Character.m_InitialHeightInRide then
--                        local heightDif=SceneMgr.GetHeight1(vecPos)-SceneMgr.GetHeight(vecPos)
--                        if (SceneMgr.GetHeight(vecPos)>DefineEnum.MinHeight) and (heightDif>-self.Character.m_Height_Dif) and (heightDif<self.Character.m_Height_Dif) then         
--                            self.Character.m_OffsetY=self.Character.m_InitialHeightInRide
--                            self.Character.m_MountState=MountType.Ride
--				                    self.Character:SendMountState(cfg.equip.RideType.WALK)
--                            self.Character.m_StopDown=true
--                        else
--                            self.Character.m_MountState=MountType.Fly 
--                            self.Character:SendMountState(cfg.equip.RideType.FLY)
--                            self.Character.m_OffsetY=self.Character.m_InitialHeightInRide
--                            self.Character.m_StopDown=true
--                        end
--                    else
--                        self.Character.m_OffsetY=relativeheight
--                    end			
--                else           
--                    if relativeheight<=self.Character.m_InitialHeightInRide then
--                        local heightDif=SceneMgr.GetHeight1(vecPos)-SceneMgr.GetHeight(vecPos)              
--                        if (SceneMgr.GetHeight(vecPos)>DefineEnum.MinHeight) and (heightDif>-self.Character.m_Height_Dif) and (heightDif<self.Character.m_Height_Dif)then
--                            self.Character.m_OffsetY=self.Character.m_InitialHeightInRide
--                            self.Character.m_MountState=MountType.Ride
--                            self.Character.m_StopDown=true
--                        else
--                            self.Character.m_OffsetY=self.Character.m_InitialHeightInRide
--                            self.Character.m_StopDown=true
--                        end                
--                    elseif (relativeheight)<=self.Character.m_HeightLimit then
--                        self.Character.m_OffsetY=self.Character.m_HeightLimit
--                        self.Character.m_MountState=MountType.Down
--                    else
--                        self.Character.m_OffsetY=relativeheight
--                    end
--                end 
--		            vecPos.y=self.Character.m_OffsetY
--		            self.Character:moveTo(vecPos,self.m_DescendSpeed)
--            elseif self.Character.m_Flying then
--                --printyellow("Updatepos:pos:",self.Character:GetPos())
--                vecPos = self.Character:GetPos() + self.m_Dir * self.Character.m_FlySpeed * Time.deltaTime
--           --vecPos = self.Character.m_Pos + self.m_Dir * speed * Time.deltaTime        
----                --printyellow("updatepos return:",vecPos)
----                --printyellow("fly height:",SceneMgr.GetHeight1(vecPos))
--                if SceneMgr.GetHeight1(vecPos)<=DefineEnum.MinHeight then
--                    --printyellow("flywork:height1 is invalid")
----              self.offsetY=0
----              self.Character.WorkMgr:StopWork(WorkType.Fly)
----              self:SendStop()
--                    return
--                end 
--                self.Character:CaloffsetY(vecPos)
--                if self.Character.m_OffsetY>self.Character.m_Height_Error then                      
--                    if self.Character.m_OffsetY<0 then
--                        local heightDif=SceneMgr.GetHeight1(vecPos)-SceneMgr.GetHeight(vecPos)
--                       -- printyellow("flywork:updatepos:heightDif:",heightDif)
--                        if  SceneMgr.GetHeight(vecPos)>DefineEnum.MinHeight and (heightDif>-self.Character.m_Height_Dif) and (heightDif<self.Character.m_Height_Dif) then
--                           --printyellow("flywork:keeponmoving")
--                            self.Character.m_OffsetY=0
--                        else
--                            self.Character.m_OffsetY=0
--                            self.Character.WorkMgr:StopWork(WorkType.Fly)
--                            self.Character:SendStop()
--                            return
--                        end 
--                    end
--				            vecPos.y=self.Character.m_OffsetY
--				            self.Character:moveTo(vecPos,self.Character.m_FlySpeed)
--                else
--                    self.Character.m_OffsetY=0
--                    --printyellow("move:stop")
--                    self.Character.WorkMgr:StopWork(WorkType.Fly)
--                    self.Character:SendStop()
--                end
--            else
--                return
--            end        
--        else
--            self.Character.m_OffsetY=self.Target.y
--            vecPos = Vector3(self.Target.x, self.Character.m_Pos.y, self.Target.z)
--        end
--    else
    
    
    
    
    ----------------------------------------------
    if Vector3.Distance(self.Character:GetRefPos(), self.Target) < self.m_Speed * Time.deltaTime then
        vecPos = Vector3(self.Target.x, self.Target.y, self.Target.z)
        self:End()
    else
        vecPos = self.Character:GetRefPos() + self.m_Dir * self.m_Speed * Time.deltaTime   
    end
    local skyHeight=SceneMgr.GetHeight1(vecPos)
    if self.Character:PlayerIsRole() then
        if skyHeight then
            local curPos=self.Character:GetPos()
            if (not self.Character:IsNavigating()) and (self.Character:CanFlyTo(vecPos)==false) or ((skyHeight>cfg.map.Scene.HEIGHTMAP_MIN) and (skyHeight-curPos.y)>0.5) then
                if self.Character.m_FlyNav~=true then
                    vecPos= curPos
                end
            end   
            local skyHeight1=SceneMgr.GetHeight1(vecPos)
            if skyHeight1>cfg.map.Scene.HEIGHTMAP_MIN then
                local offsetY=vecPos.y-skyHeight1
                if self.Character.m_Flying then
                    if self.Character.m_PressUp==true then
                        local heightCeil=SceneMgr.GetFlyHeightCeil()
                        offsetY=offsetY+self.Character.m_AscendSpeed*Time.deltaTime
                        if (skyHeight1+offsetY)>=heightCeil then
                            offsetY=(heightCeil-skyHeight1)
                        end
                    elseif self.Character.m_PressDown==true then
                        offsetY=offsetY-self.Character.m_DescendSpeed*Time.deltaTime
                    end
                elseif (self.Character:IsNavigating()) and (self.m_FlyNavDown==true) then
                    local groudHeight=SceneMgr.GetHeight(vecPos)
                    if groudHeight>cfg.map.Scene.HEIGHTMAP_MIN then
                        offsetY=vecPos.y-groudHeight
                    end
                end
                self.Character.m_OffsetY=offsetY>0 and offsetY or 0
            end
        end
    else
        if skyHeight then
            local offsetY=vecPos.y-skyHeight
            self.Character.m_OffsetY=offsetY>0 and offsetY or 0
        end
    end
    self.Character:SetPos(vecPos)
end

return FlyWork
