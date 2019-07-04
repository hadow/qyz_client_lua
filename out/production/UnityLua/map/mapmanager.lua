local NetWork = require("network")
local UIManager = require("uimanager")
local ConfigManager = require("cfg.configmanager")
local SceneManager  = require("scenemanager")
local PlayerRole

local m_FirstLogin = true
local m_SkyRegion = nil

local function EnterMapWithoutStop(mapId,lineId)
    local line = lineId
    if line == nil then
        line = 0
    end
    if mapId == nil then
        mapId = PlayerRole:GetMapId()
    end
    local msg = lx.gs.map.msg.CEnterWorld({worldid = mapId,lineid = line})
    NetWork.send(msg)
end

local function EnterMap(mapId,lineId)
    PlayerRole:Instance():stop()
    EnterMapWithoutStop(mapId,lineId)
end

local function TransferMapWithoutStop(portalId)
    local msg = map.msg.CTransferWorld({ portalid = portalId })
    NetWork.send(msg)
end

local function TransferMap(portalId)
    PlayerRole:Instance():stop()
    TransferMapWithoutStop(portalId)
end

local function GetMapIdBySceneName(name)
    local mapData = ConfigManager.getConfig("worldmap")
    for _,map in pairs(mapData) do
        if map.scenename == name then
            return map.id
        end
    end
end

local function GetMapLines()
    local msg = lx.gs.map.msg.CGetWorldLines({worldid = PlayerRole:GetMapId()})      
    NetWork.send(msg)
end

local function OnMsg_SGetMapLines(msg)
    if UIManager.isshow("map.tabline") then
        UIManager.call("map.tabline","ShowMapLines",msg)
    end
end

local function AllowRide()
    local result = false
    local mapData = ConfigManager.getConfigData("worldmap",PlayerRole:GetMapId())
    if mapData then
        result = mapData.allowride
    end
    return result 
end

local function PreLoadLoadingTexture()
    Util.Load("ui/dlgloading.ui", define.ResourceLoadType.LoadBundleFromFile, function(asset_obj)
    end)
    local mapLoading = ConfigManager.getConfig("maploading")
    for texture,text in pairs(mapLoading) do
        if texture then
            local texName=string.format("texture/t_%s.bundle",texture)
            Util.Load(texName, define.ResourceLoadType.LoadBundleFromFile, function(asset_obj)
            end)
        end
    end   
end

local function Clear()
    m_FirstLogin = true
end

local function init()
    m_FirstLogin = true
    PlayerRole = require("character.playerrole"):Instance()
    NetWork.add_listener("lx.gs.map.msg.SGetWorldLines",OnMsg_SGetMapLines)
    gameevent.evt_system_message:add("logout",Clear)
end

local function GetCenterPosOfPortal(regionsetId,portalId)
    local circleRegion = ConfigManager.getConfigData("circleregionset",regionsetId)
    if circleRegion == nil then 
        return nil 
    end
    local center = nil
    for _, region in pairs(circleRegion.regions) do
          if region.id == portalId then
              center = region.circle.center
              break
          end
    end
    return center
end

local function GetPortalOfMap(currentMapId, targetMapId)
    if currentMapId == nil or targetMapId == nil then
        return nil,nil
    end
    local mapData = ConfigManager.getConfigData("worldmap",currentMapId)
    for i, portal in pairs(mapData.portals) do
        if portal.dstworldmapid == targetMapId then
            local centerPos = GetCenterPosOfPortal(mapData.circleregionsetid, portal.srcregionid)
            if centerPos then
                local y = SceneManager.GetHeight(Vector3(centerPos.x,0,centerPos.z))
                return Vector3(centerPos.x,y,centerPos.z), portal.srcregionid
            end
        end
    end
    return nil,nil
end

local function GetTransferCoord(oldCoord,wRatio,hRatio)
    local newCoord = Vector3.zero
    local mapData = ConfigManager.getConfigData("worldmap",PlayerRole:Instance():GetMapId())
    if mapData then
        local sceneName = mapData.scenename
        local sceneData = ConfigManager.getConfigData("scene",sceneName)
        local sceneSize = sceneData.scenesize
        local type = sceneData.pivot
        local offsetX = sceneData.offsetX
        local offsetZ = sceneData.offsetZ
        if type == cfg.map.PivotPos.CENTER then
            newCoord = Vector3((- (oldCoord.x - offsetX) / 2 ) * wRatio, (- (oldCoord.z - offsetZ) / 2) * hRatio, 0)
        elseif type == cfg.map.PivotPos.LEFTBOTTOM then
            newCoord = Vector3((-(oldCoord.x - offsetX) + sceneSize / 2) * wRatio,(-(oldCoord.z - offsetZ) + sceneSize / 2) * hRatio,0)
        end
    end
    return newCoord
