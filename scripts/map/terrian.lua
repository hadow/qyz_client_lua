local MathUtils=require"common.mathutils"

local Version=1
local INT_SIZE=4
local FLOAT_SIZE = 4
local MIN_HEIGHT = cfg.map.Scene.HEIGHTMAP_MIN

local MTerrain=Class:new()   

function  MTerrain:__new()
end
    
function MTerrain:init()
end

function MTerrain:ReadInt(file)
    local b = file:read(INT_SIZE)
    self.m_CurPos=self.m_CurPos+INT_SIZE
    self.m_CurPos=file:seek("set",self.m_CurPos)
    if not b then return nil end
    return MathUtils.BinIntToHexInt(string.byte(b, 1, INT_SIZE))
end

function MTerrain:ReadFloat(file,isdebug)
    local b = file:read(FLOAT_SIZE)
    self.m_CurPos=self.m_CurPos+FLOAT_SIZE
    file:seek("set",self.m_CurPos)
    return MathUtils.BinFloatToHexFloat(string.byte(b, 1, FLOAT_SIZE))
end

function MTerrain:LoadHeightData(strSceneName)
    local strFileName = string.format("config/map/%s.hmap", strSceneName)
    local dataPath = LuaHelper.GetPath(strFileName)
    local f=io.open(dataPath,"rb")
    self.m_CurPos=0
    if (not f) then
        logError(string.format("Can't find the height map %s!",strFileName))
        return
    end
    local allData=f:read("*all")
    local startPos,endPos=string.find(allData,'heightmap ver')
    if ((startPos==nil) or (endPos==nil)) then
        logError(string.format("the format of the height map %s is not valid!", strFileName))
        f:close()
        return
    end
    self.m_CurPos=self.m_CurPos+14
    f:seek("set",self.m_CurPos)
    local version=self:ReadInt(f)
    if (version ~= Version) then
        logError(string.format("the version of the height map %s is not valid!", strFileName))
        f:close()
        return
    end    
    self.m_fStartX = self:ReadFloat(f)
    self.m_fEndX = self:ReadFloat(f)
    self.m_fStartZ = self:ReadFloat(f)
    self.m_fEndZ = self:ReadFloat(f)
    self.m_iWidth = self:ReadInt(f)
    self.m_iHeight = self:ReadInt(f)
    self.m_fStepX = 0
    self.m_fStepZ = 0
    if  (self.m_iWidth > 0) then
        self.m_fStepX = (self.m_fEndX - self.m_fStartX) / self.m_iWidth
    end
    if (self.m_iHeight > 0) then
        self.m_fStepZ = (self.m_fEndZ - self.m_fStartZ) / self.m_iHeight
    end

    if(self.m_fStartX > self.m_fEndX or self.m_fStartZ > self.m_fEndZ) then
        logError(string.Format("the area of the height map {0} is not valid!", strFileName))
        f:close()
        return
    end
    self.m_HeightData = {}    
    self.m_CurPos=self.m_CurPos+FLOAT_SIZE
    f:seek("set",self.m_CurPos)
    self.m_ValidCount = self:ReadInt(f)
    for i=0,self.m_iWidth do
        self.m_HeightData[i]={}
    end
    for k=1,self.m_ValidCount do
        local i = self:ReadInt(f)
        local j = self:ReadInt(f)     
        self.m_HeightData[i][j]=self:ReadFloat(f)  
    end  
    f:close()
end

function MTerrain:GetHeight(pos)
    return self:GetHeightByXZ(pos.x, pos.z)
end

