local unpack, print         = unpack, print
local UIManager             = require("uimanager")
local ItemManager           = require("item.itemmanager")
local ConfigManager         = require("cfg.configmanager")
local ResurgenceBiyaoManager= require "ui.resurgencebiyao.resurgencebiyaomanager"
local NewYearManager        = require "ui.newyear.newyearmanager"

local BagManager            = require "character.bagmanager"
local EventHelper           = UIEventListenerHelper
local CheckCmd				= require("common.checkcmd")
local ColorUtil             = require("common.colorutil")
local LimitManager          = require "limittimemanager"
local network               = require "network"
local HeroData
local fields
local name
local gameObject
local rebornData
local allNum = 50 --總交付上限
local function destroy()
end

local function init(params)
    name, gameObject, fields    = unpack(params)
    
    EventHelper.SetClick(fields.UISprite_Click,function()
        UIManager.hide(name)
    end)
    fields.UILabel_delivery.gameObject:SetActive(false)
end

local function refresh()
    
end

local function update()

end

local function show(params)
    local times = ResurgenceBiyaoManager.getserverData().todayNum
    rebornData = ResurgenceBiyaoManager.getLocalConfig()
    
    HeroData = params.HeroData
    fields.UILabel_Title.text = HeroData.talkdecs
    fields.UITexture_Left.gameObject:SetActive(true)
    fields.UITexture_Left:SetIconTexture(HeroData.npchead)
    fields.UILabel_NPCName.text = HeroData.npcname
    fields.UILabel_delivery.gameObject:SetActive(true)
    
    allNum = rebornData.dailyup.num - times
    if allNum < 0 then
        allNum = 0
    end
    if not params.justTalk then
        local itemData = ItemManager.CreateItemBaseById(rebornData.needitem)
        fields.UISprite_Quality.color = ColorUtil.GetQualityColor(itemData:GetQuality())
        fields.UITexture_Icon:SetIconTexture(itemData:GetIconPath())
        local itemNum = BagManager.GetItemNumById(rebornData.needitem)
        local g_TotalNum
        if itemNum > 0 then
            if itemNum <= allNum then
                g_TotalNum = itemNum
            else
                g_TotalNum = allNum
            end
            fields.UILabel_Amount.text = "1/" .. itemNum
            EventHelper.SetInputValueChange(fields.UIInput_Item_SellNumber,function(input)
                local num = tonumber(input.value)
                if not num then 
                    return 
                end
                if num < 0 then
                    input.value = 1 
                elseif num > g_TotalNum then 
                    input.value = g_TotalNum
                end
                fields.UILabel_Amount.text = input.value .."/" .. itemNum
            end)

            EventHelper.SetClick(fields.UIButton_ItemNum_Minus, function()
                local sellNumber = 0
                sellNumber = tonumber(fields.UIInput_Item_SellNumber.value)
                if not sellNumber then 
                    sellNumber = 1
                end
                if sellNumber > 1 and sellNumber <= g_TotalNum then
                    sellNumber = sellNumber - 1
                else
                    if g_TotalNum == math.huge then
                        sellNumber = 1
                    else
                        sellNumber = g_TotalNum
                    end
                end
                fields.UIInput_Item_SellNumber.value = sellNumber
                fields.UILabel_Amount.text = sellNumber .."/" .. itemNum
            end )

            EventHelper.SetClick(fields.UIButton_ItemNum_Add, function()
                local sellNumber = tonumber(fields.UIInput_Item_SellNumber.value)
                if not sellNumber then 
                    sellNumber = 1
                end
                if sellNumber < g_TotalNum and sellNumber >= 1 then
                    sellNumber = sellNumber + 1
                else
                    sellNumber = 1
                end
                fields.UIInput_Item_SellNumber.value = sellNumber
                fields.UILabel_Amount.text = sellNumber .."/" .. itemNum
            end )
        else
            fields.UIInput_Item_SellNumber.value = 0
            fields.UILabel_Amount.text = "0/0"
        end
        EventHelper.SetClick(fields.UIButton_Delivery,function()
            if tonumber(fields.UIInput_Item_SellNumber.value) > 0 then
                local message =lx.gs.rebornbiyao.msg.CDeliver({activityid = ResurgenceBiyaoManager.getActivityId(),npcindex=HeroData.npcid,num = tonumber(fields.UIInput_Item_SellNumber.value)})
                network.send(message)
                UIManager.hide(name)
            end
        end)
        fields.UILabel_delivery.text =  string.format(LocalString.PAYUPPERLIMIT,times,rebornData.dailyup.num)
    else
        fields.UIButton_Delivery.gameObject:SetActive(false)
        fields.UIButton_ItemNum_Minus.gameObject:SetActive(false)
        fields.UIButton_ItemNum_Add.gameObject:SetActive(false)
        fields.UIInput_Item_SellNumber.gameObject:SetActive(false)
        fields.UIGroup_Property.gameObject:SetActive(false)
        fields.UILabel_delivery.gameObject:SetActive(false)
    end
    
end

local function hide()
end

local function uishowtype()
    return UIShowType.Refresh
end


return{
    show=show,
    hide=hide,
    init=init,
    refresh=refresh,
    uishowtype=uishowtype,
    update=update,
    destroy = destroy,
}
