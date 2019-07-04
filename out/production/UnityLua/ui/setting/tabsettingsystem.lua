local unpack = unpack
local EventHelper = UIEventListenerHelper
local SettingManager = require "character.settingmanager"
local SceneManager = require "scenemanager"
local uimanager = require "uimanager"
local PlayerRole = require "character.playerrole"
local AudioManager = require"audiomanager"
local DlgChoosePlayer = require"ui.dlgchooseplayer"
local CameraManager = require"cameramanager"
local SettingSystem = {}
local auth = require"auth"
local Server
local login = require"login"
local network = require"network"
local GraphicSettingMgr = require"ui.setting.graphicsettingmanager"
local DlgFlytext = require"ui.dlgflytext"

local fields
local name
local gameObject

local RangePlayerNum
local RangeMonsterNum
local RangeCameraPosition
local minPlayerNum
local minMonsterNum
local minCameraPosition


local function update()
	--printyellow("update system")
	--printyellow(fields.UISlider_BackgroundMusic.value)
end

local function UpdateToggles(SettingSystem)
	fields.UIList_GridPickup:GetItemByIndex(0).gameObject:GetComponent(UIToggle).value = SettingSystem["SkillEffectOther"]
	fields.UIList_GridPickup:GetItemByIndex(1).gameObject:GetComponent(UIToggle).value = SettingSystem["SkillEffectMonster"]
	fields.UIList_GridPickup:GetItemByIndex(2).gameObject:GetComponent(UIToggle).value = SettingSystem["SkillEffectSelf"]
	fields.UIList_GridPickup:GetItemByIndex(3).gameObject:GetComponent(UIToggle).value = SettingSystem[GraphicSettingMgr.FlyTextSettingName]--not GraphicSettingMgr.IsFlyTextHided()
	fields.UIList_GridPickup:GetItemByIndex(4).gameObject:GetComponent(UIToggle).value = SettingSystem[GraphicSettingMgr.NameHPSettingName]--not GraphicSettingMgr.IsNameHPHided()

    --[[
    printyellow(string.format("[tabsettingsystem:UpdateToggles] set toggle[SkillEffectOther] = %s!", SettingSystem["SkillEffectOther"]))
    printyellow(string.format("[tabsettingsystem:UpdateToggles] set toggle[SkillEffectMonster] = %s!", SettingSystem["SkillEffectMonster"]))
    printyellow(string.format("[tabsettingsystem:UpdateToggles] set toggle[SkillEffectSelf] = %s!", SettingSystem["SkillEffectSelf"]))
    printyellow(string.format("[tabsettingsystem:UpdateToggles] set toggle[ShowFlyText] = %s!", SettingSystem[GraphicSettingMgr.FlyTextSettingName]))
    printyellow(string.format("[tabsettingsystem:UpdateToggles] set toggle[ShowNameHP] = %s!", SettingSystem[GraphicSettingMgr.NameHPSettingName]))
    --]]
end

local function show()


	SettingSystem = SettingManager.GetSettingSystem()
	--printyellow("[tabsettingsystem:show] show !")
	fields.UIButton_ChangePlayer.gameObject:SetActive(false)
	printt(SettingSystem)
	fields.UISlider_People.value					 = (SettingSystem["Player"] - minPlayerNum)/RangePlayerNum
	fields.UISlider_Pet.value						 = (SettingSystem["Monster"] - minMonsterNum)/RangeMonsterNum
	fields.UISlider_Camera.value					 = GraphicSettingMgr.Quality2SliderValue()
	fields.UISlider_BackgroundMusic.value			 = SettingSystem["Music"]
	fields.UISlider_SoundEffect.value				 = SettingSystem["MusicEffect"]
    UpdateToggles(SettingSystem)
end

local function hide()
	SettingSystem["SkillEffectOther"]   = fields.UIList_GridPickup:GetItemByIndex(0).gameObject:GetComponent(UIToggle).value
	SettingSystem["SkillEffectMonster"] = fields.UIList_GridPickup:GetItemByIndex(1).gameObject:GetComponent(UIToggle).value
	SettingSystem["SkillEffectSelf"]    = fields.UIList_GridPickup:GetItemByIndex(2).gameObject:GetComponent(UIToggle).value
	SettingSystem[GraphicSettingMgr.FlyTextSettingName] = fields.UIList_GridPickup:GetItemByIndex(3).gameObject:GetComponent(UIToggle).value
	SettingSystem[GraphicSettingMgr.NameHPSettingName] = fields.UIList_GridPickup:GetItemByIndex(4).gameObject:GetComponent(UIToggle).value
    CharacterManager.SetHeadInfoActive(not GraphicSettingMgr.IsNameHPHided())
    DlgFlytext.SetEnable(not GraphicSettingMgr.IsFlyTextHided())

    --save setting
    if false==GraphicSettingMgr.IsTmpQuality() then
        print("[tabsettingsystem:hide] save settingsystem on hide,", SettingSystem and dump_table(SettingSystem) or nil)
	    SettingManager.SetSettingSystem(SettingSystem)
	    SettingManager.SendCSetConfigureSystem()
    else
        print("[tabsettingsystem:hide] do not save settingsystem for temp setting.")
    end

	SettingManager.SetRedDotSetting(false)
	local DlgDialog = require "ui.dlgdialog"
	if uimanager.isshow("dlgdialog") then
		DlgDialog.SetReturnButtonActive(true)
	end
