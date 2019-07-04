local Unpack = unpack
local Format = string.format
local EventHelper = UIEventListenerHelper
local UIManager =require("uimanager")
local ItemManager = require("item.itemmanager")
local DharmakayaManager = require("ui.dharmakaya.dharmakayamanager")
local CheckCmd = require("common.checkcmd")
local AttributeHelper = require("attribute.attributehelper")
local PlayerRole = require("character.playerrole")

local m_Name
local m_GameObject
local m_Fields
local m_BodyId
local m_PointId
local m_Type = 0
local m_SelectedPoint
local m_FirstPointId
local m_SecondPointId

local function GetCurrencyIconById(currencyId)
    local item = ItemManager.CreateItemBaseById(currencyId)
    return item:GetIconName()
end

local function LevelUp(params)
    local levelUpCost,keyUpgradeCost = DharmakayaManager.GetLevelUpCost(m_BodyId,m_PointId)
    local pointInfo = DharmakayaManager.GetPointInfoById(m_BodyId,m_PointId)
    local pointName = DharmakayaManager.GetPointName(m_BodyId,m_PointId)
    m_Fields.UILabel_LevelTitle.text = Format(LocalString.Dharmakaya_TranslateTitle,(pointName .. pointInfo.normallevl))
    m_Fields.UIWidget_LevelUp.gameObject:SetActive(levelUpCost ~= nil)  
    if levelUpCost then
        local i = 1
        for _,condition in pairs(levelUpCost) do
            if (i == 1) then
                m_Fields.UILabel_LevelUp1.text = condition.amount
                m_Fields.UISprite_LevelUp1.spriteName = GetCurrencyIconById(condition.currencytype)
            elseif (i == 2) then
                m_Fields.UILabel_LevelUp2.text = condition.amount
                m_Fields.UISprite_LevelUp2.spriteName = GetCurrencyIconById(condition.currencytype)
            end
            i = i + 1
        end
        EventHelper.SetClick(m_Fields.UIButton_Up,function()
            local result = true
            local itemId
            for _,condition in pairs(levelUpCost) do
                if CheckCmd.CheckData({data = condition}) ~= true then
                    result = false
                    itemId = condition.currencytype
                    break
                end
            end
            if result then
                DharmakayaManager.SendCLevelUp(m_BodyId,m_PointId,lx.gs.magicbody.msg.CLevelUp.ONE_TIME)
            else
                local item = ItemManager.CreateItemBaseById(itemId)
                UIManager.ShowAlertDlg({immediate = true,content = Format(LocalString.Dharmakaya_NotEnoughCurrencyToLevelUp,item:GetName()),
                callBackFunc    = function()
                    ItemManager.GetSource(itemId,UIManager.currentdialogname())
                    UIManager.hide(m_Name)
                end,})              
            end
        end)
    else
        EventHelper.SetClick(m_Fields.UIButton_Up,function()
            UIManager.ShowSystemFlyText(LocalString.Dharmakaya_MaxLevel)
        end)
    end
    if keyUpgradeCost then
        EventHelper.SetClick(m_Fields.UIButton_UpOneTouch,function()
            local result = true
            local itemId
            local PlayerRole = require("character.playerrole")
            for type,value in pairs(keyUpgradeCost) do
                if PlayerRole:Instance():GetCurrency(type) < value then
                    result = false
                    itemId = type
                    break
                end
            end
            if result then
                DharmakayaManager.SendCLevelUp(m_BodyId,m_PointId,lx.gs.magicbody.msg.CLevelUp.TEN_TIME)
            else
                local item = ItemManager.CreateItemBaseById(itemId)
                UIManager.ShowAlertDlg({immediate = true,content = Format(LocalString.Dharmakaya_NotEnoughCurrencyToLevelUp,item:GetName()),
                callBackFunc    = function()
                    ItemManager.GetSource(itemId,UIManager.currentdialogname())
                    UIManager.hide(m_Name)
                end,})
            end
        end)
    else
        EventHelper.SetClick(m_Fields.UIButton_UpOneTouch,function()
            UIManager.ShowSystemFlyText(LocalString.Dharmakaya_MaxLevel)
        end)
    end
    m_Fields.UIList_Attribute:Clear()
    local propertys = DharmakayaManager.GetAllProperty(m_BodyId,m_PointId)
    local nextPropertys = DharmakayaManager.GetNextLevelProperty(m_BodyId,m_PointId)
    if propertys then
        local PureManager = require("ui.pureair.pureairmanager")
        for id,value in pairs(propertys) do
            local listItem = m_Fields.UIList_Attribute:AddListItem()
            listItem.Controls["UILabel_Attribute"].text = PureManager.GetTextByAttr(id) .. ":"
            if nextPropertys[id] then
                listItem.Controls["UILabel_AttributeAmount"].text = AttributeHelper.GetAttributeValueString(id,value) .." +[00FF00]" .. AttributeHelper.GetAttributeValueString(id,nextPropertys[id]).."[-]"
            else
                listItem.Controls["UILabel_AttributeAmount"].text = AttributeHelper.GetAttributeValueString(id,value)
            end
        end
    end
