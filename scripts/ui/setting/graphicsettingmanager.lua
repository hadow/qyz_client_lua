local EventHelper = UIEventListenerHelper
local uimanager = require("uimanager")
local CameraManager  = require "cameramanager"
local ConfigManager = require("cfg.configmanager")
local Utils = require "common.utils"
local defineenum = require "defineenum"
local GrahpicQuality = defineenum.GrahpicQuality
local SettingManager
local DlgFlytext
local CharacterManager
local gameevent


local GraphicSettingName = "GraphicQuality"
local FlyTextSettingName = "ShowFightFlyText"
local NameHPSettingName = "ShowNameHP"
local EffectSelfSettingName = "SkillEffectSelf"
local EffectOtherSettingName = "SkillEffectOther"
local EffectMonsterSettingName = "SkillEffectMonster"

local m_SettingCfg
local m_MainCamera
local m_SceneName

--current quality
local m_CurQuality
local m_SettingSystem

local m_CurCameraClip
local m_SceneStripList
local m_HideEffectList
local m_HideOhterNameHP
local m_HideFlyTextList
local m_HideFightFlyText
local m_LodDistanceMap
local m_FogSettingID

--tmp quality
local m_SavedQuality
local m_SavedSettingSystem
local m_SetTmpCount

------------------------------------------------------------------------
--utils
------------------------------------------------------------------------
local function ClearTmpQuality()
    m_SavedQuality = nil
    m_SavedSettingSystem = nil
    m_SetTmpCount = 0
end

local function Reset()
    --print("[graphicsettingmanager:Reset] Reset graphic settings." .. '\t' .. debug.traceback())
    --current quality
	m_CurQuality = nil
    m_SettingSystem = nil

    m_CurCameraClip = nil
    m_SceneStripList = nil
    m_HideEffectList = nil
    m_HideNameHP = nil
    m_HideFightFlyText = nil
    m_HideFlyTextList = nil
    m_LodDistanceMap = nil
    m_FogSetting = nil
    
    --tmp quality
    ClearTmpQuality()
end

local function Clear()
    Reset()
end

local function NeedOverrideSystemSetting(settingname, isinit, isfirstsetting)
    if settingname then
        --��¼ʱSGetConfigures��ʼ������m_SettingSystem����ֵ��������ֹ���󸲸�
        if true~=isinit or true==isfirstsetting or nil==m_SettingSystem[settingname] or "boolean"~=type(m_SettingSystem[settingname]) then
            return true
        else
            return false
        end
    else
        return false
    end
end

local function OverrideSystemSetting(settingname, value)
    if m_SettingSystem and settingname and nil~=value and "boolean"==type(value) then
        m_SettingSystem[settingname] = value
        --print(string.format("[graphicsettingmanager:OverrideSystemSetting] Set m_SettingSystem[%s] = %s!", settingname, value))     
    else
        print("[graphicsettingmanager:OverrideSystemSetting] parameter invalid:")
        print("[graphicsettingmanager:OverrideSystemSetting] m_SettingSystem:", m_SettingSystem and dump_table(m_SettingSystem) or nil)
        print("[graphicsettingmanager:OverrideSystemSetting] settingname:", settingname)
        print("[graphicsettingmanager:OverrideSystemSetting] value:", value)
        print("[graphicsettingmanager:OverrideSystemSetting] type(value):", value and type(value) or nil)
    end
end

------------------------------------------------------------------------
--CameraClip
------------------------------------------------------------------------
local function SetCameraClip(camerafarclip, isinit, isfirstsetting)
    if nil == m_CurCameraClip or camerafarclip~=m_CurCameraClip then
        if camerafarclip and camerafarclip>0 then
            --CameraManager.SetFarClipPlane(camerafarclip)
            if m_MainCamera then
                m_MainCamera.farClipPlane = camerafarclip     
            end
            m_CurCameraClip = camerafarclip
            --printyellow(string.format("[graphicsettingmanager:SetCameraClip] Set m_CurCameraClip=[%s]!", m_CurCameraClip))        
        end
    end
