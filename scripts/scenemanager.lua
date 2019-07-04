local SceneManager = Game.SceneMgr
local CharacterManager
local GameEvent = require "gameevent"
local ConfigManager = require "cfg.configmanager"
local UIManager = require "uimanager"
local DefineEnum = require "defineenum"
local network   = require"network"
local scenestripping
local MapManager
local CameraManager
local GraphicSettingMgr
local NoviceGuideManager
local AudioMgr = require"audiomanager"
local MTerrain = require"map.terrian"
local PrologueManager

local currentAudio = nil
local m_FrameCount = nil
local m_Terrian
local m_Terrian1
local m_Scene = 'maincity_01'
local m_IsLoading = false
local EctypeManager
local PlayerRole
local m_AudioList=nil
local m_SceneStartCutscene = {
    m_CutsceneIndex = nil,
    m_Played = true,
}
local m_FadeInTime = 0.7
local m_FadeInObject = nil
local m_IsClearOldScene = false
local m_HideLoading = nil
local m_LoadTimes=0
local m_SkyHeightCeil=100
local m_HasSkyHeight=false

local function PlayBackgroundMusic(id,mst)
    currentAudio = id or currentAudio

    if (currentAudio and not EctypeManager.IsInEctype()) or mst then
        AudioMgr.PlayBackgroundMusic(currentAudio)
    end
end


local function ShouldPlayMapCutscene()
    --printyellow("ShouldPlayMapCutscene",tostring(m_SceneStartCutscene.m_CutsceneIndex))
    if m_SceneStartCutscene ~= nil and m_SceneStartCutscene.m_CutsceneIndex ~= nil and m_SceneStartCutscene.m_Played == false then
        return true
    end
    return false
end

local function AlterLoadedEctypeMap(b)
    loadedEctypeMap = b
end

local function LoadedEctypeMap()
    local ret = loadedEctypeMap
    loadedEctypeMap = false
    return ret
end

local function SceneCutsceneFadeIn()
    local PlotManager = require("plot.plotmanager")
    if m_SceneStartCutscene.m_CutsceneIndex then
        m_SceneStartCutscene.m_Played = true
        PlotManager.DirectPlayCutscene(m_SceneStartCutscene.m_CutsceneIndex,   function()
            UIManager.hide("dlgloading")
        end, function() end, true)
    end
    m_SceneStartCutscene = {}
end

local function SetChangeMapCutscene(cutsceneIndex)
    if m_SceneStartCutscene == nil then
        m_SceneStartCutscene = {}
    end
    m_SceneStartCutscene.m_CutsceneIndex = cutsceneIndex
    m_SceneStartCutscene.m_Played = false
end

local function LoadBySceneName(sceneName)
    --SceneManager.Instance.UseSteamedScene=false
    if sceneName then
        m_Scene = sceneName
        -- printt{"changemap"}
        -- printt(sceneName)
        SceneManager.Instance:ChangeMap(sceneName)
    else
        SceneManager.Instance:ChangeMap("maincity_01")
    end
end

local function update()
    --SceneManager.Instance:Update()
    if m_HideLoading and ((os.time()-m_HideLoading)>=cfg.map.Scene.LOADSCENEDELAYTIME) then
        m_HideLoading=nil
        UIManager.hide("dlgloading")
    end
end

local function late_update()
end

local function LoadSkyHeightData()
    local sceneData = ConfigManager.getConfigData("scene",m_Scene)
    if sceneData.skyheightmap and sceneData.skyheightmap~="" then
        if m_Terrian1==nil then
            if Local.LoadHeightByLua==true then
                m_Terrian1=MTerrain:new()
            else
                m_Terrian1=Game.MTerrain(false)
            end
        end
        m_Terrian1:LoadHeightData(sceneData.skyheightmap)
        if sceneData.skyregionset~=0 then
            MapManager.GetPolygon(sceneData.skyregionset)
        end
        m_HasSkyHeight=true
    else
        m_HasSkyHeight=false
    end
end

local function LoadHeightData()
    local sceneData = ConfigManager.getConfigData("scene",m_Scene)
    if Local.LoadHeightByLua==true then
        if m_Terrian==nil then
            m_Terrian=MTerrain:new()
        end
        m_Terrian:LoadHeightData(sceneData.groundheightmap)
    else
        SceneManager.Instance:LoadHeightData(sceneData.groundheightmap)
    end
