local BaseCurve=require"character.curve.basecurve"

local LineCurve=Class:new(BaseCurve)

local HeightData=4
local MaxFlyTime=2

function LineCurve:__new()
    self.m_MiddlePos= Vector3.zero
    self.m_Coeff=0.5
    self.m_MaxTimeUse = 2
    self.m_UseParabolaOfY = false
    self.m_UseParabolaOfX = false
    self.m_UseParabolaOfZ = false
end


function LineCurve:UseTime()
    return self.m_MaxTimeUse
end

function LineCurve:init(params)
    self.m_StartPos = params.startPos
    self.m_EndPos = params.endPos
    --self.m_MiddlePos = (1 - self.m_Coeff) * params.startPos + self.m_Coeff * params.startPos
    self.m_MiddlePos=Vector3(params.startPos.x,params.startPos.y,params.startPos.z)
    
    if self.m_StartPos.y > self.m_EndPos.y then       
        self.m_MiddlePos.y = self.m_StartPos.y 
    else
        self.m_MiddlePos.y=self.m_EndPos.y
    end
    self.m_MiddlePos.y = self.m_MiddlePos.y + HeightData
    self.m_Distance = self:Distance()
end

function  LineCurve:SetUseTime(useTime)
    self.m_MaxTimeUse = useTime
end

function LineCurve:SetMiddlePosY(middlePosY)
    self.m_MiddlePos.y = middlePosY
end

function LineCurve:SetMiddlePosX(middlePosX)
    self.m_MiddlePos.x = middlePosX
end

function LineCurve:Bezier(currentTime)
    local result = Vector3.zero
    local t = (self.m_Rate * currentTime) / self.m_MaxTimeUse
    if (t <= 1) and (currentTime<MaxFlyTime) then
        if true == self.m_UseParabolaOfY then
            result.y = self:Parabola(self.m_StartPos.y, self.m_EndPos.y, self.m_MiddlePos.y, t)
        else
            result.y =self:Line(self.m_StartPos.y,self.m_EndPos.y,t)
        end
        if true == self.m_UseParabolaOfX then
            result.x = self:Parabola(self.m_StartPos.x, self.m_EndPos.x, self.m_MiddlePos.x, t) 
        else
            result.x = self:Line(self.m_StartPos.x, self.m_EndPos.x, t)
        end
        if true == self.m_UseParabolaOfZ then
            result.z = self:Parabola(self.m_StartPos.z, self.m_EndPos.z, self.m_MiddlePos.z, t)            
        else
            result.z = self:Line(self.m_StartPos.z, self.m_EndPos.z, t)
        end
    else
        result = self.m_EndPos
        self.m_Finished = true
    end
    return result
end

function LineCurve:SetMiddlePos(v)
    self.m_MiddlePos = v
end

function LineCurve:SetPos(startPos, endPos,middlePos)
    self.m_StartPos = startPos
    self.m_EndPos = endPos
    self.m_MiddlePos = middlePos
end

function LineCurve:SetParabolaAxis( useParabolaOfY, useParabolaOfX)
    self.m_UseParabolaOfX = useParabolaOfX
    self.m_UseParabolaOfY = useParabolaOfY
end

function LineCurve:GetPos(currentTime)
    return self:Bezier(currentTime) 
end

return LineCurve