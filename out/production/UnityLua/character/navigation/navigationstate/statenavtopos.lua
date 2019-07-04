
local StateBase         = require("character.navigation.navigationstate.statebase")
local NavigationHelper  = require("character.navigation.navigationhelper.navigationhelper")
local SceneManager      = require("scenemanager")
local Network           = require("network")

local StateNavToPos = Class:new(StateBase)

function StateNavToPos:__new(controller, targetPos, newStopLength, isAdjustByRideState, lengthCallback, localMode)
    StateBase.__new(self,controller,"StateNavToPos")
    self.m_TargetPos = targetPos
    self.m_Path = {}
    self.m_Length = 0
    --self.m_StopLength = newStopLength or NavigationHelper.Config.DefaultStopLength
    self.m_NodeStopLength = NavigationHelper.Config.DefaultStopLength
    self.m_EndStopLength = newStopLength or NavigationHelper.Config.DefaultStopLength
    self.m_IsAdjustByRideState = isAdjustByRideState
    self.m_LengthCallback = lengthCallback or nil
    self.m_LocalMode = localMode

    self.m_CalculatedPath = false
    self.m_ListenerId = nil
    self.m_ReceiveCountDown = -1

    self.m_MoveMsg = {}
    self.m_LastSendTime = 0
    --printyellow("=============",self.m_LengthCallback)
end

function StateNavToPos:CalculatePathByNavMesh()
    --printyellowmodule( Local.LogModuals.Navigate,"CalculatePathByNavMesh")
    local path = UnityEngine.NavMeshPath()
    local result = UnityEngine.NavMesh.CalculatePath(self.m_Player:GetPos(),self.m_TargetPos,UnityEngine.NavMesh.AllAreas,path )
    return path, result
end

function StateNavToPos:CalculatePathByAgent()
    --printyellowmodule( Local.LogModuals.Navigate,"CalculatePathByAgent")
    local navmeshagent = self.m_Player:GetNavMeshAgent()
    if navmeshagent == nil or navmeshagent.isOnNavMesh == false then
        return nil, false
    end

    local path = UnityEngine.NavMeshPath()
    local result = navmeshagent:CalculatePath(self.m_TargetPos, path)
    return path, result
end

function StateNavToPos:CalculatePathLocal()
    local y = SceneManager.GetHeight(self.m_TargetPos)

    if y > NavigationHelper.Config.MaxHeight or y < NavigationHelper.Config.MinHeight then
        NavigationHelper.LogError("导航目标点不可达（目标地点没有高度图） => Y:" .. tostring(Vector3(self.m_TargetPos.x, y, self.m_TargetPos.z)))
        return nil, nil
    end

    self.m_TargetPos =  Vector3(self.m_TargetPos.x,y,self.m_TargetPos.z)

    local path, result
    if self.m_Player:IsRole() then
        path, result = self:CalculatePathByAgent()
        if result == false then
            path, result = self:CalculatePathByNavMesh()
        end
    else
        path, result = self:CalculatePathByNavMesh()
    end
   -- local path = UnityEngine.NavMeshPath()

   -- local result = UnityEngine.NavMesh.CalculatePath(self.m_Player:GetPos(),self.m_TargetPos,UnityEngine.NavMesh.AllAreas,path )

    if result == false then
        NavigationHelper.LogError("导航计算失败，请检查导航图是否存在 或者 人物是否位于导航图上")
        return nil, nil
    end
    local allWayPoints = {}

    allWayPoints[0] = self.m_Player:GetPos()

    for i = 1, path.corners.Length do
        allWayPoints[i] = path.corners[i]
    end

    local length = 0
    for i = 1, path.corners.Length do
        local mDir = allWayPoints[i] - allWayPoints[i-1]
        mDir.y = 0
        length = length + mDir.magnitude
    end

    return allWayPoints, length

end


function StateNavToPos:CalculatePathServer()
    local re = map.msg.CFindPath({src = self.m_Player:GetPos(), dst = self.m_TargetPos })
    Network.send(re)
end

function StateNavToPos:OnMsgCalculatePathServer(msg)
    local allWayPoints = {}
    allWayPoints[0] = self.m_Player:GetPos()
    for i, vec in ipairs(msg.path) do
        allWayPoints[i] = Vector3(vec.x, vec.y, vec.z)
    end

    local length = 0

    for i = 1, #msg.path-1 do
        local mDir = allWayPoints[i+1] - allWayPoints[i]
        mDir.y = 0
        length = length + mDir.magnitude
    end

    return allWayPoints, length
