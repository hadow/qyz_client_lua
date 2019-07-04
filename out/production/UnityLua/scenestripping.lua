local ConfigManager
local PlayerRole
local gameevent
local mathutils
local SceneManager

local InactivePosition = Vector3(900000000, 900000000, 900000000)

local TagLight = "scene_light"
local TagGround = "scene_ground"
local TagBuilding = "scene_building"
local TagStairs = "scene_stairs"
local TagCloud = "scene_cloud"
local TagWater = "scene_water"
local TagTree = "scene_tree"
local TagGrass = "scene_grass"
local TagStone = "scene_stone"
local TagSfx = "scene_sfx"
local TagGround = "scene_sound"

local m_CurSceneName
local m_SceneObjectCache

local m_ForceStripTagList

local m_PreStripRolePos
local m_CurRoleActiveCenter
local m_RoleActiveAreaCache
--local m_RoleCircleCache

local m_PreStripCamX    --UP DOWN
local m_PreStripCamY    --LEFT RIGHT
local m_PreStripCamPos   

local m_IsFlying
local m_StripCount

local function Reset()
    m_CurSceneName = nil
    m_SceneObjectCache = {}

    m_PreStripRolePos = nil
    m_CurRoleActiveCenter = nil
    m_RoleActiveAreaCache = {}
    --m_RoleCircleCache = {}

    m_PreStripCamX = nil
    m_PreStripCamY = nil
    m_PreStripCamPos = nil

    m_IsFlying = false
    m_StripCount = 0
end

local function Clear()
    m_ForceStripTagList = nil
    Reset()
end
------------------------------------------------------------------------
--utils
------------------------------------------------------------------------
local function GetDistance(p1, p2)
    if p1 and p2 then
        if true==m_IsFlying then
            return math.sqrt((p1.x-p2.x)^2 + (p1.y-p2.y)^2 + (p1.z-p2.z)^2) 
        else
            return mathutils.DistanceOfXoZ(p1, p2) 
        end 
    end
    return 10000000
end

local function Type2Tag(type)
    if type then
        if type == cfg.role.SceneObjectType.LIGHT then
            return TagLight
        elseif type == cfg.role.SceneObjectType.BUILDING then
            return TagBuilding
        elseif type == cfg.role.SceneObjectType.STAIRS then
            return TagStairs
        elseif type == cfg.role.SceneObjectType.CLOUD then
            return TagCloud
        elseif type == cfg.role.SceneObjectType.WATER then
            return TagWater
        elseif type == cfg.role.SceneObjectType.TREE then
            return TagTree
        elseif type == cfg.role.SceneObjectType.GRASS then
            return TagGrass
        elseif type == cfg.role.SceneObjectType.STONE then
            return TagStone
        elseif type == cfg.role.SceneObjectType.SFX then
            return TagSfx
        elseif type == cfg.role.SceneObjectType.SOUND then
            return TagStone
        elseif type == cfg.role.SceneObjectType.GROUND then
            return TagSfx
        end
    end
    return nil
end

local function GetDifference(list1, list2)
    if list2 == list1 then
        return nil
    elseif nil == list1 then
        return nil
    elseif nil == list2 then
        return list1
    else
        local diff = {}
        for _,tag1 in ipairs(list1) do
            local isin = false
            for _,tag2 in ipairs(list2) do
                if tag1==tag2 then
                    isin = true
                    break
                end
            end  
            if false==isin then
                table.insert(diff,tag1)
            end
        end        
        return diff
    end
end

local function GetBioDifference(list1, list2)
    if list1==list2 then
        return nil, nil
    elseif nil == list1 then
        return nil, list2
    elseif nil == list2 then
        return list1, nil
    else
        local diff1 = GetDifference(list1, list2)
        local diff2 = GetDifference(list2, list1)
        return diff1, diff2
    end
end