end

------------------------------------------------------------------------
--SceneStrip
------------------------------------------------------------------------
local function SceneObjcetType2Layer(sceneobjecttype)
    if m_SettingCfg and m_SettingCfg.sceneobjectlayermap then
        return m_SettingCfg.sceneobjectlayermap[sceneobjecttype]
    end
end

local function SceneObjcetTypes2Layers(scenestriplist)
    local striplayerlist
    if scenestriplist and table.getn(scenestriplist) >0 then
        striplayerlist = {}
        for _,sceneobjecttype in ipairs(scenestriplist) do
            local layer = SceneObjcetType2Layer(sceneobjecttype)
            if layer and layer>=0 and layer<=32 then
                table.insert(striplayerlist, layer)            
            end
        end
    end
    return striplayerlist
end

local function GetInitCullingMask()
    local mask = m_MainCamera.cullingMask
    if m_SettingCfg and m_SettingCfg.sceneobjectlayermap then
        for sceneobjecttype, layer in pairs(m_SettingCfg.sceneobjectlayermap) do
            mask = bit.bor(mask, bit.lshift(1,layer))
        end
    end
    return mask
end

local function HideLayers(layers)
    if m_MainCamera then
        local mask = GetInitCullingMask()
        if layers then
            for _,layer in pairs(layers) do
                if layer and layer>=0 then
                    local re = bit.lshift(1,layer)
                    mask = bit.band(mask, bit.bnot(re))
                    --printyellow(string.format("[graphicsettingmanager:HideLayers] hide layer [%s]",layer))                
                end
            end   
        end 
        m_MainCamera.cullingMask = mask
    else
        print("[graphicsettingmanager:HideLayers] m_MainCamera nil! hide layer fail!")       
    end
end

local function SetSceneStrip(scenestriplist, isinit, isfirstsetting)
    if nil==m_SceneStripList or false==Utils.CompareList(m_SceneStripList, scenestriplist) then    
        local striplayerlist = SceneObjcetTypes2Layers(scenestriplist)
        if striplayerlist then
            --printyellow(string.format("[graphicsettingmanager:SetSceneStrip] striplayerlist = %s.",striplayerlist and dump_table(striplayerlist) or nil ))    
        else       
            --printyellow("[graphicsettingmanager:SetSceneStrip] striplayerlist = {}.")   
        end
        HideLayers(striplayerlist)
        m_SceneStripList = scenestriplist
    end
end

------------------------------------------------------------------------
--HideEffect
------------------------------------------------------------------------
local function SetHideEffect(hideeffectlist, isinit, isfirstsetting)
    --update
    local hideEffectSelf = false
    local hideEffectOther = false
    local hideEffectMonster = false
    if hideeffectlist then
        for _,hideeffcttype in ipairs(hideeffectlist) do
            if hideeffcttype == cfg.setting.CharacterEffectType.SELF then
                hideEffectSelf = true
            elseif hideeffcttype == cfg.setting.CharacterEffectType.PLAYER then
	            hideEffectOther = true 
            elseif hideeffcttype == cfg.setting.CharacterEffectType.MONSTER then
	            hideEffectMonster = true      
            end
        end              
    end     
    
    --override setting
    if NeedOverrideSystemSetting(EffectSelfSettingName, isinit, isfirstsetting) then
        OverrideSystemSetting(EffectSelfSettingName, not hideEffectSelf)                   
    end 
    if NeedOverrideSystemSetting(EffectOtherSettingName, isinit, isfirstsetting) then
        OverrideSystemSetting(EffectOtherSettingName, not hideEffectOther)                   
    end 
    if NeedOverrideSystemSetting(EffectMonsterSettingName, isinit, isfirstsetting) then
        OverrideSystemSetting(EffectMonsterSettingName, not hideEffectMonster)               
    end

    --local copy
    if nil==m_HideEffectList or false==Utils.CompareList(m_HideEffectList, hideeffectlist) then  
        --printyellow(string.format("[graphicsettingmanager:SetHideEffect] m_HideEffectList=%s, hideeffectlist=%s.",m_HideEffectList and dump_table(m_HideEffectList) or nil,dump_table(hideeffectlist) ))  
        m_HideEffectList = hideeffectlist
    end