end

function StateNavToPos:GetPathInfo(isLocalMode)
    if isLocalMode == true then
        self.m_Path, self.m_Length = self:CalculatePathLocal()
        self.m_CalculatedPath = true
        if self.m_Path == nil or self.m_Length == nil then
            self:End()
            self.m_Controller:StopNavigate()
            return
        end
    else
        self:CalculatePathServer()
    end
end


function StateNavToPos:Start()
  --  printyellow("Nav To Pos Start")
    StateBase.Start(self)
    self.m_ListenerId = Network.add_listeners( {
		{   "map.msg.SFindPath",
            function(msg)
                self.m_Path, self.m_Length = self:OnMsgCalculatePathServer(msg)
                self.m_CalculatedPath = true
                if self.m_Path == nil or self.m_Length == nil then
                    self:End()
                    self.m_Controller:StopNavigate()
                    return
                end
            end},
	} )
    self.m_CalculatedPath = false
    self.m_ReceiveCountDown = -1
    self:GetPathInfo(self.m_LocalMode)

end
--检测停止距离
function StateNavToPos:CheckStopLength(currentLength)

    if not self.m_Player:IsRiding() then
        if currentLength <= self.m_EndStopLength then
            self:End()
            return true
        end
    else
        local mountStopLength = self.m_EndStopLength + self.m_Player.m_Mount:GetNavStopLength()
        local rideStopLength = (((self.m_IsAdjustByRideState == true) and mountStopLength) or self.m_EndStopLength)
        --printyellow("aaaa++++++>",currentLength, rideStopLength)
        if currentLength <= rideStopLength then
            self:End()
            return true
        end
    end
    return false
end
--检测一定距离回调
function StateNavToPos:CheckLengthCallback(currentLength)
    if self.m_LengthCallback then
        for i, tb in pairs(self.m_LengthCallback) do
            if tb.callback then
                if currentLength < tb.length then
                    local re = tb.callback()
                    tb.callback = nil
                    return re
                end
            end
        end
    end
end

function StateNavToPos:MsgUpdate()
    if #self.m_MoveMsg > 0 then
        local deltaTime = Time.time - self.m_LastSendTime
        if deltaTime > 0.2 then
            self.m_LastSendTime = Time.time
            self.m_Player.m_TransformSync:SendMove(self.m_MoveMsg[#self.m_MoveMsg])
            self.m_MoveMsg = {}
        end
    end
end

function StateNavToPos:Update()
    StateBase.Update(self)
    if self.m_ReceiveCountDown >= 0 then
        self.m_ReceiveCountDown = self.m_ReceiveCountDown - Time.unscaleDeltaTime
        if self.m_ReceiveCountDown < 0 then
            if self.m_CalculatedPath == false then
                self:GetPathInfo(true)
            end
        end
    end

    if self.m_CalculatedPath == false then
        return
    end

    local currentLength = mathutils.DistanceOfXoZ(self.m_Player:GetRefPos(), self.m_TargetPos)
    --检测停止距离
    if self:CheckStopLength(currentLength) == true then
        return
    end
    --检测一定距离回调
    if self:CheckLengthCallback(currentLength) == true then
        return
    end
    --======================================================================================================
    if #self.m_Path == 0 then
        if mathutils.DistanceOfXoZ(self.m_Player:GetRefPos(), self.m_TargetPos) > self.m_EndStopLength then
            NavigationHelper.LogError("无法到达终点位置: " .. tostring(self.m_TargetPos))
            self.m_Controller:StopNavigate()
            return
        end
    end
    if mathutils.DistanceOfXoZ(self.m_Player:GetRefPos(), self.m_Path[1]) <= self.m_NodeStopLength then
        table.remove(self.m_Path, 1)
        if #self.m_Path >= 1 then
            self.m_Player.m_TransformSync:SendMove(self.m_Path[1])
            --table.insert( self.m_MoveMsg, self.m_Path[1])
        end
    else
        if (self.m_Player:IsIdle() and not self.m_Player:IsMoving()) or (self.m_Player:IsRiding() and not self.m_Player:IsMoving()) then
            self.m_Player.m_TransformSync:SendMove(self.m_Path[1])
            --table.insert( self.m_MoveMsg, self.m_Path[1])
        end
    end

    --self:MsgUpdate()
end

function StateNavToPos:End()
    StateBase.End(self)
    if self.m_ListenerId ~= nil then
        Network.remove_listeners(self.m_ListenerId)
    end
end

return StateNavToPos