end

local function DisplayPlayerInfo()
	fields.UITexture_Head:SetIconTexture(PlayerRole:Instance():GetHeadIcon())
	fields.UILabel_PlayerName.text = PlayerRole:Instance().m_Name
	fields.UILabel_PlayerID.text = PlayerRole:Instance().m_Id
    local serverid = network.GetDefaultLogin()
    if(serverid ~= nil and Server[serverid] ~= nil) then
	    fields.UILabel_Server.text = Server[serverid].name
    else
        fields.UILabel_Server.text = ""
    end
end

local function SetScreenPlayer(value)
	fields.UILabel_PeopleAmount.text = math.floor(minPlayerNum + value * RangePlayerNum)
end

local function SetScreenMonster(value)
	fields.UILabel_PetAmount.text = math.floor(minMonsterNum + value * RangeMonsterNum)
end

local function SetBackGroundMusic(value)
	fields.UILabel_Volume.text = math.floor(value * 100)
end

local function SetMusicEffect(value)
	fields.UILabel_Effect.text = math.floor(value * 100 )
end

local function OnQualitySliderChange()
    GraphicSettingMgr.SetQualityBySlider(fields.UISlider_Camera.value, SettingSystem)   --SettingSystem =
	SettingManager.SetSettingSystem(SettingSystem)
    UpdateToggles(SettingSystem)
end

local function ShowAccount(dlgfields)
	dlgfields.UIGroup_Content_Three.gameObject:SetActive(false)
	dlgfields.UIGroup_TextWarp.gameObject:SetActive(false)
	dlgfields.UIGroup_Compare.gameObject:SetActive(false)
	dlgfields.UIGroup_TextWarp2.gameObject:SetActive(false)
	dlgfields.UIGroup_Button_1.gameObject:SetActive(false)
	dlgfields.UIGroup_Button_2.gameObject:SetActive(true)
	dlgfields.UIGroup_Resource.gameObject:SetActive(false)
	dlgfields.UIGroup_Reminder_Full.gameObject:SetActive(true)
	dlgfields.UIGroup_ItemUse.gameObject:SetActive(false)
	dlgfields.UILabel_Content_Single2.gameObject:SetActive(false)
	dlgfields.UILabel_Content_Single3.gameObject:SetActive(false)
	dlgfields.UILabel_Title.text           = LocalString.TipText
	dlgfields.UILabel_Content_Single1.text = LocalString.Setting_ChangeAccount
	dlgfields.UILabel_Return.text          =  LocalString.CancelText
	dlgfields.UILabel_Sure.text            =  LocalString.SureText
	EventHelper.SetClick(dlgfields.UIButton_Return,function ()

		uimanager.hide("common.dlgdialogbox_common")

	end)

	EventHelper.SetClick(dlgfields.UIButton_Sure,function ()
        --Game.Platform.Interface.Instance:Logout()
	    --login.role_logout(login.LogoutType.to_login)
		uimanager.hide("common.dlgdialogbox_common")
		login.logout(login.LogoutType.to_login)
	end)
end

local function ShowPlayer(dlgfields)
    dlgfields.UIGroup_Content_Three.gameObject:SetActive(false)
	dlgfields.UIGroup_TextWarp.gameObject:SetActive(false)
	dlgfields.UIGroup_Compare.gameObject:SetActive(false)
	dlgfields.UIGroup_TextWarp2.gameObject:SetActive(false)
	dlgfields.UIGroup_Button_1.gameObject:SetActive(false)
	dlgfields.UIGroup_Button_2.gameObject:SetActive(true)
	dlgfields.UIGroup_Resource.gameObject:SetActive(false)
	dlgfields.UIGroup_Reminder_Full.gameObject:SetActive(true)
	dlgfields.UIGroup_ItemUse.gameObject:SetActive(false)
	dlgfields.UILabel_Content_Single2.gameObject:SetActive(false)
	dlgfields.UILabel_Content_Single3.gameObject:SetActive(false)
	dlgfields.UILabel_Title.text           = LocalString.TipText
	dlgfields.UILabel_Content_Single1.text = LocalString.Setting_ChangePlayer
	dlgfields.UILabel_Return.text          =  LocalString.CancelText
	dlgfields.UILabel_Sure.text            =  LocalString.SureText
	EventHelper.SetClick(dlgfields.UIButton_Return,function ()
		uimanager.hide("common.dlgdialogbox_common")

	end)

	EventHelper.SetClick(dlgfields.UIButton_Sure,function ()
	    --login.role_logout(login.LogoutType.to_choose_player)
	    login.logout(login.LogoutType.to_choose_player)
		uimanager.hide("common.dlgdialogbox_common")
	end)
