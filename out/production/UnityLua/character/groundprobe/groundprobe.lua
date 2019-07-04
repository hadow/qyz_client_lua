local SceneManager = require("scenemanager")
local mathutils    = require("common.mathutils")
local Probe        = require("character.groundprobe.probe")


local GroundProbe = Class:new()

function GroundProbe:__new(player)
    self.m_Player = player
    self.m_Speed = 5
    self.m_LoadingScene = false
    self.m_PlayerEnter = false
    self.m_CheckCount = 0
end

function GroundProbe:OnLoaded(gameObject)
    if self.m_Object then 
        return
    end
    self.m_Object = UnityEngine.GameObject("GroundProbe")
    GameObject.DontDestroyOnLoad(self.m_Object)

    --self.m_Object.transform.parent = self.m_Player.m_Object.transform
    self.m_HeightProbe = Probe:new("HeightProbeObject",self.m_Object)
    self.m_PositionProbe = Probe:new("PositionProbeObject",self.m_Object)
    self.m_HeightProbe:ChangeSpeed(self.m_Speed)
    --printt(self.m_Player.m_Pos)
    local playerPos = Vector3(self.m_Player.m_Pos.x, SceneManager.GetHeight(self.m_Player.m_Pos), self.m_Player.m_Pos.z)
    --printt(playerPos)
    self.m_HeightProbe:SetPos(playerPos)
    self.m_PositionProbe:SetPos(playerPos)

    self.m_Pos = playerPos
end

function GroundProbe:Reset()
    if self.m_HeightProbe and self.m_PositionProbe then
        self.m_HeightProbe:Reset()
        self.m_PositionProbe:Reset()
    end
end

function GroundProbe:SetActive(active)
    self.m_HeightProbe:SetActive(active)
    self.m_PositionProbe:SetActive(active)
end


function GroundProbe:Update()
    if self.m_HeightProbe then
        self.m_HeightProbe:SetPos(self.m_Pos)
    end
end

function GroundProbe:GetHeight()
    return self.m_HeightProbe ~= nil and self.m_HeightProbe:GetHeight() or SceneManager.GetHeight(self.m_Player.m_Pos)
end


function GroundProbe:CanReach(pos)
    self.m_PositionProbe:Reset()
    self.m_PositionProbe:SetPos(pos)
    return self.m_PositionProbe:IsOnNavMesh()
end

function GroundProbe:CanMoveTo(pos)
    local height = SceneManager.GetHeight(pos)
    local probePos = self.m_HeightProbe:GetPos()

    if height >= cfg.map.Scene.HEIGHTMAP_MAX then
        height = probePos.y
    end
    if height <= cfg.map.Scene.HEIGHTMAP_MIN then
        height = probePos.y
    end
    local newPos = Vector3(pos.x, height, pos.z)
    return self.m_HeightProbe:CanMoveToByAgentResult(newPos)
end

function GroundProbe:CanMoveToWithHitPos(pos)
    local height = SceneManager.GetHeight(pos)
    local probePos = self.m_HeightProbe:GetPos()

    if height >= cfg.map.Scene.HEIGHTMAP_MAX then
        height = probePos.y
    end
    if height <= cfg.map.Scene.HEIGHTMAP_MIN then
        height = probePos.y
    end
    local newPos = Vector3(pos.x, height, pos.z)
    return self.m_HeightProbe:CanMoveToByAgent(newPos)
end


function GroundProbe:CanMove()
    if self:IsOnNavMesh() then
        return true
    end
    self.m_HeightProbe:Reset()
    if self:IsOnNavMesh() then
        return true
    end
    return false
end

function GroundProbe:SetPos(pos)
    if self.m_HeightProbe and pos then
        if self:IsOnNavMesh() == false then
            self.m_HeightProbe:Reset()
        end
        --self.m_Pos = Vector3(pos.x, SceneManager.GetHeight(pos), pos.z)
        self.m_Pos = pos
        self.m_HeightProbe:SetPos(self.m_Pos)
        return self.m_Pos
    end
    return pos
