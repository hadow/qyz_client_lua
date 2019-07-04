local unpack, print         = unpack, print
local UIManager             = require("uimanager")
local PersonalBossManager   = require("ui.activity.personalboss.personalboss")
local ItemIntroduction      = require("item.itemintroduction")
local BonusManager          = require("item.bonusmanager")
local Define                = require("define")
local EventHelper           = UIEventListenerHelper
local PersonalBoss          = PersonalBossManager.PersonalBoss
local CheckCmd				= require("common.checkcmd")
local ColorUtil             = require("common.colorutil")

local fields
local name
local gameObject
local personalbossConfig
local CurrentBoss
local CurrentPosX = -1


local function ShowLeftPage(selectedBossIndex, selectedBossInfo)
    if CurrentBoss ~= nil and CurrentBoss.m_Id == selectedBossInfo.m_Id then
        return
    end
    if CurrentBoss ~= nil and CurrentBoss.m_Id ~= selectedBossInfo.m_Id then
        CurrentBoss:release()
        CurrentBoss = nil
    end
    --printyellow("StartLoad")
    CurrentBoss = selectedBossInfo:LoadCharacter(function(boss, obj)
        --printyellow("LoadOver")
        obj.transform.parent = fields.UITexture_Boss.gameObject.transform
        obj:SetActive(true)
        obj.transform.localPosition = Vector3(0,-fields.UITexture_Boss.height*0.5,300)
        obj.transform.rotation = Quaternion.Euler(0,180,0)
        boss:SetUIScale(selectedBossInfo:GetUIScale())
        ExtendedGameObject.SetLayerRecursively(obj, Define.Layer.LayerUICharacter)
        --selectedBossInfo:SetUIPos(obj)
        EventHelper.SetDrag(fields.UITexture_Boss,function(o,delta)
            local vecRotate = Vector3(0,-delta.x,0)
            obj.transform.localEulerAngles = obj.transform.localEulerAngles + vecRotate
        end)
    end)
    
    if selectedBossInfo ~= nil then
        --fields.UILabel_RemainTimes.text = selectedBossInfo:GetRemainTimes()
        local challengeCost  = selectedBossInfo:GetChallengeCost()
        local currencyName   = selectedBossInfo:GetCostCurrencyName()
        local challengeTimes = selectedBossInfo:GetChallengedTimes()
        local allFreeTimes   = selectedBossInfo:GetFreeTimes()
        local totalTime      = selectedBossInfo:GetTotalTimes(PlayerRole:Instance().m_VipLevel)
                
        fields.UILabel_ChallengeCost.text   = ((challengeCost <= 0) and LocalString.PersonalBoss_Free or ( tostring(challengeCost) .. currencyName ))
        fields.UILabel_TimesFree.text       = tostring(allFreeTimes)
        fields.UILabel_TimesVipLevel.text   = tostring(PlayerRole:Instance().m_VipLevel)
        fields.UILabel_TimesEnter.text      = tostring(challengeTimes) .. "/" .. tostring(totalTime)

        fields.UILabel_PersonalBossTalk.text = selectedBossInfo.m_TalkContent
        fields.UILabel_PersonalBossName.text = selectedBossInfo.m_Name
        
        
    end
end

local function ShowRightPage(selectedBossIndex,selectedBossInfo)

    local playerPower = PlayerRole:Instance():GetPower()
    local bossPower = tonumber(selectedBossInfo.m_ReCommendPower)

    local bossPowerStr, playerPowerStr
    if playerPower < bossPower then
        fields.UILabel_PersonalBossRecommendPower.text = tostring(bossPower) --ColorUtil.GetColorStr(ColorUtil.ColorType.Red_Character, tostring(bossPower)) 
        fields.UILabel_PersonalBossPlayerPower.text = ColorUtil.GetColorStr(ColorUtil.ColorType.Red_Character, tostring(playerPower)) 
    else
        fields.UILabel_PersonalBossRecommendPower.text = tostring(bossPower) --ColorUtil.GetColorStr(ColorUtil.ColorType.Green, tostring(bossPower)) 
        fields.UILabel_PersonalBossPlayerPower.text = ColorUtil.GetColorStr(ColorUtil.ColorType.Green, tostring(playerPower)) 
    end
    fields.UILabel_Objective01.text = selectedBossInfo.m_Name
    fields.UILabel_PersonalBossIntroduction.text = selectedBossInfo.m_Introduction
    local rewardsList = selectedBossInfo:GetRewards()
    local rewardsNum = #rewardsList

    UIHelper.ResetItemNumberOfUIList(fields.UIList_PersonalBossRewards,rewardsNum)

    for i =1,rewardsNum do
        local reward = rewardsList[i]
        local item = fields.UIList_PersonalBossRewards:GetItemByIndex(i-1)
        BonusManager.SetRewardItem(item,rewardsList[i],{notShowAmount = true})
    end

    local isMatchCondition = PersonalBossManager.IsMatchBossCondition(selectedBossInfo)

    if isMatchCondition then
        fields.UIButton_PersonalBossChallenge.isEnabled = true
    else
        fields.UIButton_PersonalBossChallenge.isEnabled = false
    end

    EventHelper.SetClick(fields.UIButton_PersonalBossChallenge,function()
        local costCount = selectedBossInfo:GetChallengeCost()
        local costName  = selectedBossInfo:GetCostCurrencyName()
        if costCount <= 0 then
            PersonalBossManager.BeginChallengeBoss(selectedBossInfo)
        else
            UIManager.ShowAlertDlg({
                immediate       = true,
                content         = string.format(LocalString.PersonalBoss_CostMoney[1], costCount, costName),
                callBackFunc    = function()
                    PersonalBossManager.BeginChallengeBoss(selectedBossInfo)
                end,
            })
        end
    end)