end

local function BreakThrough()
    local pointInfo = DharmakayaManager.GetPointInfoById(m_BodyId,m_PointId)
    local pointName = DharmakayaManager.GetPointName(m_BodyId,m_PointId)
    local breakLevel = pointInfo.breaklevel or 0
    local curExp = pointInfo.curexp or 0
    m_Fields.UILabel_Level.text = Format(LocalString.Dharmakaya_BreakThgoughLevel,(pointName .. pointInfo.normallevl),breakLevel)
    local curBreakLevelInfo = DharmakayaManager.GetBreakInfoByLevel(breakLevel)
    local nextBreakLevelInfo = DharmakayaManager.GetBreakInfoByLevel(breakLevel + 1)
    if nextBreakLevelInfo then
        m_Fields.UIProgressBar_Break.value = curExp / nextBreakLevelInfo.upexp
        m_Fields.UILabel_Progress.text = curExp .. "/" .. nextBreakLevelInfo.upexp
    end
    if curBreakLevelInfo then       
        m_Fields.UILabel_NowTransformationNumber.text = (curBreakLevelInfo.propertyaddrate * 100) .. "%"       
    elseif breakLevel == 0 then        
        m_Fields.UILabel_NowTransformationNumber.text = "0%"
    end
    local canBreak = (nextBreakLevelInfo ~= nil)
    m_Fields.UILabel_Up.gameObject:SetActive(canBreak)
    m_Fields.UILabel_UpOneTouch.gameObject:SetActive(canBreak)
    m_Fields.UIButton_Up.isEnabled = canBreak
    m_Fields.UIButton_UpOneTouch.isEnabled = canBreak
    if canBreak then
        m_Fields.UILabel_NextTransformationNumber.text = (nextBreakLevelInfo.propertyaddrate * 100) .. "%"
        local normalBreakCost = DharmakayaManager.GetNormalBreakCost()
        local highBreakCost = DharmakayaManager.GetHighBreakCost()
        for _,condition in pairs(normalBreakCost.cost) do
            m_Fields.UILabel_Up.text = condition.amount
            local item = ItemManager.CreateItemBaseById(condition.currencytype)
            m_Fields.UISprite_Up.spriteName = item:GetIconName()
            break
        end
        for _,condition in pairs(highBreakCost.cost) do
            m_Fields.UILabel_UpOneTouch.text = condition.amount
            local item = ItemManager.CreateItemBaseById(condition.currencytype)
            m_Fields.UISprite_UpOneTouch.spriteName = item:GetIconName()
            break
        end
        local remainTime,totalTime = DharmakayaManager.GetBreakFreeRemainTime(0)
        m_Fields.UILabel_VIPLevel.text=Format(LocalString.Dharmakaya_VIPLevel,PlayerRole:Instance().m_VipLevel)
        m_Fields.UILabel_VIPFreeTime.text = Format(LocalString.Dharmakaya_VIPFreeTime,remainTime,totalTime)
        EventHelper.SetClick(m_Fields.UIButton_Up,function()
            local result = true
            local itemId
            for _,condition in pairs(normalBreakCost.cost) do
                if CheckCmd.CheckData({data = condition}) ~= true then
                    result = false
                    itemId = condition.currencytype
                    break
                end
            end
            if (DharmakayaManager.GetBreakFreeRemainTime(0) > 0) or result then
                DharmakayaManager.SendCBreakUp(m_BodyId,m_PointId,lx.gs.magicbody.msg.CBreakUp.XUNIBI)
            else
                local item = ItemManager.CreateItemBaseById(itemId)
                UIManager.ShowSystemFlyText(Format(LocalString.Dharmakaya_CanNotBreakNoCurrency,item:GetName()))
            end
        end)
        EventHelper.SetClick(m_Fields.UIButton_UpOneTouch,function()
            local result = true
            local itemId
            for _,condition in pairs(highBreakCost.cost) do
                if CheckCmd.CheckData({data = condition}) ~= true then
                    result = false
                    itemId = condition.currencytype
                    break
                end
            end
            if (DharmakayaManager.GetBreakFreeRemainTime(1) > 0) or result then
                DharmakayaManager.SendCBreakUp(m_BodyId,m_PointId,lx.gs.magicbody.msg.CBreakUp.YUANBAO)
            else
                local item = ItemManager.CreateItemBaseById(itemId)
                UIManager.ShowSystemFlyText(Format(LocalString.Dharmakaya_CanNotBreakNoCurrency,item:GetName()))
            end
        end)
    else
        m_Fields.UILabel_NextTransformationNumber.text = LocalString.Dharmakaya_MaxBreakThgoughLevel        
    end