end

------------------------------------------------------------------------
--HideNameHP
------------------------------------------------------------------------
local function IsNameHPHided()
    if m_SettingSystem and nil~=m_SettingSystem[NameHPSettingName] then
        --printyellow(string.format("[graphicsettingmanager:IsNameHPHided] return [%s], m_SettingSystem[NameHPSettingName]=[%s]!", not m_SettingSystem[NameHPSettingName], m_SettingSystem[NameHPSettingName]))
        return not m_SettingSystem[NameHPSettingName] 
    else
        --printyellow(string.format("[graphicsettingmanager:IsFlyTextHided] return [%s], m_HideNameHP=[%s]!", m_HideNameHP, m_HideNameHP))
        return m_HideNameHP
    end
end

local function SetHideNameHP(hideothernamehp, isinit, isfirstsetting)
    --printyellow(string.format("[graphicsettingmanager:SetHideNameHP] m_HideNameHP=[%s], hideothernamehp=[%s]!", m_HideNameHP, hideothernamehp))
    if NeedOverrideSystemSetting(NameHPSettingName, isinit, isfirstsetting) then    
        OverrideSystemSetting(NameHPSettingName, not hideothernamehp)                  
    end

    if nil==m_HideNameHP or (nil~=hideothernamehp and m_HideNameHP ~= hideothernamehp) then
        --printyellow(string.format("[graphicsettingmanager:SetHideNameHP] Set m_HideNameHP=[%s], m_SettingSystem[NameHPSettingName]=[%s]!", hideothernamehp, m_SettingSystem[NameHPSettingName]))                    
        m_HideNameHP = hideothernamehp       
	    CharacterManager.SetHeadInfoActive(not IsNameHPHided()) 
    end
end

------------------------------------------------------------------------
--SetHideFlyText
------------------------------------------------------------------------
local function IsFlyTextHided()
    if m_SettingSystem and nil~=m_SettingSystem[FlyTextSettingName] then
        --printyellow(string.format("[graphicsettingmanager:IsFlyTextHided] return [%s], m_SettingSystem[FlyTextSettingName]=[%s]!", not m_SettingSystem[FlyTextSettingName], m_SettingSystem[FlyTextSettingName]))
        return not m_SettingSystem[FlyTextSettingName] 
    else
        --printyellow(string.format("[graphicsettingmanager:IsFlyTextHided] return [%s], m_HideFightFlyText=[%s]!", m_HideFightFlyText, m_HideFightFlyText))
        return m_HideFightFlyText
    end
end

local function SetHideFlyText(hideflytextlist, isinit, isfirstsetting)--, m_SettingSystem
    --update
    local hideFightFlyText = false
    if hideflytextlist and table.getn(hideflytextlist)>0 then
        for _,hideflytexttype in ipairs(hideflytextlist) do
            if hideflytexttype == cfg.setting.FightFlyTextType.SELF then
                hideFightFlyText = true
            end
        end
    end 

    --override setting
    if NeedOverrideSystemSetting(FlyTextSettingName, isinit, isfirstsetting) then 
        OverrideSystemSetting(FlyTextSettingName, not hideFightFlyText)     
    end     
    
    --local copy
    if hideFightFlyText~=m_HideFightFlyText then 
        m_HideFightFlyText = hideFightFlyText
        --printyellow(string.format("[graphicsettingmanager:SetHideFlyText] Set m_HideFightFlyText=[%s], m_SettingSystem[FlyTextSettingName]=[%s]!", m_HideFightFlyText, m_SettingSystem[FlyTextSettingName]))
	    DlgFlytext.SetEnable(not IsFlyTextHided())
    end
    m_HideFlyTextList = hideflytextlist
end

