local unpack = unpack
local print = print
local math = math
local EventHelper = UIEventListenerHelper
local uimanager = require("uimanager")
local network = require("network")
local login = require("login")
local Player = require"character.player"
local ConfigManager = require "cfg.configmanager"
local HumanoidAvatar = require "character.avatar.humanoidavatar"
local CameraManager = require"cameramanager"
local UIList_FactionSelect
local Define = require"define"
local gameObject
local name
local lateSelect,currSelect
local fields
local fractionSelect
local playerModel
local m_player
local needSetParent
local CurrentGender -- true male false female
local selectedFaction
local selectedGender
local IdleTime
local utils = require"common.utils"
-- local canloadnewmodel = false
local standTime
local newFaction
local selectedProfession
local descriptions = {"LoginDescribe_QY","LoginDescribe_TY","LoginDescribe_GW"}
local randomName
local ListItems = {}

local function SetItemsEnable(b)
    for i=1,3 do
        if i ~= selectedProfession then
            ListItems[i].Enable = b
        end
    end
    fields.UIButton_SexSelection.enabled = b
end

local function hide_UIs()
    fields.UIGroup_UIs.gameObject:SetActive(false)
end

local function show_UIs()
    fields.UIGroup_UIs.gameObject:SetActive(true)
    IdleTime = 3.5
end

local function OnModelLoaded(go)
    if not m_player.m_Object then return end
    local playerTrans         = m_player.m_Object.transform
    playerTrans.localScale    = Vector3.one
    playerTrans.position = Vector3(-34.30257, 3.08, 2.775848)
    playerTrans.rotation = Quaternion.Euler(0,23.93724,0)
    m_player:RefreshAvatarObject()
    m_player.m_Avatar:Arm(selectedFaction,HumanoidAvatar.EquipDetailType.CREATEWEAPON)
    if m_player.m_ShadowObject then
        m_player.m_ShadowObject:SetActive(false)
    end
    -- canloadnewmodel = true
    IdleTime = 0
    standTime = 0
    SetItemsEnable(true)
end

local function RefreshModel()
    if m_player and m_player.m_Object then
        m_player:release()
    end
    selectedProfession = newFaction or selectedProfession
    m_player = Player:new(true)
    m_player.m_AnimSelectType = cfg.skill.AnimTypeSelectType.UI
    m_player:RegisterOnLoaded(OnModelLoaded)
    -- newFaction = fields.UIList_FactionSelect:GetSelectedIndex()+1
    fields.UITexture_Describe:SetIconTexture(descriptions[selectedProfession])
    local newGender = CurrentGender and 0 or 1
    selectedFaction,selectedGender = selectedProfession,newGender
    m_player:init(0,selectedFaction,selectedGender,nil,nil,{},true)
    SetItemsEnable(false)
end

local function RefreshGenderBtn()
    fields.UISprite_Man.gameObject:SetActive(not CurrentGender)
    fields.UISprite_Woman.gameObject:SetActive(CurrentGender)
end

local function onmsg_RandomName(msg)
    randomName = msg.name
    fields.UIInput_Name.value = msg.name
end

local function destroy()
  --print(name, "destroy")
end

local function show(params)
    selectedProfession = 1
    CameraManager.CreatLoginAssist()
    CameraManager.stop()
    if not params then
        hide_UIs()
    end
    network.send(lx.gs.login.CRandomName({gender=gender}))
    IdleTime = nil
    -- local item = fields.UIList_FactionSelect:GetItemByIndex(1)
    -- item.Enable = false
end

local function hide()
    if m_player then
        m_player:release()
        m_player = nil
    end
end

local function update()
    if m_player and m_player.m_Object then --and m_player.m_Avatar then
        -- m_player.m_Avatar:Update()
        m_player.m_Avatar:Update()
        if IdleTime then
            -- printyellow("IdleTime",IdleTime)
            IdleTime = IdleTime + Time.deltaTime
            if IdleTime >5 then
                CameraManager.Rotate(0.2,0)
            end
        end
    end
end

local function refresh(params)
    CurrentGender = true
    RefreshGenderBtn()
    RefreshModel()
end
local function SetAnchor(fields)
    uimanager.SetAnchor(fields.UIWidget_TopLeft)
    uimanager.SetAnchor(fields.UIWidget_Bottom)
    uimanager.SetAnchor(fields.UIWidget_BottomRight)
    uimanager.SetAnchor(fields.UIWidget_Left)
    uimanager.SetAnchor(fields.UIWidget_Right)
end

local function init(params)

  name, gameObject, fields = unpack(params)
  SetAnchor(fields)

  for i=1,3 do
      local item = fields.UIList_FactionSelect:GetItemByIndex(i-1)
      ListItems[i] = item
  end
  math.randomseed(os.time())
  fractionSelect = fields.UIList_FactionSelect
  playerModel = fields.UISprite_PlayerModel
  needSetParent = false
  network.add_listener("lx.gs.login.SRandomName",onmsg_RandomName)

  fields.UIList_FactionSelect:SetSelectedIndex(0)
  selectedGender = 1
  selectedFaction = 0

  EventHelper.SetClick(fields.UIButton_Play, function ()
    --   printyellow("play",os.time())
    local rolename          = fields.UILabel_Name.text
    local roleprofession    = selectedProfession
    local gender            = CurrentGender and 0 or 1
	local bLegal,sInfo 		= utils.CheckName(rolename)
	if randomName == fields.UILabel_Name.text or bLegal then
		login.create_role(sInfo,roleprofession,gender)
	else
		uimanager.ShowSingleAlertDlg{content = sInfo}
	end
  end)

  EventHelper.SetClick(fields.UIButton_Random, function ()
    local gender = CurrentGender and 0 or 1
    local re = lx.gs.login.CRandomName({gender=gender})
    network.send(re)
  end)

  EventHelper.SetClick(fields.UIButton_Return, function ()
    local roles = login:get_roles()
    uimanager.hide(name)
    if #roles >0 then
        uimanager.show("dlgchooseplayer",true)
    else
        hide_UIs()
        CameraManager.LoginPush("dlgcreatplayer")
    end
  end)

  EventHelper.SetClick(fields.UIButton_SexSelection,function()
      CurrentGender = not CurrentGender
      local gender = CurrentGender and 0 or 1
    --   network.send(lx.gs.login.CRandomName({gender=gender}))
    --   if canloadnewmodel then
    --       canloadnewmodel = false
          RefreshModel()
          RefreshGenderBtn()
    --   end
  end)

  EventHelper.SetDrag(fields.UISprite_PlayerModel,function(o,delta)
    CameraManager.Rotate(delta.x,delta.y/20)
    IdleTime = 0
  end)

  EventHelper.SetListSelect(fields.UIList_FactionSelect,function(item)
    --   if canloadnewmodel then
          newFaction = item.m_nIndex + 1
        --   canloadnewmodel = false
          RefreshModel()
    --   end
  end)
end


return {
  init = init,
  show = show,
  hide = hide,
  update = update,
  destroy = destroy,
  refresh = refresh,
  show_UIs = show_UIs,
  hide_UIs = hide_UIs,
}
