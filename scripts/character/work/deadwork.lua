-- region *.lua
-- Date
-- 此文件由[BabeLua]插件自动生成



-- endregion
local defineenum = require "defineenum"
local WorkType = defineenum.WorkType
local Work = require "character.work.work"
local AniStatus = defineenum.AniStatus
local PlayerRole
local DeadWork = Class:new(Work)
local CharacterType =defineenum.CharacterType
local MonsterAudioType = defineenum.MonsterAudioType
local AudioManager = require"audiomanager"
local ConfigManager = require"cfg.configmanager"

local uimanager     = require"uimanager"
function DeadWork:__new()
    PlayerRole = require"character.playerrole"
    Work.__new(self)
    self:reset()
    self.type = WorkType.Dead

end

function DeadWork:OnStart()
    self.Character.m_IsDead = true
    self.Character.WorkMgr:StopWork(WorkType.Move)
    self.Character.WorkMgr:StopWork(WorkType.Jump)
    self.Character.WorkMgr:StopWork(WorkType.NormalSkill)
    self.Character.WorkMgr:StopWork(WorkType.BeAttacked)
    self.Character.WorkMgr:StopWork(WorkType.FreeAction)
    Work.OnStart(self)
    self.UpdateNextFrame = true
    if self.Character.m_Type == CharacterType.PlayerRole then
        LuaHelper.CameraGrayEffect(true)
        local EctypeManager = require"ectype.ectypemanager"
        if not EctypeManager.IsInEctype() then
            local ReviveManager=require"character.revivemanager"
            ReviveManager.SetReviveState(true)
        else
            EctypeManager.Dead()
        end
    end
    
	-- DlgUIMain_Combat = require"dlguimain_combat"
	-- DlgUIMain_Combat.SwitchAutoFight(false)
    if self.Character:IsRole() and uimanager.isshow("dlguimain") then
        uimanager.call("dlguimain","SwitchAutoFight",false)
    end
    if self.Character.m_Type == CharacterType.Monster then
        AudioManager.PlayMonsterAudio(MonsterAudioType.DEAD,self.Character.m_Data,self.Character:GetPos())
    end
    if self.m_bIsDead then
        self.Character:PlayAction(cfg.skill.AnimType.Death)
    else
        self.Character:PlayAction(cfg.skill.AnimType.Dying)
    end
end

function DeadWork:OnUpdate()
end

function DeadWork:OnEnd()
    Work.OnEnd(self)
end

function DeadWork:ResumeWork() 
    Work.ResumeWork(self)
    if self.m_bIsDead then
        self.Character:PlayAction(cfg.skill.AnimType.Death)
    else
        self.Character:PlayAction(cfg.skill.AnimType.Dying)
    end
end 

return DeadWork