------------------------------------------------------------------------
--scene lod
------------------------------------------------------------------------
local function PrintCameraLod()
    if m_MainCamera then
        local log = ""  
        for layer=1,m_MainCamera.layerCullDistances.Length do
            log = log..layer.."="..m_MainCamera.layerCullDistances[layer]..","
        end
        --printyellow(string.format("[graphicsettingmanager:PrintCameraLod] m_MainCamera.layerCullDistances = {%s}.",log))    
    end
end

local function SetSceneLod(loddistancemap, isinit, isfirstsetting)
    if m_MainCamera then
        if loddistancemap then  
            --PrintCameraLod()
            local lodsetting = LuaHelper.CreateArrayInstance("System.Single", 32)
            for sceneobjecttype,loddistance in pairs(loddistancemap) do
                local layer = SceneObjcetType2Layer(sceneobjecttype)
                if layer and loddistance then
                    lodsetting[layer+1] = loddistance
                    --printyellow(string.format("[graphicsettingmanager:SetSceneLod] layer[%s]=[%s]!", layer, lodsetting[layer]))
                end
            end
            m_MainCamera.layerCullDistances = lodsetting;
            --PrintCameraLod()
        end

        --printyellow(string.format("[graphicsettingmanager:SetSceneLod] Set m_LodDistanceMap:", loddistancemap and dump_table(loddistancemap) or nil ))
        m_LodDistanceMap = loddistancemap   
    else
        print("[ERROR][graphicsettingmanager:SetSceneLod] m_MainCamera nil!")  
    end
end

------------------------------------------------------------------------
--SetFog
------------------------------------------------------------------------
local function SetLinearFogSetting(linearfogsetting)
    if linearfogsetting then
        --printyellow(string.format("[graphicsettingmanager:SetLinearFogSetting] set LinearFogSetting:%s!",linearfogsetting and dump_table(linearfogsetting) or nil ))
        UnityEngine.RenderSettings.fogStartDistance = linearfogsetting.startdistance
        UnityEngine.RenderSettings.fogEndDistance = linearfogsetting.enddistance
    else
        --printyellow("[graphicsettingmanager:SetLinearFogSetting] set linearfogsetting nil!")
        UnityEngine.RenderSettings.fog = false
    end
end

local function SetFogSetting(fogsetting)
    if fogsetting then
        --printyellow(string.format("[graphicsettingmanager:SetFogSetting] set fogsetting:%s!",fogsetting and dump_table(fogsetting) or nil ))
        UnityEngine.RenderSettings.fog = fogsetting.enable
        --UnityEngine.RenderSettings.fogMode = fogsetting.mode
        --UnityEngine.RenderSettings.fogColor = Color(fogsetting.colorred/255, fogsetting.colorgreen/255, fogsetting.colorblue/255, fogsetting.coloralpha/255) 
        if UnityEngine.RenderSettings.fogMode == UnityEngine.FogMode.Linear then
            UnityEngine.RenderSettings.fogStartDistance = fogsetting.startdistance
            UnityEngine.RenderSettings.fogEndDistance = fogsetting.enddistance
        else
            UnityEngine.RenderSettings.fogDensity = 0.01
        end       
    else
        --printyellow("[graphicsettingmanager:SetFogSetting] set fogsetting nil!")
        UnityEngine.RenderSettings.fog = false
    end
end

local function SetFogEnable(enable)
    --printyellow("SetFogEnable",enable)
    UnityEngine.RenderSettings.fog = enable
end 

local function GetSceneFogSetting(scenename, fogsettingid)
    if scenename and fogsettingid then
        local sceneFogSettings = m_SettingCfg.scenefogsettings[scenename]
        if sceneFogSettings and sceneFogSettings.linearfogsettinglist and fogsettingid>0 and fogsettingid<=table.getn(sceneFogSettings.linearfogsettinglist) then
            --printyellow(string.format("[graphicsettingmanager:GetSceneFogSetting] get scenefogsetting %s for id[%s]!",sceneFogSettings.linearfogsettinglist[fogsettingid] and dump_table(sceneFogSettings.linearfogsettinglist[fogsettingid]) or nil, fogsettingid ))
            return sceneFogSettings.linearfogsettinglist[fogsettingid]
        else
            --printyellow(string.format("[graphicsettingmanager:GetSceneFogSetting] can not find scene[%s] fogsetting for id[%s]!", scenename, fogsettingid ))            
        end
    else
        --printyellow("[graphicsettingmanager:GetSceneFogSetting] scenename or fogsettingid nil!")            
    end
