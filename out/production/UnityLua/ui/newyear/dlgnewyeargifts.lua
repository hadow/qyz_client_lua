local unpack, print         = unpack, print
local UIManager             = require("uimanager")
local BonusManager          = require("item.bonusmanager")
local ItemManager           = require("item.itemmanager")
local ConfigManager         = require("cfg.configmanager")
local PlayerRole            = require ("character.playerrole")
local NewYearManager        = require ("ui.newyear.newyearmanager")
local BagManager            = require ("character.bagmanager")
local network               = require "network"
local EventHelper           = UIEventListenerHelper
local CheckCmd				= require("common.checkcmd")
local colorutil             = colorutil
local ItemIntroduc          = require("item.itemintroduction")
local ColorUtil = require("common.colorutil")
local fields
local name
local gameObject
local rebornData
-- local inactiveShader = UnityEngine.Shader.Find("Unlit/Transparent Colored Gray")
-- local activeShader = UnityEngine.Shader.Find("Unlit/Transparent Colored")

local DlgType = enum{
    "Donate",
    "Resrugence",
}
local function destroy()
end

local function DisplayGroupByType(mtype)
    fields.UIGroup_Donate.gameObject:SetActive(mtype==DlgType.Donate)
    fields.UIGroup_Resrugence.gameObject:SetActive(mtype==DlgType.Resrugence)
end



local function init(params)
    name, gameObject, fields    = unpack(params)
    --params.type = 2
    rebornData = NewYearManager.getLocalConfig()
    EventHelper.SetClick(fields.UIButton_Close,function()
        UIManager.hide(name)
    end)
    fields.UISprite_Warning.gameObject:SetActive(false)
    EventHelper.SetClick(fields.UIButton_Rule,function()

        UIManager.show("common.dlgdialogbox_complex",{
            type=2,
            callBackFunc = function(params,ofields)
                ofields.UILabel_Content_Single.text = rebornData.desc
        end})
    end)
    EventHelper.SetClick(fields.UIButton_Award,function()
        local serverData = NewYearManager.getserverData()
        local params   = {}
        params.type    = 1
        params.items   = BonusManager.GetItemsByBonusConfig(rebornData.showdailybonus)
        params.title   = LocalString.Alert_RewardsChanceList
        local text = LocalString.Task_GetReward
        params.buttons =
        {
            { 
                text = text,
                Enable = (serverData.dayState == 0 and serverData.handNum>= rebornData.gradeneedtimes),           
                callBackFunc = function()
                    local message=lx.gs.newyeargift.msg.CNewYearTakeDailyBonus()
                    network.send(message)  
                    UIManager.hide("common.dlgdialogbox_reward")  
                end 
            },
        }
        local DlgAlert_ShowRewards = require("ui.dlgalert_showrewards")
        params.callBackFunc = function(p, f) 
            DlgAlert_ShowRewards.init(f)
            DlgAlert_ShowRewards.show(p) 
        end
        UIManager.show("common.dlgdialogbox_reward", params) 
    end)

    EventHelper.SetClick(fields.UIButton_01,function()
        local HeroData = rebornData.npcmsg1
        UIManager.hide(name) 
        PlayerRole:Instance():navigateTo({
            targetPos=Vector3(HeroData.pos.x,0,HeroData.pos.y),
            mapId= HeroData.mapid,
            callback =function ()
                UIManager.show("resurgencebiyao.dlgalert_delivery",{HeroData = HeroData,Type = 2})
            end 
        })
    end)
    EventHelper.SetClick(fields.UIButton_02,function()
        local HeroData = rebornData.npcmsg2
        UIManager.hide(name)
        PlayerRole:Instance():navigateTo({
            targetPos=Vector3(HeroData.pos.x,0,HeroData.pos.y),
            mapId= HeroData.mapid,
            callback =function ()
                UIManager.show("resurgencebiyao.dlgalert_delivery",{HeroData = HeroData,Type = 2})
            end 
        })  
    end)

    EventHelper.SetClick(fields.UIButton_GetRewards,function()
        local message=lx.gs.newyeargift.msg.CNewYearTakeFinalBonus()
        network.send(message) 
    end)
    local message=lx.gs.newyeargift.msg.CNewYearSyncNPCScore()
    network.send(message) 
