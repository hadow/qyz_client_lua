local TransformSync = require("character.transformsync.transformsync")
local defineenum        = require("defineenum")
local WorkType          = defineenum.WorkType

local CharacterTransformSync = Class:new(TransformSync)


function CharacterTransformSync:SyncMoveTo(msg)
    --TransformSync.SyncMoveTo(self, msg)
    local msgTarget = Vector3(msg.target.x,msg.target.y,msg.target.z)
    local msgPos = Vector3(msg.position.x,msg.position.y,msg.position.z)
--    if not self.m_Character:IsRole() then
--        printyellow(string.format( "[%s] => %s",tostring(Time.time), tostring(msg)))
--    end
--    Game.CharacterTransformSync.Instance:AddMoveMessage(self.m_Character.m_Id, Time.time, msgPos, msgTarget)
    local rolePos = self.m_Character:GetPos()
    local positionDeviation = mathutils.DistanceOfXoZ(rolePos, msgPos)
    local targetDeviation = mathutils.DistanceOfXoZ(rolePos, msgTarget)

    if positionDeviation > 3 then
        if targetDeviation > 3 then
            self.m_Character:SetPos(msgPos)
        end
    end
    if msg.isplayercontrol == -1 then
        self.m_Character:MoveTo(msgTarget)
    else
        if targetDeviation > 0.5 then
            self.m_Character:MoveTo(msgTarget)
        end
    end
end

function CharacterTransformSync:SyncStop(msg)
    local msgPos = Vector3(msg.position.x,msg.position.y,msg.position.z)
    local msgOrient = Vector3(msg.orient.x,0,msg.orient.z)
    local rolePos = self.m_Character:GetPos()
  	local deviation = mathutils.DistanceOfXoZ(rolePos, msgPos)
    
    
    -- if not self.m_Character:IsRole() then
    --     printyellow(string.format( "[%s] => %s",tostring(Time.time), tostring(msg)))
    -- end
    -- Game.CharacterTransformSync.Instance:AddStopMessage(self.m_Character.m_Id, Time.time, msgPos, msgOrient)
    if deviation > 3 then
        self.m_Character:SetPos(msgPos)
        self.m_Character:SetRotation(msgOrient)
    elseif deviation > 0.5 then
        if self.m_Character and self.m_Character.m_Object and msg.isplayercontrol ~= -1 then
            local curDir = self.m_Character.m_Object.transform.forward
            local movDir = msgPos - rolePos
            local angle = math.abs(mathutils.AngleOfXoZ(curDir, movDir))
            if deviation < 1 then
                if angle < 70 then
                    self.m_Character:MoveTo(msgPos)
                end
            else
                if angle < 45 then
                    self.m_Character:MoveTo(msgPos)
                end
            end
        end
    
    end
    self.m_Character.WorkMgr:StopWork(WorkType.Move)
end



return CharacterTransformSync