end

local function SetAmbientColor() --����unity 5.4֮������ʹ�ô˺���
    --[[local mapData = ConfigManager.getConfigData("worldmap",PlayerRole:GetMapId())
    local color = Color(mapData.AmbientLightR/255, mapData.AmbientLightG/255, mapData.AmbientLightB/255, mapData.AmbientLightA/255)
    UnityEngine.RenderSettings.ambientLight = color]]
end

local function SetAllAudioInScene()
    local currentScene=UnityEngine.SceneManagement.SceneManager.GetSceneByName(m_Scene)
    if currentScene then
        local sceneChildList=currentScene:GetRootGameObjects()
        if sceneChildList then
            for i=1,sceneChildList.Length do
                if (string.lower(sceneChildList[i].name)==m_Scene) then
                    local SettingManager=require "character.settingmanager"
                    local SystemSetting = SettingManager.GetSettingSystem()
                    local volume = (SystemSetting["MusicEffect"] or 0)
                    m_AudioList=sceneChildList[i].transform:GetComponentsInChildren(AudioSource,true)
                    for i = 1, m_AudioList.Length do
                        local audio=m_AudioList[i]
                        if audio then
                            audio.volume=volume
                        end
                    end
                    return
                end
            end
        end
    end
    m_AudioList=nil
end

local function SetAudioVolumeInScene(value)
    if m_AudioList then
        for i=1,m_AudioList.Length do
            local audio=m_AudioList[i]
            audio.volume=value
        end
    end
end

local function MuteAudioInScene(ismute)
    if m_AudioList then
        for i=1,m_AudioList.Length do
            local audio=m_AudioList[i]
            audio.mute=ismute
        end
    end
end

local function GetFlyHeightCeil()
    return m_SkyHeightCeil
end

local function SetFlyHeightCeil()
    local sceneData = ConfigManager.getConfigData("scene",m_Scene)
    if sceneData then
        m_SkyHeightCeil=sceneData.skyheightceil
    end
end


local function OnLoad(params,sceneName,callBack)
    --printyellow(string.format("[scenemanager:OnLoad] scene [%s] loaded!", m_Scene))
    SetAllAudioInScene()
    local sceneData = ConfigManager.getConfigData("scene",m_Scene)
    if UIManager.isshow("dlgloading") then
        local DlgLoading=require"ui.dlgloading"
        DlgLoading.SetLoadingProgress(1)
    end
    if UIManager.isshow("dlgjoystick") then
        Game.JoyStickManager.singleton:Reset()
    end
    PlayBackgroundMusic(sceneData.backgroundmusicid)

    --NotifySceneLoaded(sceneName)
    GameEvent.evt_notify:trigger("loadscene_end",{m_SceneName = sceneName})

    CameraManager.reset()
    --CharacterManager.Reset()
    SetAmbientColor()
    SetFlyHeightCeil()
    --scene stripping
    scenestripping.UpdateOnSceneLoaded(m_Scene)
    GraphicSettingMgr.OnSceneLoad(m_Scene)

    m_IsLoading = false

    --new prologue logic
    if PrologueManager.NeedPlaySurfixPrologue() then
        local PlotManager = require("plot.plotmanager")
        PlotManager.CutscenePlay("caomiao_1")
    end

    if ShouldPlayMapCutscene() == false then
        m_HideLoading=os.time()
    else
        SceneCutsceneFadeIn()
    end
    
    --new prologue logic
    if PrologueManager.NeedPlaySurfixPrologue() then
        PrologueManager.PlaySurfixVedio()
    end

    if callBack then
        callBack()
    end
end

local function LoadTransitScene(params)
    --SceneManager.Instance.UseSteamedScene=false
    SceneManager.Instance:ChangeMap("transit")
end


local function GetSceneName()
    return Game.SceneMgr.Instance.SceneName
end

