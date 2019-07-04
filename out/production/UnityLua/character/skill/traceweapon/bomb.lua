-- local bomb = require "character.skill.traceweapon.bomb"
local BombManager
local TraceObject = require "character.skill.traceweapon.traceobject"


------------------------------------------------------------------------------
--Bomb
------------------------------------------------------------------------------
local Bomb = Class:new(TraceObject)


function Bomb:__new()
    TraceObject.__new(self)
    BombManager = require "character.skill.traceweapon.bombmanager"
end

function Bomb:reset()
    TraceObject.reset(self)
end 
    
function Bomb:Init(attacker,targetId,skill,bombData)
    TraceObject.InitData(self,attacker,targetId,skill,bombData)
end 

function Bomb:GetTraceObjType()
    return self.TraceType.Bomb
end

function Bomb:InitBornTransform(effectobj)
    TraceObject.InitBornTransform(self,effectobj)
    --self.m_Object:SetActive(true)
end 
function Bomb:Release()
    TraceObject.Release(self)
    --GameObject.Destroy(self.m_Object)
end

return Bomb
