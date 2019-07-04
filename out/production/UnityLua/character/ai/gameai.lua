local next = next

local PlayerRole = require "character.playerrole"
local mathutils = require "common.mathutils"

local CharacterManager = require "character.charactermanager"
local SettingManager = require "character.settingmanager"
local TabSettingAutoFight = require "ui.setting.tabsettingautofight"
local CharacterSkillInfo = require "character.skill.characterskillinfo"
local RoleSkill  = require "character.skill.roleskill"
local AttackActionFsm  = require "character.ai.attackactionfsm"
local BagManager       = require "character.bagmanager"
local network		   = require "network"
local LimitTimeManager = require("limittimemanager")
local PlotManager      = require("plot.plotmanager")
local PrologueManager  = require"prologue.prologuemanager"
local TimeUtil = require "common.timeutils"


local AllSkills ={}
local AllSkillIds = {}
local isAutoFight 
local isMovingJoyStick 
local isChangeSkill
local period = 5 
local lastTimeUseHP 
local lastTimeUseMP
local hasInitTime = true
local notStopAutoFight = false
local isVisited = {}
local isAllSkillInvalid


local function GetNotStopAutoFight()
	return notStopAutoFight
end

local function SetNotStopAutoFight(b)
	notStopAutoFight = b 
end 

local function SetSkillChange(b)
	isChangeSkill = b
end

local function GetAllSkillsInProlog()
	local AllSkills =  RoleSkill.GetRoleSkillInfo():GetAllSkills()
	local allskillids = {}
--	printyellow("GetAllSkillsInProlog")
	for _,skillinfo in pairs(AllSkills) do 
        if  not skillinfo:GetSkill():IsPassive() then 	
--			table.insert(allskillids,skillinfo:GetSkill().OriginalSkillId)	

			local item ={}
--			if skillinfo.actived then
			item.skillid = skillinfo:GetSkill().OriginalSkillId
			item.actived = true
			table.insert(allskillids,item)
--			else
--				table.insert(allskillids,item)
--			end 
        end 
    end
	local selected_Skills = {}
	for _, skill in pairs(allskillids) do
--		printyellow("skillid = ",skill.skillid)	
		table.insert(selected_Skills,skill.skillid)
	end
	return selected_Skills
end

local function GetAllSkillIds()

	local AllSkills =  RoleSkill.GetRoleSkillInfo():GetAllSkills()
	local allskillids = {}

	for _,skillinfo in pairs(AllSkills) do 
        if  not skillinfo:GetSkill():IsPassive() then 	
--			table.insert(allskillids,skillinfo:GetSkill().OriginalSkillId)		
			local item ={}
			if skillinfo.actived then
				item.skillid = skillinfo:GetSkill().OriginalSkillId
				item.actived = true
				table.insert(allskillids,item)
			else
				table.insert(allskillids,item)
			end 
        end 
    end
	if PlayerRole:Instance().m_Talisman and RoleSkill.GetRoleSkillByIndex(-1) ~=nil then  --法宝技能
			local item = {}
			item.skillid = RoleSkill.GetRoleSkillByIndex(-1).m_FirstSkillId
			item.actived = true
			table.insert(allskillids,item)
	end 

	local SettingAF = SettingManager.GetSettingAutoFight()
	local selected_Skills = {}
	for index, skill in pairs(allskillids) do
		if SettingAF["Skill" ..index] and skill.actived then
			table.insert(selected_Skills,skill.skillid)
		end
	end
	return selected_Skills
end

--local function GetSelectedSkills()

--	local selected_Skills = {}
--	local allskillids = GetAllSkillIds()
--	local SettingAF = SettingManager.GetSettingAutoFight()

--	for index, skillid in pairs(allskillids) do
--		if SettingAF["Skill" ..index] then
--			table.insert(selected_Skills,skillid)
--		end
--	end
--	return selected_Skills
--end

local function SetMovingJoyStickDelayTime(time)
	isMovingJoyStick = time
end 


local function TryToAttackBySkillId(skillid)
	--return SettingData["Skill"..index] and PlayerRole:Instance().m_RoleSkillFsm:TryToAttackBySkillId(index)
	return  PlayerRole:Instance().m_RoleSkillFsm:TryToAttackBySkillId(skillid)
end


local function NeedHp()
	local SettingAutoFight = SettingManager.GetSettingAutoFight()
    local max_hp = PlayerRole:Instance().m_Attributes[cfg.fight.AttrId.HP_FULL_VALUE] or 1
	local cur_hp = PlayerRole:Instance().m_Attributes[cfg.fight.AttrId.HP_VALUE] or 0
	return cur_hp/max_hp  < (SettingAutoFight["HP"] or 0)
end

local function NeedMp()
	local SettingAutoFight = SettingManager.GetSettingAutoFight()
	local max_mp = PlayerRole:Instance().m_Attributes[cfg.fight.AttrId.MP_FULL_VALUE] or 1
	local cur_mp = PlayerRole:Instance().m_Attributes[cfg.fight.AttrId.MP_VALUE] or 0