end

local function SetFog(fogsettingid, isinit, isfirstsetting)
    --printyellow(string.format("[graphicsettingmanager:SetFog] SetFog [%s]!", fogsettingid ))
    
    --filter
    if m_SceneName and m_SettingCfg.ignorefogscenes then
        for _,ignorescenename in ipairs(m_SettingCfg.ignorefogscenes) do
            if ignorescenename == m_SceneName then
                SetFogSetting(nil)
                return
            end
        end    
    end
    
    --set fog
    if fogsettingid and fogsettingid>0 then
        local sceneFogSetting = GetSceneFogSetting(m_SceneName, fogsettingid)
        if sceneFogSetting and UnityEngine.RenderSettings.fogMode == UnityEngine.FogMode.Linear then
            SetLinearFogSetting(sceneFogSetting)
        else
            SetFogSetting(m_SettingCfg.defaultfogsettings[fogsettingid])
        end
        m_FogSettingID = fogsettingid
    end
end

local function OnSceneLoad(scenename)
    --printyellow(string.format("[graphicsettingmanager:OnSceneLoad] on scene [%s] loaded!", scenename ))
    m_SceneName = scenename
    if m_FogSettingID then
        SetFog(m_FogSettingID)
    else
        SetFog(nil)
    end
end

------------------------------------------------------------------------
--SetQuality
------------------------------------------------------------------------
local function SliderValue2Quality(value)
    local quality
    if value then
        if value==1 then
            quality = GrahpicQuality.Extreme
        elseif value>0.5 then
            quality = GrahpicQuality.High
        elseif value<0.5 and value>0 then
            quality = GrahpicQuality.Mid
        else
            quality = GrahpicQuality.Low
        end
    end
    return quality
end

local function Quality2SliderValue()
    local value = 0
    if m_CurQuality then
        if m_CurQuality == GrahpicQuality.Extreme then
            value = 1
        elseif m_CurQuality == GrahpicQuality.High then
            value = 0.666
        elseif m_CurQuality == GrahpicQuality.Mid then
            value = 0.333
        else
            value = 0
        end
    end
    --printyellow(string.format("[graphicsettingmanager:Quality2SliderValue] m_CurQuality=[%s], value=[%s]!", m_CurQuality, value))
    return value
end


local function IsTmpQuality()
    if m_SetTmpCount and m_SetTmpCount>0 then
        return true
    else
        return false
    end
end

local function GetDefaultQuality()
    local quality = GrahpicQuality.Mid
    if m_SettingCfg then
        local mem = Game.Platform.Interface.Instance:GetMemInfo()
        mem = mem and mem or 0
        if Application.platform == UnityEngine.RuntimePlatform.Android then
            if mem>=m_SettingCfg.androidmemthreshold[2] then
                quality = GrahpicQuality.High
            elseif mem>=m_SettingCfg.androidmemthreshold[1] then
                quality = GrahpicQuality.Mid
            else
                quality = GrahpicQuality.Low
            end
        elseif Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
            if mem>=m_SettingCfg.iosmemthreshold[2] then
                quality = GrahpicQuality.High
            elseif mem>=m_SettingCfg.iosmemthreshold[1] then
                quality = GrahpicQuality.Mid
            else
                quality = GrahpicQuality.Low
            end
        else
            quality = GrahpicQuality.High
        end     
    end
    print("[graphicsettingmanager:GetDefaultQuality] Game.Platform.Interface.Instance:GetMemInfo() =", Game.Platform.Interface.Instance:GetMemInfo())
    print("[graphicsettingmanager:GetDefaultQuality] default quality =", quality)
    return quality
