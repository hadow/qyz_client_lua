local Unpack = unpack
local EventHelper = UIEventListenerHelper
local Format = string.format
local UIManager =require("uimanager")
local DharmakayaManager = require("ui.dharmakaya.dharmakayamanager")
local PureAirManager = require("ui.pureair.pureairmanager")
local AttributeHelper = require("attribute.attributehelper")

local m_Name
local m_GameObject
local m_Fields
local m_CurBodyId = 0
local m_CurBodyInfo

local function hide()
end

local function destroy()
end

local function ShowTotalAttr()
    m_Fields.UIList_AttributeBG01:Clear()
    if m_CurBodyInfo and m_CurBodyInfo.extraattr then
        for id ,value in pairs(m_CurBodyInfo.extraattr) do
            local listItem = m_Fields.UIList_AttributeBG01:AddListItem()
            local label = listItem.Controls["UILabel_DharmakayaAttr01_Name"]
            label.text = PureAirManager.GetTextByAttr(id) .. ": +" .. AttributeHelper.GetAttributeValueString(id,value)
        end
    end
end

local function ShowBreakAttr()
    m_Fields.UIList_DharmakayaJewelryAttributes2:Clear()
    local propertys = DharmakayaManager.GetBreakProperty(m_CurBodyId)
    if propertys then
        for _,property in pairs(propertys) do
            local listItem = m_Fields.UIList_DharmakayaJewelryAttributes2:AddListItem()
            local label = listItem.Controls["UILabel_DharmakayaAttr_Name"]
            label.text = property
        end
    end
end

local function ShowStateAttr()
    m_Fields.UIList_DharmakayaJewelryAttributes3:Clear()
    local propertys = DharmakayaManager.GetStateProperty(m_CurBodyId)
    if propertys then
        for _,detail in pairs(propertys.gainability) do
            local listItem = m_Fields.UIList_DharmakayaJewelryAttributes3:AddListItem()
            local label = listItem.Controls["UILabel_DharmakayaAttr_Name"]
            label.text = PureAirManager.GetTextByAttr(detail.propertytype) .. ": +" .. AttributeHelper.GetAttributeValueString(detail.propertytype,detail.value)
        end
    end
    if DharmakayaManager.GetNextStateNeedLevel(m_CurBodyId) then
        m_Fields.UILabel_NextStateNeed.text = DharmakayaManager.GetNextStateNeedLevel(m_CurBodyId)
    else
        m_Fields.UILabel_NextStateNeed.text = LocalString.Dharmakaya_MaxState
    end
end

local function ShowAttr()
    ShowTotalAttr()
    ShowBreakAttr()
    ShowStateAttr()
end

local function ShowPoints()
    for i = 0,(DharmakayaManager.ROUNDNUM - 1) do
        local listItem = m_Fields.UIList_SevenRound:GetItemByIndex(i)
        if DharmakayaManager.IsOpenPoint(m_CurBodyId,i) then
            listItem.Controls["UIGroup_Toggle"].gameObject:SetActive(true)
            EventHelper.SetClick(listItem,function()
                UIManager.show("dharmakaya.dlgdharmakayaupdateattribute",{bodyId = m_CurBodyId,pointId = i})
            end)
        else
            listItem.Controls["UIGroup_Toggle"].gameObject:SetActive(false)
            EventHelper.SetClick(listItem,function()
                UIManager.ShowSystemFlyText(Format(LocalString.Dharmakaya_UnLockNeedLevel,DharmakayaManager.GetUnLockNeedLevel(m_CurBodyId,i)))
            end)
        end
    end      
    for i = DharmakayaManager.ROUNDNUM,(DharmakayaManager.ROUNDNUM + DharmakayaManager.PULSENUM - 1) do
        local listItem = m_Fields.UIList_ThreePulse:GetItemByIndex(i - DharmakayaManager.ROUNDNUM)
        if DharmakayaManager.IsOpenPoint(m_CurBodyId,i) then
            local UISprite_Frame = listItem:GetComponent("UISprite")
            UISprite_Frame.spriteName = DharmakayaManager.THREEPULSEFRAMENORMALSPRITE
            local UISprite_Name = listItem.Controls["UISprite_DharmakayaBigClose"]
            UISprite_Name.spriteName = DharmakayaManager.THREEPULSENORMALSPRITE[i - DharmakayaManager.ROUNDNUM]
            EventHelper.SetClick(listItem,function()
                UIManager.show("dharmakaya.dlgdharmakayaupdateattribute",{bodyId = m_CurBodyId,pointId = i})
            end)
        else
            local UISprite_Frame = listItem:GetComponent("UISprite")
            UISprite_Frame.spriteName = DharmakayaManager.THREEPULSEFRAMEGRAYSPRITE
            local UISprite_Name = listItem.Controls["UISprite_DharmakayaBigClose"]
            UISprite_Name.spriteName = DharmakayaManager.THREEPULSEGRAYSPRITE[i - DharmakayaManager.ROUNDNUM]
            EventHelper.SetClick(listItem,function()
                if DharmakayaManager.IsAllRoundToLevel(m_CurBodyId) == false then
                    UIManager.ShowSystemFlyText(Format(LocalString.Dharmakaya_NeedRoundLevel,DharmakayaManager.GetActiveThreePulseLevel()))
                end
            end)
        end
    end      
end

local function show(params)
end

local function refresh()
    m_CurBodyInfo = DharmakayaManager.GetBodyInfoById(m_CurBodyId)
    ShowAttr()
    ShowPoints()
end

local function init(params)
    m_Name, m_GameObject, m_Fields = Unpack(params)
    EventHelper.SetListClick(m_Fields.UIList_RadioBody,function(listItem)
        m_CurBodyId = listItem.Index
        refresh()
    end)
end

return
{
    init = init,
    show = show,
    refresh = refresh,
    hide = hide,
    destroy = destroy,
}