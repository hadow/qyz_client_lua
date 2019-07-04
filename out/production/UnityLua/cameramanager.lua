local require = require
local print = print
local printt = printt
local network = require "network"
local mathutils = require "common.mathutils"
local gameevent = require "gameevent"
local define = require"define"
local PlayerRole
local Mount
local CameraShakeManager = require "effect.camerashakemanager"
local os = require "cfg.structs"
local ConfigManager = require "cfg.configmanager"
local create_datastream=create_datastream
local SceneManager = require "scenemanager"
local CharacterManager
local lockMode = false
local adjectMode = false
local adjectSpeed = 1
local CAMERAPOS_MAX = 10000
local SettingManager = require"character.settingmanager"
local scenestripping   = require"scenestripping"

local CameraAssist
local LookAt
local Flare
local Camera
local CameraModeType = {ThirdPerson = 0,FirstPerson =1,StoryMotion=2}
local CameraMode
local AngleX
local AngleXMin
local AngleXMax
local CameraAngleX
local CameraAngleXMin
local CameraAngleXMax
local AngleY
local Offset
local Height
local Distance
local DistanceMin
local DistanceMax
local Fov
local Far
local Background
local Fov
local LookAt
local IsOrthographic
local OrthographicSize
local MoveSpeedRateX
local MoveSpeedRateY
local NeedSetupCamera
local NeedSetupDistance
local DefaultFixedDeltaTime = 0.033
local EndSlowMotionTime
local platform
local oldPosition1=nil
local oldPosition2=nil
local oldTouch = nil
local LastCameraPos
local isOnUI
local deltaDistance
local CameraDistancedampSpeed
local CameraAngleDampSpeed
local deltaX = 0
local deltaY = 0
local NeedAdjustDistance
local multManip
local CameraIsControl=false
local isStop = true
local isLogin
-- local loginMinPos = Vector3(-36.66441,4.2,3.212276)
local loginMinPos = Vector3(-35.98323,4.2,1.06)

local loginMaxPos = Vector3(-36.43,4.37,3)
local loginLoginRotation = Vector3(0,24,0)
local loginChooseRotation = Vector3(0,24,0)
-- local loginRotation = Vector3(0,24,0)
local loginFromZ
local loginToZ
local loginCurrentSpeed
local loginDeltaSpeed
local loginPushOrPull
local loginState -- 0 speed up  1 constant speed 2 speed down
local loginElapsedTime
local loginDlg
local uimanager = require"uimanager"
local grayShader = UnityEngine.Shader.Find("Hidden/GrayScale Effect")
local isNew = false
local lockDistanceMin
local lockDistanceMax
local LockAngleLow
local LockAngleHigh
local LoginAssist
local navTime
local touches = {}
local touchCount = 0
local angleSpeedX ,angleSpeedY
local DistanceSpeed
local OnReset
local resolution
local resolutionCoeff
local standardResolution = {width=1280,height=720}
local bCollisionDetect

local autoai
-- source pos = -36.39 4.14 3.8
-- target pos = -35.98323 4.2 1.06
-- new targetpos = -36.66441 4.2 3.212276

local function GetCameraPosition()

end

local function setDistance(distance)
    local dmax,dmin
    if lockMode then
        dmax = lockDistanceMax
        dmin = lockDistanceMin
    else
        dmax = DistanceMax
        dmin = DistanceMin
    end
    if distance ~= Distance then
        if distance > dmax then
            distance = dmax
        elseif distance< dmin then
            distance = dmin
        end
        Distance = distance
        NeedSetupDistance = true
    end
end

local function setAngleY(angleY)
    AngleY = angleY
    scenestripping.UpdateOnCameraRotate(AngleX, AngleY)
    NeedSetupCamera=true
end

local function setAngleX(angleX)
    if angleX < AngleXMin then angleX = AngleXMin end
    if angleX > AngleXMax then angleX = AngleXMax end
    if angleX ~= AngleX then
        AngleX = angleX
        scenestripping.UpdateOnCameraRotate(AngleX, AngleY)
        local r = (AngleX - AngleXMin)/(AngleXMax-AngleXMin)
        CameraAngleX = CameraAngleX--CameraAngleXMin+ r *(CameraAngleXMax-CameraAngleXMin)
        NeedSetupCamera = true
    end