end

function GroundProbe:ResetPosition()
    local NetWork = require("network")
    local re = map.msg.CMoveToDefaultPosition({})
    NetWork.send(re)
end

function GroundProbe:PositionCheck()
    --printyellow("self.m_LoadingScene",self.m_LoadingScene, self.m_PlayerEnter)
    if self.m_LoadingScene == false and self.m_PlayerEnter == true then
        --printyellow("self:IsOnNavmesh()", self:IsOnNavmesh())
        if self:IsOnNavMesh() == false then
            self.m_CheckCount = self.m_CheckCount + 1
            if self.m_CheckCount > 10 then
                self.m_HeightProbe:Reset()
            end
            if self.m_CheckCount > 60 then
                self.m_CheckCount = 0
                self:ResetPosition()
            end
        end
    end
end

function GroundProbe:GetPos()
    return self.m_HeightProbe and self.m_HeightProbe:GetPos() or Vector3.zero
end

function GroundProbe:GetNavMeshAgent()
    return self.m_HeightProbe:GetNavMeshAgent()
end

function GroundProbe:ResetTarget(target)
    local hit = UnityEngine.NavMeshHit()
    local currentpos = self:GetPos()
    local result = UnityEngine.NavMesh.Raycast(currentpos, target, hit, UnityEngine.NavMesh.AllAreas)
    --public static bool Raycast(Vector3 sourcePosition, Vector3 targetPosition, out NavMeshHit hit, int areaMask);
    if result == false then
        return target
    else
        return hit.position
    end
end

function GroundProbe:IsOnNavMesh()
    local agent = self:GetNavMeshAgent()
    return agent.isOnNavMesh
end

function GroundProbe:ResetToDefaultPosition()
    if self.m_Player.m_MapInfo then
        local targetPos = self.m_Player.m_MapInfo:GetStartPoint()
        if targetPos then
            self:SetPos(targetPos)
            if self.m_Player.m_Object then
                self.m_Player.m_Object.transform.position = targetPos
            end
        end
    end
    
end

function GroundProbe:IsOnHeightMap(pos)
    local height = SceneManager.GetHeight(pos)
    if height >= cfg.map.Scene.HEIGHTMAP_MAX or height <= cfg.map.Scene.HEIGHTMAP_MIN then
        return false
    else
        return true
    end
end

function GroundProbe:OnSceneLoaded()
    if self.m_Player and self.m_Object then
        local pos = self:GetPos()
        local dir = pos - self.m_Player.m_Pos
        if dir.magnitude > 10 then
            local height = SceneManager.GetHeight(self.m_Player.m_Pos)
            local targetPos = Vector3(self.m_Player.m_Pos.x, height, self.m_Player.m_Pos.z)
            if height >= cfg.map.Scene.HEIGHTMAP_MAX or height <= cfg.map.Scene.HEIGHTMAP_MIN then
                if self.m_Player.m_MapInfo then
                    targetPos = self.m_Player.m_MapInfo:GetStartPoint()
                end
            end
            if targetPos then
                self:SetPos(targetPos)
            end
        end
    end
    
    self:Reset()
    self.m_LoadingScene = false
end

function GroundProbe:sync_Enter()
    self.m_LoadingScene = true
    self.m_PlayerEnter = false
    --printyellow("self.m_LoadingScene sync_Enter",self.m_LoadingScene)
end

function GroundProbe:ChangeSpeed(speed)
    if self.m_HeightProbe then
        self.m_HeightProbe:ChangeSpeed(speed)
        self.m_Speed = speed
    else
        self.m_Speed = speed
    end
end

function GroundProbe:sync_SNearbyPlayerEnter()
    --printyellow("GroundProbe:sync_SNearbyPlayerEnter")
    self.m_PlayerEnter = true
    --printyellow("self.m_LoadingScene sync_Enter",self.m_LoadingScene)
end


return GroundProbe