------------------------------------------------------------------------
--stripping
------------------------------------------------------------------------
local function SetGOActive(goInfo, isactive, isforcestrip)
    if goInfo then
        if true==isforcestrip then
            if true==isactive then
                goInfo.isforcestrip = false
            else
                goInfo.isforcestrip = true
            end
        end

        if goInfo.active~=isactive then            
            --printyellow(string.format("[scenestripping:SetGOActive] set [%s] active [%s]!", goInfo.go.name, isactive))
            m_StripCount = m_StripCount+1
            if true == isactive then 
                goInfo.active = true
                goInfo.go:SetActive(true)  
                --goInfo.go.transform.position = goInfo.position
                --goInfo.go.transform.parent = goInfo.parent
                --[[
                if goInfo.renderer then
                    goInfo.renderer = true            
                end  
                --]]
            else 
                goInfo.active = false
                goInfo.go:SetActive(false)  
                --goInfo.go.transform.position = InactivePosition
                --goInfo.go.transform.parent = nil
                --[[
                if goInfo.renderer then
                    goInfo.renderer = false            
                end  
                --]]
            end 
        end    
    end
end

local function StripGOByDistance(goInfo, rolePos, isnew)
    if goInfo and rolePos then
        local goPos = goInfo.position
        local dist = (isnew and true==isnew) and goInfo.centerdist or GetDistance(rolePos, goPos)
        if dist > goInfo.threshold then    
            --[[
            if false ~=goInfo.active then
                printyellow(string.format("[scenestripping:StripGOByDistance] set [%s] active fasle, dist[%.2f] > threshold[%s]!", goInfo.go.name, dist, goInfo.threshold))            
            end
            --]]
            SetGOActive(goInfo, false)         
            return true
        else       
            --[[
            if true ~=goInfo.active then
                printyellow(string.format("[scenestripping:StripGOByDistance] set [%s] active true, dist[%.2f] <= threshold[%s]!", goInfo.go.name, dist, goInfo.threshold))
            end
            --]]
            SetGOActive(goInfo, true)     
            return false
        end
    else
        return false
    end
end

local function ForceStripByTag(tag, active)
    if tag and m_SceneObjectCache then
        tagCache = m_SceneObjectCache[tag]
        if tagCache and table.getn(tagCache)>0 then
            for _,goInfo in ipairs(tagCache) do                
                SetGOActive(goInfo, active, true) 
            end
        end
    end
end

local function ForceStrip(scenestriplist)
    local setactivelist, setinactivelist = GetBioDifference(m_ForceStripTagList, scenestriplist)
    if setactivelist and table.getn(setactivelist)>0 then
        for _,tag in ipairs(setactivelist) do
            ForceStripByTag(tag, true)  
            --printyellow(string.format("[scenestripping:ForceStrip] ForceStrip [%s] active to true!", tag))
        end
    end

    if setinactivelist and table.getn(setinactivelist)>0 then
        for _,tag in ipairs(setinactivelist) do
            ForceStripByTag(tag, false)  
            --printyellow(string.format("[scenestripping:ForceStrip] ForceStrip [%s] active to false!", tag))
        end
    end
    m_ForceStripTagList = scenestriplist
end

------------------------------------------------------------------------
--role move
------------------------------------------------------------------------
local function CheckActiveArea(rolePos)
    if rolePos then    
        if nil==m_CurRoleActiveCenter or GetDistance(m_CurRoleActiveCenter, rolePos)>Local.SceneStripping.CheckActiveAreaDist then
            m_CurRoleActiveCenter = rolePos
            m_RoleActiveAreaCache = {}
            
            if m_SceneObjectCache then    
                for tag, tagCache in pairs(m_SceneObjectCache) do
                    if tagCache and table.getn(tagCache)>0 then
                        for _,goInfo in ipairs(tagCache) do
                            local distance = GetDistance(m_CurRoleActiveCenter, goInfo.position)
                            if distance<=Local.SceneStripping.RoleActiveAreaRadius then
                                goInfo.centerdist = distance
                                table.insert(m_RoleActiveAreaCache, goInfo)
                            else
                                SetGOActive(goInfo, false)  
                            end
                        end
                    end
                end
            end

            --printyellow(string.format("[scenestripping:CheckActiveArea] get [%s] in active area!", table.getn(m_RoleActiveAreaCache) ))
            return true
        end
    end
    return false
end

