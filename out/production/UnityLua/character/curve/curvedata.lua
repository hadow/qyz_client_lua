local PlayerRole=require("character.playerrole"):Instance()
local DefineEnum=require"defineenum"
local CurveType=DefineEnum.TraceType
local CublicBezierCurve=require"character.curve.cublicbeziercurve"
local LineCurve=require"character.curve.linecurve"

local CurveData=Class:new()

local TotalTime=8*1000

function CurveData:__new()
    self.m_Time=0
    self.m_CallBack=nil
    self.m_Curve=nil
    self.m_Line=nil
    self.m_CurveType=CurveType.Elastic
    self.m_Rate=0.1
    self.m_AddRate=0.05
    self.m_MaxRate=2
end

local function LocalRandom()
    return math.random(8,12)/10
end

function CurveData:AddRate()
    self.m_Rate=self.m_Rate+self.m_AddRate
    if self.m_Rate>=self.m_MaxRate then
        self.m_Rate=self.m_MaxRate
    end
    return self.m_Rate
end

function CurveData:TargetPos()
    if self.m_TargetPos~=nil then
        return self.m_TargetPos            
    end
    return PlayerRole:GetRefPos()+self.m_RoleHeightV
end

function CurveData:DoAfterPlayEffectFinished()
    if nil ~= self.m_CallBack then
        self.m_CallBack()
    end
end
        
function CurveData:UpdateElastic(dwDeltaTime)
    if self.m_Curve.m_UseTime<(self.m_Time + 0.1) then
        local coe= (self.m_Curve.m_UseTime - self.m_Time)/0.1
        if (coe <0.05) then
            coe = 1
        end
        dwDeltaTime = dwDeltaTime * coe
    else
        self.m_Curve:SetRate(self:AddRate())
    end
    self.m_Pos = self.m_Curve:GetPos(self.m_Time)          
    self.m_Time =self.m_Time + dwDeltaTime
    self.m_Object.transform.position = self.m_Pos
    self.m_Curve:SetEndPos(self:TargetPos())
    if ((self.m_Curve.m_Finished) and (self.m_FlyFinished ~= 2)) then
        self.m_FlyFinished = 2
        self:DoAfterPlayEffectFinished()
    end
end

function CurveData:UpdateDirect(dwDeltaTime)
    self.m_Line:SetRate(self:AddRate())
    self.m_Pos = self.m_Line:GetPos(self.m_Time)
    self.m_Time =self.m_Time +dwDeltaTime
    if self.m_Object then
        if self.m_CurveType==CurveType.Line then
            self.m_Object.transform.position = self.m_Pos
        elseif self.m_CurveType==CurveType.Line2D then
            self.m_Object.transform.localPosition = self.m_Pos
        end
    end
    self.m_Line:SetEndPos(self:TargetPos())
    if (self.m_Line.m_Finished and self.m_FlyFinished ~= 2) then
        self.m_FlyFinished = 2
        self:DoAfterPlayEffectFinished()
    end
end

function CurveData:update(dwDeltaTime)
    if self.m_CurveType==CurveType.Bezier then
        self:UpdateElastic(dwDeltaTime)
    elseif self.m_CurveType==CurveType.Line then
        self:UpdateDirect(dwDeltaTime)
    elseif self.m_CurveType==CurveType.Line2D then
        self:UpdateDirect(dwDeltaTime)
    end
end

function CurveData:init(params)
    self.m_CurveType=params.curveType
    self.m_CallBack=params.callBack
    self.m_Object=params.object
    self.m_TargetPos=params.targetPos
    self.m_RoleHeightV=Vector3(0,PlayerRole.m_Height/2,0)
    local objPos=params.object.transform.position
    if self.m_CurveType==CurveType.Bezier then
        self.m_Pos=objPos
        self.referPos=self.m_Pos
        local deg=2*(math.pi)*LocalRandom()
        local radius=params.itemHeight*5*LocalRandom()
        local dir
        if PlayerRole:GetRefPos().x>self.m_Pos.x then
            dir=-1
        else
            dir=1
        end
        self.referPos.y=self.referPos.y+PlayerRole.m_Height/2+LocalRandom()*params.itemHeight
        self.referPos.x=self.referPos.x+radius*dir
        self.referPos.z=PlayerRole:GetRefPos().z  
        self.dwTicketLeft=TotalTime
        self.dwTicketState=TotalTime-1000
        self.m_FlyFinished=1       
        local controlVecs={}
        local x=math.random(self:TargetPos().x,self.m_Pos.x)
        local third=Vector3(x,self.referPos.y,self:TargetPos().z)
        table.insert(controlVecs,objPos)
        table.insert(controlVecs,self.referPos)
        table.insert(controlVecs,third)
        table.insert(controlVecs,self:TargetPos())
        local cublicCurve
        cublicCurve = CublicBezierCurve:new()
        cublicCurve:init({controlVec=controlVecs, rate=1})
        self.m_Curve=cublicCurve
        self.m_Curve.m_UseTime=params.useTime    
    elseif self.m_CurveType==CurveType.Line then
        local lineCurve=LineCurve:new()
        local targetPos=self:TargetPos()
        lineCurve:init({startPos=Vector3(objPos.x,objPos.y,objPos.z),endPos=Vector3(targetPos.x,targetPos.y,targetPos.z)})
        self.m_Line = lineCurve
        local middlePos = objPos * 0.2 + self:TargetPos() * 0.8
        local bDir
        if math.random(0, 100) > 50 then
            bDir = true 
        else
            bDir =false
        end
        local offset = math.random(200, 1000) / 500
        if (bDir) then
            middlePos.y = middlePos.y+offset
        else
            middlePos.y = middlePos.y-offset
        end
        self.m_Line:SetUseTime(self.m_Line:Distance() / 6)
        self.m_Line:SetParabolaAxis(true, true)
        self.m_Line:SetMiddlePos(middlePos)
        self.m_MaxRate = 5
        self.m_AddRate = 0.1
    elseif self.m_CurveType==CurveType.Line2D then
        local lineCurve=LineCurve:new()
        local targetPos=self:TargetPos()
        lineCurve:init({startPos=Vector3(objPos.x,objPos.y,objPos.z),endPos=Vector3(targetPos.x,targetPos.y,targetPos.z)})
        self.m_Line = lineCurve
        local middlePos = objPos * 0.2 + self:TargetPos() * 0.8
        local bDir
        if math.random(0, 100) > 50 then
            bDir = true 
        else
            bDir =false
        end
        local offset = math.random(200, 1000) / 5
        if (bDir) then
            middlePos.y = middlePos.y+offset
        else
            middlePos.y = middlePos.y-offset
        end
        self.m_Line:SetUseTime(self.m_Line:Distance() / 250)
        self.m_Line:SetParabolaAxis(true, true)
        self.m_Line:SetMiddlePos(middlePos)
        self.m_MaxRate = 5
        self.m_AddRate = 0.2
    end
end

function CurveData:LoadFinished()
    return true
end

function CurveData:FlyFinished()
    return self.m_FlyFinished==2
end

function CurveData:Destory()
--    if self.m_Object then
--        GameObject.Destroy(self.m_Object)
--    end
end

return CurveData