local unpack, print         = unpack, print
local UIManager             = require("uimanager")
local BonusManager          = require("item.bonusmanager")
local ItemManager           = require("item.itemmanager")
local ConfigManager         = require("cfg.configmanager")
local PlayerRole            = require "character.playerrole"
local ResurgenceBiyaoManager= require "ui.resurgencebiyao.resurgencebiyaomanager"
local BagManager            = require "character.bagmanager"
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
    rebornData = ResurgenceBiyaoManager.getLocalConfig()
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
        local serverData = ResurgenceBiyaoManager.getserverData()
        --local killNum = ExpMonsterManager.GetKillMonsterNum()
        local params   = {}
        params.type    = 1
        params.items   = BonusManager.GetItemsByBonusConfig(rebornData.showdailybonus)
        params.title   = LocalString.Alert_RewardsChanceList
        local text = LocalString.Task_GetReward

        -- if not ExpMonsterManager.isReceived(monsterbonus[i].killnum) then
        --     text = LocalString.Common_Receive
        -- end
        params.buttons =
        {
            { 
                text = text,
                Enable = (serverData.dayState == 0 and serverData.handNum>= rebornData.gradeneedtimes),           
                callBackFunc = function()
                    local message=lx.gs.rebornbiyao.msg.CTakeDailyBonus({activityid = ResurgenceBiyaoManager.getActivityId()})
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
                UIManager.show("resurgencebiyao.dlgalert_delivery",{HeroData = HeroData})
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
                UIManager.show("resurgencebiyao.dlgalert_delivery",{HeroData = HeroData})
            end 
        })  
    end)

    EventHelper.SetClick(fields.UIButton_GetRewards,function()
        local message=lx.gs.rebornbiyao.msg.CTakeFinalBonus({activityid = ResurgenceBiyaoManager.getActivityId()})
        network.send(message) 
    end)

    local message=lx.gs.rebornbiyao.msg.CSyncNPCScore({activityid = ResurgenceBiyaoManager.getActivityId()})
    network.send(message) 
end

local function refresh()

    local serverData = ResurgenceBiyaoManager.getserverData()
    if serverData == nil then
        serverData = {}
    end
    if ResurgenceBiyaoManager.getOpenState() == 1 then
        DisplayGroupByType(0)
    elseif ResurgenceBiyaoManager.getOpenState() == 2 then
        DisplayGroupByType(1)
    end

    local percent
    if serverData.allXFNum + serverData.allDXNum == 0 then
        percent = 0.5
    else
        percent =serverData.allXFNum/(serverData.allXFNum + serverData.allDXNum)
    end

    fields.UIProgressBar_background.value = percent or 0.5
    fields.UILabel_Percent01.text = tostring( math.floor(percent*100)) .. "%"
    fields.UILabel_Percent02.text = tostring(100-math.floor(percent*100)).. "%"
    fields.UILabel_MyDonate.text  = string.format(LocalString.RESURGENCE,serverData.m_XFNum,rebornData.npcmsg1.npcname,serverData.m_DXNum,rebornData.npcmsg2.npcname)
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

    local stringTime = rebornData.opentime.begintime.month .. LocalString.Time.Month .. rebornData.opentime.begintime.day .. LocalString.WeekCapitalForm[7]
    stringTime = stringTime .."-" .. rebornData.opentime.endtime.month .. LocalString.Time.Month .. rebornData.opentime.endtime.day .. LocalString.WeekCapitalForm[7]
    fields.UILabel_LastTime.text = stringTime
    fields.UILabel_itemdes.text = rebornData.itemdecs
    fields.UILabel_DonatePeople.text = rebornData.npcmsg1.talkdecs
    printyellow(rebornData.backgroundpic)
    fields.UITexture_Background:SetIconTexture(rebornData.backgroundpic)
    local itemData = ItemManager.CreateItemBaseById(rebornData.needitem)
    fields.UISprite_Quality.color = colorutil.GetQualityColor(itemData:GetQuality())
    fields.UITexture_Icon:SetIconTexture(itemData:GetIconPath())
    fields.UILabel_title.text = rebornData.name
    fields.UILabel_One.text = rebornData.npcmsg1.givename
    fields.UILabel_Two.text = rebornData.npcmsg2.givename
    fields.UILabel_OneName.text = rebornData.npcmsg1.npcname
    fields.UILabel_TwoName.text = rebornData.npcmsg2.npcname
    EventHelper.SetClick(fields.UIGroup_Property,function()
        local params={item=itemData,buttons={{display=false,text="",callFunc=nil},{display=false,text="",callFunc=nil}}}
        ItemIntroduc.DisplayBriefItem(params)
    end)
    local serverData = ResurgenceBiyaoManager.getserverData()
    local openState = ResurgenceBiyaoManager.getOpenState()
    local winBonus

    fields.UITexture_Xiaofan.gameObject:SetActive(false)
    fields.UITexture_Daoxuan.gameObject:SetActive(false)

    if serverData.allXFNum >= serverData.allDXNum then
        winBonus = rebornData.npcmsg1.winbonus
        fields.UILabel_Discription.text = rebornData.npcmsg1.windecs
    else
        winBonus = rebornData.npcmsg2.winbonus
        fields.UILabel_Discription.text = rebornData.npcmsg2.windecs
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