local function StripRoleCircle(rolePos)
    --[[
    --active area
    local isnew = CheckActiveArea(rolePos)

    --strip
    if m_RoleActiveAreaCache then    
        for _, goInfo in ipairs(m_RoleActiveAreaCache) do            
            if true==StripGOByDistance(goInfo, rolePos, isnew) then
                --table.insert(m_RoleCircleCache, goInfo)
            else

            end 
        end
    end
    --]]

    ---[[
    --strip
    --m_RoleCircleCache = {}
    if m_SceneObjectCache then    
        for tag, tagCache in pairs(m_SceneObjectCache) do
            if tagCache and table.getn(tagCache)>0 then
                for _,goInfo in ipairs(tagCache) do
                    if true==StripGOByDistance(goInfo, rolePos) then
                        --table.insert(m_RoleCircleCache, goInfo)
                    else

                    end
                end
            end
        end
    end
    --]]
end

local function NeedUpdateRoleCircle(rolePos)   
    if rolePos then
        if nil==m_PreStripRolePos or GetDistance(m_PreStripRolePos, rolePos)>Local.SceneStripping.StrppingMoveInterval then
            return true
        end
    end

    return false
end

------------------------------------------------------------------------
--camera
------------------------------------------------------------------------
local function NeedUpdateCameraStrip(camAngleX, camAngleY, camPos)    
    --[[
    if camAngleX or camAngleY then
        if camAngleX and (nil==m_PreStripCamX or math.abs(camAngleX-m_PreStripCamX)>Local.SceneStripping.StrppingCamRotateInterval) then
            return true
        end        
        if camAngleY and (nil==m_PreStripCamY or math.abs(camAngleY-m_PreStripCamY)>Local.SceneStripping.StrppingCamRotateInterval) then
            return true
        end
    end
    --]]

    return false
end

local function StripCameraView(camAngleX, camAngleY, camPos)
end

------------------------------------------------------------------------
--scene
------------------------------------------------------------------------
local function NeedUpdateScene(scenename)  
    if scenename then
        if Local.SceneStripping.IgnoreSceneList then         
            for _,ignorescene in pairs(Local.SceneStripping.IgnoreSceneList) do
                if ignorescene == scenename then
                    return false
                end
            end
        end

        return scenename~=m_CurSceneName
    end 

    return false
end

local function InitSceneInfo(scenename)
    m_SceneObjectCache = {}
    
--[[
    local gocount = 0
    for tag, threshold in pairs(Local.SceneStripping.StrppingThresholdMap) do
        --printyellow(string.format("[scenestripping:InitSceneInfo] search objects with tag [%s]!", tag))  
        local goWithTag = GameObject.FindGameObjectsWithTag(tag)
        if goWithTag and goWithTag.Length>0 then
            --printyellow(string.format("[scenestripping:InitSceneInfo] goWithTag.Length = [%s] with tag [%s]!", goWithTag.Length, tag))                       
            local tagCache = {}
            local thd = (threshold and threshold>0) and threshold or Local.SceneStripping.DefaultStrppingThreshold
            local endindex = goWithTag.Length 
            for i=1, endindex do
                local goInfo = {
                    tag         = tag, 
                    go          = goWithTag[i], 
                    threshold   = thd, 
                    active      = true, 
                    position    = goWithTag[i].transform.position, 
                    parent      = goWithTag[i].transform.parent,
                    renderer    = goWithTag[i]:GetComponent("Renderer"),
                }
                table.insert(tagCache, i, goInfo)
                gocount = gocount+1
            end
            m_SceneObjectCache[tag] = tagCache
        else
            --printyellow(string.format("[scenestripping:InitSceneInfo] find no gameobject with tag [%s]!", tag))            
        end
    end

    --force strip
    if m_ForceStripTagList and table.getn(m_ForceStripTagList)>0 then    
        for _,tag in ipairs(m_ForceStripTagList) do            
            ForceStripByTag(tag, false)
        end 
    end
    printyellow(string.format("[scenestripping:InitSceneInfo] scene [%s] contains [%s] strip objects!", scenename, gocount))
--]]
end

------------------------------------------------------------------------
--update
------------------------------------------------------------------------
local function NeedStrip(scenename, rolePos, camAngleX, camAngleY, camPos)  
    if not Local.SceneStripping.EnableStripping then
        return false
    end

    if SceneManager.IsLoadingScene() then
        return false
    end    

    return NeedUpdateScene(scenename) or NeedUpdateRoleCircle(rolePos) --or NeedUpdateCameraStrip(camAngleX, camAngleY, camPos)