local function LoadScene(params,sceneName,callBack)
    SceneManager.Instance:RegisteOnSceneLoadFinish(function(result)
        LoadSkyHeightData()
        if result==true then
            m_LoadTimes=0
            local LoadOver=function() OnLoad(params,sceneName,callBack) end
            local timer=Timer.New(LoadOver,0.5,false)
            timer:Start()
        else
            m_LoadTimes=m_LoadTimes+1
            if (m_LoadTimes>cfg.map.Scene.RELOADTIME) then
                m_LoadTimes=0
                m_IsLoading=false
                CameraManager.reset()
                local login=require"login"
                login.role_logout(login.LogoutType.to_choose_player)
            else
                LoadBySceneName(sceneName)
            end
        end
    end)
    LoadBySceneName(sceneName)
    for _,v in ipairs(params) do
        UIManager.show(v)
    end
    LoadHeightData()
end

local function GetLoadedEctypeMap()
    return LoadedMap
end

local function load(params,sceneName,callBack)
    --printyellow(string.format("[scenemanager:load] start loading scene [%s]!", sceneName))
    UIManager.DestroyAllDlgs()
    if sceneName == GetSceneName() then
        m_IsLoading = false
        if params then
            for _,v in ipairs(params) do
                UIManager.show(v)
            end
        end
        if callBack then
            callBack()
        end
        return
    end

    UIManager.show("dlgloading")
    --NotifyLoadSceneStart(sceneName)
    GameEvent.evt_notify:trigger("loadscene_start",{m_SceneName = sceneName})
    LoadedMap = EctypeManager.IsInEctype()
    m_IsLoading = true
    m_IsClearOldScene = true
    CameraManager.stop()
    AudioMgr.StopBackgroundMusic()
    NoviceGuideManager.BreakLine()
    SceneManager.Instance:RegisteOnSceneLoadFinish(function(result)
        if result==true then
            m_LoadTimes=0
            m_IsClearOldScene = false
            LuaGC()
            LoadScene(params,sceneName,callBack)
        else
            m_LoadTimes=m_LoadTimes+1
            if (m_LoadTimes>cfg.map.Scene.RELOADTIME) then
                m_LoadTimes=0
                m_IsLoading=false
                CameraManager.reset()
                local login=require"login"
                login.role_logout(login.LogoutType.to_choose_player)
            else
               LoadBySceneName(sceneName)
            end
        end
    end)
    local mapId=MapManager.GetMapIdBySceneName(sceneName)
    if mapId then
        PlayerRole.m_MapInfo:SetMapId(mapId)
    end
    LoadTransitScene(params)
end

local function GetLoadingProgress()
    if SceneManager.Instance.AsyncRate then
        if m_IsClearOldScene == true then
            return 0.15
        end
        return 0.15 + SceneManager.Instance.AsyncRate.progress * 0.85
    end
    return 0.9
end


local function init()
    GameEvent.evt_update:add(update)
    GameEvent.evt_late_update:add(late_update)
    EctypeManager = require"ectype.ectypemanager"
    CameraManager = require "cameramanager"
    NoviceGuideManager=require"noviceguide.noviceguidemanager"
    CharacterManager = require "character.charactermanager"
    PlayerRole=(require"character.playerrole"):Instance()
    MapManager = require "map.mapmanager"
    scenestripping   = require"scenestripping"
    GraphicSettingMgr = require"ui.setting.graphicsettingmanager"
    PrologueManager = require"prologue.prologuemanager"
    SceneManager.Instance:RegisteOnSceneLoadFinish(OnLoad)
end

local function GetHeight(pos)
    local height=cfg.map.Scene.HEIGHTMAP_MIN
    if pos and (pos.x) and (pos.z) and (pos.y) then
        if Local.LoadHeightByLua==true then
            if m_Terrian then
                height = m_Terrian:GetHeight(Vector3(pos.x,pos.y,pos.z))
            end
         else
            height = SceneManager.Instance:GetHeight(Vector3(pos.x,pos.y,pos.z))
         end
    end
    if height > cfg.map.Scene.HEIGHTMAP_MAX then
        return cfg.map.Scene.HEIGHTMAP_MAX
    end
    if height < cfg.map.Scene.HEIGHTMAP_MIN then
        return cfg.map.Scene.HEIGHTMAP_MIN
    end
    return height
end

local function HasSkyHeight()
    return m_HasSkyHeight
end

local function GetHeight1(pos)
    if m_Terrian1==nil or m_HasSkyHeight==false then
        return nil
    end
    local height=m_Terrian1:GetHeight(pos)
    if (height<cfg.map.Scene.HEIGHTMAP_MIN) or (height<GetHeight(pos)) then
        height=GetHeight(pos)
    end
    return height
