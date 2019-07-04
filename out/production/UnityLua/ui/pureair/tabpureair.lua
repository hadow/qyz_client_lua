local Unpack = unpack
local EventHelper = UIEventListenerHelper
local Format = string.format
local Define = define
local DefineEnum = require("defineenum")
local UIManager = require("uimanager")
local PureAirManager = require("ui.pureair.pureairmanager")
local CheckCmd = require("common.checkcmd")
local ItemManager = require("item.itemmanager")
local Player = require("character.player")
local PlayerRole = require("character.playerrole")
local Pet = require("character.pet.pet")
local PetManager = require("character.pet.petmanager")
local AttributeHelper = require("attribute.attributehelper")

local m_Name
local m_GameObject
local m_Fields
local m_Type
local m_PureAirInfo
local m_Pet
local m_Player

local function update()
    if m_Player and m_Player.m_Object and m_Player.m_Avatar then
        m_Player.m_Avatar:Update()
    end
    if m_Pet and m_Pet.m_Object and m_Pet.m_Avatar then
        m_Pet.m_Avatar:Update()
    end
end

local function show(params)
    m_Type = UIManager.gettabindex("pureair.dlgpureair") - 1
    EventHelper.SetClick(m_Fields.UIButton_Detailed,function()
         UIManager.show( "common.dlgdialogbox_complex", { 
            type = Dlg_Complex_Type.UIGROUP_BILLIONOFWORDS,
            callBackFunc = function(params,fields,gameObject)
                local pos = gameObject.transform.localPosition
                gameObject.transform.localPosition = Vector3(pos.x,pos.y,-2500)
                fields.UILabel_Title.text = LocalString.PureAir_TotalAttr
                fields.UILabel_Content_Single.text = PureAirManager.GetTotalAttr(m_Type)
            end})
    end)
end

local function hide()
end

local function OnPetLoaded()
    if not m_Pet or not m_Pet.m_Object then return end
    local petTrans = m_Pet.m_Object.transform
    petTrans.parent = m_Fields.UITexture_PlayerModel.transform
    m_Pet:SetUIScale(170)
    petTrans.localPosition = Vector3(0, -180, -1500);
    petTrans.localRotation = Vector3.up * 180
    ExtendedGameObject.SetLayerRecursively(m_Pet.m_Object, Define.Layer.LayerUICharacter)
    EventHelper.SetDrag(m_Fields.UITexture_PlayerModel, function(go, delta)
        if m_Pet then
            local vecRotate = Vector3(0, - delta.x, 0)
            m_Pet.m_Object.transform.localEulerAngles = m_Pet.m_Object.transform.localEulerAngles + vecRotate
        end
    end)
end

local function OnPlayerLoaded()
    if not m_Player and not m_Player.m_Object then return end
    local playerTrans = m_Player.m_Object.transform
    playerTrans.parent = m_Fields.UITexture_PlayerModel.transform
    playerTrans.localScale = Vector3.one * 180
    playerTrans.localPosition = Vector3(-5, -200, -300)
    playerTrans.localRotation = Vector3.up * 180
    ExtendedGameObject.SetLayerRecursively(m_Player.m_Object, Define.Layer.LayerUICharacter)
    EventHelper.SetDrag(m_Fields.UITexture_PlayerModel, function(go, delta)        
        if m_Player then
            local vecRotate = Vector3(0, - delta.x, 0)
            m_Player.m_Object.transform.localEulerAngles = m_Player.m_Object.transform.localEulerAngles + vecRotate
        end
    end)
end

local function AddModel()
    if m_Type == lx.gs.pureair.msg.AirDetail.HUMAN_TYPE  then
        if m_Pet then
            m_Pet:release()
            m_Pet = nil
        end
        if m_Player == nil then
            m_Player = Player:new(true)
            m_Player.m_AnimSelectType = cfg.skill.AnimTypeSelectType.UI
            m_Player:RegisterOnLoaded(OnPlayerLoaded)
            m_Player:init(PlayerRole:Instance().m_Id, PlayerRole:Instance().m_Profession, PlayerRole:Instance().m_Gender,false,
            PlayerRole.Instance().m_Dress,PlayerRole.Instance().m_Equips,nil,0.75)
        end
    elseif m_Type == lx.gs.pureair.msg.AirDetail.PET_TYPE then
        if m_Player then
            m_Player:release()
            m_Player = nil
        end
        if m_Pet == nil then 
            local battlePets = PetManager.GetBattlePets()
            if battlePets and battlePets[1] then
                local pet = battlePets[1]
                m_Pet = Pet:new(pet.BagId,pet.ConfigId,0,true)
                m_Pet.m_AnimSelectType = cfg.skill.AnimTypeSelectType.UI
                m_Pet:RegisterOnLoaded(OnPetLoaded)
                m_Pet:init(pet.PetSkin)
            end
        end 
    end
    
