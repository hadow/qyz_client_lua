local print = print
local require = require
local Define            = require "define"
local gameevent = require "gameevent"
local Character = require "character.character"
local Player = require "character.player"
local Monster = require "character.monster"
local Npc = require "character.npc"
local Mineral = require "character.mineral"
local Portal = require "character.portal"
local PlayerRole = require "character.playerrole"
local mathutils = require "common.mathutils"
local ConfigManager = require "cfg.configmanager"
local defineenum = require "defineenum"
local CharacterManagerUI = require("character.charactermanager_ui")
local CharactersEnter = require"character.charactermanager_charactersenter"
-- local SimplifiedCharacter = require"character.simplifiedcharacter"
local CharacterType = defineenum.CharacterType
local EctypeManager
local abridgedCharacterCount = 0
local SettingManager    = require"character.settingmanager"
local FamilyCityTower   = require"character.FamilyCityTower"
--local Camera            = UnityEngine.Camera.main
--local IsHeadInfoShown   = true

local MaiMaiManager = require"ui.maimai.maimaimanager"
local headInfoActive
local IsHidingRoles     = 0
local SceneManager = require "scenemanager"
local TeamManager
--local SkillManager
local UIMain
local buffData
local cfgRelation

local characterManager = {
    m_Object = nil
}

local characters = {} -- id ->  Character --character 同步协议
local localcharacters = {} -- id-> Character  --本地character 和协议无关
local findAgentCache = {} -- agentid -> mapid 缓存
local characterList = {}  -- sort by headInfo Distance
local monToNumMap=nil

local selectedAperture = nil


--[[
    本地character中ID 70000 ~ 80000 暂定为剧情使用
]]

local function AddLocalCharacter(id, type, name, position, eulerAngle, csvid, mounttype, mountid)

    local newCharacter
    if localcharacters[id] then
        newCharacter = localcharacters[id]
    else
        if type == CharacterType.Player then
            newCharacter = Player:new()
            newCharacter:init(id, csvid)
            newCharacter.m_MountType = mounttype
            newCharacter.m_MountId = mountid
        elseif type == CharacterType.Monster then
            newCharacter = Monster:new()
            newCharacter:init(id, csvid)
        elseif type == CharacterType.Npc then
            newCharacter = Npc:new()
            newCharacter:init(id, csvid)
        elseif type == CharacterType.Mineral then
            newCharacter = Mineral:new()
            newCharacter:init(id, csvid)
        elseif type == CharacterType.Portal then
            newCharacter = Portal:new()
            newCharacter:init(id, csvid)
        end
        localcharacters[id] = newCharacter
    end

    if newCharacter ~= nil then
        if position then
            newCharacter:SetPos(position)
        end
        if eulerAngle then
            newCharacter.m_Rotation = SetEulerAngle(eulerAngle)
        end
        if name then
            newCharacter.m_ObjectSetName = name
        end
        if newCharacter.m_Object then
            newCharacter.m_Object.name = name
        end
    end
end

local function HidingRoles()
    return IsHidingRoles == 2
end

local function NeedSimplify(characterid)
    if HidingRoles() then return true end
    local systemSetting = SettingManager.GetSettingSystem()
    local PeopleLimit = systemSetting["Player"]
    --printyellow("PeopleLimit",PeopleLimit)
    if TeamManager.IsTeamMate(characterid) or EctypeManager.IsInEctype() then
        return false
    end
    return abridgedCharacterCount >= PeopleLimit
end

local function GetLocalCharacter(id)
    return localcharacters[id]
end

local function GetCharacter(id)
    return characters[id]
end
local function AddCharacter(id,character,addCount)
    if not character:IsSimplified() and character:IsPlayer() then
        abridgedCharacterCount = abridgedCharacterCount + 1
    end
    characters[id] = character
    return characters[id]
end

local function AddFamilyCityTower(id,csvid)
    local tower = FamilyCityTower:new()
    tower:init(id,csvid)
    tower:SetPos(PlayerRole.Instance():GetRefPos())
    return AddCharacter(id,tower)
end


--为了预防断线重连进行的状态标记
local function ResetCharacterOutDated()
    --printyellow("ResetCharacterOutDataed......")
    if characters then
        for id, character in pairs(characters) do
            --printyellow("resetcharacteroutdated, id is: ", id)
            character.m_outDated = true
        end
    end
end

local function PrintCharacters()
    local characterids = ""
    if characters then
        for id, _ in pairs(characters) do
            characterids = characterids .. "  " .. id
        end
    end
end

local function IsHidingHpBar()
    return IsHidingRoles == 1
end

local function SwitchHideRoles()
    IsHidingRoles = (IsHidingRoles + 1)%3
    if IsHidingRoles == 0 then
        abridgedCharacterCount = 0
    end
    local uimanager = require"uimanager"
    uimanager.ShowSystemFlyText(LocalString.HideRolesText[IsHidingRoles+1])
    for _,character in pairs(characters) do
        if character.m_Type == CharacterType.Player then
            local ret = character
            if IsHidingRoles == 2 then
                if not character:IsSimplified() then
                    ret = character:ToSimplified()
                end
            elseif IsHidingRoles ==1 then
                character:HideHeadInfo()
            else
                if character:IsSimplified() then
                    if not NeedSimplify() then
                        ret = character:ToComplete()
                    end
                end
            end
        end
    end
    return IsHidingRoles
end

local function RemoveLocalCharacter(id)
    -- table.remove(characters,id)
    if localcharacters[id] then
        if localcharacters[id].m_Type == CharacterType.Player and localcharacters[id].m_Mount then
            localcharacters[id].m_Mount:remove()
        end
        localcharacters[id]:remove()
        localcharacters[id] = nil
    end
end