--	printyellow("NeedMp()")
--	printyellow(SettingAutoFight["MP"])
--	printyellow(cur_mp)
--	printyellow(max_mp)
	return cur_mp/max_mp  < (SettingAutoFight["MP"] or 0)  
end

local function HealMp()
    if TimeUtil.getTime() - lastTimeUseMP >= 1 then
	    local items = BagManager.GetMPItem()
	    if #items ~= 0 then
		    item = items[1]
		     local cdData =item:GetCDData() 
		    --printyellow("HealMp()")
		     if  cdData:IsReady() then
    --			printyellow("TimeUtil.getTime() - lastTimeUseMP",TimeUtil.getTime() - lastTimeUseMP)
			    BagManager.SendCUseItem(item.BagPos,1)
			    lastTimeUseMP = TimeUtil.getTime()
		    end
	    end
    end
end

local function HealHp()
    if TimeUtil.getTime() - lastTimeUseHP >= 1 then
	    local items = BagManager.GetHPItem()
	    if #items ~= 0 then
		    item = items[1]
		    local cdData =item:GetCDData()

		    if  cdData:IsReady() then
			    BagManager.SendCUseItem(item.BagPos,1)
			    lastTimeUseHP = TimeUtil.getTime()
		    end
	    end
    end
end

local function SetIsAutoFight(b)
	isAutoFight = b
end


local function Attack()
    if CharacterManager.GetRoleNearestAttackableTarget() then

--	printyellow("tag_2")
		if PlayerRole:Instance():CanAttack() then
--	printyellow("tag_3")
			local Index = #AllSkillIds 
			while Index >= 1 do	
--	printyellow("tag_4")
				if not isVisited[Index] and TryToAttackBySkillId(AllSkillIds[Index]) then
					isAllSkillInvalid = false
					isVisited[Index] = true
					break
				end
				Index = Index - 1
			end	
--	printyellow("tag_5")
                --printyellow("isAllSkillInvalid = true")
				isAllSkillInvalid = true
				isVisited = nil
				isVisited = {}
				PlayerRole:Instance().m_RoleSkillFsm:OnButtonCastSkill(0)

		end
	end

end 

local function CastNormalAttack()
	if isMovingJoyStick and isMovingJoyStick ~= 0 then
		return 
	end

	if isAutoFight then
--		printyellow("cast normal skill")
		Attack()
	end

end


local function StartAutoMove () -- 自动挂机

	if not PlayerRole:Instance():IsDead() then 

		if hasInitTime then
			lastTimeUseMP = TimeUtil.getTime() 
			lastTimeUseHP = TimeUtil.getTime() 
			hasInitTime = false
		end 
		if NeedMp() then  --自动吃蓝瓶

			HealMp()
		end
		
		if NeedHp() then  --自动吃红瓶

			HealHp()
		end
	end

	if isMovingJoyStick and isMovingJoyStick ~= 0 then --是否移动Joystic 
		--printyellow("start automove isMovingJoyStick",isMovingJoyStick)
		return 
	end

	if not isAutoFight  then  --是否开始自动战斗
--		printyellow("isAutoFight",isAutoFight)

		return
	end

	if  PlotManager.IsPlayingCutscene()  then
		return 
	end 


	if period ~= 0 then       -- 每五帧运行一次
		period = period - 1
		return 
	else
		period = 5 
	end 

	if PrologueManager.IsInPrologue() then
		AllSkillIds = GetAllSkillsInProlog()
	end

	if isChangeSkill  then
		AllSkillIds = GetAllSkillIds()       --自动打怪
		isChangeSkill = false
			isVisited = nil
			isVisited = {}
	end 
    Attack()

--	printyellow("tag_0")

--	if PlayerRole:Instance():IsAttacking() then
--		return 
--	end 
--	printyellow("tag_1")
	
end




local function second_update(now)
	--printyellow("second_update gameai",isMovingJoyStick)


	if isMovingJoyStick and isMovingJoyStick ~= 0 then
		isMovingJoyStick = isMovingJoyStick - 1
	end


end

local function init()
	local gameevent = require "gameevent"
	gameevent.evt_update:add(StartAutoMove)
	gameevent.evt_second_update:add(second_update)
	isAutoFight = false
end

return {
	init = init,
	update = update,
	
	second_update =second_update,
	SetIsAutoFight = SetIsAutoFight,
	NormalAttack = NormalAttack,
	StartAutoMove = StartAutoMove,
	TryToAttackBySkillId = TryToAttackBySkillId,
	HealMp = HealMp,
	HealHp = HealHp,
	SetMovingJoyStickDelayTime = SetMovingJoyStickDelayTime,
	SetSkillChange = SetSkillChange,
	GetNotStopAutoFight = GetNotStopAutoFight,
	SetNotStopAutoFight = SetNotStopAutoFight,
	CastNormalAttack = CastNormalAttack,
}
