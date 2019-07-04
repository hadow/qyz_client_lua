local StateBase         = require("character.navigation.navigationstate.statebase")
local ConfigManager     = require("cfg.configmanager")
local NavigationHelper  = require("character.navigation.navigationhelper.navigationhelper") 
local UIManager         = require("uimanager")
local MapManager        = require("map.mapmanager")
local StateNavToMap = Class:new(StateBase)

function StateNavToMap:__new(controller, isDirectEnter, mapId, lineId, portalId)
    StateBase.__new(self,controller,"StateNavToMap")
    self.m_MapId            = mapId
    self.m_LineId           = lineId
    self.m_PortalId         = portalId
    self.m_IsDirectEnter    = isDirectEnter
end

function StateNavToMap:Start()
    StateBase.Start(self)
    if self.m_IsDirectEnter == false then
        MapManager.TransferMapWithoutStop(self.m_PortalId)
    else
        MapManager.EnterMapWithoutStop(self.m_MapId, self.m_LineId)
    end
end

function StateNavToMap:Update()
    StateBase.Update(self)
    if self.m_Player:GetMapId() == self.m_MapId
     --   and self.m_Player.m_MapInfo:GetLineId() == self.m_LineId
        and self.m_Player.m_MapInfo:IsChangingScene() == false then
        self:End()    
    end
end
--[[

]]
function StateNavToMap:End()
    --printyellowmodule( Local.LogModuals.Navigate,"chang map end")
    StateBase.End(self)
end

return StateNavToMap