local function RemoveCharacter(id)
    local char = characters[id]
    if char then
        if not char:IsSimplified() and char:IsPlayer() then
            abridgedCharacterCount = abridgedCharacterCount - 1
        end
        char:remove()
        characters[id] = nil
    end
end


--为了断线重连之后的现场恢复
local function ClearInvalidCharacter()
    --printyellow("ClearInvalidCharacter.....")
    if characters then
        for id, character in pairs(characters) do
            --printyellow("before clear invalid character, id is :", id)
            if character.m_outDated and characterList.m_Type ~= CharacterType.PlayerRole then
                --printyellow("should clear invalid character, id is :", id)
                RemoveCharacter(id)
            end
        end
    end
end

local function LeaveCurrentScene()
    local UIMgr=require "uimanager"
    UIMgr.DestroyAllDlgs()
    for i, v in pairs(characters) do
        if v.m_Type ~= CharacterType.PlayerRole then
            RemoveCharacter(i)
        else
            if v:IsRiding() then
                v:DeviatePlayerFromMount(false)
                v.m_Riding=true
            else
                v.m_Riding=nil
                if v.m_Mount then
                    v:DestroyMount()
                    v.m_Riding=true
                end

            end
            v:OnLeaveMap()
        end
    end
    for i, v in pairs(localcharacters) do
        RemoveLocalCharacter(i)
    end
end

local function evaluationCharAttr(charAttr, valueAttr)
    return valueAttr and valueAttr or charAttr
end

local function GetMaxVisiableCount()
    local SystemSetting = SettingManager.GetSettingSystem()
    --printt(SystemSetting)
    return SystemSetting["Monster"] or 10
