local gameevent = require("gameevent")
local UIManager = require("uimanager")
local CharacterManager = require"character.charactermanager_sync"
local Pressed
local lastMoveTime
local InputController = require"input.inputcontroller"
local ic
local player
local CameraManager = require"cameramanager"
local effectmanager = require "effect.effectmanager"
local auth = require"auth"
--local Define=require"define"

-- 暴露给c#的接口
function playerrole_move(delta)
    local TeamManager = require("ui.team.teammanager")
    local NoviceGuideManager = require("noviceguide.noviceguidemanager")
    local NoviceGuideTrigger = require("noviceguide.noviceguide_trigger")
    if TeamManager.IsForcedFollow() ~= true then  --非强制跟随
        if NoviceGuideManager.IsGuiding() then
            NoviceGuideTrigger.MoveJoy()
        end    
        TeamManager.RequestCancelFollowing()
        -- local RoleSkillFsm  = require("character.ai.roleskillfsm")
        if PlayerRole:Instance().m_Object then
            local speed = PlayerRole:Instance():GetJoySpeed()
            local dst = PlayerRole:Instance():GetPos() + Vector3(speed * delta.x, 0, speed * delta.z)
            PlayerRole:Instance():moveTo(dst)
            PlayerRole:Instance():OnJoyStickMove(delta)
        end
    end
end

function playerrole_stop()
    PlayerRole:Instance():stop()
    --print("==================joystick stop now ......")
    PlayerRole:Instance():OnJoyStickStop()
end

local G = {}

local function GetG() 
    local g = {}
    local t = {}
    for k,v in pairs(_G) do 
        local t = {}
        t.name = k 
        t.type = type(v)
        t.value = v
        table.insert(g,t)
        --printyellow("k",tostring(k),"v",type(v))
    end 
    table.sort(g,function(a,b) return a.type<b.type end)
    return g
end

