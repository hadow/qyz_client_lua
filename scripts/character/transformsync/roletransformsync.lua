local PlayerTransformSync = require("character.transformsync.playertransformsync")
local TransformMsgSender = require("character.transformsync.transformmsgsender")


local RoleTransformSync = Class:new(PlayerTransformSync)

function RoleTransformSync:__new(character)
    PlayerTransformSync.__new(self, character)
    self.m_MsgSender = TransformMsgSender:new(self)
end

function RoleTransformSync:SyncMoveTo(msg)
    PlayerTransformSync.SyncMoveTo(self,msg)
    if msg.isplayercontrol ~= -1 then
        if self.m_Character:IsNavigating() then
     --       self.m_Character.m_Navigation:Restart()
        end
    end
end

function RoleTransformSync:LateUpdate()
    PlayerTransformSync.LateUpdate(self)
    self.m_MsgSender:MoveMsgUpdate()
end

function RoleTransformSync:SendMove(targetPos)
    local rolePos = self.m_Character:GetPos()
    if not self.m_Character:IsFlying() then
        self:SyncMoveTo({position = rolePos, target = targetPos, isplayercontrol=-1})
        self.m_MsgSender:TrySendMove(rolePos, targetPos)
    else
        if self.m_Character.m_Mount then
            self.m_Character.m_Mount:move(targetPos)
        end
    end
end

function RoleTransformSync:SendStop()
    local rolePos = self.m_Character:GetPos()
    local roleDir = self.m_Character:GetForward() -- (((self.m_Character.m_Object ~= nil) and self.m_Character.m_Object.transform.forward) or Vector3(0,0,1))
    self:SyncStop({position = rolePos, orient = roleDir, isplayercontrol=-1 })
    self.m_MsgSender:TrySendStop(rolePos, roleDir)
end

return RoleTransformSync