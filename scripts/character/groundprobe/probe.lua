local SceneManager = require("scenemanager")
local mathutils    = require("common.mathutils")

local Probe = Class:new()

function Probe:__new(name,parentObject,params)
    self.m_Object = UnityEngine.GameObject(name)
    self.m_Object.transform.parent = parentObject.transform
    self.m_Transform = self.m_Object.transform
    --self.m_NavMeshAgent = LuaHelper.AddComponent(self.m_Object,"UnityEngine.AI.NavMeshAgent")
    --self.m_NavMeshAgent.radius = 0
    --self.m_NavMeshAgent.speed = 6

end

function Probe:GetPos()
    return self.m_Object.transform.position
end

function Probe:GetHeight()
    return self.m_Object.transform.position.y
end

function Probe:IsOnNavMesh()

    if self.m_NavMeshAgent == nil then
        return false
    end
    return self.m_NavMeshAgent.isOnNavMesh
end

function Probe:CanMoveToByAgent(pos)
    if self:IsOnNavMesh() == false then
        self:Reset()
        return false, pos
    end
    local navHit = LuaHelper.NavMeshAgentRaycast(self.m_NavMeshAgent,pos)
    if navHit.distance >= 0 then
        --printyellow(navHit.position)
        return false, navHit.position
    end
    return true, pos
end

function Probe:CanMoveToByAgentResult(pos)
    if self:IsOnNavMesh() == false then
        self:Reset()
        return false, pos
    end
    local re = LuaHelper.NavMeshAgentRaycastResult(self.m_NavMeshAgent,pos)
    return not re
end

function Probe:CanMoveToByNavMesh(pos)
    local newPos = Vector3(pos.x, SceneManager.GetHeight(pos), pos.z)
    local navHit = LuaHelper.NavMeshRaycast(self.m_Object.transform.position, pos)
    if navHit.distance >= 0 then
        -- printyellow(navHit.position)
        return false, navHit.position
    end
    return true, pos
end

function Probe:CanMoveToByNavMeshResult(pos)
    local newPos = Vector3(pos.x, SceneManager.GetHeight(pos), pos.z)
    local re = LuaHelper.NavMeshRaycastResult(self.m_Object.transform.position, pos)
    return not re
end

function Probe:SetActive(active)
    self.m_Object:SetActive(active)
end

function Probe:Reset()
    if not self:IsOnNavMesh() then
        self.m_Object:SetActive(false)
        self.m_Object:SetActive(true)
    end
end


function Probe:DestroyNavMeshAgent()
    if self.m_NavMeshAgent ~= nil then

        GameObject.DestroyObject(self.m_NavMeshAgent);
        self.m_NavMeshAgent = nil
    end

end

function Probe:SetPos(pos)
    -- if self.m_Object == nil then
    --     return nil
    -- end
    if self.m_NavMeshAgent == nil then
        pos = LuaHelper.NavMeshSamplePositionResult(pos)
        self.m_Object.transform.position = pos
        self.m_NavMeshAgent = LuaHelper.AddComponent(self.m_Object,"UnityEngine.AI.NavMeshAgent")
        --self.m_NavMeshAgent.radius = 0
    end
    if mathutils.DistanceOfXoZ(self.m_Transform.position, pos) < 5 then
        self.m_Object.transform.position = pos
        if self:IsOnNavMesh() == false and self.m_NavMeshAgent ~= nil then
            pos = LuaHelper.NavMeshSamplePositionResult(pos)
            --self.m_NavMeshAgent.enabled = false
            --self.m_NavMeshAgent.enabled = true
            self.m_Object.transform.position = pos
            self:Reset()
        end
        return pos
    else
        if self:IsOnNavMesh() == false and self.m_NavMeshAgent ~= nil then
            pos = LuaHelper.NavMeshSamplePositionResult(pos)
            self.m_NavMeshAgent.enabled = false
            self.m_NavMeshAgent.enabled = true
            self.m_Object.transform.position = pos
        end
        if self.m_NavMeshAgent ~= nil then
            self.m_NavMeshAgent:Warp(pos)
        end

        self.m_Object.transform.position = pos
        return pos
    end
end

function Probe:GetNavMeshAgent()
    return self.m_NavMeshAgent
end

function Probe:ChangeSpeed(speed)
    if self.m_NavMeshAgent ~= nil then
        self.m_NavMeshAgent.speed = speed
    end

end

return Probe