end

function init(params)
	name, gameObject, fields = unpack(params)
	Server = GetServerList()
	DisplayPlayerInfo()
	local roleconfig = ConfigManager.getConfig("roleconfig")
	local playeramount = roleconfig.playeramount
	local monsteramount = roleconfig.monsteramount
	local cameraposition = roleconfig.cameraposition
	minPlayerNum 		   = playeramount[2]
	minMonsterNum		   = monsteramount[2]
	minCameraPosition	   = cameraposition[2]
	RangePlayerNum         = playeramount[3] - playeramount[2]
	RangeMonsterNum        = monsteramount[3] - monsteramount[2]
	RangeCameraPosition    = cameraposition[3] - cameraposition[2]

	EventHelper.SetClick(fields.UIButton_CopyName,function()


--		uimanager.ShowSystemFlyText(LocalString.RoleInfo_copynamesuccessed)

	end )

	EventHelper.SetClick(fields.UIButton_CopyID,function()


--		uimanager.ShowSystemFlyText(LocalString.RoleInfo_copyidsuccessed)

	end )

	EventHelper.SetClick(fields.UIButton_ChangeAccount,function()

		uimanager.show("common.dlgdialogbox_common",{callBackFunc = ShowAccount})

	end )

	EventHelper.SetClick(fields.UIButton_ChangePlayer,function()
		uimanager.show("common.dlgdialogbox_common",{callBackFunc = ShowPlayer})
	end )

	EventHelper.SetClick(fields.UIButton_OfficialWebsite,function()
	end )

	EventHelper.SetClick(fields.UIButton_SystemNotice,function()

		uimanager.show("dlgnotice",true)
		local DlgDialog = require "ui.dlgdialog"
		if uimanager.isshow("dlgdialog") then

			DlgDialog.SetReturnButtonActive(false)
			DlgDialog.SetListTabActive(false)
		end


	end )

	EventHelper.SetSliderValueChange(fields.UISlider_BackgroundMusic,function()

		SetBackGroundMusic(fields.UISlider_BackgroundMusic.value)
		AudioManager.SetBackgroundMusicVolume(fields.UISlider_BackgroundMusic.value * 0.5)
		SettingSystem["Music"]  = fields.UISlider_BackgroundMusic.value
		SettingManager.SetSettingSystem(SettingSystem)
	end)


	EventHelper.SetSliderValueChange(fields.UISlider_SoundEffect,function()

		SetMusicEffect(fields.UISlider_SoundEffect.value)
		SceneManager.SetAudioVolumeInScene(fields.UISlider_SoundEffect.value * 0.4)
		SettingSystem["MusicEffect"]  = fields.UISlider_SoundEffect.value
		SettingManager.SetSettingSystem(SettingSystem)
	end)

	EventHelper.SetSliderValueChange(fields.UISlider_People,function() --ͬ����������
		SetScreenPlayer(fields.UISlider_People.value)

		SettingSystem["Player"]       = math.floor(minPlayerNum + fields.UISlider_People.value * RangePlayerNum)
		SettingManager.SetSettingSystem(SettingSystem)
	end)

	EventHelper.SetSliderValueChange(fields.UISlider_Pet,function()  --ͬ����������
		SetScreenMonster(fields.UISlider_Pet.value)
		--CharacterManager.SetMaxVisiableCount(minMonsterNum + fields.UISlider_Pet.value * RangeMonsterNum)
		SettingSystem["Monster"]       = math.floor(minMonsterNum + fields.UISlider_Pet.value * RangeMonsterNum)
		SettingManager.SetSettingSystem(SettingSystem)
	end)

	EventHelper.SetSliderValueChange(fields.UISlider_Camera, OnQualitySliderChange)
end

local function uishowtype()
	return UIShowType.Refresh
end

return {

	init = init,
	show = show,
	hide = hide,
	uishowtype = uishowtype,
	update = update,
}