end

local function IsMaxLevel()
    return (m_PureAirInfo.normallevl % PureAirManager.LEVELPERIOD == 0) and ((m_PureAirInfo.normallevl / PureAirManager.LEVELPERIOD) == m_PureAirInfo.laylevel)
end

local function IsMaxAwakeLevel()
    return (m_PureAirInfo.awakelevel % PureAirManager.AWAKEPERIOD == 0) and ((m_PureAirInfo.awakelevel / PureAirManager.AWAKEPERIOD) == m_PureAirInfo.laylevel)
end

local function IsMaxStarLevel()
    return (m_PureAirInfo.starlevel % PureAirManager.STARPERIOD == 0) and ((m_PureAirInfo.starlevel / PureAirManager.STARPERIOD) == m_PureAirInfo.laylevel)
end

local function GetDisplayLevel()
    local level
    if IsMaxLevel() then
        level = PureAirManager.LEVELPERIOD
    else
        level = m_PureAirInfo.normallevl % PureAirManager.LEVELPERIOD
    end
    return level
end

local function GetDisplayAwakeLevel()
    local level
    if IsMaxAwakeLevel() then
        level = PureAirManager.AWAKEPERIOD
    else
        level = m_PureAirInfo.awakelevel % PureAirManager.AWAKEPERIOD
    end
    return level
end

local function GetDisplayStarLevel()
    local level
    if IsMaxStarLevel() then 
        level = PureAirManager.STARPERIOD
    else
        level = m_PureAirInfo.starlevel % PureAirManager.STARPERIOD
    end
    return level
end

local function SetPropertyText(uiList,propertyData)
    for _,property in pairs(propertyData) do
        if property.class == "cfg.pureair.Property" then                
            for _,detail in pairs(property.gainability) do
                local UIListItem_LevelProperty = uiList:AddListItem()
                local UILabel = UIListItem_LevelProperty.gameObject.transform:GetComponent("UILabel")
                local attrToText = PureAirManager.GetTextByAttr(detail.propertytype)
                UILabel.text = attrToText .. ": +" .. AttributeHelper.GetAttributeValueString(detail.propertytype,detail.value)            
            end
        elseif property.class == "cfg.pureair.PropertyRate" then                
            local UIListItem_LevelProperty = uiList:AddListItem()
            local UILabel = UIListItem_LevelProperty.gameObject.transform:GetComponent("UILabel")
            local attrToText = PureAirManager.GetTextByAttr(property.gainability)
            UILabel.text = attrToText .. ": +" .. Format("%.1f",(property.rate * 100)) .. "%"    
        end
    end
end

local function RefreshLevelAttr()
    m_Fields.UIList_Leveladd:Clear()
    m_Fields.UILabel_LittleTitle1_Level.text = Format(LocalString.PureAir_CurLevel,GetDisplayLevel())
    local levelAttr = PureAirManager.GetPureAirLevelAttr(m_Type)    
    if (IsMaxLevel()) then
        local UIListItem_LevelProperty = m_Fields.UIList_Leveladd:AddListItem()
        local UILabel = UIListItem_LevelProperty.gameObject.transform:GetComponent("UILabel")
        UILabel.text = LocalString.PureAir_MaxLevel                    
    elseif levelAttr then
        SetPropertyText(m_Fields.UIList_Leveladd,levelAttr.getproperty)
    end
    m_Fields.UIProgressBar_BG.value = m_PureAirInfo.normalluckyvalue / cfg.pureair.LuckyValue.LUCKYMAXVALUE
end