end

local function UpdateStripping(scenename, rolePos, camAngleX, camAngleY, camPos)
    if Local.SceneStripping.EnableStripping then
        m_IsFlying = PlayerRole:Instance():IsFlying()
        m_StripCount = 0
        local starttime = Time.time

        --scene
        if NeedUpdateScene(scenename) then
            Reset()
            InitSceneInfo(scenename)        
            m_CurSceneName = scenename
        end

        --role position strip
        if NeedUpdateRoleCircle(rolePos) then
            StripRoleCircle(rolePos)
            m_PreStripRolePos = rolePos
        end

        --camera view strip
        --[[
        if NeedUpdateCameraStrip(camAngleX, camAngleY, camPos) then
            StripCameraView(camAngleX, camAngleY, camPos)
        end
        --]]
        --printyellow(string.format("[scenestripping:UpdateStripping] strip [%s] objects, costs [%.2f] ms!", m_StripCount, 1000*(Time.time-starttime) ))
    end
end

local function UpdateOnSceneLoaded(scenename)
    --printyellow(string.format("[scenestripping:UpdateOnSceneLoaded] update scenename=[%s]!", scenename))
    
    Reset()
    InitSceneInfo(scenename)        
    m_CurSceneName = scenename

    --Reset()
    --UpdateStripping(scenename)
end

local function UpdateOnRoleMove(mapid, rolePos)
    if mapid and mapid>0 and rolePos then        
        if NeedStrip(nil, rolePos) then
            --[[
            if m_PreStripRolePos then
                printyellow(string.format("[scenestripping:UpdateOnRoleMove] mapid=[%s], rolepos=(%.2f,%.2f,%.2f), movedist[%.2f]>Local.SceneStripping.StrppingMoveInterval[%s]!", mapid, rolePos.x, rolePos.y, rolePos.z, GetDistance(m_PreStripRolePos, rolePos), Local.SceneStripping.StrppingMoveInterval))            
            else
                printyellow(string.format("[scenestripping:UpdateOnRoleMove] mapid=[%s], rolepos=(%.2f,%.2f,%.2f), m_PreStripRolePos nil!", mapid, rolePos.x, rolePos.y, rolePos.z, GetDistance(m_PreStripRolePos, rolePos), Local.SceneStripping.StrppingMoveInterval))            
            end
            --]]
            
            UpdateStripping(nil, rolePos)
        end
    end
end

local function UpdateOnCameraRotate(camAngleX, camAngleY)
--[[
    if NeedStrip(nil, nil, camAngleX, camAngleY) then
        if m_PreStripCamX then
            printyellow(string.format("[scenestripping:UpdateOnCameraRotate] rotatex=[%s]!", camAngleX-m_PreStripCamX))        
        end
        m_PreStripCamX = camAngleX
        
        if m_PreStripCamY then
            printyellow(string.format("[scenestripping:UpdateOnCameraRotate] rotatey=[%s]!", camAngleY-m_PreStripCamY))     
        end
        m_PreStripCamY = camAngleY
    end
    --]]
end

local function UpdateOnCameraPull(camPos)
end

------------------------------------------------------------------------
--Others
------------------------------------------------------------------------
local function OnLogout()
    Clear()
end

local function test()
    local list1 = {1,2,3,4,5}
    local list2 = {4,5,6,7}
    local diff1, diff2 = GetBioDifference(list1, list2)
    printyellow("[scenestripping:test] diff1:")
    printt(diff1)
    printyellow("[scenestripping:test] diff2:")
    printt(diff2)
end

local function init()
    ConfigManager     = require("cfg.configmanager")
    PlayerRole = require "character.playerrole"
    gameevent         = require "gameevent"
    mathutils = require "common.mathutils"
    SceneManager = require("scenemanager")

    Reset()
	gameevent.evt_system_message:add("logout", OnLogout)

    --test()
end

return {
    init = init,
    UpdateOnSceneLoaded = UpdateOnSceneLoaded,
    UpdateOnRoleMove = UpdateOnRoleMove,
    UpdateOnCameraRotate = UpdateOnCameraRotate,
    UpdateOnCameraPull = UpdateOnCameraPull,
    ForceStrip = ForceStrip,
    Type2Tag = Type2Tag,
}