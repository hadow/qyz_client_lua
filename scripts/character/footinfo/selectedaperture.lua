local Define            = require("define")

local SelectedAperture = Class:new()

function SelectedAperture:__new()
    self.m_Character = nil
    self.m_Object = nil
    self.m_ObjColor_Blue = nil
    self.m_ObjColor_Red = nil
    self.m_ObjColor_Yellow = nil
    self:Load()

    
end

function SelectedAperture:Load()
    local CharacterManager  = require("character.charactermanager")
    self.m_Object = UnityEngine.GameObject("selectedaperture")
    self.m_Object:SetActive(false)
    local objCharacters = CharacterManager.GetCharacterManagerObject()
    self.m_Object.transform.parent = objCharacters.transform
    local bundleName = "sfx/s_footinfo.bundle"
    Util.Load(bundleName,Define.ResourceLoadType.LoadBundleFromFile,function(obj)
        if not IsNull(obj) then
            local template = Util.Instantiate(obj,bundleName)
            template.transform.parent = self.m_Object.transform
            template.transform.localPosition = Vector3(0,0,0)
            local blue_trans = template.transform:Find("mubiao_Xuan_Lan")
            local red_trans = template.transform:Find("mubiao_Xuan_Hong")
            local yellow_trans = template.transform:Find("mubiao_Xuan_Huang")
            if blue_trans and red_trans and yellow_trans then
                self.m_ObjColor_Blue    = blue_trans.gameObject
                self.m_ObjColor_Red     = red_trans.gameObject
                self.m_ObjColor_Yellow  = yellow_trans.gameObject
                self:SetColor()
            end
        end
    end)

end

function SelectedAperture:SetColor()
    local isShowRed = false
    local isShowYellow = true
    local isShowBlue = false
    if self.m_Character and self.m_Character.m_ModelData and self.m_Character.m_Camp ~= nil then
        local CharacterManager  = require("character.charactermanager")
        local campRelation = CharacterManager.GetRelation(self.m_Character.m_Camp)
        if campRelation == cfg.fight.Relation.ENEMY then
            isShowRed = true
            isShowYellow = false
            isShowBlue = false 
        elseif campRelation == cfg.fight.Relation.FRIEND then
            isShowRed = false
            isShowYellow = false
            isShowBlue = true 
        else
            isShowRed = false
            isShowYellow = true
            isShowBlue = false 
        end
    end
    if self.m_ObjColor_Red then
        self.m_ObjColor_Red:SetActive(isShowRed)
    end
    if self.m_ObjColor_Yellow then
        self.m_ObjColor_Yellow:SetActive(isShowYellow)
    end
    if self.m_ObjColor_Blue then
        self.m_ObjColor_Blue:SetActive(isShowBlue)
    end

end

function SelectedAperture:Instance()
    if _G.SelectedAperture then
        return _G.SelectedAperture
    end
    local aperture = SelectedAperture:new()
    _G.SelectedAperture = aperture
    return aperture
end

function SelectedAperture:Update()
    if self.m_Object and self.m_Character and self.m_Character.m_Object then
        local playerPos = self.m_Character.m_Object.transform.position
        local height = self.m_Character:GetGroundHeight(playerPos)
        self.m_Object.transform.position = Vector3(playerPos.x, height + 0.1, playerPos.z)
        self:CalculateEulerAngleOfTerrain(self.m_Object, 0.9)
    end
end


function SelectedAperture:SetTarget(char)
    if char == nil then
        self:CancelTarget()
    else
        self.m_Character = char
        self.m_Object:SetActive(true)
        if self.m_Character.m_ModelData then
            local scale = self.m_Character.m_ModelData.aperturescale or 1
            self.m_Object.transform.localScale = Vector3(scale,scale,scale)
            self:SetColor()
        end
    end
end

function SelectedAperture:GetTarget()
    return self.m_Character
end

function SelectedAperture:CancelTarget()
    self.m_Character = nil
    if self.m_Object then
        self.m_Object:SetActive(false)
        self.m_Object.transform.localScale = Vector3(1,1,1)
    end
end

function SelectedAperture:SmoothHeight(heightA, heightB, heightCenter, errorLenght)
    if heightA < cfg.map.Scene.HEIGHTMAP_MIN/2 and heightB > cfg.map.Scene.HEIGHTMAP_MIN/2 then
        heightA = heightB
    elseif heightA >= cfg.map.Scene.HEIGHTMAP_MIN/2 and heightB < cfg.map.Scene.HEIGHTMAP_MIN/2 then
        heightB = heightA
    elseif heightA < cfg.map.Scene.HEIGHTMAP_MIN/2 and heightB < cfg.map.Scene.HEIGHTMAP_MIN/2 then
        heightA = heightCenter
        heightB = heightCenter
    end
    if math.abs( heightA - heightB ) > errorLenght then
        if math.abs( heightA - heightCenter ) > math.abs( heightB - heightCenter ) then
            heightA = 2 * heightCenter - heightB
        else
            heightB = 2 * heightCenter - heightA
        end
    end
    return heightA, heightB
end


function SelectedAperture:CalculateEulerAngleOfTerrain(gameObject,radius)
    local vectorFront = self.m_Character.m_Object.transform.rotation * Vector3(0,0,radius)

    local center = gameObject.transform.position
    local frontPoint = center +  Quaternion.Euler(0, 0, 0) * vectorFront
    local backPoint = center + Quaternion.Euler(0, 180, 0) * vectorFront
    local leftPoint = center + Quaternion.Euler(0, 270, 0) * vectorFront
    local rightPoint = center + Quaternion.Euler(0, 90, 0) * vectorFront

    local centerHeight = self.m_Character:GetGroundHeight(center)
    local frontHeight = self.m_Character:GetGroundHeight(frontPoint)
    local backHeight = self.m_Character:GetGroundHeight(backPoint)
    local leftHeight = self.m_Character:GetGroundHeight(leftPoint)
    local rightHeight = self.m_Character:GetGroundHeight(rightPoint)

    frontHeight, backHeight = self:SmoothHeight(frontHeight, backHeight, centerHeight, radius * 2)
    leftHeight, rightHeight = self:SmoothHeight(leftHeight, rightHeight, centerHeight, radius * 2)

    local angleX = math.atan((frontHeight - backHeight)/((frontPoint - backPoint).magnitude)) * 180 / 3.14
    local angleZ = math.atan((leftHeight - rightHeight)/((leftPoint - rightPoint).magnitude)) * 180 / 3.14

    local charAngleY = self.m_Character.m_Object.transform.rotation.eulerAngles.y

    gameObject.transform.localRotation = Quaternion.Euler(-angleX, charAngleY, -angleZ)
end


return SelectedAperture