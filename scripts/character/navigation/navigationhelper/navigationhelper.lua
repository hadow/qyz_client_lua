local MapManager = require("map.mapmanager")
local ConfigManager = require("cfg.configmanager")


local Config = {
    MinHeight           = -500,
    MaxHeight           = 500,
    DefaultStopLength   = 0.5,
    SceneNameColor      = "[00DD00]",
}

local function LogError(msg)
    printyellow(msg)
end



local function GetPortalPos(currentMapId, targetMapId)
    return MapManager.GetPortalOfMap(currentMapId,targetMapId)
end

local function CheckParams(params,player)
    local para = {}

    --[[
        目标点与停止距离
    ]]
    
    para.stopLength = params.newStopLength or Config.DefaultStopLength
    para.isAdjustByRideState = params.isAdjustByRideState or false
    para.targetPos  = params.targetPos
    para.lengthCallback = params.lengthCallback
    para.endDir     = params.endDir
       
    --[[
        地图Id与线Id
    ]]
    para.mapId  = params.mapId  or player:GetMapId()
    para.lineId = params.lineId or 0
    
    if para.mapId == player:GetMapId() then
        para.mode = 0
    else
        local portalPos,portalId = GetPortalPos(player:GetMapId(), para.mapId)
        para.mode = (((params.navMode == 1 or portalPos == nil) and 1) or 2)
        if  params.isShowAlert == nil or params.isShowAlert == true then
            para.isShowAlert = true
        else
            para.isShowAlert = false
        end
        
        if para.mode == 2 then
            para.portalPos = portalPos
            para.portalId = portalId
        end
    end
    
    --[[
        设置回调
    ]]
    para.endCallback  = params.callback
    para.stopCallback = params.stopCallback
    
    return para
    
end

local function GetNavMode(mapId)
    local worldMap = ConfigManager.getConfigData("worldmap",mapId)
    
end

return {
    Config      = Config,
    LogError    = LogError,
    CheckParams = CheckParams,
    GetNavMode  = GetNavMode, 
}