end



local function SetRotation(rotationX,rotationY)
    printyellow("cameramanager setrotation ",rotationY)
    if rotationX then
        setAngleX(rotationX)
    end
    if rotationY then
        setAngleY(rotationY)
    end
end

local function SetCameraZ(targetZ)
    cameraTransform.position = Vector3(cameraTransform.position.x,cameraTransform.position.y,targetZ)
end

local function ToLoginMode(param)
    cameraTransform.parent = nil
    isLogin = true
    loginState = 0
    loginPushOrPull = true
    loginElapsedTime = 0
    loginFromRotation = cameraTransform.rotation.eulerAngles

    loginDlg = param
end

local function LoginPush(param)
    ToLoginMode(param)
    loginFromPos = cameraTransform.position
    loginToPos = loginMaxPos
    loginToRotation = loginLoginRotation
    loginDeltaSpeed = 1
end

local function LoginPull(param)
    ToLoginMode(param)
    loginFromPos = cameraTransform.position
    loginToPos = loginMinPos
    loginToRotation = loginChooseRotation
    loginDeltaSpeed = -1
end

local function LoginUpdate()
    loginElapsedTime = loginElapsedTime + Time.deltaTime
    local factor = loginElapsedTime/1
    if factor>1 then
        factor=1
        if LoginAssist then
            cameraTransform.parent = LoginAssist.transform
        end
        loginPushOrPull = false
        isLogin = false
        if loginDeltaSpeed>0 then
            uimanager.hide(loginDlg)
            uimanager.show("dlglogin")
        else

        end
        if loginDlg then
            if uimanager.hasloaded(loginDlg) then
                uimanager.call(loginDlg,"show_UIs")
                loginDlg = nil
            end
        end
        -- return
    end
    -- local targetPos = Vector3.Lerp(loginFromPos,loginToPos,factor)
    local targetPos = (loginToPos - loginFromPos) * factor + loginFromPos
    local deltaPos = targetPos - cameraTransform.position
    --printyellow("delta dist",deltaPos.magnitude)
    cameraTransform.position = targetPos
    local fromX ,toX
    fromX = loginFromRotation.x > 180 and loginFromRotation.x - 360 or loginFromRotation.x
    toX = loginToRotation.x
    local fromY ,toY
    fromY = loginFromRotation.y > 180 and loginFromRotation.y - 360 or loginFromRotation.y
    toY = loginToRotation.y
    local newX = (toX - fromX) * factor + fromX
    local newY = (toY - fromY) * factor + fromY
    cameraTransform.rotation = Quaternion.Euler(newX,newY,0)
end

local function SetBornParams()
    setDistance(8.5)
    SetRotation(21,123)
end

local function CameraEuler()
    return CameraAssist.transform.localEulerAngles
end

local function CameraAssistPos()
    return CameraAssist.transform.position
end

local function SetCameraPos(pos)
    if CameraAssist then
        local pos_x = math.clamp(pos.x,-CAMERAPOS_MAX,CAMERAPOS_MAX)
        -- local pos_y = math.clamp(pos.y,-CAMERAPOS_MAX,CAMERAPOS_MAX)
        -- local heightY = SceneManager.GetHeight(pos)
        -- printyellow("heightY",heightY)
        local pos_y = math.clamp(pos.y,-CAMERAPOS_MAX,CAMERAPOS_MAX)
        -- printyellow("pos_y",pos_y)
        local pos_z = math.clamp(pos.z,-CAMERAPOS_MAX,CAMERAPOS_MAX)
        CameraAssist.transform.position = Vector3(pos_x, pos_y, pos_z)
    end
end

local function SetBackGroundColor(color)
    if Camera and color then
        Camera.backgroundColor = color
        Background = mathutils.ColorToInt(color)
    end
end

local function GetPlayerPos()

    if PlayerRole.Instance().m_Mount and PlayerRole.Instance().m_Mount:IsAttach() then
        local OffsetPlayer = Vector3.up * 0.1 * PlayerRole.Instance().m_Height
        return PlayerRole.Instance().m_Mount:GetRefPos() + OffsetPlayer + Vector3.up * PlayerRole.Instance().m_Mount.m_PropData.ridingheight
    else
        local OffsetPlayer = Vector3.up * 0.7 * PlayerRole.Instance().m_Height
        return PlayerRole.Instance():GetRefPos() + OffsetPlayer
    end