end

local function ShowBottomPage(selectedBossIndex)

    local bossNum = (PersonalBossManager.GetBossCount()) or 0
    UIHelper.ResetItemNumberOfUIList(fields.UIList_Boss,bossNum)

    local lastBossIndex = 0
    local scrollX = 0
    for i = 1,bossNum do
        local boss = PersonalBoss.BossList[i]
        
        local isCurrentLvRegion = PersonalBossManager.IsCurrenctLevelRegion(boss) 
        
        if isCurrentLvRegion then
           -- printyellow("lastBossIndex: ",i,isCurrentLvRegion)
            lastBossIndex = i

            local item = fields.UIList_Boss:GetItemByIndex(i-1)
            if item then
                if lastBossIndex > bossNum - 5 then
                    lastBossIndex = bossNum - 5
                end
                scrollX = -lastBossIndex * fields.UIList_Boss.CellSize.x
            end
            break
        end
    end

    if CurrentPosX < 0 then
       -- printyellow("|||||",lastBossIndex,scrollX)
        local sp = fields.UIList_Boss.transform.parent.gameObject:GetComponent("SpringPanel")
        if sp then
         --   printyellow("SpringPanel")
            sp.target = Vector3(scrollX ,sp.transform.localPosition.y,sp.transform.localPosition.z )
        end
        fields.UIList_Boss:RecenterOnListItem(lastBossIndex)
        CurrentPosX = lastBossIndex
    end

    for i = 1,bossNum do
        local boss = PersonalBoss.BossList[i]
        local item = fields.UIList_Boss:GetItemByIndex(i-1)
        --local UIButton_Boss = item.Controls["UIButton_Boss"]
        local UITexture_Boss = item.Controls["UITexture_Boss"]

    --local UISprite_Done = item.Controls["UISprite_Done"]
    --local UISprite_Not = item.Controls["UISprite_Not"]

        local UISprite_Complete = item.Controls["UISprite_Complete"]
        local UISprite_UnChalleng = item.Controls["UISprite_UnChalleng"]
        local UISprite_Lock = item.Controls["UISprite_Lock"]
        local UISprite_Select = item.Controls["UISprite_Select"]
        local UISprite_Warning = item.Controls["UISprite_Warning"]

        local isMatchCondition = PersonalBossManager.IsMatchBossCondition(boss)
        local isCurrentLvRegion = PersonalBossManager.IsCurrenctLevelRegion(boss)
     --   printyellow("==============",isMatchCondition,boss.m_AllowIcon,boss.m_ForbidIcon)
        if isMatchCondition == true then
            if boss.m_AllowIcon ~= nil then
                UITexture_Boss:SetIconTexture(boss.m_AllowIcon)
                ColorUtil.SetTextureColorGray(UITexture_Boss, false)
            end
            UISprite_Lock.gameObject:SetActive(false)
            if boss:CanChanllenge() == true and isCurrentLvRegion then
                UISprite_Warning.gameObject:SetActive(true)
            else
                UISprite_Warning.gameObject:SetActive(false)
            end
        else
            if boss.m_ForbidIcon ~= nil then
                UITexture_Boss:SetIconTexture(boss.m_ForbidIcon)
                ColorUtil.SetTextureColorGray(UITexture_Boss, true)
            end
            UISprite_Lock.gameObject:SetActive(true)
            UISprite_Warning.gameObject:SetActive(false)
        end
        
        local allowCount = boss:GetRemainTimes()
        if isMatchCondition == true then
            if allowCount > 0 then
                UISprite_Complete.gameObject:SetActive(false)
                if boss.m_CombatedTimes == 0 then
                    UISprite_UnChalleng.gameObject:SetActive(true)
                else
                    UISprite_UnChalleng.gameObject:SetActive(false)
                end
            else
                UISprite_Complete.gameObject:SetActive(true)
                UISprite_UnChalleng.gameObject:SetActive(false)
            end
        else
            UISprite_Complete.gameObject:SetActive(false)
            UISprite_UnChalleng.gameObject:SetActive(false)
        end
        
        if PersonalBoss.ChooseState.CurrentChooseIndex == i then
            UISprite_Select.gameObject:SetActive(true)
        else
            UISprite_Select.gameObject:SetActive(false)
        end

        
        EventHelper.SetClick(item,function()
            if PersonalBossManager.IsMatchBossCondition(boss) then

                PersonalBoss.ChooseState.CurrentChooseIndex = i
                UIManager.refresh(name)
            else
                PersonalBoss.ChooseState.CurrentChooseIndex = i
                UIManager.refresh(name)
                if boss.m_LimitCondition.Level > PlayerRole:Instance().m_Level then
                    local lvlContent = string.format(LocalString.PersonalBoss_OpenLevel, boss.m_LimitCondition.Level)
                    UIManager.ShowSystemFlyText(lvlContent)
                else
                    if Local.HideVip == false then
                        if boss.m_LimitCondition.VipLevel > PlayerRole:Instance().m_VipLevel then
                            local vipContent = string.format(LocalString.PersonalBoss_OpenVipLevel, boss.m_LimitCondition.VipLevel)
                            UIManager.ShowSystemFlyText(vipContent)
                        end
                    end
                end
            end

        end)