function MTerrain:GetHeightByXZ(fPosX,fPosZ)
    if (self.m_HeightData == nil) then
        return MIN_HEIGHT
    end
    if(fPosX >= self.m_fStartX and fPosX <= self.m_fEndX and 
               fPosZ >= self.m_fStartZ and fPosZ <= self.m_fEndZ) then
        local fIndexX = 0
        local fIndexZ = 0
        if (self.m_fStepX > 0) then
            fIndexX = (fPosX - self.m_fStartX) / self.m_fStepX
            if (self.m_fStepZ > 0) then
                fIndexZ = (fPosZ - self.m_fStartZ) / self.m_fStepZ
                local iLeftIndex   = math.floor(fIndexX)
                local iRightIndex  = iLeftIndex + 1
                local iBottomIndex = math.floor(fIndexZ)
                local iTopIndex = iBottomIndex + 1
                if(iRightIndex > self.m_iWidth) then iRightIndex = self.m_iWidth end
                if (iTopIndex > self.m_iHeight) then iTopIndex = self.m_iHeight end                   
                local fLeftWeight   = 1 - (fIndexX - iLeftIndex)
                local fRightWeight  = 1 - fLeftWeight
                local fBottomWeight = 1 - (fIndexZ - iBottomIndex)
                local fTopWeight = 1 - fBottomWeight
                local LBHeight=self.m_HeightData[iLeftIndex][iBottomIndex]
                local RBHeight=self.m_HeightData[iRightIndex][iBottomIndex]
                local LTHeight=self.m_HeightData[iLeftIndex][iTopIndex]
                local RTHeight=self.m_HeightData[iRightIndex][iTopIndex]
                if (LBHeight~=nil) and
                   (RBHeight~=nil) and
                   (LTHeight~=nil) and
                   (RTHeight~=nil) then                     
                    return LBHeight * fLeftWeight * fBottomWeight +
                           RBHeight * fRightWeight * fBottomWeight +
                           LTHeight * fLeftWeight * fTopWeight +
                           RTHeight * fRightWeight * fTopWeight
                else
                    if ((LBHeight~=nil) and
                        (RBHeight~=nil)) then
                        if (fLeftWeight * fBottomWeight+ fRightWeight * fBottomWeight) ~= 0 then
                            return ((LBHeight * fLeftWeight * fBottomWeight + RBHeight * fRightWeight * fBottomWeight) /(fLeftWeight * fBottomWeight+ fRightWeight * fBottomWeight))
                        end
                    end
                    if ((LTHeight~=nil) and
                        (RTHeight~=nil)) then
                        if (fLeftWeight * fTopWeight+fRightWeight * fTopWeight) ~= 0 then
                            return ((LTHeight * fLeftWeight * fTopWeight + RTHeight * fRightWeight * fTopWeight) /(fLeftWeight * fTopWeight+fRightWeight * fTopWeight))
                        end
                    end
                    if ((LBHeight~=nil) and
                        (LTHeight~=nil)) then
                        if (fLeftWeight * fTopWeight + fLeftWeight * fBottomWeight) ~= 0 then
                            return ((LTHeight * fLeftWeight * fTopWeight + LBHeight * fLeftWeight * fBottomWeight) /(fLeftWeight * fTopWeight + fLeftWeight * fBottomWeight))
                        end
                    end
                    if ((LBHeight~=nil) and
                        (RTHeight~=nil)) then
                        if (fLeftWeight * fBottomWeight + fRightWeight * fTopWeight) ~= 0 then
                            return ((LBHeight * fLeftWeight * fBottomWeight + RTHeight * fRightWeight * fTopWeight) /(fLeftWeight * fBottomWeight + fRightWeight * fTopWeight))
                        end
                    end
                    if ((LTHeight~=nil) and
                        (RBHeight~=nil)) then
                        if (fLeftWeight * fTopWeight + fRightWeight * fBottomWeight) ~= 0 then
                            return ((LTHeight * fLeftWeight * fTopWeight + RBHeight * fRightWeight * fBottomWeight) /(fLeftWeight * fTopWeight + fRightWeight * fBottomWeight))
                        end
                    end
                    if ((RBHeight~=nil) and
                        (RTHeight~=nil)) then
                        return ((RBHeight * fRightWeight * fBottomWeight + RTHeight * fRightWeight * fTopWeight) /(fRightWeight * fBottomWeight + fRightWeight * fTopWeight))
                    end
                    if ((LBHeight~=nil)) then
                        return LBHeight
                    end
                    if ((RBHeight~=nil)) then
                        return RBHeight
                    end
                    if ((LTHeight~=nil)) then
                        return LTHeight
                    end
                    if ((RTHeight~=nil)) then
                        return RTHeight
                    end
                end
            end
        end
    end
    return MIN_HEIGHT
end

return MTerrain