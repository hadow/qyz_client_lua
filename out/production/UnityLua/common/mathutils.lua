-- local mathutils = require "common.mathutils"
local require = require
local math = math
--local bit = require "bit"


local function DistanceOfXoZ(v1,v2)
  return math.sqrt((v2.x-v1.x)^2+(v2.z-v1.z)^2) --Vector3.Distance(Vector3(v1.x,0,v1.z),Vector3(v2.x,0,v2.z))
end

local function DistanceOfVector3(v1,v2)   --lua算术运算替代Vector3.Distance()
  return math.sqrt((v2.x-v1.x)^2+(v2.y-v1.y)^2+(v2.z-v1.z)^2)
end

local function IntToColor(ibg)
  return Color(bit.band(bit.rshift(ibg,16),0xff) / 255.0,bit.band(bit.rshift(ibg,8),0xff) / 255.0,bit.band(ibg,0xff) / 255.0,bit.band(bit.rshift(ibg,24),0xff) / 255.0)
end

local function IntToColorWithoutAlpha(ibg)
  return Color(bit.band(bit.rshift(ibg,16),0xff) / 255.0,bit.band(bit.rshift(ibg,8),0xff) / 255.0,bit.band(ibg,0xff) / 255.0, 1)
end

local function ColorToInt(bgcolor)
  local ibg = 0
  ibg = bit.bor(ibg, bit.lshift (math.round(bgcolor.a * 255),24) )
  ibg = bit.bor(ibg, bit.lshift (math.round(bgcolor.r * 255),16) )
  ibg = bit.bor(ibg, bit.lshift (math.round(bgcolor.g * 255),8) )
  ibg = bit.bor(ibg, math.round(bgcolor.b * 255) )

  return ibg
end

local function ClampAngle(fAngle)
  if math.abs(fAngle)>360 then
    fAngle = fAngle % 360
  end
  return fAngle
end

local function ClampAngles(vecAngle)
  if vecAngle then
    vecAngle.x = ClampAngle(vecAngle.x)
    vecAngle.y = ClampAngle(vecAngle.y)
    vecAngle.z = ClampAngle(vecAngle.z)
  end
  return vecAngle
end

local function NormalAttr(vv)
    local value = vv*10
    local i = math.floor(value/10)
    local f = value%10
    return (i*10+f)/10
    -- local ret = tostring(i)..'.'..tostring(f)
    -- return ret
end

local function RoundAttr(vv)
    local value = vv*10
    local l = value%10
    local ret
    if l>4 then
        ret = math.floor(vv) + 1
    else
        ret = math.floor(vv)
    end
    return ret
end

local function PercentAttr(vv)
    vv = vv * 100
    local value = tonumber(RoundAttr(vv*10))/10
    return NormalAttr(value)
end

local function GetMathematicAttr(value,type)
    if type == cfg.fight.DisplayType.NORMAL then
        return NormalAttr(value)
    elseif type == cfg.fight.DisplayType.ROUND then
        return RoundAttr(value)
    elseif type == cfg.fight.DisplayType.PERCENT then
        return PercentAttr(value)
    end
    logError("wrong attr type")
    return nil
end

local function GetAttr(value,type)
    if type == cfg.fight.DisplayType.NORMAL then
        return tostring(NormalAttr(value))
    elseif type == cfg.fight.DisplayType.ROUND then
        return tostring(RoundAttr(value))
    elseif type == cfg.fight.DisplayType.PERCENT then
        return tostring(PercentAttr(value))..'%'
    end
    logError("wround attr type")
    return nil
end



--mathutils.TernaryOperation(a,b,c)
local function TernaryOperation(a,b,c)
  if a then return b else return c end
end

local function NumberToLabel(a)
    if a > 10000 then
        return string.format("%d%s",math.floor(a/10000),LocalString.TenThousand)
    else
        return tostring(a)
    end
end

local function RandomSeed()
    math.randomseed(os.time())
end
local function Random(m,n)

    if m~=nil and n~=nil then
        return math.random(m,n)
    elseif m~=nil then
        return math.random(m)
    else
        return math.random()
    end
end

local function Round(x)
    if x%1 >= 0.5 then
        return math.ceil(x)
    else
        return math.floor(x)
    end
end

local function Vector2Dist(vec1,vec2)
    local x = vec1.x - vec2.x
    local y = vec1.y - vec2.y
    return math.sqrt(x*x+y*y)
end

local function AngleOfXoZ(vec1, vec2)
    local length1 = math.sqrt( vec1.x * vec1.x + vec1.z * vec1.z )
    local length2 = math.sqrt( vec2.x * vec2.x + vec2.z * vec2.z )
    local dotval = vec1.x * vec2.x + vec1.z * vec2.z
    local length = length1 * length2
    if length ~= 0 then
        return math.acos( dotval / length ) * 57.32484 --180 / 3.14
    end
    return 0
end

local function BinIntToHexInt(b1,b2,b3,b4)  --二进制转十进制整数(4个字节)
    local x = 0
    local times=0x100       --2的8次方
    x = x*times + b4
    x = x*times + b3
    x = x*times + b2
    x = x*times + b1
    return x
end

local function BinFloatToHexFloat(b1, b2, b3, b4)   --二进制转十进制浮点数
    local sign = b4 > 0x7F  --第1位表示符号位
    local expo = (b4 % 0x80) * 0x02 + math.floor(b3 / 0x80)  --中间8位整数部分
    local mant =  ((b3%0x80)*0x100+b2)*0x100+b1 --最后23位表示小数部分
    if sign then
        sign = -1
    else
        sign = 1
    end
    local n
    if mant == 0 and expo == 0 then
        n = sign * 0.0
    elseif expo == 0xFF then
        if mant == 0 then
            n = sign * math.huge
        else
            n = 0.0/0.0
        end
    else
        local divident=8388608 --小数部分需要除以2的23次方
        if (expo>0) and (expo<0xFF) then
            n = sign * math.ldexp(1.0 + mant / divident, expo - 0x7F)
        else
            n = sign * math.ldexp(0.0 + mant / divident, - 0x7E)
        end
    end
    return n
end


return {
  DistanceOfXoZ = DistanceOfXoZ,
  DistanceOfVector3 = DistanceOfVector3,
  IntToColor = IntToColor,
  ColorToInt = ColorToInt,
  ClampAngle = ClampAngle,
  ClampAngles = ClampAngles,
  TernaryOperation = TernaryOperation,
  NumberToLabel = NumberToLabel,
  GetAttr = GetAttr,
  GetMathematicAttr = GetMathematicAttr,
  Random = Random,
  RandomSeed = RandomSeed,
  Round = Round,
  Vector2Dist = Vector2Dist,

  AngleOfXoZ = AngleOfXoZ,
  IntToColorWithoutAlpha = IntToColorWithoutAlpha,
  BinFloatToHexFloat = BinFloatToHexFloat,
  BinIntToHexInt = BinIntToHexInt,
}