end

local function Translate()
    local pointInfo = DharmakayaManager.GetPointInfoById(m_BodyId,m_PointId)
    local pointName = DharmakayaManager.GetPointName(m_BodyId,m_PointId)
    m_Fields.UILabel_ChangeNow.text = Format(LocalString.Dharmakaya_TranslateTitle,(pointName .. pointInfo.normallevl))
    m_Fields.UISprite_CurThreePulse.spriteName = DharmakayaManager.THREEPULSENORMALSPRITE[m_PointId - DharmakayaManager.ROUNDNUM]
    for i = DharmakayaManager.ROUNDNUM,(DharmakayaManager.ROUNDNUM + DharmakayaManager.PULSENUM - 1) do
        if i ~= m_PointId then
            m_FirstPointId = i
            m_Fields.UISprite_ChangeOne.spriteName = DharmakayaManager.THREEPULSEFRAMENORMALSPRITE
            m_Fields.UISprite_ChangeNameOne.spriteName = DharmakayaManager.THREEPULSENORMALSPRITE[i - DharmakayaManager.ROUNDNUM]
            EventHelper.SetClick(m_Fields.UISprite_ChangeOne,function()
                m_SelectedPoint = i
                m_Fields.UISprite_ChangeOne.spriteName = DharmakayaManager.THREEPULSEFRAMENORMALSPRITE
                m_Fields.UISprite_ChangeTwo.spriteName = DharmakayaManager.THREEPULSEFRAMEGRAYSPRITE
                m_Fields.UISprite_ChangeNameOne.spriteName = DharmakayaManager.THREEPULSENORMALSPRITE[i - DharmakayaManager.ROUNDNUM]
                m_Fields.UISprite_ChangeNameTwo.spriteName = DharmakayaManager.THREEPULSEGRAYSPRITE[m_SecondPointId - DharmakayaManager.ROUNDNUM]
            end)
        end
    end
    for i = DharmakayaManager.ROUNDNUM,(DharmakayaManager.ROUNDNUM + DharmakayaManager.PULSENUM - 1) do
        if (i ~= m_PointId) and (i ~= m_FirstPointId) then
            m_SecondPointId = i
            m_Fields.UISprite_ChangeTwo.spriteName = DharmakayaManager.THREEPULSEFRAMENORMALSPRITE
            m_Fields.UISprite_ChangeNameTwo.spriteName = DharmakayaManager.THREEPULSENORMALSPRITE[i - DharmakayaManager.ROUNDNUM]
            EventHelper.SetClick(m_Fields.UISprite_ChangeTwo,function()
                m_SelectedPoint = i
                m_Fields.UISprite_ChangeOne.spriteName = DharmakayaManager.THREEPULSEFRAMEGRAYSPRITE
                m_Fields.UISprite_ChangeTwo.spriteName = DharmakayaManager.THREEPULSEFRAMENORMALSPRITE
                m_Fields.UISprite_ChangeNameOne.spriteName = DharmakayaManager.THREEPULSEGRAYSPRITE[m_FirstPointId - DharmakayaManager.ROUNDNUM]
                m_Fields.UISprite_ChangeNameTwo.spriteName = DharmakayaManager.THREEPULSENORMALSPRITE[i - DharmakayaManager.ROUNDNUM]
            end)
        end
    end
    local normalCost = DharmakayaManager.GetNormalTranslateCost()
    m_Fields.UILabel_Up.text = normalCost.amount
    local item1 = ItemManager.CreateItemBaseById(normalCost.currencytype)
    m_Fields.UISprite_Up.spriteName = item1:GetIconName()
    local yuanbaoCost = DharmakayaManager.GetYuanBaoTranslateCost()
    m_Fields.UILabel_UpOneTouch.text = yuanbaoCost.amount
    local item2 = ItemManager.CreateItemBaseById(yuanbaoCost.currencytype)
    m_Fields.UISprite_UpOneTouch.spriteName = item2:GetIconName()
    EventHelper.SetClick(m_Fields.UIButton_Up,function()
        if CheckCmd.CheckData({data = normalCost}) then
            if m_SelectedPoint then
                DharmakayaManager.SendCTranslate(lx.gs.magicbody.msg.CTranslate.NORMAL_TRANS,m_BodyId,m_PointId,m_SelectedPoint)
            else
                UIManager.ShowSystemFlyText(LocalString.Dharmakaya_SelectTargetPulse)
            end
        else
            UIManager.ShowSystemFlyText(Format(LocalString.Dharmakaya_CanNotTranslateNoCurrency,item1:GetName()))
        end
    end)
    EventHelper.SetClick(m_Fields.UIButton_UpOneTouch,function()
        if CheckCmd.CheckData({data = yuanbaoCost}) then
            if m_SelectedPoint then
                DharmakayaManager.SendCTranslate(lx.gs.magicbody.msg.CTranslate.YUANBAO_TRANS,m_BodyId,m_PointId,m_SelectedPoint)
            else
                UIManager.ShowSystemFlyText(LocalString.Dharmakaya_SelectTargetPulse)
            end
        else
            UIManager.ShowSystemFlyText(Format(LocalString.Dharmakaya_CanNotTranslateNoCurrency,item2:GetName()))
        end
    end)
