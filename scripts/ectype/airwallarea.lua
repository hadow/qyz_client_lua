local ConfigManager = require("cfg.configmanager")
local EctypeTools   = require("ectype.ectypetools")



local AirWallArea = Class:new()


function AirWallArea:__new(regionsetid, regionid)

    self.m_Areas = self:GetArea(regionsetid, regionid)
    self.m_AirWalls = {}
    self.m_RegionSetId = regionsetid
    self.m_RegionId = regionid
end

function AirWallArea:init()
    self.m_AirWalls = self:CreateAirWall(self.m_Areas)
end

function AirWallArea:GetId()
    return self.m_RegionId
end

function AirWallArea:GetRegionSetId()
    return self.m_RegionSetId
end

function AirWallArea:GetArea(regionsetid, regionid)
    local regions = ConfigManager.getConfigData("ectyperegionset",regionsetid)
    local polygons = regions.regions_id
    local areas = polygons[regionid].polygon.vertices
    return areas
end

function AirWallArea:CreateAirWall(areas)
    local airwalls = {}
    Util.Load("sfx/s_kongqiqiang.bundle",define.ResourceLoadType.LoadBundleFromFile,function(asset_obj)
        if IsNull(asset_obj) then
            return
        end
        for i,v in ipairs(areas) do

            local tp1,tp2 = areas[i], areas[i==#areas and 1 or i+1]
            local p1=Vector3(tp1.x,tp1.y,tp1.z)
            local p2=Vector3(tp2.x,tp2.y,tp2.z)
            local mid = (p1+p2)*0.5
            mid.y = math.min(p1.y,p2.y)
            local AirWall = Util.Instantiate(asset_obj,"sfx/s_kongqiqiang.bundle")
            local airwallroot = UnityEngine.GameObject.Find("airwalls")
            if airwallroot == nil then
                airwallroot = UnityEngine.GameObject("airwalls")
                UnityEngine.GameObject.DontDestroyOnLoad(airwallroot)
            end
            AirWall.name = "airwall" .. tostring(i)
            AirWall.transform.parent = airwallroot.transform
            AirWall.transform.position = mid
            local pp1 = Vector3(p1.x,0,p1.z)
            local pp2 = Vector3(p2.x,0,p2.z)
            local symbol = EctypeTools.Cross2(pp2-pp1,Vector3(1,0,0))
            local rotation =180 + Vector3.Angle(pp2-pp1,Vector3(1,0,0))*symbol
            AirWall.transform:Rotate(Vector3(0,rotation,0))
            local sizeX = Vector3.Distance(pp1,pp2)
            AirWall.transform.localScale = Vector3(sizeX,50,5)
            AirWall:SetActive(true)
            local MeshRenderer = AirWall:GetComponent("MeshRenderer")
            local material = MeshRenderer.material
            material:SetTextureScale("_Tex3",Vector2(sizeX/5,10))
            table.insert(airwalls,i,{AirWall = AirWall,Material = material})
        end
    end)
    return airwalls
end


function AirWallArea:GetDistanceToPolygonEdge(p1,p2,pPos)
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

function AirWallArea:GetDistanceToWall(p1,p2,playerPos)
    local d1 = mathutils.DistanceOfXoZ(p1,playerPos)
    local d2 = mathutils.DistanceOfXoZ(p2,playerPos)
    local dist,collision = self:GetDistanceToPolygonEdge(p1,p2,playerPos)
    local btm = mathutils.DistanceOfXoZ(p1,p2)
    if d1^2>(btm^2+d2^2) then  return d2,collision
    elseif d2^2>(btm^2+d1^2) then return d1,collision
    else  return dist,collision
    end
end


function AirWallArea:Update(playerPos)
    for i,v in ipairs(self.m_Areas) do
        local tp1,tp2 = self.m_Areas[i],self.m_Areas[i==#self.m_Areas and 1 or i+1]
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

function AirWallArea:CheckPosition(position)
    return EctypeTools.CheckInTheArea(position,self.m_Areas)
end

function AirWallArea:Destroy()
    self.m_Areas = {}
    for i,v in ipairs(self.m_AirWalls) do
        GameObject.Destroy(v.AirWall)
    end
    self.m_AirWalls = {}
end

return AirWallArea
