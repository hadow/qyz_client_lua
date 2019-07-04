-- local flytext = require "flytext"
local ObjectPool = require "common.objectpool"

local FlyTextType = enum{
    "Damage",
    "CritWhite",
    "Blue1",
    "Blue2",
    "Green1",
    "Green2",
    "Golden",
    "Block",
    "Dodge",
    "Red",
    "SystemInfo",
    "ItemInfo",
    "Purple1",
    "Purple2",
}


---==========================================================================================
-- FlyTextEntity
----==========================================================================================

local FlyTextEntity = Class:new()

function FlyTextEntity:__new()
    self.PosStart = Vector3.zero
    self.TimeStart = 0
    self.DirectionRandom = Vector2.zero
end

function FlyTextEntity:BindUIListItem(flyTextItem)
    self.FlyTextItem = flyTextItem
    if flyTextItem then
        self.Label = flyTextItem.Controls["UILabel_FlyText"]
        self.TransformItem = self.Label.gameObject.transform.parent
    end
end

function FlyTextEntity:Init(strText,target,data,ampFactor)
    if self.Label and strText then
        self.Label.text = strText
    end
    self.Target = target
    if self.FlyTextItem then
        self.FlyTextItem.Data = data
        --self.Animation = LuaHelper.GetComponent(self.FlyTextItem.gameObject,"Animation")
    end
    if ampFactor then
        self.ampFactor = ampFactor
    else
        self.ampFactor = 1
    end
    self.currentFactor = 1
    self.HasAmplification = false
    self.m_ElapsedTime = 0
    self.targetPos = nil
end

function FlyTextEntity:SetSourceScale(scale)
    self.sourceScale = scale
end

function FlyTextEntity:GetActive()
    return self.Label and self.Lable.active
end

function FlyTextEntity:Active()
    self.Label.gameObject.transform.parent.localScale = Vector3.one
end

function FlyTextEntity:Remove()
    self.Label.gameObject.transform.parent.localScale = Vector3.zero
end

function FlyTextEntity:SetActive(value)
    if self.Label then
        NGUITools.SetActive(self.Label.gameObject, value)
    end
end

function FlyTextEntity:GetAlpha()
    if self.Label then
        return self.Lable.Alpha
    end
    return 0
end

function FlyTextEntity:SetAlpha(value)
    if self.Label then
        self.Label.alpha = value
    end
end

function FlyTextEntity:Release()
    --printyellow("Release()")
    if self.FlyTextItem then
        self.FlyTextItem.Parent:DelListItem(self.FlyTextItem)
    end
end

function FlyTextEntity:PlayTextAnimation()
    local anim = self.FlyTextItem.gameObject:GetComponent("Animation")
    if anim then
    --    printyellow("FlyTextEntity:PlayTextAnimation()")
        anim:Stop()
        anim:Play()
    end
end

function FlyTextEntity:update()
    -- if IsNull(UICamera.currentCamera) then return end
    if self.Target and self.Target.m_Object then
        local targetPos = self.Target:GetPos()
        targetPos.y = targetPos.y + self.Target.m_Height*1.25
        self.targetPos = targetPos
        -- local srcPos = mainCamera:WorldToScreenPoint(targetPos)--+
            -- Camera.main.transform.right*self.OffsetX*cfg.fight.FlytextOffset.HORIZONTAL/1000+
            -- Camera.main.transform.up*self.OffsetY*cfg.fight.FlytextOffset.VERTICAL/1000)
        -- local uiPos = UICamera.currentCamera:ScreenToWorldPoint(srcPos)
        local uiPos = LuaHelper.WorldToUI(targetPos)
        uiPos.z = 500
        self.TransformItem.position = uiPos
        -- local dist = targetPos - Camera.main.transform.position
        -- local cameraDist = dist.magnitude
        -- if cameraDist>30 and  Vector3.Angle(dist,Camera.main.transform.forward)>90 then --do nothing
        -- else
        --     local rate = cameraDist/30
        --     local scaleValue =1- rate^2
        --     self.Label.gameObject.transform.parent.localScale = Vector3.one*scaleValue
        -- end
    elseif self.targetPos then
        local targetPos = self.targetPos
        local uiPos = LuaHelper.WorldToUI(targetPos)
        uiPos.z = 500
        self.TransformItem.position = uiPos
        -- local dist = targetPos - Camera.main.transform.position
        -- local cameraDist = dist.magnitude
        -- if cameraDist>30 and  Vector3.Angle(dist,Camera.main.transform.forward)>90 then --do nothing
        -- else
        --     local rate = cameraDist/30
        --     local scaleValue =1- rate^2
        --     self.Label.gameObject.transform.parent.localScale = Vector3.one*scaleValue
        -- end
    end