end

local function SetQuality(quality, isinit, istmp)
    if IsTmpQuality() and true~=istmp then
        --printyellow(string.format("[graphicsettingmanager:SetQuality] Clear Tmp Quality by SetQuality(%s)!", quality))   
        ClearTmpQuality()
    end

    local isfirstsetting = false
    if nil==quality and nil==m_CurQuality then     
        isfirstsetting = true
        quality = GetDefaultQuality()    
    end

    if m_SettingCfg and quality and (nil==m_CurQuality or m_CurQuality~=quality) then
        local graphicSettingCfg = m_SettingCfg.graphicsettings[quality]
        if graphicSettingCfg then
            --printyellow(string.format("[graphicsettingmanager:SetQuality] SetQuality [%s], qualityconfig=[%s]!", quality, graphicSettingCfg and dump_table(graphicSettingCfg) or nil ))

	        --camera
            SetCameraClip(graphicSettingCfg.camerafarclip, isinit, isfirstsetting)
            --strip
            SetSceneStrip(graphicSettingCfg.scenestriplist, isinit, isfirstsetting)
            --effect
            SetHideEffect(graphicSettingCfg.hideeffectlist, isinit, isfirstsetting)
            --namehp
            SetHideNameHP(graphicSettingCfg.hideothernamehp, isinit, isfirstsetting)
            --flytext
            SetHideFlyText(graphicSettingCfg.hideflytextlist, isinit, isfirstsetting)
            --lod
            SetSceneLod(graphicSettingCfg.loddistancemap, isinit, isfirstsetting)
            --fog
            SetFog(graphicSettingCfg.fogsettingid, isinit, isfirstsetting)

            print(string.format("[graphicsettingmanager:SetQuality] SetQuality [%d].",quality))
            m_CurQuality = quality
        else         
            print("[ERROR][graphicsettingmanager:SetQuality] graphicSettingCfg NIL for quality:", quality)   
        end
    end

    --setting
    if m_CurQuality and m_SettingSystem then
        m_SettingSystem[GraphicSettingName] = m_CurQuality
        if true==isfirstsetting then
            print("[graphicsettingmanager:SetQuality] Send CSetConfigure on firstsetting:", m_SettingSystem and dump_table(m_SettingSystem) or nil)  
            SettingManager.SendCSetConfigureSystem()
        end
    else
        print("[graphicsettingmanager:SetQuality] set m_SettingSystem[GraphicSettingName] failed!")
        print("[graphicsettingmanager:SetQuality] m_CurQuality:", m_CurQuality)
        print("[graphicsettingmanager:SetQuality] m_SettingSystem:", m_SettingSystem)
    end
end

local function SetQualityBySlider(value)
    --printyellow(string.format("[graphicsettingmanager:SetQualityBySlider] slider value=[%f].", value)) 
    SetQuality(SliderValue2Quality(value))
end

local function InitSetting(SettingSystem)
    if nil==m_SettingSystem and SettingSystem then
        print("[graphicsettingmanager:InitSetting] init with SettingSystem:", SettingSystem and dump_table(SettingSystem) or nil)
        local quality = SettingSystem[GraphicSettingName]
        m_SettingSystem = SettingSystem
        SetQuality(quality, true)
    end
end

------------------------------------------------------------------------
--tmp quality
------------------------------------------------------------------------
local function SaveSettings()
    --printyellow("[graphicsettingmanager:SaveSettings] Save Settings.")   
    m_SavedQuality = m_CurQuality
    m_SavedSettingSystem = m_SettingSystem and utils.copy_table(m_SettingSystem) or {}
    m_SetTmpCount = 1
end

local function RecoverSettings()
    --printyellow("[graphicsettingmanager:RecoverSettings] Recover Settings.")   
    utils.deep_copy_to(m_SavedSettingSystem, m_SettingSystem)
    CharacterManager.SetHeadInfoActive(not IsNameHPHided())
    DlgFlytext.SetEnable(not IsFlyTextHided())
    
    ClearTmpQuality()