end

local function GetTransferCoordInArea(oldCoord,wRatio,hRatio)
    local sceneName = ConfigManager.getConfigData("worldmap",PlayerRole:Instance():GetMapId()).scenename
    local sceneData = ConfigManager.getConfigData("scene",sceneName)
    local sceneSize = sceneData.scenesize
    local type = sceneData.pivot
    local offsetX = sceneData.offsetX
    local offsetZ = sceneData.offsetZ
    local newCoord = Vector3.zero
    if type == cfg.map.PivotPos.CENTER then
        newCoord = Vector3((oldCoord.x-offsetX)* wRatio, (oldCoord.z-offsetZ) * hRatio, 0)
    elseif type == cfg.map.PivotPos.LEFTBOTTOM then
        newCoord = Vector3(((oldCoord.x-offsetX)-sceneSize/2)*wRatio,((oldCoord.z-offsetZ)-sceneSize/2)*hRatio,0)
    end
    return newCoord
end

local function GetBornPos(mapId)
    local map = mapId
    if map == nil then
        map = PlayerRole:Instance():GetMapId()
    end
    local pos = nil
    local mapData = ConfigManager.getConfigData("worldmap",map)
    if mapData then
        pos = Vector3(mapData.WorldFlyInX,0,mapData.WorldFlyInY)
        local height = SceneManager.GetHeight(pos)
        pos.y = height
    end
    return pos
end

local function IsValidNavigatePos(params)
    local pos=Vector3(params.pos.x,params.pos.y,params.pos.z)
    local mapId = params.mapId
    if mapId == nil then
        mapId = PlayerRole:Instance():GetMapId()
    end
    local result = false 
    local height = SceneManager.GetHeight(pos)
    if height > cfg.map.Scene.HEIGHTMAP_MIN then
        pos.y = height
        local path = UnityEngine.NavMeshPath()
        result = UnityEngine.NavMesh.CalculatePath(pos,GetBornPos(mapId),UnityEngine.NavMesh.AllAreas,path )
    end   
    return result
end

local function GetPolygon(id)
    local ectypeRegion = ConfigManager.getConfigData("ectyperegionset",id)
    if ectypeRegion then
        for _, region in pairs(ectypeRegion.regions) do
            m_SkyRegion = region.polygon.vertices
            break
        end
    end
end

local function GetLandscapeId(mapId)
    local map
    if mapId ~= nil then
        map = mapId
    else
        map = PlayerRole:GetMapId()
    end
    local landscapeId = 0
    local mapData = ConfigManager.getConfigData("worldmap",map)
    if mapData then
        landscapeId = mapData.landscapeid
    end
    return landscapeId
end

local function IsCurMapWarp(id)
    local isCurWarp = false
    local worldMapData = ConfigManager.getConfigData("worldmap",PlayerRole:GetMapId())
    if worldMapData then
        if worldMapData.circleregionsetid == id then
            isCurWarp = true
        end
    end
    return isCurWarp
end

local function GetCurMapId()
    return PlayerRole:GetMapId()
end

local function GetSkyRegion()
    return m_SkyRegion
end

local function IsFirstLogin()
    return m_FirstLogin
end

local function SetFirstLogin()
    m_FirstLogin = false
end

return {
    EnterMap = EnterMap,
    EnterMapWithoutStop = EnterMapWithoutStop,
    TransferMap = TransferMap,
    TransferMapWithoutStop = TransferMapWithoutStop,
    GetMapLines = GetMapLines,
    GetMapIdBySceneName = GetMapIdBySceneName,
    init = init,
    AllowRide = AllowRide,
    GetPortalOfMap = GetPortalOfMap,
    GetTransferCoord = GetTransferCoord,
    GetTransferCoordInArea = GetTransferCoordInArea,
    GetBornPos = GetBornPos,
    SetFirstLogin = SetFirstLogin,
    IsFirstLogin = IsFirstLogin,
    IsValidNavigatePos = IsValidNavigatePos,
	  PreLoadLoadingTexture = PreLoadLoadingTexture,
    GetPolygon = GetPolygon,
    GetSkyRegion = GetSkyRegion,
    GetLandscapeId = GetLandscapeId,
    IsCurMapWarp = IsCurMapWarp,
    GetCurMapId = GetCurMapId,
}