end


---==========================================================================================
-- FlyTextManagerBase
----=========================================================================================
local FlyTextManagerBase = Class:new()

function FlyTextManagerBase:__new(uiList,isFixed)
    self.UIList = uiList
    self.m_bIsFixed = isFixed
    self.FlyTextList = {}
    self:Init()
end

function FlyTextManagerBase:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,50)
    self.TotalTime = 1 --飘字存活时间
end


function FlyTextManagerBase:Add(strText,target,data,ampFactor)
    if target and Vector3.Distance(target:GetRefPos()+Vector3(0,target.m_Height*1.25,0),cameraTransform.position) > 30 then return end
    local entity = self.FlyTextPool:GetObject()
    if entity.FlyTextItem == nil then
        --printyellow("self.UIList",self.UIList:GetClassType())
        local listItem =self.UIList:AddListItem()
        entity:BindUIListItem(listItem)
    end
    -- if self.m_bIsFixed then
    --     entity:SetActive(true)
    -- end
    entity:Active()
    entity.targetPos = nil
    entity.TimeStart = Time.time
    entity.OffsetX = math.random()*2-1
    entity.OffsetY = math.random()
    self:InitFlyText(entity,strText,target,data,ampFactor)
    table.insert(self.FlyTextList,entity)
end

function FlyTextManagerBase:InitFlyText(entity,strText,target,data,ampFactor)
    entity:Init(strText,target,data,ampFactor)
    if target then
        local posNew = cloneVector3(target:GetRefPos())
        posNew.y = posNew.y + target.m_Height*1.25
        self.PosStart = LuaHelper.WorldToUI(posNew)
        self.PosStart.z = 500
        -- local transText =
        entity.Label.gameObject.transform.parent.position = self.PosStart
        -- local dist = posNew - Camera.main.transform.position
        -- local cameraDist = dist.magnitude
        -- if cameraDist>30 or Vector3.Angle(dist,Camera.main.transform.position)>90 then
        --     --do nothing
        -- else
        --     local rate = cameraDist/30
        --     local scaleValue =1- rate^2
        --     transText.localScale = Vector3.one*scaleValue
        --     entity:SetSourceScale(transText.localScale)
        --     self.sourceScale = transText.localScale
        -- end
    end
    entity:PlayTextAnimation()
end

function FlyTextManagerBase:RemoveAll()
    for i = #self.FlyTextList ,1,-1 do
        local entity = self.FlyTextList[i]
        table.remove(self.FlyTextList,i)
        -- if self.m_bIsFixed then
        --     entity:SetActive(false)
        -- else
        --     entity:Remove()
        -- end
        entity:Remove()

        if not self.FlyTextPool:PushObject(entity) then
            entity:Release()
        end
    end
end



function FlyTextManagerBase:Update()
    for i = #self.FlyTextList ,1,-1 do
        local entity = self.FlyTextList[i]
        if Time.time - entity.TimeStart > self.TotalTime then
            table.remove(self.FlyTextList,i)
            -- if self.m_bIsFixed then
            --     entity:SetActive(false)
            -- else
            --     entity:Remove()
            -- end
            entity:Remove()
            if not self.FlyTextPool:PushObject(entity) then
                entity:Release()
            end
        else
            entity:update()
        end
    end
end


---==========================================================================================
-- SystemInfoFlyTextManager:FlyTextManagerBase
----=========================================================================================
local SystemInfoFlyTextManager = Class:new(FlyTextManagerBase)