end

local function RefreshDisplayDetail()
    m_Fields.UILabel_Title.text = LocalString.Dharmakaya_Title[m_Type]   
    m_Fields.UISprite_AttributeBackground.gameObject:SetActive(m_Type == 0) 
    m_Fields.UISprite_Break.gameObject:SetActive(m_Type == 1)
    m_Fields.UISprite_Change.gameObject:SetActive(m_Type == 2)
    m_Fields.UILabel_VIPFreeTime.gameObject:SetActive(m_Type == 1)
    m_Fields.UILabel_VIPLevel.gameObject:SetActive(m_Type == 1)
    m_Fields.UILabel_Up.gameObject:SetActive(m_Type ~= 0)    
    m_Fields.UILabel_UpOneTouch.gameObject:SetActive(m_Type ~= 0)
    m_Fields.UIWidget_LevelUp.gameObject:SetActive(m_Type == 0)   
    m_Fields.UILabel_Apply.text = LocalString.Dharmakaya_ApplyText[m_Type]
    m_Fields.UILabel_UpOneTouchFunc.text = LocalString.Dharmakaya_UpOneTouch[m_Type]  
end

local function show(params)
    m_BodyId = params.bodyId
    m_PointId = params.pointId
    if m_PointId < DharmakayaManager.ROUNDNUM then
        m_Fields.UIButton_Translate.gameObject:SetActive(false)
    else
        m_Fields.UIButton_Translate.gameObject:SetActive(true)
    end
end

local function refresh(params)
    RefreshDisplayDetail()
    if m_Type == 0 then
        LevelUp(params)
    elseif m_Type == 1 then
        BreakThrough()
    elseif m_Type == 2 then
        Translate()
    end
end

local function hide()
end

local function destroy()
end

local function init(params)
    m_Name, m_GameObject, m_Fields = Unpack(params)
    EventHelper.SetClick(m_Fields.UIButton_LevelUp,function()
        m_Type = 0
        RefreshDisplayDetail()
        LevelUp()
    end)
    EventHelper.SetClick(m_Fields.UIButton_BreakThrough,function()
        m_Type = 1
        RefreshDisplayDetail()
        BreakThrough()
    end)
    EventHelper.SetClick(m_Fields.UIButton_Translate,function()
        m_Type = 2
        RefreshDisplayDetail()
        Translate()
    end)
    EventHelper.SetClick(m_Fields.UIButton_Close,function()
        UIManager.hide(m_Name)
    end)
end

return 
{
    init = init,
    refresh = refresh,
    show = show,
    hide = hide,
    destroy = destroy,
}