local function RefreshAwakeAttr()
    m_Fields.UILabel_LittleTitle2_Wake.text = Format(LocalString.PureAir_CurAwake,GetDisplayAwakeLevel())
    m_Fields.UIList_Wakeadd:Clear()
    local awakeAttr = PureAirManager.GetPureAirAwakeAttr(m_Type)
    if (IsMaxAwakeLevel()) then
        local UIListItem_LevelProperty = m_Fields.UIList_Wakeadd:AddListItem()
        local UILabel = UIListItem_LevelProperty.gameObject.transform:GetComponent("UILabel")
        UILabel.text = LocalString.PureAir_MaxAwakeLevel
    elseif awakeAttr then
        local awakePropertys = awakeAttr.getproperty
        SetPropertyText(m_Fields.UIList_Wakeadd,awakeAttr.getproperty)
    end
    m_Fields.UIProgressBar_BG2.value = m_PureAirInfo.awakeluckyvalue / cfg.pureair.LuckyValue.LUCKYMAXVALUE
end

local function RefreshStarAttr()
    m_Fields.UILabel_LittleTitle3_Star.text = Format(LocalString.PureAir_CurStar,GetDisplayStarLevel())
    m_Fields.UIList_Staradd:Clear()
    local starAttr = PureAirManager.GetPureAirStarAttr(m_Type)
    if (IsMaxStarLevel()) then
        local UIListItem_LevelProperty = m_Fields.UIList_Staradd:AddListItem()
        local UILabel = UIListItem_LevelProperty.gameObject.transform:GetComponent("UILabel")
        UILabel.text = LocalString.PureAir_MaxStarLevel
    elseif starAttr then
        SetPropertyText(m_Fields.UIList_Staradd,starAttr.getproperty)
    end
end

local function ShowInfo(params)
    AddModel()
    if m_PureAirInfo == nil then return end
    m_Fields.UILabel_Title.text=LocalString.PureAir_Title[m_Type]
    m_Fields.UILabel_ChiLevel.text = Format(LocalString.PureAir_Layer,LocalString.NUMTOCHARACTER[m_PureAirInfo.laylevel]).." "..Format("LV %d",GetDisplayLevel())
    m_Fields.UILabel_WakeLevel.text = Format(LocalString.PureAir_Awake,GetDisplayAwakeLevel())
    local starLevel = GetDisplayStarLevel()
    for i = 1,PureAirManager.STARPERIOD do
        local UIListItem_Star = m_Fields.UIList_Star:GetItemByIndex(i - 1)
        local UISprite_Star = UIListItem_Star.Controls["UISprite_Star"]
        if (starLevel >= i) then
            UISprite_Star.gameObject:SetActive(true)
        else
            UISprite_Star.gameObject:SetActive(false)
        end
    end       
    if (params == nil) or (params and params.type == DefineEnum.PuerAirOperType.LEVEL) then  
        RefreshLevelAttr()
    end
    if params == nil or (params and params.type == DefineEnum.PuerAirOperType.AWAKE) then 
        RefreshAwakeAttr()
    end
    if params == nil or (params and params.type == DefineEnum.PuerAirOperType.STAR) then
        RefreshStarAttr()   
    end
    local levelAttr = PureAirManager.GetPureAirLevelAttr(m_Type)
    if IsMaxLevel() then
        m_Fields.UIButton_LevelUp.isEnabled = false
        m_Fields.UILabel_LevelUp.gameObject:SetActive(false)
    elseif levelAttr then   
        m_Fields.UILabel_LevelUp.gameObject:SetActive(true)
        for _,condition in pairs(levelAttr.cost) do
            m_Fields.UILabel_LevelUp.text = condition.amount      
            if CheckCmd.CheckData({data = condition}) then
                m_Fields.UIButton_LevelUp.isEnabled = true
                EventHelper.SetClick(m_Fields.UIButton_LevelUp,function()
                    PureAirManager.SendCAirLevelUp(m_Type)
                end)
            else
                m_Fields.UIButton_LevelUp.isEnabled = false
            end
            break
        end
    end
    local awakeAttr = PureAirManager.GetPureAirAwakeAttr(m_Type)
    if IsMaxAwakeLevel() then
        m_Fields.UILabel_WakeUp.gameObject:SetActive(false)
        m_Fields.UIButton_WakeUp.isEnabled = false
    elseif awakeAttr then
        m_Fields.UILabel_WakeUp.gameObject:SetActive(true)
        for _,condition in pairs(awakeAttr.cost) do
            m_Fields.UILabel_WakeUp.text = condition.amount     
            if CheckCmd.CheckData({data = condition}) then
                m_Fields.UIButton_WakeUp.isEnabled = true
                EventHelper.SetClick(m_Fields.UIButton_WakeUp,function()
                    PureAirManager.SendCAirAwake(m_Type)
                end)
            else
                m_Fields.UIButton_WakeUp.isEnabled = false
            end
            break
        end
    end
    local layAttr = PureAirManager.GetAirLayInfo(m_Type)
    if layAttr then
        m_Fields.UILabel_NextNeed.text = Format(LocalString.PureAir_BreakNeedRoleLevel,layAttr.rolelvlimit.level)
    else
        m_Fields.UILabel_NextNeed.text = LocalString.PureAir_BreakOver
    end
    if IsMaxStarLevel() then
        m_Fields.UILabel_ClearUp.text = LocalString.PureAir_Breakthrough      
        if layAttr then
            local result = true
            for _,condition in pairs(layAttr.upcost) do
                m_Fields.UILabel_BreakUp.text = condition.amount   
                if CheckCmd.CheckData({data = condition}) ~= true then
                    result = false 
                end                                  
                break
            end
            if result and CheckCmd.CheckData({data = layAttr.rolelvlimit}) and (m_PureAirInfo.normallevl >= layAttr.purelvlimit) and (m_PureAirInfo.awakelevel >= layAttr.awakelimit) and (m_PureAirInfo.starlevel >= layAttr.starlimit) then
                m_Fields.UIButton_BreakUp.isEnabled = true
                EventHelper.SetClick(m_Fields.UIButton_BreakUp,function()
                    PureAirManager.SendCAirEvolve(m_Type)
                end)                    
            else
                m_Fields.UIButton_BreakUp.isEnabled = false