--[[
            else

                local levelStr = (((boss.m_LimitCondition.Level > PlayerRole:Instance().m_Level) and
                                    LocalString.PersonalBoss_ConditionUnFinish) or
                                    LocalString.PersonalBoss_ConditionFinished)
                local vipStr = (((boss.m_LimitCondition.VipLevel > PlayerRole:Instance().m_VipLevel) and
                                    LocalString.PersonalBoss_ConditionUnFinish) or
                                    LocalString.PersonalBoss_ConditionFinished)

                local taskStr = ""
                if boss.m_TaskId and boss.m_TaskId > 0 then
                    taskStr = boss.m_TaskDescribe .. (((CheckCmd.CheckCompleteTask({taskid = bossInfo.m_TaskId},{})) and 
                                                        LocalString.PersonalBoss_ConditionFinished) or 
                                                        LocalString.PersonalBoss_ConditionUnFinish)
                end
                local alertText
                if Local.HideVip == true then
                    alertText = string.format(LocalString.PersonalBoss_AlertContent2, 
                                              boss.m_Name,
                                              tostring(boss.m_LimitCondition.Level) .. levelStr
                                              ) .. "\n" .. taskStr
                else
                    alertText = string.format(LocalString.PersonalBoss_AlertContent, 
                                              boss.m_Name,
                                              tostring(boss.m_LimitCondition.Level) .. levelStr,
                                              tostring(boss.m_LimitCondition.VipLevel) .. vipStr ) .. "\n" .. taskStr
                end
                UIManager.ShowAlertDlg({immediate=true,title = LocalString.PersonalBoss_AlertTitle, content = alertText})
            end
        ]]
    end
end



local function init(params)
    --printyellow("Personal Boss initing ")
    name, gameObject, fields    = unpack(params)
    EventHelper.SetClick(fields.UIButton_PersonalBossArrowsLeft, function()
        --printyellow("UIButton_PersonalBossArrowsLeft")
        fields.UIScrollView_BOSS.currentMomentum = fields.UIScrollView_BOSS.currentMomentum + Vector3(0.1,0,0)
    end)

     EventHelper.SetClick(fields.UIButton_PersonalBossArrowsRight, function()
    --printyellow("UIButton_PersonalBossArrowsRight")
        fields.UIScrollView_BOSS.currentMomentum = fields.UIScrollView_BOSS.currentMomentum - Vector3(0.1,0,0)
    end)
    PersonalBossManager.init()
end

local function refresh()
    --printyellow("pb refresh")
    if PersonalBoss.ChooseState.CurrentChooseIndex == nil then
        return
    end
    local selectedBossInfo = PersonalBoss.BossList[PersonalBoss.ChooseState.CurrentChooseIndex]

    if selectedBossInfo == nil then
        return
    end
    ShowLeftPage(PersonalBoss.ChooseState.CurrentChooseIndex,selectedBossInfo)
    ShowRightPage(PersonalBoss.ChooseState.CurrentChooseIndex,selectedBossInfo)
    ShowBottomPage(PersonalBoss.ChooseState.CurrentChooseIndex,selectedBossInfo)
end

local showedTime = 0
local delayTime = 0

local function update()
    if CurrentBoss and CurrentBoss.m_Object then
        CurrentBoss.m_Avatar:Update()--:update()
    end
    showedTime = showedTime + Time.deltaTime
    if fields.UISprite_Pop.gameObject.activeSelf == true then
        if showedTime > (cfg.ectype.PersonalBoss.TALK_LAST + delayTime) then
            fields.UISprite_Pop.gameObject:SetActive(false)
            showedTime = 0
            delayTime = 0
            if cfg.ectype.PersonalBoss.ENDOFFTIME > 0 then
                delayTime = math.random(cfg.ectype.PersonalBoss.ENDOFFTIME)
            end
        end
    else
        if showedTime > (cfg.ectype.PersonalBoss.TALK_INTERVAL + delayTime) then
            fields.UISprite_Pop.gameObject:SetActive(true)
            showedTime = 0
            delayTime = 0
            if cfg.ectype.PersonalBoss.ENDOFFTIME > 0 then
                delayTime = math.random(cfg.ectype.PersonalBoss.ENDOFFTIME)
            end
        end
    end
end
local function show()
    --printyellow("pb show")
end
local function hide()
    if CurrentBoss then
        CurrentBoss:release()
        CurrentBoss = nil
    end
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
}