end

local function GetCameraBasicPos()
    local pos
    if CameraMode == CameraModeType.ThirdPerson then
        pos = GetPlayerPos()
    elseif CameraMode == CameraModeType.FirstPerson then
        pos = LookAt
    elseif CameraMode == CameraModeType.StoryMotion then

    end
    SetCameraPos(pos)
end


local function GetCameraPosByShake()
    local pos = CameraAssist.transform.position
    local offset = CameraShakeManager.GetOffset()
    pos = pos + Vector3.Normalize(CameraAssist.transform.right) * offset.x
    pos.y =pos.y+ offset.y
    SetCameraPos(pos)
end

local function StartSlowMothion(durationTime)
    if durationTime then
        EndSlowMotionTime = Time.realtimeSinceStartup + durationTime
    end
    Time.timeScale = 0.5
    Time.fixedDeltaTime = DefaultFixedDeltaTime * Time.timeScale
end

local function EndSlowMotion()
    EndSlowMotionTime = 0
    Time.timeScale = 1.0
    Time.fixedDeltaTime = DefaultFixedDeltaTime * Time.timeScale
    NeedSetupDistance = true
end

local function setup()
    platform = Application.platform
    NeedSetupCamera = false
    CameraAssist.transform.position = LookAt+Vector3.up*0.8
    CameraAssist.transform.localEulerAngles = Vector3(AngleX,AngleY,0)
    cameraTransform.parent = CameraAssist.transform
    cameraTransform.localPosition = Vector3(Offset,Height,-Distance)
    Camera.fieldOfView = Fov
    Camera.farClipPlane = Far
    if IsOrthographic then
        Camera.orthographic = true
        Camera.orthographicSize = OrthographicSize
    else
        Camera.orthographic = false
    end

    Camera.backgroundColor = mathutils.IntToColor(Background)
    cameraTransform.localEulerAngles = Vector3(CameraAngleX, 0, 0)
    LastCameraPos = CameraAssist.transform.position
    GetCameraBasicPos()
end

local cameraConfig={}

local function SetFarClipPlane(far)
    --printyellow(string.format("[cameramanager:SetFarClipPlane] Set far clip=[%s]!", far))
    Far = far
    NeedSetupCamera = true
end

local function reset()
    printyellow("cameramanager reset")
  local sysSetting = SettingManager.GetSettingSystem()
  LookAt = Vector3.zero
  local mapid = PlayerRole.Instance():GetMapId() or 100
  local mapInfo = ConfigManager.getConfigData("worldmap",mapid)
  bCollisionDetect = mapInfo.collisiondetect
  local cameraInfo_id = mapInfo.CameraId
  CameraMode = CameraModeType.ThirdPerson
  cameraConfig = ConfigManager.getConfig("camera")
  if not cameraConfig[cameraInfo_id] then return false end
  local curr_cfg=cameraConfig[cameraInfo_id]
  AngleX = curr_cfg.CameraModeAnglex
  AngleY =  curr_cfg.CameraModeAngley
  Height =  curr_cfg.CameraModeHeight
  Distance = curr_cfg.CameraModeDistance
  DistanceMin = curr_cfg.CameraModeDistanceMin
  DistanceMax = curr_cfg.CameraModeDistanceMax
  Fov = curr_cfg.CameraModeFov
  Far =  Far and Far or curr_cfg.CameraModeFar--sysSetting["Camera"]  or
  MoveSpeedRateX = curr_cfg.MoveSpeedRateX
  MoveSpeedRateY = curr_cfg.MoveSpeedRateY
  MoveDistanceSpeed = curr_cfg.MoveDistanceSpeed
  OrthographicSize = curr_cfg.Orhtographic
  Offset = curr_cfg.Offset
  CameraAngleX = curr_cfg.CameraAngleX
  CameraAngleXMin = curr_cfg.CameraAngleMinX
  CameraAngleXMax = curr_cfg.CameraAngleMaxX
  Background = tonumber("0x"..curr_cfg.CameraModeBackground)
  IsOrthographic = curr_cfg.IsOrthoGraphic==1
  AngleXMin = curr_cfg.AngleXMin
  AngleXMax = curr_cfg.AngleXMax
  DefaultDistance = curr_cfg.defaultdistance
  lockDistanceMin = curr_cfg.lockeddistancemin
  lockDistanceMax = curr_cfg.lockeddistancemax
  LockAngleLow = curr_cfg.lockedlowangle
  LockAngleHigh = curr_cfg.lockedhightangle
  CameraDistanceDampSpeed = curr_cfg.CameraDistanceDampSpeed
  CameraAngleDampSpeed = curr_cfg.CameraAngleDampSpeed
    deltaX = 0
    deltaY = 0
    multManip=false
  LookAt = Vector3.zero
  EndSlowMotionTime = 0
  NeedSetupCamera = true
  deltaDistance = 0
  EndSlowMotion()
  isOnUI = false
  isStop = false
  local PrologueManager = require"prologue.prologuemanager"
  if isNew then
      SetBornParams()
      isNew = false
  end
  angleSpeedX = 0
  angleSpeedY = 0
  distanceSpeed = 0
  if OnReset then
      OnReset()
      OnReset = nil
  end
  if PlayerRole.Instance() and PlayerRole.Instance().m_Object then
      SetRotation(nil,PlayerRole.Instance().m_Rotation.eulerAngles.y)
  end
  NeedSetupDistance = true
  NeedAdjustDistance = false
  return true
