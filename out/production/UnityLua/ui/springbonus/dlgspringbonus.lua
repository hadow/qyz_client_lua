local unpack = unpack
local Format = string.format
local EventHelper = UIEventListenerHelper
local UIManager = require("uimanager")
local SpringBonusManager = require("ui.springbonus.springbonusmanager")
local BonusManager = require("item.bonusmanager")

local m_GameObject
local m_Name
local m_Fields
local m_CurSelectedType

local function destroy()
end

local function show(params)
end

local function hide()
end

local function DisplayAllBonus(data)
    m_Fields.UIList_ActivityRewards:Clear()
    for _,bonus in pairs(data.details) do
        local item = m_Fields.UIList_ActivityRewards:AddListItem()
        item.Controls["UILabel_Level"].text = bonus.desc
        local beginTime = bonus.starttime.year.."."..bonus.starttime.month.."."..bonus.starttime.day
        item.Controls["UILabel_Level01"].text = Format(LocalString.SpringBonus_GetBonusTime,beginTime)
        local items = BonusManager.GetMultiBonusItems(bonus.bonus)
        for _,rewardItem in pairs(items) do
            local rewardListItem = item.Controls["UIList_UpgradeRewards"]:AddListItem()
            BonusManager.SetRewardItem(rewardListItem,rewardItem)         
        end    
        local buyedType = SpringBonusManager.BuyedBonusType()
        item.Controls["UIButton_UpgradeReceive"].isEnabled = false
        item.Controls["UILabel_UpgradeReceive"].text = LocalString.SpringBonus_Recieve
        if buyedType ~= 0 then
            if buyedType == m_CurSelectedType then
                if SpringBonusManager.HasRecieved(bonus.id) == false then
                    if SpringBonusManager.CompareDate(bonus.starttime) then
                        item.Controls["UIButton_UpgradeReceive"].isEnabled = true
                        EventHelper.SetClick(item.Controls["UIButton_UpgradeReceive"],function()
                            SpringBonusManager.SendGetBonus(bonus.id)
                        end) 
                    end   
                else
                    item.Controls["UILabel_UpgradeReceive"].text = LocalString.SpringBonus_HasRecieved  
                end
            end   
        end  
    end
end

local function DisplayDetail()
    local buyedType = SpringBonusManager.BuyedBonusType()
    local data = SpringBonusManager.GetData()
    local typeData = SpringBonusManager.GetDataByType(m_CurSelectedType)
    m_Fields.UILabel_Consume.text = typeData.buymoney.amount
    m_Fields.UILabel_Recieve.text = typeData.totalmoney.amount
    m_Fields.UILabel_Limit.text = Format(LocalString.SpringBonus_LimitCondition[m_CurSelectedType])
    local timeRange = data.time.begintime.year.."."..data.time.begintime.month.."."..data.time.begintime.day.."-"..data.time.endtime.year.."."..data.time.endtime.month.."."..data.time.endtime.day
    m_Fields.UILabel_ActivityTime.text = Format(LocalString.SpringBonus_ActivityTime,timeRange)  --活动时间
    m_Fields.UILabel_PresentPriceNum.text = typeData.buymoney.amount   --价格
    if buyedType ~= 0 then
        if buyedType ~= m_CurSelectedType then
            m_Fields.UIButton_Buy.isEnabled = false
            m_Fields.UILabel_Buy.text = LocalString.SpringBonus_Buy
        else
            m_Fields.UIButton_Buy.isEnabled = false
            m_Fields.UILabel_Buy.text = LocalString.SpringBonus_Buyed
        end
    else  --还未购买
        m_Fields.UIButton_Buy.isEnabled = true
        EventHelper.SetClick(m_Fields.UIButton_Buy,function()
            UIManager.ShowAlertDlg({immediate = true,content = LocalString.SpringBonus_IsSureBuy,callBackFunc = function()
                SpringBonusManager.SendBuy(m_CurSelectedType)
            end})
            
        end)    
    end
    DisplayAllBonus(typeData)
end

local function DisplayByType(type)
    m_CurSelectedType = type   
    DisplayDetail()     
end

local function RefreshRedDot()
    local listItem = m_Fields.UIList_TitleSelect:GetItemById(m_CurSelectedType)
    listItem.Controls["UISprite_Warning"].gameObject:SetActive(SpringBonusManager.UnRead())
end

local function refresh(params)
    local buyedType = SpringBonusManager.BuyedBonusType()
    if buyedType ~= 0 then
        DisplayByType(buyedType)
        RefreshRedDot()    
    else
        DisplayByType(cfg.bonus.SPRINTBONUSTYPE.THIRD)
    end
end

local function update()
end

local function init(params)
    m_Name, m_GameObject, m_Fields = unpack(params)  
    m_Fields.UITexture_ActivityBg:SetIconTexture("ICON_Activity_BG47")
    m_Fields.UIList_TitleSelect:Clear()
    local data = SpringBonusManager.GetData()
    if data and data.springbonus then
        local bonusList =  data.springbonus
        for _,bonus in pairs(bonusList) do
            local item = m_Fields.UIList_TitleSelect:AddListItem()
            item.Controls["UILabel_TypeName"].text = bonus.desc1
            item.Id = bonus.id           
        end
        EventHelper.SetListClick(m_Fields.UIList_TitleSelect,function(item)
            if item.Id ~= m_CurSelectedType then
                DisplayByType(item.Id)
            end
        end) 
        local buyedType = SpringBonusManager.BuyedBonusType()
        if buyedType ~= 0 then
            local item = m_Fields.UIList_TitleSelect:GetItemById(buyedType) 
            local UIToggle_Title = item:GetComponent("UIToggle")
            UIToggle_Title.value = true   
        else
            local item = m_Fields.UIList_TitleSelect:GetItemById(cfg.bonus.SPRINTBONUSTYPE.THIRD)
            local UIToggle_Title = item:GetComponent("UIToggle")
            UIToggle_Title.value = true
        end     
    end
end

return {
    init = init,
    show = show,
    hide = hide,
    update = update,
    destroy = destroy,
    refresh = refresh,
}