end

local function UseTmpQuality(quality)
    if IsTmpQuality() then
        m_SetTmpCount = m_SetTmpCount+1
        print(string.format("[graphicsettingmanager:UseTmpQuality] Use Tmp Quality for the [%d] Time.", m_SetTmpCount))
        return
    else
        print(string.format("[graphicsettingmanager:UseTmpQuality] Use Tmp Quality [%d] First Time.", GrahpicQuality.Extreme))   
        SaveSettings()
        SetQuality(quality, false, true)
        if (quality == GrahpicQuality.Low) then
            OverrideSystemSetting(EffectSelfSettingName, false)  
            OverrideSystemSetting(FlyTextSettingName, false)
            DlgFlytext.SetEnable(not IsFlyTextHided())
        end
    end
end

local function ResumeQuality()
    if IsTmpQuality() then
        m_SetTmpCount = m_SetTmpCount-1
        print(string.format("[graphicsettingmanager:ResumeQuality] m_SetTmpCount = %d.", m_SetTmpCount))  
        if m_SetTmpCount==0 then
            SetQuality(m_SavedQuality)
            RecoverSettings()    
        end
    else    
        print("[graphicsettingmanager:ResumeQuality] quality Already resumed or Overrided.")   
    end
end

------------------------------------------------------------------------
--Others
------------------------------------------------------------------------
local function OnLogout()
    print("[graphicsettingmanager:OnLogout] clear on logout.")  
    Clear()
end

local function OnNetworkAbort()
    print("[graphicsettingmanager:OnNetworkAbort] clear on NetworkAbort.")  
    --Clear()
end

local function init()
    --print("[graphicsettingmanager:init] init.")  
    --require
    DlgFlytext = require"ui.dlgflytext"
    CharacterManager = require "character.charactermanager"
    gameevent         = require "gameevent"
    SettingManager = require "character.settingmanager"

    --cfg
	m_SettingCfg = ConfigManager.getConfig("settingconfig")
    if nil == m_SettingCfg then
        print("[ERROR][graphicsettingmanager:init] settingconfig NIL!")
    else
        --[[
        printyellow("[graphicsettingmanager:init] print settingconfig:")
        printt(m_SettingCfg.graphicsettings[1])
        printt(m_SettingCfg.graphicsettings[2])
        printt(m_SettingCfg.graphicsettings[3])
        printt(m_SettingCfg.graphicsettings[4])
        printt(m_SettingCfg.sceneobjectlayermap)
        printt(m_SettingCfg.sceneobjectlayermap)
        printt(m_SettingCfg.customfogsettings)
        --]]
    end
    
    --camera
    m_MainCamera = CameraManager.MainCamera() and CameraManager.MainCamera():GetComponent("Camera") or nil
    
	gameevent.evt_system_message:add("logout", OnLogout)
    gameevent.evt_system_message:add("network_abort", OnNetworkAbort)
	Reset()
end

return {
    --init
	init = init,

    --set quality
    InitSetting = InitSetting,
    SetQualityBySlider = SetQualityBySlider,
    
    --tmp setting
    IsTmpQuality = IsTmpQuality,
    UseTmpQuality = UseTmpQuality,
    ResumeQuality = ResumeQuality,

    --setting names
    GraphicSettingName = GraphicSettingName,
    FlyTextSettingName = FlyTextSettingName,
    NameHPSettingName = NameHPSettingName,
    EffectSelfSettingName = EffectSelfSettingName,
    EffectOtherSettingName = EffectOtherSettingName,
    EffectMonsterSettingName = EffectMonsterSettingName,

    --others
    OnSceneLoad = OnSceneLoad,
    Quality2SliderValue = Quality2SliderValue,
    IsFlyTextHided = IsFlyTextHided,
    IsNameHPHided = IsNameHPHided,
    SetFogEnable = SetFogEnable,
}