end

local function setupDistance(dist)
    NeedSetupDistance = false
    if PlayerRole.Instance():IsNavigating() and math.abs(dist) < 5 then
        return
    end
    CameraAssist.transform.localEulerAngles = Vector3(AngleX,AngleY,0)
    --printyellow(string.format("[cameramanager:setupDistance] cameraz=[%s]!", -dist))
    cameraTransform.localPosition = Vector3(Offset,Height,-dist)
    cameraTransform.localEulerAngles = Vector3(CameraAngleX,0,0)
end


local function DistanceJudgement(from,to) -- from player to camera
    local fromHeight = SceneManager.GetHeight(from) + 1
    local toHeight = SceneManager.GetHeight(to) + 1
    local dist = Vector3.Distance(from,to)
    if (toHeight > 1e-3 and toHeight > to.y) then
        local newDist = 1/((toHeight-to.y)/(from.y- fromHeight) + 1) * dist
        setupDistance(newDist)
    elseif (toHeight<=1e-3 and to.y < fromHeight) then
        local newDist = 1/((fromHeight-to.y)/(from.y - fromHeight) + 1) * dist
        setupDistance(newDist)
    else

    end
end

local function AdjectModeUpdate(playerTrans)
    local from = cameraTransform.eulerAngles.y < 0 and cameraTransform.eulerAngles.y+360 or cameraTransform.eulerAngles.y
    local to = playerTrans.eulerAngles.y < 0 and playerTrans.eulerAngles.y+360 or playerTrans.eulerAngles.y
    local delta = to-from
    if delta==0 then return end
    if math.abs(delta)>180 then
        if delta>0 then delta = delta-360
        else delta = delta+360
        end
    end
    local degree = math.abs(delta)
    local symbol = delta>0 and 1 or -1
    if degree>adjectSpeed then
        setAngleY (from+symbol*adjectSpeed)
    else
        setAngleY (playerTrans.eulerAngles.y)
    end
end

local function stop()
    isStop = true
end

local function CalcLockedAngleY()
    local r = (Distance - lockDistanceMin)/(lockDistanceMax - lockDistanceMin)
    setAngleX((LockAngleHigh-LockAngleLow)*r+LockAngleLow)
end

local function updateTouches()
    if touchCount ~= Input.touchCount then
        touchCount = Input.touchCount
        for i=0,touchCount-1 do
            local curTouch = Input.GetTouch(i)  -- no prob
            if curTouch.phase == TouchPhase.Began then
                if LuaHelper.IsTouchedUI(i) then
                    touches[curTouch.fingerId] = 0 -- on ui
                else
                    touches[curTouch.fingerId] = 1 -- not on ui
                end
            elseif curTouch.phase == TouchPhase.Ended
                or curTouch.phase == TouchPhase.Canceled then
                touches[i] = nil
            end
        end
    end
end

