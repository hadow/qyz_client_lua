local require                       = require
local EffectInstance                = require "effect.instance.effectinstance"
local defineenum                    = require "defineenum"
local mathutils                     = require "common.mathutils"
local cameramanager                 = require "cameramanager"
local define                        = require "define"
local EffectInstanceAlignType       = defineenum.EffectInstanceAlignType
local ESpecialType                  = defineenum.ESpecialType


local FollowTargetEffectInstance = Class:new(EffectInstance)

function FollowTargetEffectInstance:CheckCanShow()
    if self.ParentEffect:Target() ==nil or 
       IsNull(self.ParentEffect:Target().m_Object) or
       IsNullOrEmpty(self.EffectInstanceData.Path) then 
        return false
    end 
    return true
end

function FollowTargetEffectInstance:GenBornPosition()
    --printyellow("FollowTargetEffectInstance:GenBornPosition()")
    local vecPos = Vector3.zero
    if self.ParentEffect:Target() then
        vecPos =self:GetBindPos(self.ParentEffect:Target(),self.EffectInstanceData.TargetBindType)
    end
    
    return vecPos;
end

function FollowTargetEffectInstance:GetOffset()
    local vecOffset = Vector3.zero
    local dir = nil
    if self.ParentEffect and self.ParentEffect:Target() then
        local bonetrans = self:GetBindTransform(self.ParentEffect:Target(),self.EffectInstanceData.TargetBindType)
        if bonetrans then 
            dir = bonetrans.rotation
        else
            dir = self.ParentEffect:GetTargetDir()
        end
    end

    if dir then 
        vecOffset = dir * self.EffectInstanceData.OffSet
    else 
        vecOffset = self.EffectInstanceData.OffSet
    end
    return vecOffset
end

function FollowTargetEffectInstance:UpdateTransform()
    if self.ParentEffect and self.ParentEffect:Target() then
        self:UpdateRotation() 
        self:SetPosition(self:GetBindPos(self.ParentEffect:Target(),self.EffectInstanceData.TargetBindType) + self:GetOffset())
        --printt(vecPos)
    end
end

function FollowTargetEffectInstance:UpdateRotation()
    if Local.LogModuals.EffectManager then 
        printyellow("FollowTargetEffectInstance:UpdateRotation()",Time.time)
    end
    local bonetrans = self:GetBindTransform(self.ParentEffect:Target(),self.EffectInstanceData.TargetBindType) 
    if self.EffectInstanceData.FollowBoneDirection and bonetrans~=nil then 
        if Local.LogModuals.EffectManager then 
            printyellow("FollowBoneDirection")
        end
        self.Object.transform.rotation = bonetrans.rotation * self.EffectInstanceData.Rot
    elseif self.EffectInstanceData.FollowDirection and self.ParentEffect:GetTargetDir() then
        if Local.LogModuals.EffectManager then 
            printyellow("FollowDirection")
        end
        self.Object.transform.rotation = self.ParentEffect:GetTargetDir() * self.EffectInstanceData.Rot
    else 
        if Local.LogModuals.EffectManager then 
            printyellow("DefaultDirection")
        end
        self.Object.transform.localEulerAngles = self.EffectInstanceData.EulerAngles
    end
end



return FollowTargetEffectInstance