end

local function refresh()
    local serverData = NewYearManager.getserverData()
    if serverData == nil then
        serverData = {}
    end
    if NewYearManager.getOpenState() == 1 then
        DisplayGroupByType(0)
    elseif NewYearManager.getOpenState() == 2 then
        DisplayGroupByType(1)
    end

    local percent
    if serverData.allPlayerOneNum + serverData.allPlayerTwoNum == 0 then
        percent = 0.5
    else
        percent =serverData.allPlayerOneNum/(serverData.allPlayerOneNum + serverData.allPlayerTwoNum)
    end

    fields.UIProgressBar_background.value = percent or 0.5
    fields.UILabel_Percent01.text = tostring( math.floor(percent*100)) .. "%"
    fields.UILabel_Percent02.text = tostring(100-math.floor(percent*100)).. "%"
    
    if serverData.dayState == 0 and serverData.handNum>= rebornData.gradeneedtimes then
        fields.UISprite_Warning.gameObject:SetActive(true)
    else
        fields.UISprite_Warning.gameObject:SetActive(false)
    end

    fields.UILabel_03.text = tostring(serverData.handNum).."/" .. tostring(rebornData.gradeneedtimes)
    fields.UILabel_itemname.text = string.format(LocalString.HAVEITEMNUM,BagManager.GetItemNumById(rebornData.needitem)) 
    if serverData.finalState == 1 then
        fields.UIButton_GetRewards.isEnabled = false
    end
end

local function update()

end

local function show()
    local stringTime = rebornData.datetime.begintime.month .. LocalString.Time.Month .. rebornData.datetime.begintime.day .. LocalString.WeekCapitalForm[7]
    stringTime = stringTime .."-" .. rebornData.datetime.endtime.month .. LocalString.Time.Month .. rebornData.datetime.endtime.day .. LocalString.WeekCapitalForm[7]
    fields.UILabel_LastTime.text = stringTime
    fields.UILabel_itemdes.text = rebornData.itemdecs

    local itemData = ItemManager.CreateItemBaseById(rebornData.needitem)
    fields.UISprite_Quality.color = colorutil.GetQualityColor(itemData:GetQuality())
    fields.UITexture_Icon:SetIconTexture(itemData:GetIconPath())

    fields.UILabel_Xueqi.text = rebornData.npcmsg1.talkdecs
    fields.UILabel_Biyao.text = rebornData.npcmsg2.talkdecs

    EventHelper.SetClick(fields.UIGroup_Property,function()
        local params={item=itemData,buttons={{display=false,text="",callFunc=nil},{display=false,text="",callFunc=nil}}}
        ItemIntroduc.DisplayBriefItem(params)
    end)

    local serverData = NewYearManager.getserverData()
    local openState = NewYearManager.getOpenState()
    local winBonus
    
    ColorUtil.SetTextureColorGray(fields.UITexture_Xueqi, false)
    ColorUtil.SetTextureColorGray(fields.UITexture_Biyao, false)
    if serverData.allPlayerOneNum >= serverData.allPlayerTwoNum then
        if openState == 2 then
            ColorUtil.SetTextureColorGray(fields.UITexture_Xueqi, false)
            ColorUtil.SetTextureColorGray(fields.UITexture_Biyao, true)
        end
        winBonus = rebornData.npcmsg1.winbonus
    else
        if openState == 2 then
            ColorUtil.SetTextureColorGray(fields.UITexture_Xueqi, true)
            ColorUtil.SetTextureColorGray(fields.UITexture_Biyao, false)
        end
        winBonus = rebornData.npcmsg2.winbonus
    end

    fields.UIList_Rewards:Clear()
    local rewardItems = BonusManager.GetItemsByBonusConfig(winBonus)
    for _, bonusItem in ipairs(rewardItems) do
        local listItem = fields.UIList_Rewards:AddListItem()
        BonusManager.SetRewardItem(listItem, bonusItem)
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
