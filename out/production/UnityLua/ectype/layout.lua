--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
--endregion

local mathutils = require"common.mathutils"
local ConfigManager
local defineenum = require "defineenum"
local PlayerRole = require "character.playerrole"
local network = require"network"
local mathutils = require"common.mathutils"
local tools = require"ectype.ectypetools"

local Layout = Class:new()

function Layout:Init(layoutGroupID,IsPrologue)
    local polygonRegion = ConfigManager.getConfigData("ectyperegionset",layoutGroupID)
    self.m_polygons = polygonRegion.regions_id
    local polygon = polygonRegion.regions_id
    self.m_WallsPoints = polygon[self.m_LayoutArea.curveid].polygon.vertices
    if not IsPrologue then
        for i,v in ipairs(self.m_WallsPoints) do
            local tp1,tp2 = self.m_WallsPoints[i], self.m_WallsPoints[i==#self.m_WallsPoints and 1 or i+1]
            local p1=Vector3(tp1.x,tp1.y,tp1.z)
            local p2=Vector3(tp2.x,tp2.y,tp2.z)
            local mid = (p1+p2)*0.5
            mid.y = math.min(p1.y,p2.y)
            Util.Load("sfx/s_kongqiqiang.bundle",define.ResourceLoadType.LoadBundleFromFile,function(asset_obj)
                if IsNull(asset_obj) then
                    return
                end
                local AirWall = GameObject.Instantiate(asset_obj)

                local airwallroot = UnityEngine.GameObject.Find("airwalls")
                if airwallroot == nil then
                    airwallroot = UnityEngine.GameObject("airwalls")
                end
                AirWall.transform.parent = airwallroot.transform
                AirWall.transform.position = mid
                -- GameObject.DontDestroyOnLoad(AirWall)
                local pp1 = Vector3(p1.x,0,p1.z)
                local pp2 = Vector3(p2.x,0,p2.z)
                local symbol = tools.Cross2(pp2-pp1,Vector3(1,0,0))
                local rotation =180+ Vector3.Angle(pp2-pp1,Vector3(1,0,0))*symbol
                AirWall.transform:Rotate(Vector3(0,rotation,0))
                local sizeX = Vector3.Distance(pp1,pp2)
                AirWall.transform.localScale = Vector3(sizeX,50,5)
                AirWall:SetActive(true)
                local MeshRenderer = AirWall:GetComponent("MeshRenderer")
                local material = MeshRenderer.material
                material:SetTextureScale("_Tex3",Vector2(sizeX/5,10))
                table.insert(self.m_AirWalls,i,{AirWall = AirWall,Material = material})
                local material = self.m_AirWalls[i].Material
                local color = material.color
                color.a = 0
                self.m_AirWalls[i].Material.color = color
            end)
        end
    end
end

function Layout:__new(layout_infos,ectypeinfo,layoutGroupID,pre,IsPrologue)
    ConfigManager = require "cfg.configmanager"
    self.m_LayoutID             = layout_infos.id
    self.m_Completed            = layout_infos.completed
    self.m_OpenEntryIDs         = layout_infos.openentryids
    self.m_OpenExitIDs          = layout_infos.openexitids
    local layouts               = ectypeinfo.layouts
    local layouts_id            = ectypeinfo.layouts_id
    local infos                 = layouts_id[self.m_LayoutID]
    self.m_LayoutType           = infos.type
    self.m_LayoutArea           = infos.area
    self.m_Enters               = infos.enters_id
    self.m_Exits                = infos.exits_id
    self.m_RevivePos            = infos.reviveposition
    self.m_CompleteCondition    = infos.conditions
    self.m_Characters           = infos.characters
    self.m_PlayerRole           = PlayerRole.Instance()
    self.m_Regions              = infos.regions_id
    self.m_ShowDist             = 2
    self.m_StopDist             = 0.2
    self.m_Executions           = {}
    self.m_Conditions           = {}
    self.m_AirWalls             = {}
    self.m_WallsPoints          = {}
    self.m_ShouldStop           = false
    self.m_ExitPoints           = {}
    self.m_EnterAreas           = {}
    self.m_PreLayoutID          = pre
    for i,v in pairs(self.m_Exits) do
        v.isOpen = false
    end
    for i,v in pairs(self.m_Enters) do
        v.isOpen = true
    end
    self:Init(layoutGroupID,IsPrologue)
end

function Layout:Release()
    for _,v in pairs(self.m_AirWalls) do
        if v.AirWall then
            GameObject.Destroy(v.AirWall)
        end
        v = nil
    end
    self.m_AirWalls     = {}
    self.m_Executions   = nil
    self.m_Conditions   = nil
    self.m_WallsPoints  = {}
end

function Layout:GetDistanceToPolygonEdge(p1,p2,pPos)
    local pPos = self.m_PlayerRole:GetPos()
    if (math.abs(p1.x-p2.x))<1e-5 then
        return math.abs(pPos.x - p1.x),Vector3(p1.x,pPos.z)
    elseif (math.abs(p1.z-p2.z))<1e-5 then
        return math.abs(pPos.z-p1.z),Vector3(pPos.x,p1.z)
    else
        local k = (p2.z-p1.z)/(p2.x-p1.x)
        local d = p1.z-k*p1.x
        local tmp = k^2+1
        local dist = (k*pPos.x-pPos.z+d)/math.sqrt(tmp)
        local collision = Vector3(0,0,0)
        collision.x = (pPos.x+k*pPos.z-k*d)/tmp
        collision.z = (k^2*pPos.z+k*pPos.x+d)/tmp
        return math.abs(dist),collision
    end
end

function Layout:AddExecution(msg)
    if msg then
        table.insert(self.m_Executions,msg)
    end
end

function Layout:AddCondition(msg)
    if msg then
        table.insert(self.m_Conditions,msg)
    end
end

function Layout:CheckPosition(position)
    return tools.CheckInTheArea(position,self.m_WallsPoints)
end

function Layout:CheckPassage(position,points)
    return tools.CheckInTheArea(position,points)
end

function Layout:GetDistanceToWall(p1,p2,playerPos)
    local d1 = mathutils.DistanceOfXoZ(p1,playerPos)
    local d2 = mathutils.DistanceOfXoZ(p2,playerPos)
    local dist,collision = self:GetDistanceToPolygonEdge(p1,p2,playerPos)
    local btm = mathutils.DistanceOfXoZ(p1,p2)
    if d1^2>(btm^2+d2^2) then  return d2,collision
    elseif d2^2>(btm^2+d1^2) then return d1,collision
    else  return dist,collision
    end
end

function Layout:MovingAndAirWallsUpdate()
    local playerPos = self.m_PlayerRole:GetPos()
    self.m_ShouldStop = false
    for i,v in ipairs(self.m_WallsPoints) do
        local tp1,tp2 = self.m_WallsPoints[i],self.m_WallsPoints[i==#self.m_WallsPoints and 1 or i+1]
        local p1=Vector3(tp1.x,tp1.y,tp1.z)
        local p2=Vector3(tp2.x,tp2.y,tp2.z)
        local dist ,collision = self:GetDistanceToWall(p1,p2,playerPos)
        if self.m_AirWalls[i] and self.m_AirWalls[i].AirWall then
            local material = self.m_AirWalls[i].Material
            local color = material.color
            if dist>=5 then color.a = 0
            elseif dist<5 and dist>2 then color.a = (5-dist)/3
            else color.a = 1
            end
            self.m_AirWalls[i].Material.color = color
        end
    end
end

function Layout:Finish()
    self.m_Completed = 1
end

function Layout:Update()
        self:MovingAndAirWallsUpdate()
end

function Layout:ChangeEntry(id,open)
    self.m_Enters[id].isOpen = open
end

function Layout:ChangeExit(id,open)
    self.m_Exits[id].isOpen = open
end

function Layout:LayoutFinished(id)
    if self.m_LayoutID == id then
        self.m_Completed = 1
    end
end

function Layout:GetArea(curveid)
    return self.m_polygons[curveid].polygon.vertices
end
function Layout:UpdateEnterLayout()
    if not self.m_PreLayoutID then --[[printyellow("UpdateEnterLayout()")]] return end
    -- printyellow("num enters",getn(self.m_EnterAreas))
    if getn(self.m_EnterAreas)==0 then
        for i,v in pairs(self.m_Enters) do
            -- printyellow("enters index",i)
            self.m_EnterAreas[i] = self.m_polygons[v.curveid].polygon.vertices
        end
    else
        for i,v in pairs(self.m_EnterAreas) do
            if self:CheckPassage(self.m_PlayerRole:GetPos(),v) then
                local re = map.msg.CCloseLayout({layoutid=self.m_PreLayoutID})
                self.m_PreLayoutID=nil
                network.send(re)
                return
            end
        end
    end
    self:MovingAndAirWallsUpdate()
end

function Layout:GetOpenExitPoint(Pos)
    local nearestPoint = nil
    local nearestDist = 1e10

    for i,v in pairs(self.m_Exits) do
        if v.isOpen then
            if tools.CheckInTheArea(Pos,self.m_polygons[v.curveid].polygon.vertices) then
                return nil
            end
            local target = tools.GetMidPoint(self.m_polygons[v.curveid].polygon.vertices)
            local dist = mathutils.DistanceOfXoZ(Pos,target)
            if dist<nearestDist then
                nearestDist = dist
                nearestPoint = target
            end
        end
    end
    return nearestPoint
end

function Layout:UpdateCompletedLayout()
    if #self.m_ExitPoints == 0 then
        for i,v in pairs(self.m_Exits) do
            if v.isOpen then
                self.m_ExitPoints = self.m_polygons[v.curveid].polygon.vertices
                self.m_LinkedLayout = v.linkedlayout
            end
        end
    end
    if #self.m_ExitPoints>0 then
        if self:CheckPassage(self.m_PlayerRole:GetPos(),self.m_ExitPoints) then
            local re = map.msg.COpenLayout({layoutid = self.m_LinkedLayout})
            network.send(re)
        end
    end
    self:MovingAndAirWallsUpdate()
end

function Layout:late_update()

end

function Layout:GetNextLayout()

end

function Layout:GetFinished()
    return self.m_Completed == 1
end


return Layout
