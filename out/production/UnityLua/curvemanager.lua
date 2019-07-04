--region *.lua
--Date
--此文件由[BabeLua]插件自动生成



--endregion


local require = require
local print = print
--require "global"
local ConfigManager = require "cfg.configmanager"
local Curves = {}

function GetCurve(curID)
    return Curves[curID]
end

function ParseRand(str)
    local ans = {}
    if str~= "nil" then
    ans = Split(str,";") 
    return ans
    else return nil 
    end
end

function resetCurves()
    local nums 
    local curveConfig = ConfigManager.getConfig("beattackcurve")
    for i=1,#curveConfig do
        Curves[i]={}
        Curves[i].id = curveConfig[i].id
        Curves[i].note = curveConfig[i].note
        Curves[i].ename = curveConfig[i].ename
        Curves[i].mass = curveConfig[i].mass
        Curves[i].typeid = curveConfig[i].typeid
        Curves[i].velocity = curveConfig[i].velocity
        Curves[i].randv = ParseRand(curveConfig[i].randv)
        Curves[i].angle = curveConfig[i].angle
        Curves[i].distance = curveConfig[i].distance
        Curves[i].randDX = ParseRand(curveConfig[i].randx)
        Curves[i].randDY = ParseRand(curveConfig[i].randy)
        Curves[i].randDZ = ParseRand(curveConfig[i].randz)
        Curves[i].angleToGather = curveConfig[i].angletogether
        Curves[i].gravity = curveConfig[i].gravity
        Curves[i].friction = curveConfig[i].friction
        Curves[i].defaultGravity = curveConfig[i].defaultgravity
        Curves[i].decay = curveConfig[i].decay
        Curves[i].actionInTheAir = curveConfig[i].actionintheair
        Curves[i].actionToClimb = curveConfig[i].actiontoclimb
        Curves[i].maxTime = curveConfig[i].maxtime
        Curves[i].shakeID = curveConfig[i].shakeid
        Curves[i].Time = curveConfig[i].time
  --[[
        for k,v in pairs(Curves[i]) do
            if tostring(type(v))=="table" then
            for kk,vv in pairs(v) do
            printyellow("rand",kk,vv)
            end
            else 
            printyellow(k,v)
            end
        end
        ]]--
    end
end


return {
    getCurve = GetCurve,
    resetCurves = resetCurves,
}