end

local function GetCurrentTerrian(pos)
    local t = GetHeight(pos)
    local t1 = GetHeight1(pos)
    if t<-1e10 then t=nil end
    if t1<-1e10 then t1=nil end
    if not (t or t1) then
        return nil
    elseif not (t and t1) then
        if t and pos.y>=t then   return true
        elseif t1 and pos.y>=t1 then return false
        end
    else
        if  math.abs(t-t1)<1 then return true
        elseif pos.y>=t1 then  return false
        elseif pos.y>=t then return true
        else return nil
        end
    end
end


local function GetLandscapeId()
    local landscapeId=0
    local mapData=ConfigManager.getConfigData("worldmap",PlayerRole:GetMapId())
    if mapData then
        landscapeId=mapData.landscapeid
    end
    return landscapeId
end

local function IsCurMapWarp(id)
    local isCurWarp=false
    local worldMapData=ConfigManager.getConfigData("worldmap",PlayerRole:GetMapId())
    if worldMapData then
        if worldMapData.circleregionsetid==id then
            isCurWarp=true
        end
    end
    return isCurWarp
end

local function IsLoadingScene()
    return m_IsLoading
end

local function GetCurMapId()
    return PlayerRole:GetMapId()
end

local function OnLoginFinish(b)

    CharacterManager.NotifySceneLoginLoaded()
    UIManager.NotifySceneLoginLoaded()
    CameraManager.NotifySceneLoginLoaded()
    local auth = require"auth"
    auth.NotifySceneLoginLoaded()
	local login = require"login"
    login.NotifySceneLoginLoaded()
    if not b then
        network.send(lx.gs.login.CRoleLogout({}))
    end
    -- network.close()
    --Game.Platform.Interface.Instance:Login()
    local sceneInfo = ConfigManager.getConfigData("scene","login")
    AudioMgr.PlayBackgroundMusic(sceneInfo.backgroundmusicid)
    UIManager.show("dlgflytext")
    -- UIManager.show("dlgmonster_hp")
    -- UIManager.show("dlglogin")
    UIManager.show("dlgheadtalking")

    UIManager.hide("dlgloading")

end

local function RegisteOnLoginFinish(b)
    if not b then
        UIManager.show("dlgloading")
        m_IsLoading = false
    end
    SceneManager.Instance:RegisteOnSceneLoadFinish(function(result)
        if result==true then
            local LoadOver=function()
                OnLoginFinish(b)
                -- UIManager.show("dlglogin")
                UIManager.show("dlglogin_reminder")
            end
            local timer=Timer.New(LoadOver,0.5,false)
            timer:Start()
        else
            SceneManager.Instance:ChangeMap("login")
        end
    end)
end

local function LoadLoginScene()
    if GetSceneName() == "login" then
        UIManager.DestroyAllDlgs()
        OnLoginFinish()
        UIManager.show("dlglogin")
    else
        RegisteOnLoginFinish()
        SceneManager.Instance:ChangeMap("login")
    end
end
return {
    init = init,
    load = load,
    GetHeight  = GetHeight,
    GetHeight1 = GetHeight1,
    GetCurrentTerrian = GetCurrentTerrian,
    GetLandscapeId=GetLandscapeId,
    IsCurMapWarp = IsCurMapWarp,
    IsLoadingScene = IsLoadingScene,
    GetCurMapId = GetCurMapId,
    GetSceneName = GetSceneName,
    SetChangeMapCutscene = SetChangeMapCutscene,
    PlayBackgroundMusic = PlayBackgroundMusic,
    SetAudioVolumeInScene = SetAudioVolumeInScene,
    MuteAudioInScene = MuteAudioInScene,
    RegisteOnLoginFinish = RegisteOnLoginFinish,
    LoadLoginScene  = LoadLoginScene,
    GetLoadingProgress = GetLoadingProgress,
    HasSkyHeight = HasSkyHeight,
    GetFlyHeightCeil = GetFlyHeightCeil,
    AlterLoadedEctypeMap = AlterLoadedEctypeMap,
    LoadedEctypeMap = LoadedEctypeMap,
}