local function TouchCameraAngleManager()
    local actFingerId = nil
    for i=0,touchCount-1 do
        local curTouch = Input.GetTouch(i)
        if touches[curTouch.fingerId] == 1 then
            actFingerId = i
            break
        end
    end
    if actFingerId then
        local curTouch = Input.GetTouch(actFingerId)
        local deltaPos = curTouch.deltaPosition
        if deltaPos.magnitude < 0.3 then return end
        angleSpeedX = deltaPos.x  * 10 * resolutionCoeff.x
        angleSpeedY = -deltaPos.y * 5  * resolutionCoeff.y
    end
end

local function TouchDistanceManager()
    local fingerIds = {}
    for i=0,touchCount-1 do
        local curTouch = Input.GetTouch(i)
        if touches[curTouch.fingerId] == 1 then
            table.insert(fingerIds,i)
        end
    end
    if #fingerIds == 2 then
        local curTouch1 = Input.GetTouch(fingerIds[1])
        local curTouch2 = Input.GetTouch(fingerIds[2])
        local touchPos1 = curTouch1.position
        local touchPos2 = curTouch2.position
        local deltaPos1 = curTouch1.deltaPosition
        local deltaPos2 = curTouch2.deltaPosition
        local sourcePos1 = touchPos1 - deltaPos1
        local sourcePos2 = touchPos2 - deltaPos2
        local Dist1 = mathutils.Vector2Dist(touchPos1,touchPos2)
        local Dist2 = mathutils.Vector2Dist(sourcePos1,sourcePos2)
        local tmp = Dist1 - Dist2
        if math.abs(tmp)<1 then tmp = 0 end
        if tmp>0 then distanceSpeed = 20*3 * MoveDistanceSpeed
        elseif tmp<0 then distanceSpeed = -20*3 * MoveDistanceSpeed
        elseif tmp == 0 then distanceSpeed = 0
        end
    end
end

local function WindowsDistanceManager(v)
    if v > 0 then
        distanceSpeed = 40
    else
        distanceSpeed = -40
    end
end

local function WindowsCameraAngleManager(x,y)
        angleSpeedX = x * 5
        angleSpeedY = -y * 5
end

local function ResetRotation()
    printyellow("cameramanager resetrotation",PlayerRole.Instance().m_Rotation.eulerAngles.y)
    setAngleY(PlayerRole.Instance().m_Rotation.eulerAngles.y)
end

local function CameraUpdate()
    if angleSpeedX~=0 or angleSpeedY~=0 then
        local NoviceGuideTrigger=require"noviceguide.noviceguide_trigger"
        NoviceGuideTrigger.Rotate()
        NeedAdjustDistance = true
        setAngleX(AngleX + angleSpeedY * MoveSpeedRateX)
        setAngleY(AngleY + angleSpeedX * MoveSpeedRateY)
        angleSpeedX = 0
        angleSpeedY = 0
        -- angleSpeedX = angleSpeedX - angleSpeedX*Time.deltaTime* CameraAngleDampSpeed
        -- angleSpeedY = angleSpeedY - angleSpeedY*Time.deltaTime* CameraAngleDampSpeed
        -- if math.abs(angleSpeedX) < 1 then angleSpeedX = 0 end
        -- if math.abs(angleSpeedY) < 1 then angleSpeedY = 0 end
    end
    if distanceSpeed~=0 then
        setDistance(Distance - distanceSpeed * Time.deltaTime * 0.2)
        distanceSpeed = 0
        -- if math.abs(distanceSpeed)<1 then
        --     distanceSpeed = 0
        --     return
        -- else
        --     distanceSpeed = distanceSpeed - Time.deltaTime*distanceSpeed*CameraDistanceDampSpeed
        -- end
    end
end

local function UpdateCollision()
    local originPos = PlayerRole.Instance().m_Object.transform.position + Vector3.zero * PlayerRole.Instance().m_Height * 0.7
    local direction = cameraTransform.position - originPos
    local hit
    local b,hit = Physics.Raycast(originPos,direction,hit,direction.magnitude,bit.lshift(1,define.Layer.LayerCameraCollider))
    if b then
        cameraTransform.position = hit.point
    end
end

