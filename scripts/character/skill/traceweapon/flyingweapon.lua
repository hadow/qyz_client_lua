-- local flyingweapon = require "character.skill.traceweapon.flyingweapon"
local FlyingWeaponManager
local TraceObject = require "character.skill.traceweapon.traceobject"


------------------------------------------------------------------------------
--FlyingWeapon
------------------------------------------------------------------------------
local FlyingWeapon = Class:new(TraceObject)


function FlyingWeapon:__new()
    TraceObject.__new(self)
    
    FlyingWeaponManager = require "character.skill.traceweapon.flyingweaponmanager"
    --[[
    self.m_Object = GameObject(string.format("flyingweapon_%s", FlyingWeaponManager.GetCount()))
    self.m_Object.tag = define.WeaponCollider
    self.m_Object:SetActive(false)
    local sc = LuaHelper.AddComponent(self.m_Object,"UnityEngine.SphereCollider")
    sc.radius = 0.2
    sc.isTrigger = true
    GameObject.DontDestroyOnLoad(self.m_Object)
    --]]
end

function FlyingWeapon:reset()
    TraceObject.reset(self)
    --[[
    if self.m_Object then
        self.m_Object:SetActive(false)
    end
    --]]
end 
    
function FlyingWeapon:Init(attacker,targetId,skill,flyWeaponData)
    TraceObject.InitData(self,attacker,targetId,skill,flyWeaponData)
    --[[
    local spereCollider = LuaHelper.GetComponent(self.m_Object,"UnityEngine.SphereCollider")
    if spereCollider then
        pereCollider.radius = data.bulletradius
    end
    --]]
end 

function FlyingWeapon:GetTraceObjType()
    return self.TraceType.FlyWeapon
end


function FlyingWeapon:CanAttack(character)
    if character == nil then
        return false
    end 
    if self.m_Attacker~=nil and self.m_Attacker.m_Id == character.m_Id then 
        return false
    end 
    for _,beattacker in pairs(self.m_BeAttackerList) do
        if beattacker.m_Id == character.m_Id then
            return false
        end 
    end 
    table.insert(self.m_BeAttackerList,character)
    return true
end

function FlyingWeapon:InitBornTransform(effectobj)
    TraceObject.InitBornTransform(self,effectobj)
    --self.m_Object:SetActive(true)
end 
function FlyingWeapon:Release()
    TraceObject.Release(self)
    --GameObject.Destroy(self.m_Object)
end


function FlyingWeapon:OnAttack()
    --printyellow("OnAttack",self.m_Id,self.m_Data.passbody,Time.time)
    if not self.m_Data.passbody and 
        self.m_CurrentState ~= self.FsmState.None  then 
        self:SetState(TraceObject.FsmState.Dead)
    end 
end




return FlyingWeapon