function SystemInfoFlyTextManager:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,10)
    self.TotalTime = 1.5 --飘字存活时间
end

local ItemInfoFlyTextManager = Class:new(FlyTextManagerBase)

function ItemInfoFlyTextManager:Init()
    --printyellow("ItemInfoFlyTextManager:Init")
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,10)
    self.TotalTime = 1.5 --飘字存活时间
end

local FlyTextManager = Class:new(FlyTextManagerBase)
function FlyTextManager:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,50)
    self.TotalTime = 1 --飘字存活时间
end

-- SystemInfoFlyTextManager:FlyTextManagerBase
----=========================================================================================
local Blue1FlyTextManager = Class:new(FlyTextManagerBase)
function Blue1FlyTextManager:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,30)
    self.TotalTime = 1.5 --飘字存活时间
end

local Blue2FlyTextManager = Class:new(FlyTextManagerBase)
function Blue2FlyTextManager:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,30)
    self.TotalTime = 1.5 --飘字存活时间
end

local Green1FlyTextManager = Class:new(FlyTextManagerBase)
function Green1FlyTextManager:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,30)
    self.TotalTime = 1.5 --飘字存活时间
end

local Green2FlyTextManager = Class:new(FlyTextManagerBase)
function Green2FlyTextManager:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,30)
    self.TotalTime = 1.5 --飘字存活时间
end

local GoldenFlyTextManager = Class:new(FlyTextManagerBase)
function GoldenFlyTextManager:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,30)
    self.TotalTime = 1.5 --飘字存活时间
end
---==========================================================================================
-- WhiteFlyTextManager:FlyTextManagerBase
----=========================================================================================
local DamageFlyTextManager = Class:new(FlyTextManagerBase)

function DamageFlyTextManager:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,30)
    self.TotalTime = 1.5 --飘字存活时间
end

local BlockFlyTextManager = Class:new(FlyTextManagerBase)

function BlockFlyTextManager:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,10)
    self.TotalTime = 1.5 --飘字存活时间
end

local DodgeFlyTextManager = Class:new(FlyTextManagerBase)

function DodgeFlyTextManager:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,10)
    self.TotalTime = 1.5
end

local CritWhiteFlyTextManager = Class:new(FlyTextManagerBase)

function CritWhiteFlyTextManager:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,30)
    self.TotalTime = 1.5
end

local SelfWhiteFlyTextManager = Class:new(FlyTextManagerBase)

function SelfWhiteFlyTextManager:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,30)
    self.TotalTime = 1.5
end


local Purple1FlyTextManager = Class:new(FlyTextManagerBase)

function Purple1FlyTextManager:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,30)
    self.TotalTime = 1.5 --飘字存活时间
end

local Purple2FlyTextManager = Class:new(FlyTextManagerBase)

function Purple2FlyTextManager:Init()
    self.FlyTextPool = ObjectPool:new(FlyTextEntity,30)
    self.TotalTime = 1.5 --飘字存活时间
end

return{
    FlyTextType = FlyTextType,
    FlyTextEntity = FlyTextEntity,
    SystemInfoFlyTextManager = SystemInfoFlyTextManager,
    ItemInfoFlyTextManager = ItemInfoFlyTextManager,
    DamageFlyTextManager = DamageFlyTextManager,
    Blue1FlyTextManager = Blue1FlyTextManager,
    Blue2FlyTextManager = Blue2FlyTextManager,
    Green1FlyTextManager = Green1FlyTextManager,
    BlockFlyTextManager = BlockFlyTextManager,
    DodgeFlyTextManager = DodgeFlyTextManager,
    CritWhiteFlyTextManager = CritWhiteFlyTextManager,
    Green2FlyTextManager = Green2FlyTextManager,
    GoldenFlyTextManager = GoldenFlyTextManager,
    Purple2FlyTextManager = Purple2FlyTextManager,
    Purple1FlyTextManager = Purple1FlyTextManager,
    SelfWhiteFlyTextManager= SelfWhiteFlyTextManager,
    FlyTextManager = FlyTextManager,
}