local function late_update()
    -- printyellow("late_update")
    if SceneManager.IsLoadingScene() then return end
    if isLogin and loginPushOrPull then
        LoginUpdate()
        return
    end
    if isLogin or loginPushOrPull then return end
    if isStop then return end
    if CameraIsControl==true then
        return
    end
    if not Camera then
        return
    end
    if PlayerRole.Instance():IsLoadingModel() or not PlayerRole.Instance().m_Object then return end
    GetCameraBasicPos()
    -- CharacterManager.UpdateDistHeadInfosToCamera(Camera.transform.position)
    -- CharacterManager.UpdateHeadInfoDepth()
    -- if not LuaHelper.IsWindowsEditor() then
    --     updateTouches()
    -- end
    local playerrole = PlayerRole.Instance().m_Object
    if playerrole then
        if LuaHelper.IsWindowsEditor() or Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer then
            if autoai.IsRunning()then
                local InputController = require"input.inputcontroller"
                local inputinst = InputController.Instance()
                local clicks = inputinst:GetCurrentClicks()
                if clicks[0] then
                    autoai.ToNormalMode()
                end
            end
        end

        if not LuaHelper.IsWindowsEditor() and Application.platform ~= UnityEngine.RuntimePlatform.WindowsPlayer then
            if autoai.IsRunning() then
                if Input.touchCount > 0 then
                    autoai.ToNormalMode()
                end
            end
            updateTouches()
            local UITouchCount = 0
            for i=0,touchCount-1 do
                local curTouch = Input.GetTouch(i)
                if touches[curTouch.fingerId] == 0 then
                    UITouchCount = UITouchCount + 1
                end
            end
            local actTouchCount = touchCount - UITouchCount
            if actTouchCount == 0 then
                -- do nothing
            elseif actTouchCount == 1 then
                TouchCameraAngleManager()
            elseif actTouchCount == 2 then
                TouchDistanceManager()
            end
        end
        if lockMode then
            angleSpeedY = 0
        end
        CameraUpdate()
    end

    if 0 ~= EndSlowMotionTime and Time.realtimeSinceStartup > EndSlowMotionTime then
        EndSlowMotion()
    end

    if  NeedSetupCamera then
        setup()
    end

    if NeedSetupDistance then
        setupDistance(Distance)
    end
    if PlayerRole.Instance().m_Object then
        local pPos = GetPlayerPos()
        if not lockMode then
            DistanceJudgement(pPos,cameraTransform.position)
        else
            CalcLockedAngleY()
        end
        GetCameraPosByShake()
    end

    if bCollisionDetect then
        UpdateCollision()
    end
    if PlayerRole.Instance():IsNavigating() then
        if not navTime or navTime < 0 then
            if not PlayerRole.Instance():IsFighting() then
                if PlayerRole:Instance().m_Mount and PlayerRole:Instance().m_Mount:IsAttach() then
                    AdjectModeUpdate(PlayerRole.Instance().m_Mount.m_Object.transform)
                else
                    AdjectModeUpdate(PlayerRole.Instance().m_Object.transform)
                end
                navTime = nil
            end
        end
        if navTime then
            navTime = navTime - Time.deltaTime
        end
    else
        if not navTime then
            navTime = math.random()*0.5 + 1.5
        end
    end

end

local function init()
    local eid = gameevent.evt_late_update:add(late_update)
    -- local a = gameevent.evt_fixed_update:add(fixed_update)
    PlayerRole = require "character.playerrole"
    Mount=require "character.mount"
    CameraAssist = GameObject("CameraController")
    CharacterManager = require"character.charactermanager"
    Camera = mainCamera
    resolution = UnityEngine.Screen.currentResolution
    resolutionCoeff = {}
    resolutionCoeff.x = 1--standardResolution.width / Camera.pixelWidth--resolution.width
    resolutionCoeff.y = 1--standardResolution.height/ Camera.pixelHeight
    if Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
        resolutionCoeff.x = 1/8
        resolutionCoeff.y = 1/8
    end

    --SetDontDestroyOnLoad(CameraAssist.gameObject)
    GameObject.DontDestroyOnLoad(CameraAssist.gameObject)
    if Camera then
        reset()
    end
    isStop = true
    autoai = require "character.ai.autoai"
end

local function release()
    GameObject.Destroy(CameraAssist)
    CameraAssist = nil
