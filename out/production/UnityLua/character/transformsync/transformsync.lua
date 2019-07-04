local defineenum        = require("defineenum")
local WorkType          = defineenum.WorkType

local TransformSync = Class:new()

function TransformSync:__new(character)
    self.m_Character = character
end

function TransformSync:SyncMoveTo(msg)
    local msgTarget = Vector3(msg.target.x,msg.target.y,msg.target.z)
    local msgPos = Vector3(msg.position.x,msg.position.y,msg.position.z)
--    if not self.m_Character:IsRole() then
--        printyellow(string.format( "[%s] => %s",tostring(Time.time), tostring(msg)))
--    end
--    Game.CharacterTransformSync.Instance:AddMoveMessage(self.m_Character.m_Id, Time.time, msgPos, msgTarget)
  
    local deviation = mathutils.DistanceOfXoZ(self.m_Character:GetRefPos(), msgPos)
    if deviation > 3 then
        self.m_Character:SetPos(msgPos)
    end
    if msg.isplayercontrol == -1 then
        self.m_Character:MoveTo(msgTarget)
    else
        local deviation2 = mathutils.DistanceOfXoZ(self.m_Character:GetRefPos(), msgTarget)
        if deviation2 > 0.5 then
            self.m_Character:MoveTo(msgTarget)
        end
    end
end

function TransformSync:SyncStop(msg)
    local msgPos = Vector3(msg.position.x,msg.position.y,msg.position.z)
    local msgOrient = Vector3(msg.orient.x,0,msg.orient.z)
    -- if not self.m_Character:IsRole() then
    --     printyellow(string.format( "[%s] => %s",tostring(Time.time), tostring(msg)))
    -- end
    -- Game.CharacterTransformSync.Instance:AddStopMessage(self.m_Character.m_Id, Time.time, msgPos, msgOrient)

  	local deviation = mathutils.DistanceOfXoZ(self.m_Character:GetRefPos(), msgPos)

    if deviation > 3 then
        self.m_Character:SetPos(msgPos)
        if msg.isplayercontrol ~= -1 then
            self.m_Character:SetRotation(msgOrient)
        end
    end
    self.m_Character.WorkMgr:StopWork(WorkType.Move)
end

function TransformSync:SyncOrient(msg)
    local msgOrient = Vector3(msg.orient.x,0,msg.orient.z)
  
   -- Game.CharacterTransformSync.Instance:AddOrientMessage(self.m_Character.m_Id, Time.time, msgOrient)
  
    self.m_Character:SetRotation(msgOrient)
end


function TransformSync:LateUpdate()
 --   local vec = self.m_Character.m_Rotation * Vector3(0,0,1)

  --  Game.CharacterTransformSync.Instance:AddPosition(self.m_Character.m_Id, Time.time, self.m_Character:GetPos(), vec)

end


return TransformSync