local function PrintG(g)
    local ss = "count:" .. tostring(#g) .."\n"
    for k,v in pairs(g) do
        ss = ss .."type:"..v.type.."     name:"..v.name.."\n"
    end 
    printyellow(ss)
end  

local function PrintDiff(g1,g2)
    printyellow("#g1",#g1,"#g2",#g2)
    local ng = {}
    for _,v2 in pairs(g2) do 
        local new = true
        for _,v1 in pairs(g1) do 
            if v1.value == v2.value then 
                new = false
            end 
        end
        if new then 
            table.insert(ng,v2)
        end 
    end 
    PrintG(ng)
end 

local function keyboard_ctrl()

    local Vertical = LuaHelper.GetAxis(AxisType.Vertical)
    local Horizontal = LuaHelper.GetAxis(AxisType.Horizontal)
    Vertical = math.abs(Vertical) <=0 and 0 or Vertical>0 and 68.5 or -68.5
    Horizontal = math.abs(Horizontal) <=0 and 0 or Horizontal>0 and 68.5 or -68.5
    if Vertical ~= 0 or Horizontal ~=0 then
        if Time.realtimeSinceStartup - lastMoveTime > 0.2 then
            local v = Vector3(Horizontal,Vertical,0).normalized
            local angle = 180*math.acos(v.y)/math.pi
            if v.x>0 then
                angle = 360 - angle
            end
            local RoleDir = Vector3(cameraTransform.forward.x,cameraTransform.forward.z,0).normalized
            local cosA = math.cos(angle*math.pi/180)
            local sinA = math.sin(angle*math.pi/180)
            local mvDir = Vector3(RoleDir.x*cosA-RoleDir.y*sinA,RoleDir.x*sinA+RoleDir.y*cosA,0).normalized
            playerrole_move(Vector3(mvDir.x, 0, mvDir.y))
            lastMoveTime = Time.realtimeSinceStartup
            Pressed = true
        end
    else
        if Pressed then
            PlayerRole:Instance():stop()
            Pressed = false
        end
    end

--    if Input.GetKey(KeyCode.Space) and not UICamera.isOverUI then
--        if PlayerRole:Instance().m_Mount and PlayerRole:Instance().m_Mount:IsAttach() then
--            local MountType = defineenum.MountType
--            if PlayerRole:Instance().m_Mount.m_MountState == MountType.Ride then
--                PlayerRole:Instance().m_Mount:Jump()
--            end
--        else
--            if PlayerRole:Instance():CanJump() then
--                PlayerRole:Instance():Jump()
--            end
--        end
--    end
--
--    if Input.GetKey(KeyCode.Q) and not UICamera.isOverUI then     --清除新手指引使用快捷键，请勿覆盖
--        -- local NoviceGuideSyncServer=require"noviceguide.noviceguide_syncserver"
--        -- NoviceGuideSyncServer.SendClearNoviceGuide()
--        -- local effect = {}
--        -- effect.id = 50002
--        -- effect.overlaynum = 1
--        -- effect.level = 1
--        -- PlayerRole.Instance():AddEffect(effect)
--        local uimanager = require"uimanager"
--        uimanager.call("dlgheadtalking","Add",{content="abcdefg",target=PlayerRole.Instance()})
--    end
--
--
--    if Input.GetKeyUp(KeyCode.P) then
--            --local PaoMaDengManager=require"paomadeng.paomadengmanager"
--            --PaoMaDengManager.PushBroadCastMsg("跑马灯测试，大家了上来的daqi.com；寄过来拉风的拉多少分‘啊")
----        Util.Load("sfx/s_chong_06.bundle", Define.ResourceLoadType.LoadBundleFromFile, function(asset_obj)
----        local effectObject = GameObject.Instantiate(asset_obj)
----        end)
--
----        local uimanager = require"uimanager"
----        uimanager.showdialog("activity.springfestival.dlgspringfestivalgifts")
----        local SceneManager = require("scenemanager")
----        local height = SceneManager.GetHeight({x=433,y=0,z=309})
----        printyellow("---:",cfg.map.Scene.HEIGHTMAP_MIN)
----        printyellow("+++:",cfg.map.Scene.HEIGHTMAP_MAX)
----        printyellow("y:",height)
--    end
--
--    if Input.GetKeyUp(KeyCode.I) then
----        local active = not  PlayerRole:Instance():IsActive()  
----        PlayerRole:Instance():SetActive(active)
----        if PlayerRole:Instance():IsRiding() then 
----            PlayerRole:Instance().m_Mount:SetActive(active)
----        end 
--        --UIManager.show("dlgtest")
--        G= GetG()
--        PrintG(G)
--
--    end
--
--    if Input.GetKeyUp(KeyCode.O) then
----        local active = not  PlayerRole:Instance():IsActive()  
----        PlayerRole:Instance():SetActive(active)
----        if PlayerRole:Instance():IsRiding() then 
----            PlayerRole:Instance().m_Mount:SetActive(active)
----        end 
--        local G2 = GetG() 
--        PrintDiff(G,G2)
--    end

    local v = LuaHelper.GetAxis(AxisType.MouseScrollWheel)
    if v ~= 0 then
        CameraManager.WindowsDistanceManager(v)
    end
    if Input.GetMouseButton(1) and not UICamera.isOverUI then
        local mx,my = LuaHelper.GetAxis(AxisType.MouseX), LuaHelper.GetAxis(AxisType.MouseY)
        if mx~=0 or my~=0 then
            CameraManager.WindowsCameraAngleManager(mx,my)
        end
    end
end

--[[
    #map.msg.SEndTeamFight#{result=2147483647,evaluate={1={evaluates={},death=0,damage=0,name=#9#229.164.143.228.190.175.233.161.190,kill=0,},2={evaluates={},death=0,damage=0,name=#7#230.149.176.229.128.188.52,kill=0,},},bonus={bindtype=0,items={10200005=1000000,10200001=1000,},},}
    #map.msg.SEndTeamFight#{result=2147483647,,}
]]

local function update()
    if LuaHelper.IsWindowsEditor() or Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer then
        keyboard_ctrl()
    end
    ic:Update()
    if player and player.m_Object then
        player.m_Avatar:Update()
    end

end

local function init()
    lastMoveTime    = 0
    player          = nil
    gameevent.evt_update:add(update)
    ic = InputController.Instance()
    -- ic:RegisterOnClick(function()
    --     printyellow("left button click")
    -- end,0)
    -- ic:RegisterOnPressEnd(function()
    --     printyellow("left button press end")
    -- end,0)
--    ic:RegisterOnDragEnd(function()
--         printyellow("left button drag end")
--     end,0)

end

return {
    init = init,
}