--              UIManager.ShowSingleAlertDlg({content = Format(LocalString.PureAir_BreakNeedRoleLevel,layAttr.rolelvlimit.level)})
            end                         
        else          
            m_Fields.UIButton_BreakUp.isEnabled = false
            m_Fields.UILabel_BreakUp.gameObject:SetActive(false)
        end
    else
        local starAttr = PureAirManager.GetPureAirStarAttr(m_Type)
        m_Fields.UILabel_ClearUp.text = LocalString.PureAir_Star
        local cost = true
        for _,condition in pairs(starAttr.cost) do
            m_Fields.UILabel_BreakUp.text = condition.amount          
            cost = CheckCmd.CheckData({data = condition})
            break
        end               
        if cost then
            m_Fields.UIButton_BreakUp.isEnabled = true       
            EventHelper.SetClick(m_Fields.UIButton_BreakUp,function()                
                PureAirManager.SendCAirStarUp(m_Type)
            end)
        else 
            m_Fields.UIButton_BreakUp.isEnabled = false           
            --UIManager.ShowSingleAlertDlg({content = LocalString.PureAir_StarNeedLevel})
        end                
    end
end

local function refresh(params)
    m_PureAirInfo = PureAirManager.GetPureAirByType(m_Type)
    EventHelper.SetClick(m_Fields.UIButton_WTF,function()
        UIManager.show( "common.dlgdialogbox_complex", { 
            type = Dlg_Complex_Type.UIGROUP_BILLIONOFWORDS,
            callBackFunc = function(params,fields,gameObject)
                local pos = gameObject.transform.localPosition
                gameObject.transform.localPosition = Vector3(pos.x,pos.y,-2500)
                fields.UILabel_Title.text = LocalString.PureAir_Des
                fields.UILabel_Content_Single.text = PureAirManager.GetDes()
            end})
    end)
    ShowInfo(params)
end

local function destroy()
    if m_Pet then
        m_Pet:release()
        m_Pet = nil
    end
    if m_Player then
        m_Player:release()
        m_Player = nil
    end
end

local function init(params)
    m_Name, m_GameObject, m_Fields = Unpack(params)   
end

local function uishowtype()
    return UIShowType.Refresh
end

return {
    init = init,
    show = show,
    hide = hide,
    update = update,
    destroy = destroy,
    refresh = refresh,
    uishowtype = uishowtype,
}