end
local function CameraControl(state)

    if state=="Obtain" then
        CameraIsControl=true
    elseif state=="Release" then
        CameraIsControl=false
    end
    return mainCamera
end

local function GetCameraMode()
    return lockMode
end

local function ChangeMode()
    lockMode = not lockMode
    if lockMode then
        Distance = DefaultDistance
        uimanager.call("dlgflytext","AddSystemInfo",LocalString.CameraLockMode)
    else
        uimanager.call("dlgflytext","AddSystemInfo",LocalString.CameraFreeMode)
    end
    NeedSetupDistance = true
    return lockMode
end


local function NewCharacter(b)
    isNew = b
end

local function Rotate(angleY,angleX)
    if IsNull(LoginAssist) then return end
    local sAngleX = LoginAssist.transform.eulerAngles.x
    local sAngleY = LoginAssist.transform.eulerAngles.y
    sAngleX = sAngleX-angleX
    sAngleY = sAngleY+angleY
    local k

    if sAngleX < 0 then sAngleX = sAngleX + 360 end
    if sAngleX > 360 then sAngleX = sAngleX - 360 end
    if sAngleX>180 then
        k = 360 - sAngleX
    else
        k = sAngleX
    end
    if k>30 or math.abs(angleX)>10 then return end
    LoginAssist.transform.eulerAngles = Vector3(sAngleX,sAngleY,0)
end

local function CreatLoginAssist()
    if not LoginAssist then
        LoginAssist = GameObject("LoginAssist")
    end
    LoginAssist.transform.rotation = Quaternion.Euler(0,23.93724,0)
    LoginAssist.transform.position = Vector3(-34.30257, 3.08, 2.775848)
end

local function DestroyLoginAssist()
    if LoginAssist then
        cameraTransform.parent = nil
        GameObject.Destroy(LoginAssist)
        LoginAssist = nil
    end
end

local function RegisteOnReset()
    ResetRotation()
    OnReset = ResetRotation
end

local function NotifySceneLoginLoaded()
    local pos = Vector3(-36.39,4.14,3.8)
    cameraTransform.parent = nil
    cameraTransform.position = pos
    cameraTransform.rotation = Quaternion.Euler(0,23.93724,0)
    isLogin = true
end

local function Restore()
    NeedSetupCamera = true
    NeedSetupDistance = true
end

local function AlterAngleSpeedX(v)
    MoveSpeedRateX = v
end

local function AlterAngleSpeedY(v)
    MoveSpeedRateY = v
end

local function AlterDistanceSpeed(v)
    MoveDistanceSpeed = v
end

local function MainCamera()
    return Camera
end

local function ActiveSunShaft()
    local comp = mainCamera:GetComponent("SunShafts")
    comp.enabled = true
end

local function RemoveSunShafts()
    local comp = mainCamera:GetComponent("SunShafts")
    comp.enabled = false
end

return {
    init = init,
    reset = reset,
    CameraAssist = CameraAssist,
    CameraEuler = CameraEuler,
    CameraModeType = CameraModeType, -- 相机类型
    CameraControl =CameraControl,
    SetRotation = SetRotation,
    stop = stop,
    ChangeMode = ChangeMode,
    GrayEffect = GrayEffect,
    LoginPush = LoginPush,
    LoginPull = LoginPull,
    RemoveSunShafts = RemoveSunShafts,
    NewCharacter = NewCharacter,
    Rotate = Rotate,
    CreatLoginAssist = CreatLoginAssist,
    DestroyLoginAssist = DestroyLoginAssist,
    RegisteOnReset  = RegisteOnReset,
    NotifySceneLoginLoaded = NotifySceneLoginLoaded,
    ResetRotation = ResetRotation,
    WindowsDistanceManager= WindowsDistanceManager,
    Restore = Restore,
    WindowsCameraAngleManager = WindowsCameraAngleManager,
    AlterAngleSpeedX = AlterAngleSpeedX,
    AlterAngleSpeedY = AlterAngleSpeedY,
    AlterDistanceSpeed = AlterDistanceSpeed,
    SetFarClipPlane = SetFarClipPlane,
    MainCamera = MainCamera,
    GetCameraMode = GetCameraMode,
    ActiveSunShaft = ActiveSunShaft,
}