end
local function UpdateVisiable()
    local MaxVisiableCount = GetMaxVisiableCount()
    --printyellow("MaxVisiableCount",MaxVisiableCount)
    if not EctypeManager.IsInEctype() and MaxVisiableCount>0 then
        local visiablemonsters = {}
        local unvisiablemonsters = {}
        local playerPos = PlayerRole.Instance():GetRefPos()
        -- printyellow("UpdateVisiable1",Time.realtimeSinceStartup)
        for id, character in pairs(characters) do
            if id ~= 0 and character and character:IsMonster() and not character:IsBoss() and character:IsLoaded() then
                if character:IsInCamera() then
                    if character:IsActive() then
                        table.insert(visiablemonsters,{dis = mathutils.DistanceOfXoZ(playerPos,character:GetRefPos()),char = character })
                    else
                        table.insert(unvisiablemonsters,{dis = mathutils.DistanceOfXoZ(playerPos,character:GetRefPos()),char = character })
                    end
                else
                    character:SetActive(false)
                end

            end
        end
        -- printyellow("UpdateVisiable2",Time.realtimeSinceStartup)
        -- printyellow("#visiablemonsters",#visiablemonsters,"#unvisiablemonsters",#unvisiablemonsters)
        if #visiablemonsters > MaxVisiableCount then
            table.sort(visiablemonsters,function (a,b) return a.dis<b.dis end )
            for i=MaxVisiableCount+1,#visiablemonsters do
                visiablemonsters[i].char:SetActive(false)
            end
        elseif #unvisiablemonsters >0 then
            table.sort(unvisiablemonsters,function (a,b) return a.dis<b.dis end )
            for i=1,#unvisiablemonsters do
                -- printyellow("unvisiablemonsters",i,MaxVisiableCount - #visiablemonsters)
                -- printyellow(i<=MaxVisiableCount - #visiablemonsters,i<=(MaxVisiableCount - #visiablemonsters))
                unvisiablemonsters[i].char:SetActive(i<= MaxVisiableCount - #visiablemonsters)
            end
        end
        -- printyellow("UpdateVisiable3",Time.realtimeSinceStartup)
    end
end

local function update()
    if isLogin then return end
    --status.BeginSample("character")
    for id, character in pairs(characters) do
        if id ~= 0 and character then
            --status.BeginSample(tostring(character.m_Type))
            --for i =1, 100 do
            character:update()
            --end
            --status.EndSample()
            if character.m_Type == CharacterType.Player then
                if HidingRoles() then
                    if character:IsShowObj() then
                        character:Hide()
                    end
                end
                if IsHidingHpBar() then
                    if character:IsShowHp() then
                        character:Hide(true)
                    end
                end
            end
        end
    end
    --status.EndSample()
    --status.BeginSample("localcharacter")
    for id, character in pairs(localcharacters) do
        if id ~= 0 and character then
            -- UpdateLoadModel(character)
            character:update()
        end
    end
    CharacterManagerUI.update()
    -- for _,v in pairs
    if selectedAperture then
        selectedAperture:Update()
    end
    --status.EndSample()
end

local function late_update()
    if isLogin then return end
    for id, character in pairs(characters) do
        if id ~= 0 and character then
            character:lateUpdate()
        end
    end
end






local function second_update()
    UpdateVisiable()
end

local function CreatAssistCharacter()
    characterManager.m_Object = UnityEngine.GameObject("characters")
    --characterManager.m_Object:AddComponent(UIPanel)
    UnityEngine.Object.DontDestroyOnLoad(characterManager.m_Object)
    --SetDontDestroyOnLoad()
end

local function GetCharacterManagerObject()
    if characterManager.m_Object then
        return characterManager.m_Object
    end
    CreatAssistCharacter()
    return characterManager.m_Object
end
local function SetCharactersActive(show)
    if characterManager.m_Object then
        characterManager.m_Object:SetActive(show)
    end
    local MonsterHp             = require"ui.dlgmonster_hp"
    if show then
        MonsterHp.show()
    else
        MonsterHp.hide()
    end
    --if show == true then

    --end
end

local function GetNearestCharacterByType(type,Pos,camp,csvid)
    local ret = nil
    local nearestDist = 1e10
    local hasLoadingCharacter = false
    for i, v in pairs(characters) do
        if not csvid or v.m_CsvId == csvid then
            if v.m_Type == type and (v.m_Camp~=camp) and not v:IsDead() then
                if not v:IsLoadingModel() then
                    if not ret then
                        ret = v
                        nearestDist = mathutils.DistanceOfXoZ(v:GetRefPos(), Pos)
                    else
                        local dist = mathutils.DistanceOfXoZ(v:GetRefPos(), Pos)
                        if dist < nearestDist then
                            ret = v
                            nearestDist = dist
                        end
                    end
                else
                    hasLoadingCharacter = true
                end
            end
        end
    end

    if ret then
        return ret,ret
    else
        if hasLoadingCharacter then
            return nil,-1
        else
            return nil,nil
        end
    end
end

local function GetRelation(camp)
    if PlayerRole.Instance().m_Camp then
        local relationInfo = cfgRelation[PlayerRole.Instance().m_Camp]
        local relation = relationInfo.relations[camp + 1]
        return relation
    end
end

local function CanBeAttacker(character)
    if character:IsRole() then return false end
    if character:IsPlayer() then
        local rolefamily = PlayerRole.Instance().m_FamilyName
        local maimai_relation = MaiMaiManager.GetMaimaiRelation(character.m_Id)
        if character.m_PKState == cfg.fight.PKState.TEAM then
            return not TeamManager.IsTeamMate(character.m_Id)
        elseif character.m_PKState == cfg.fight.PKState.FAMILY_AND_TEAM then
            if TeamManager.IsTeamMate(character.m_Id)
            or (maimai_relation and maimai_relation ~= cfg.friend.MaimaiRelationshipType.SuDi)
            or (rolefamily == character.m_FamilyName and rolefamily~="") then
                return false
            else
                return true
            end
        else
            if TeamManager.IsTeamMate(character.m_Id)
            or (maimai_relation and maimai_relation ~= cfg.friend.MaimaiRelationshipType.SuDi)
            or (rolefamily == character.m_FamilyName and rolefamily~="") then
                return false
            elseif (maimai_relation and maimai_relation == cfg.friend.MaimaiRelationshipType.SuDi)
            or character:IsInWarWithRoleFamily()
            or character.m_PKState == cfg.fight.PKState.FAMILY_AND_TEAM
            or character.m_PKState == cfg.fight.PKState.TEAM then
                return true
            else
                return false
            end
        end
    elseif character:IsPet() then
        local master = GetCharacter(character.m_MasterId)
        if master then
            return CanBeAttacker(master)
        else
            return GetRelation(character.m_Camp) == cfg.fight.Relation.ENEMY
        end
    end
    return false
end

local function CheckAttackable(character,relation,b)
    if character:IsRole() then return false end
    if EctypeManager.IsInEctype() and GetRelation(character.m_Camp) == relation then
        return true
    else
        local pkstate = PlayerRole.Instance().m_PKState
        local maimai_relation = MaiMaiManager.GetMaimaiRelation(character.m_Id)
        local rolefamily = PlayerRole.Instance().m_FamilyName
        if pkstate == cfg.fight.PKState.TEAM then
            return not TeamManager.IsTeamMate(character.m_Id)
        elseif pkstate == cfg.fight.PKState.FAMILY_AND_TEAM then
            if character.m_PKState == cfg.fight.PKState.TEAM then
                return not TeamManager.IsTeamMate(character.m_Id)
            else
                if TeamManager.IsTeamMate(character.m_Id)
                or (maimai_relation and maimai_relation ~= cfg.friend.MaimaiRelationshipType.SuDi)
                or (rolefamily == character.m_FamilyName and rolefamily~="") then
                    return false
                else
                    return true
                end
            end
        else
            if character.m_PKState == cfg.fight.PKState.TEAM then
                return not TeamManager.IsTeamMate(character.m_Id)
            elseif character.m_PKState == cfg.fight.PKState.FAMILY_AND_TEAM then
                if TeamManager.IsTeamMate(character.m_Id)
                or (maimai_relation and MaimaiRelationshipType ~= cfg.friend.MaimaiRelationshipType.SuDi)
                or (rolefamily == character.m_FamilyName and rolefamily ~= "") then
                    return false
                else

                    return true
                end
            else
                if (maimai_relation and maimai_relation == cfg.friend.MaimaiRelationshipType.SuDi)
                or character:IsInWarWithRoleFamily() then
                    return true
                else
                    return false
                end
            end
        end
    end
end

local function CanAttack(character,r)
    local relation = r or cfg.fight.Relation.ENEMY
    if character:IsDead() then return false end
    if character:IsRole() then return false end
    -- if character.m_Effect:CanBeAttack() then return false end
    if not character:IsSimplified() then
        if relation == cfg.fight.Relation.ENEMY then
            if not character.m_Effect:CanBeAttack() then return false end
        else
            if not character.m_Effect:CanUseItem() then return false end
        end
    end
    if character:IsMonster() then
        return GetRelation(character.m_Camp) == relation
    elseif character.m_Type == CharacterType.Player then
        return CheckAttackable(character,relation)
    elseif character:IsPet() then
        local master = character:GetMaster()
        if master then
            return CheckAttackable(master,relation)
        else
            return GetRelation(character.m_Camp) == relation
        end
    else
        return false
    end
end

local function GetRoleAttackableTargets(relation)
    local ret = {}
    for _,target in pairs(characters) do
        if CanAttack(target,relation) then
            table.insert(ret,target)
        end
    end
    return ret
end

local function GetRoleNearestAttackableTarget(relation)
    local targets = GetRoleAttackableTargets(relation)
    local nearestDist = 1e10
    local ret = nil
    for _,target in pairs(targets) do
        local dist = mathutils.DistanceOfXoZ(PlayerRole.Instance():GetRefPos(),target:GetRefPos())
        if dist < nearestDist then
            nearestDist = dist
            ret = target
        end
    end
    return ret,nearestDist
end

local function GetNearestMonster(Pos,camp,csvid)
    return GetNearestCharacterByType(CharacterType.Monster,Pos,camp,csvid)
end

local function GetNearestMineral(Pos,camp,csvid)
    return GetNearestCharacterByType(CharacterType.Mineral,Pos,camp,csvid)
end

local function GetNearestDropItem(Pos)
	local ret = nil
	local nearestDist = 1e10
	for i, v in pairs(characters) do
		if v.m_Type == CharacterType.DropItem then
			local dist = mathutils.DistanceOfXoZ(v:GetRefPos(), Pos)
            if dist < nearestDist then
                ret = v
                nearestDist = dist
            end
		end
	end
	if ret then
		return  ret
	else
		return nil
	end

end


local function GetNearestCharacterByCsvId(csvId)
    local miningmanager = require "miningmanager"
    local maxDistance = 10000
    local target
    for id, character in pairs(characters) do
        if id ~= PlayerRole.Instance().m_Id then
            if character and character.m_Pos and character.m_CsvId == csvId and character:IsShowObj() and
               (character:IsMineral() == false or miningmanager.GetCurMineID() ~= character.m_Id) then
                local dis = mathutils.DistanceOfXoZ(character:GetRefPos(), PlayerRole.Instance():GetRefPos())
                if dis < maxDistance then
                    maxDistance = dis
                    target = character
                end
            end
        end
    end
    return target
end

local function HideNearestCharacterByCsvId(csvId,ishide)
    local maxDistance = 10000
    local target
    for id, character in pairs(characters) do
        if id ~= PlayerRole.Instance().m_Id then
            if character and character.m_Pos and character.m_CsvId == csvId then
                local dis = mathutils.DistanceOfXoZ(character:GetRefPos(), PlayerRole.Instance():GetRefPos())
                if dis < maxDistance then
                    if ishide then
                        character:Hide()
                    else
                        character:Show()
                    end
                end
            end
        end
    end
end

local function GetAllNearbyNpcs()
    local maxDistance = 15
    local target = {}
    local count = 0
    for id, character in pairs(characters) do
        if id ~= PlayerRole.Instance().m_Id then
            if character and character.m_Pos and character.m_Type == CharacterType.Npc then
                local dis = mathutils.DistanceOfXoZ(character:GetRefPos(), PlayerRole.Instance():GetRefPos())
                if dis <= maxDistance then
                    count = count + 1
                    target[count] = character
                end
            end
        end
    end
    return target,count
end

local function GetAllMonstersByCsv()
    local allMonsters = { }
    local landscapedata = ConfigManager.getConfig("landscape")
    local i = 1
    for _, item in pairs(landscapedata) do
        if item and item.controllers then
            for _, controller in pairs(item.controllers) do
                if controller and controller.monsters then
                    for _, monster in pairs(controller.monsters) do
                        allMonsters[i] = monster
                    end
                end
            end
        end
        i = i + 1
    end
    return allMonsters
end

local function Comps(a, b)
    return a.count > b.count
end

local function GetTypicalMonsterName(monsters)
    local monsterName = ""
    if monsters then
        table.sort(monsters, Comps)
        local monsterData = ConfigManager.getConfigData("monster", monsters[1].monsterid)
        if monsterData then
            monsterName = monsterData.name
        end
    end
    return monsterName
end

local function GetCentralPointOfPolygon(polygonRegion)
    local centralPoint = Vector3.zero
    local i = 0
    for _, point in pairs(polygonRegion.vertices) do
        centralPoint = Vector3(centralPoint.x + point.x, centralPoint.y + point.y, centralPoint.z + point.z)
        i = i + 1
    end
    if i ~= 0 then
        centralPoint = Vector3((centralPoint.x) / i,(centralPoint.y) / i,(centralPoint.z) / i)
    end
    return centralPoint
end


local function GetAgentPositionInControllers(controllers, agent_id, agent_type)
    for _, controller in pairs(controllers) do
        if controller and controller.deployments then
            for _, deployment in pairs(controller.deployments) do
                if deployment then
                    if agent_type == CharacterType.Monster and deployment.monsters then
                        for _, monster in pairs(deployment.monsters) do
                            if monster and monster.monsterid == agent_id then
                                if deployment.location.polygons then
                                    for _, polygonRegion in pairs(deployment.location.polygons) do
                                        local position = GetCentralPointOfPolygon(polygonRegion)
                                        return position
                                    end
                                elseif deployment.location.positions then
                                    for _, point in pairs(deployment.location.positions) do
                                        local position = Vector3(point.position.x, point.position.y, point.position.z)
                                        return position
                                    end
                                end
                            end
                        end
                    elseif agent_type == CharacterType.Npc and deployment.npcid == agent_id then
                        local position = Vector3(deployment.position.x, deployment.position.y, deployment.position.z)
                        return position,deployment.orientation
                    elseif agent_type == CharacterType.Mineral and deployment.minerals then
                        for _, mineral in pairs(deployment.minerals) do
                            if mineral and mineral.mineralid == agent_id then
                                if deployment.location.positions then
                                    for _, point in pairs(deployment.location.positions) do
                                        local position = Vector3(point.position.x, point.position.y, point.position.z)
                                        return position
                                    end
                                elseif deployment.location.polygons then
                                    for _, polygonRegion in pairs(deployment.location.polygons) do
                                        local position = GetCentralPointOfPolygon(polygonRegion)
                                        return position
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function GetAgentPositionInCSV(agent_id,agent_type)
    -- 先找附近的
   local curMapId = SceneManager.GetCurMapId()
   local nearestCharacter = GetNearestCharacterByCsvId(agent_id)
   if nearestCharacter then
       findAgentCache[agent_id] = curMapId
       --printyellow("success to find agent, mapId:"..curMapId)
       return curMapId,nearestCharacter.m_Pos,nearestCharacter.m_Rotation
   end

    -- 接着找历史地图或当前地图
    local landscapeId = 0
    local mapId = 0
    if findAgentCache[agent_id] and findAgentCache[agent_id] > 0 then
        local worldmapData = ConfigManager.getConfigData("worldmap",findAgentCache[agent_id])
        if worldmapData then
            landscapeId = worldmapData.landscapeid
            mapId = findAgentCache[agent_id]
        end
    end
    if landscapeId <= 0 then
       landscapeId = SceneManager.GetLandscapeId() --当前地图
       mapId = curMapId
    end

    local landscapedata = ConfigManager.getConfigData("landscape",landscapeId)
    if landscapedata and landscapedata.controllers then
        local position
        local orientation
        position,orientation = GetAgentPositionInControllers(landscapedata.controllers,agent_id,agent_type)
        if position then
            findAgentCache[agent_id] = mapId
            -- printyellow("success to find agent, mapId:"..mapId)
            return mapId, position,orientation
        end
    end

    -- 再找其他的
    local worldmap = ConfigManager.getConfig("worldmap")
    for _, item in pairs(worldmap) do
        if item.id ~= mapId then
            local landscapedata = ConfigManager.getConfigData("landscape",item.landscapeid)
            if landscapedata and landscapedata.controllers then
                local position
                local orientation
                position,orientation = GetAgentPositionInControllers(landscapedata.controllers,agent_id,agent_type)
                if position then
                    findAgentCache[agent_id] = item.id
                    -- printyellow("success to find agent, mapId:"..item.id)
                    return item.id, position,orientation
                end
            end
        end
    end
end

local function IsPolygonValue(monsterName)
    local value=false
    if monToNumMap[monsterName] then
        if monToNumMap[monsterName]<2 then
            monToNumMap[monsterName]=monToNumMap[monsterName]+1
            value=true
        end
    else
        value=true
        monToNumMap[monsterName]=1
    end
    return value
end

local function GetAllPolygonRegions()
    local allPolygons = { }
    monToNumMap={}
    local landscapeId = SceneManager.GetLandscapeId()
    local landscapedata = ConfigManager.getConfig("landscape")
    local i = 1
    for _, item in pairs(landscapedata) do
        if item.id == landscapeId then
            if item and item.controllers then
                for _, controller in pairs(item.controllers) do
                    if controller and controller.deployments then
                        for _, deployment in pairs(controller.deployments) do
                            if deployment and deployment.monsters then
                                local monsterName = GetTypicalMonsterName(deployment.monsters)
                                if deployment.location.polygons then
                                    for _, polygonRegion in pairs(deployment.location.polygons) do
                                        if IsPolygonValue(monsterName)==true then
                                            local monsterInfo = { }
                                            monsterInfo.monsterName = monsterName
                                            monsterInfo.position = GetCentralPointOfPolygon(polygonRegion)
                                            allPolygons[i] = monsterInfo
                                            i = i + 1
                                        end
                                    end
                                elseif deployment.location.positions then
                                    for _, point in pairs(deployment.location.positions) do
                                        if IsPolygonValue(monsterName)==true then
                                            local monsterInfo = { }
                                            monsterInfo.monsterName = monsterName
                                            monsterInfo.position = point.position
                                            allPolygons[i] = monsterInfo
                                            i = i + 1
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    monToNumMap=nil
    return allPolygons
end

local function GetAllNpcsByCsv()
    local allNpcs = { }
    local landscapeId = SceneManager.GetLandscapeId()
    local landscapedata = ConfigManager.getConfig("landscape")
    local i = 1
    local TaskManager=require"taskmanager"
    for _, item in pairs(landscapedata) do
        if item.id == landscapeId then
            if item and item.controllers then
                for _, controller in pairs(item.controllers) do
                    if controller and controller.deployments then
                        for _, deployment in pairs(controller.deployments) do
                            if deployment and deployment.npcid then
                                local npcCfg=ConfigManager.getConfigData("npc",deployment.npcid)
                                if (npcCfg.isexclusive==false) or (TaskManager.IsExclusiveNpcShowHide(deployment.npcid)==true) then
                                    local npc = { npcid = deployment.npcid, position = deployment.position, orientation = deployment.orientation }
                                    allNpcs[i] = npc
                                    i = i + 1
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return allNpcs
end

local function GetPortal(id)
    local portal = nil
    local mapCfg = ConfigManager.getConfigData("worldmap", PlayerRole:Instance():GetMapId())
    if mapCfg and mapCfg.portals then
        for _, portalItem in pairs(mapCfg.portals) do
            if portalItem.srcregionid == id then
                portal = portalItem
            end
        end
    end
    return portal
end

local function GetWarp(id)
    local warp = nil
    local circleRegionSet = ConfigManager.getConfig("circleregionset")
    local i = 1
    for _, circleRegion in pairs(circleRegionSet) do
        if SceneManager.IsCurMapWarp(circleRegion.id) then
            for _, region in pairs(circleRegion.regions) do
                if region.id == id then
                    warp = { }
                    warp.id = region.id
                    warp.circle = region.circle
                    warp.position = region.circle.center
                    warp.portal = GetPortal(region.id)
                    warp.name = warp.portal.srcregionname
                    warp.effectPos=Vector3(warp.portal.effectpos.x,warp.portal.effectpos.y,warp.portal.effectpos.z)
                    warp.effectRotation=warp.portal.rotation
                end
            end
        end
    end
    return warp
end

local function GetAllWarps()
    local allWarps = { }
    local circleRegionSet = ConfigManager.getConfig("circleregionset")
    local i = 1
    for _, circleRegion in pairs(circleRegionSet) do
        if SceneManager.IsCurMapWarp(circleRegion.id) then
            for _, region in pairs(circleRegion.regions) do
                local warp = { }
                warp.id = region.id
                warp.circle = region.circle
                warp.position = region.circle.center
                warp.portal = GetPortal(region.id)
                if warp.portal then
                    warp.name = warp.portal.srcregionname
                end
                if warp.portal~=nil then
                    allWarps[i] = warp
                    i = i + 1
                end
            end
        end
    end
    return allWarps
end



local function GetNearestAttackableCharacter(pos)
    if not pos then pos = PlayerRole.Instance():GetRefPos() end
    local nearestDist = 1e10
    local nearestChar = nil
    for i, v in pairs(characters) do
        local dist = mathutils.DistanceOfXoZ(v:GetRefPos(), pos)
        if dist < nearestDist then
            nearestDist = dist
            nearestChar = v
        end
    end
    return nearestChar, nearestDist
end


local function GetNearestPlayer()
    local maxDistance = 10000
    local target
    for id, character in pairs(characters) do
        if id ~= PlayerRole.Instance().m_Id then
            --[[


            printyellow("character.Pos")


            printt(character.Pos)


            printyellow("PlayerRole.Instance().Pos")


            printt(PlayerRole.Instance().Pos)


            --]]
            if character and character.m_Pos then
                local dis = mathutils.DistanceOfXoZ(character:GetRefPos(), PlayerRole.Instance():GetRefPos())
                if dis < maxDistance then
                    maxDistance = dis
                    target = character
                end
            end
        end
    end
    return target
end

local function AddPortals()
    local warps = GetAllWarps()
    if warps then
        for _, warp in ipairs(warps) do
            AddLocalCharacter(warp.id, CharacterType.Portal, warp.name)
        end
    end
end

local function GetCharacterByCsvId(csvid)--获取一个
    for _, v in pairs(characters) do
        if v.m_CsvId == csvid then
            return v
        end
    end
end

local function GetCharactersByCsvId(csvid)--获取所有
    local result={}
    for _, v in pairs(characters) do
        if v.m_CsvId == csvid then
            table.insert(result,v)
        end
    end
    return result
end

local function ShowCharactersByCsvId(csvid)
    for _, character in pairs(characters) do
        if character and character.m_CsvId == csvid then
            character:Show()
        end
    end
end

local function NotifySceneLoadStart()
    for _, char in pairs(characters) do
        if char:IsPathFlying() then
            char:StopPathFly()
        end
    end
    PlayerRole:Instance():SwitchToOutFightState()
end


-- local function Reset()
--     isLogin = false
-- end

local function NotifySceneLoaded()
    isLogin = false
    --Reset()
    PlayerRole:Instance():OnSceneLoaded()
    for id, character in pairs(characters) do
        character:SetPos(character.m_Pos)
    end


    local EctypeManager = require "ectype.ectypemanager"
    if not EctypeManager.IsInEctype() then
        AddPortals()
    end
end


local function NotifySceneLoginLoaded()
    for _,char in pairs(characters) do
        if char:IsRole() then
            char:Hide()
            characters[char.m_Id] = nil
        else
            RemoveCharacter(_)
        end
    end
    isLogin = true
end


local function GetCharacters()
    return characters
end
local function GetLocalCharacters()
    return localcharacters
end

local function RemoveCharacters()
    for i, v in pairs(characters) do
        if v.m_Type ~= CharacterType.PlayerRole then
            RemoveCharacter(i)
        end
    end
end

local function HideElsePlayer(hideHP)
    for i, v in pairs(characters) do
        if v.m_Type == CharacterType.Player then
            v:Hide(hideHP)
        end
    end
end

local function ShowElsePlayer()
    for i, v in pairs(characters) do
        if v.m_Type == CharacterType.Player then
            v:Show()
        end
    end
end

local function GetNearestCharacter(pos)
    local distMin = 1e10
    local nearestCharacter = nil
    for i,v in pairs(characters) do
        local dist = mathutils.DistanceOfXoZ(pos,v:GetRefPos())
        if dist<distMin then
            nearestCharacter = v
            distMin = distMin
        end
    end
    return nearestCharacter
end



local function NotifyPlotCutsceneStart(info)

    local types = "PlotCutsceneStart"
    for i, char in pairs(characters) do
        if types == nil or types[char.m_Type] ~= nil then
           -- printyellow("===>", char.m_Name)
            if char.NotifyProcessor then
            --    printyellow("name:" .. char.m_Name)
                char:NotifyProcessor(info)
            end
        end
    end
end

local function NotifyPlotCutsceneEnd(info)

    local types = "PlotCutsceneEnd"
    for i, char in pairs(characters) do
        if types == nil or types[char.m_Type] ~= nil then
           -- printyellow("===>", char.m_Name)
            if char.NotifyProcessor then
            --    printyellow("name:" .. char.m_Name)
                char:NotifyProcessor(info)
            end
        end
    end
end

local function NotifyFamilyWarStateChange(info)
    for i, char in pairs(characters) do
        if char:IsPlayer() then
            char:OnFamilyWarChange()
        end
    end
end

local function ChangePetSkin(petid,skinid)
    local pet = GetCharacter(petid)
    if pet then
        pet:ChangeSkin(skinid)
    end
end

local function GetPlayerForUI(publicRoleInfo,callback)
    local TitleManager = require "ui.title.titlemanager"

    local player = Player:new(nil)
    player.m_AnimSelectType = cfg.skill.AnimTypeSelectType.UI
    player:RegisterOnLoaded(function(obj)
        ExtendedGameObject.SetLayerRecursively(obj, Define.Layer.LayerUICharacter)
        if callback then
            callback(player,obj)
        end
    end)

    player:init(publicRoleInfo.roleid, publicRoleInfo.profession, publicRoleInfo.gender, false,publicRoleInfo.dressid,publicRoleInfo.equips, nil, 0.75)

    player.m_Name           = publicRoleInfo.name or ""
    player.m_Level          = publicRoleInfo.level or 0
    player.m_VipLevel       = publicRoleInfo.viplevel or 0
    player.m_Power          = publicRoleInfo.combatpower or 0
    --player.m_Dress =

    --player.m_FamilyID   = publicRoleInfo.family or nil
    player.m_FamilyName     = publicRoleInfo.familyname or ""
    player:ChangeTitle(publicRoleInfo.title)
    player.m_LoverName      = publicRoleInfo.lovername or ""
    --player.m_Profession = publicRoleInfo.profession
    if publicRoleInfo.fightattrs then
        player:ChangeAttr(publicRoleInfo.fightattrs)
    end

    return player
end

local function GetCharacterPets(player)
    local ret = {}
    for _,character in pairs(characters) do
        if character:IsPet() and character.m_MasterId == player.m_Id then
            table.insert(ret,character)
        end
    end
    return ret
end


local function AlterCharacter(id,b)
    local char = characters[id]
    local ret = nil
    if char:IsPlayer() then
        local charMsg = char:GetMessage()
        local charPets = GetCharacterPets(char)
        RemoveCharacter(char.m_Id)
        ret = CharactersEnter.CreatePlayer(charMsg,b)
        for _,pet in pairs(charPets) do
            AlterCharacter(pet.m_Id,b)
        end
    elseif char:IsPet() then
        local petMsg = char:GetMessage()
        RemoveCharacter(char.m_Id)
        ret = CharactersEnter.CreatePet(petMsg,b)
    end
    return ret
end
--
-- local function UpdateDistHeadInfosToCamera(pos)
--     for _,character in pairs(characters) do
--         if character.m_Object and character.m_HeadInfo.m_HpBar then
--             local headInfo = character.m_HeadInfo
--             if headInfo then
--                 local worldPosition = --headInfo.m_HpBar.transform.position
--                 character.m_Object.transform.position + Vector3.up * character.m_HeadInfo.m_Height
--                 local dist = worldPosition - pos
--                 headInfo.m_VectorToCamera   = dist
--                 headInfo.m_DistToCamera = dist.magnitude
--             end
--         end
--     end
-- end
--
-- local function UpdateHeadInfoDepth()
--     characterList = {}
--     for id,character in pairs(characters) do
--         if character.m_Object and character.m_HeadInfo.m_HpBar then
--             local tb = {}
--             tb.character = character
--             tb.dist = character.m_HeadInfo.m_DistToCamera
--             table.insert(characterList,tb)
--         end
--     end
--     table.sort(characterList,function(a,b) return a.dist > b.dist end)
--     for idx,depthInfo in ipairs(characterList) do
--         local character = depthInfo.character
--         local depthOffset = depthInfo.dist
--         character.m_HeadInfo:SetDepth(idx)
--     end
-- end

local function init()
    local CharacterManager_Sync = require("character.charactermanager_sync")
    TeamManager = require "ui.team.teammanager"
    EctypeManager = require "ectype.ectypemanager"
    IsHidingRoles = 0
    local evtid_update = gameevent.evt_update:add(update)
    status.AddStatusListener("charmgr",gameevent.evt_update,evtid_update)
    local evtid_late_update = gameevent.evt_late_update:add(late_update)
    status.AddStatusListener("charmgr",gameevent.evt_late_update,evtid_late_update)
    gameevent.evt_second_update:add(second_update)

    gameevent.evt_system_message:add("logout",LeaveCurrentScene)

    gameevent.evt_notify:add("plotcutscene_start",NotifyPlotCutsceneStart)
    gameevent.evt_notify:add("plotcutscene_end",NotifyPlotCutsceneEnd)
    gameevent.evt_notify:add("loadscene_start",NotifySceneLoadStart)
    gameevent.evt_notify:add("loadscene_end",NotifySceneLoaded)
    gameevent.evt_notify:add("familywar_statechange",NotifyFamilyWarStateChange)
    headInfoActive = true
    abridgedCharacterCount = 0
    CreatAssistCharacter()
    CharacterManager_Sync.init()
    CharacterManagerUI.init()
    cfgRelation = ConfigManager.getConfig("camprelation")
    --SkillManager = require "character.skill.skillmanager"
end

local function Start()
    local SelectedAperture = require("character.footinfo.selectedaperture")
    selectedAperture = SelectedAperture:Instance()
end


local function GetPlayerPets(player)
    local ret = {}
    for _,char in pairs(characters) do
        if char:IsPet() then
            if char.m_MasterId == player.m_Id then
                table.insert(ret,char)
            end
        end
    end
    return ret
end

local function GetAbridgedCharacterCount()
    return abridgedCharacterCount
end

local function SkillAttack(msg)
    local attacker = GetCharacter(msg.attackerid)
    if not attacker then return false end
    local SkillManager = require"character.skill.skillmanager"
    local skill = SkillManager.GetSkill(msg.skillid)
    if not skill then return false end
    for _,attackInfo in pairs(msg.attacks) do
        local beAttacker = GetCharacter(attackInfo.defencerid)
        if beAttacker then
            -- beAttacker:HPDecrease(attackInfo.attack)
            -- printt(attackInfo)
            if attackInfo.ismiss ~=1 then
                --beAttacker:ChangeHP(attackInfo.hp)
                beAttacker:ChangeAttr( { [cfg.fight.AttrId.HP_VALUE] = attackInfo.hp } )
            end
            if beAttacker:IsRole() then
                if not beAttacker.m_MapInfo:IsChangingScene() then
                    beAttacker:OnBeAttacked(attacker,skill,cfg.skill.AnimType.Hit,attackInfo)
                end
            else
                --printyellow("OnBeAttacked",beAttacker.m_Id)
                beAttacker:OnBeAttacked(attacker,skill,cfg.skill.AnimType.Hit,attackInfo)
            end
        end
    end
    return true
end

local function GetRolePet(modelid)
    for _,char in pairs(characters) do
        if char:IsPet() then
            local pet = char
            if pet.m_CsvId == modelid then
                local master = pet:GetMaster()
                if master and master:IsRole() then
                    return pet
                end
            end
        end
    end
    return nil
end

local function RefreshPetAttributes(pet)
    local uimanager = require"uimanager"
    if uimanager.hasloaded("dlguimain") then
        uimanager.call("dlguimain","RefreshPetAttributes",pet)
    end
end

local function SetHeadInfoActive(b)
    headInfoActive = b
    for _,character in pairs(characters) do
        if character:IsRole() or (character:IsPet() and character:IsRolePet()) then

        else
            if not character:IsNpc()
            or not EctypeManager.IsBattleEctype() then
                character:HeadActive(b)
            end
        end
    end
end

local function ShowAllHpProgress()
    for _,character in pairs(characters) do
        if not character:IsRole() then
            if character.m_HeadInfo then
                character.m_HeadInfo:ShowHpProgress(true)
            end
        end
    end
end

local function GetHeadInfoActivity()
    return headInfoActive
end

return {
    -- UpdateDistHeadInfosToCamera = UpdateDistHeadInfosToCamera,
    -- UpdateHeadInfoDepth  = UpdateHeadInfoDepth,

    init = init,
    Start = Start,
    GetNearestMonster = GetNearestMonster,
    GetCharacter = GetCharacter,
    GetCharacters = GetCharacters,
    GetNearestPlayer = GetNearestPlayer,
    GetNearestCharacterByCsvId = GetNearestCharacterByCsvId,
    HideNearestCharacterByCsvId = HideNearestCharacterByCsvId,
    GetAgentPositionInCSV = GetAgentPositionInCSV,
    GetAllNearbyNpcs = GetAllNearbyNpcs,
    GetAllNpcsByCsv = GetAllNpcsByCsv,
    GetAllWarps = GetAllWarps,
    GetWarp = GetWarp,
    GetAllMonstersByCsv = GetAllMonstersByCsv,
    GetAllPolygonRegions = GetAllPolygonRegions,
    --NotifySceneLoaded = NotifySceneLoaded,
    AddNpc = AddNpc,
    AddMineral = AddMineral,
    AddCharacter = AddCharacter,
    AddPortals = AddPortals,
    RemoveCharacter = RemoveCharacter,
    GetNpcName = GetNpcName,
    CanBeAttacker = CanBeAttacker,
    GetCharacterPets    = GetCharacterPets,

    RemoveCharacters = RemoveCharacters,
    LeaveCurrentScene = LeaveCurrentScene,
    GetCharacterByCsvId = GetCharacterByCsvId,
    GetCharactersByCsvId = GetCharactersByCsvId,
    GetNearestCharacter = GetNearestCharacter,
    GetNearestAttackableCharacter = GetNearestAttackableCharacter,
    GetNearestDropItem = GetNearestDropItem,
    GetRelation = GetRelation,
    UpdateLoadModel = UpdateLoadModel,
    CanAttack = CanAttack,
    RefreshPetAttributes        = RefreshPetAttributes,

    AddLocalCharacter = AddLocalCharacter,
    GetLocalCharacter = GetLocalCharacter,
    RemoveLocalCharacter = RemoveLocalCharacter,
    --SendPick = SendPick,
    ShowElsePlayer = ShowElsePlayer,
    HideElsePlayer = HideElsePlayer,
    GetPlayerForUI=GetPlayerForUI,
    SwitchHideRoles = SwitchHideRoles,
    HidingRoles = HidingRoles,
    GetCharacterManagerObject = GetCharacterManagerObject,
    SetCharactersActive = SetCharactersActive,
    IsHidingHpBar = IsHidingHpBar,
   -- Notify = Notify,
    GetRoleNearestAttackableTarget = GetRoleNearestAttackableTarget,
    GetRoleAttackableTargets = GetRoleAttackableTargets,
    ChangePetSkin   = ChangePetSkin,
    --NotifySceneLoadStart    = NotifySceneLoadStart,
    NotifySceneLoginLoaded   = NotifySceneLoginLoaded,
    Reset = Reset,
    GetMaxVisiableCount = GetMaxVisiableCount,
    ClearInvalidCharacter = ClearInvalidCharacter,
    ResetCharacterOutDated = ResetCharacterOutDated,
    GetPlayerPets = GetPlayerPets,
    GetAbridgedCharacterCount = GetAbridgedCharacterCount,
    GetRolePet              = GetRolePet,
    -- CreatSimplifiedCharacter = CreatSimplifiedCharacter,

    NeedSimplify = NeedSimplify,
    AlterCharacter = AlterCharacter,
    SkillAttack     = SkillAttack,

    UpdatePlayer    = CharactersEnter.UpdatePlayer,
    CreatePlayer    = CharactersEnter.CreatePlayer,
    UpdatePet       = CharactersEnter.UpdatePet,
    CreatePet       = CharactersEnter.CreatePet,
    AddFamilyCityTower  = AddFamilyCityTower,

    ShowCharactersByCsvId = ShowCharactersByCsvId,
    SetHeadInfoActive       = SetHeadInfoActive,
    GetHeadInfoActivity     = GetHeadInfoActivity,
    ShowAllHpProgress       = ShowAllHpProgress,
}
