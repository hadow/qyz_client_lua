local unpack, print     = unpack, print
local UIManager 	    = require("uimanager")
local EventHelper 	    = UIEventListenerHelper
local ConfigManager     = require("cfg.configmanager")
local HeroBookManager   = require("ui.activity.herobook.herobookmanager")
local BonusManager      = require("item.bonusmanager")
local ItemIntroduction  = require("item.itemintroduction")
local ItemManager       = require("item.itemmanager")
local ColorUtil         = require("common.colorutil")
local Define            = require("define")


local name, gameObject, fields

local currentMonster = nil


local function ShowPetDisplayArea(group)
    local heroEctype = group:GetCurrentHeroEctype()
    local bossId = heroEctype:GetBossId()
    
    if currentMonster and currentMonster.m_CsvId ~= bossId then
        currentMonster:remove()
        currentMonster = nil  
    end
    if currentMonster == nil then
    
        currentMonster = heroEctype:LoadCharacter(function(monster, obj)
            --monster:UIScaleModify()
            obj.transform.parent = fields.UITexture_Partner.gameObject.transform
            obj:SetActive(true)
            ExtendedGameObject.SetLayerRecursively(obj, Define.Layer.LayerUICharacter)
            obj.transform.localPosition = Vector3(0,-fields.UITexture_Partner.height*0.5,0)
            obj.transform.rotation = Quaternion.Euler(0,180,0)
            monster:SetUIScale(heroEctype:GetUIScale())
            --local ratio = fields.UITexture_Partner.height * heroEctype:GetUIScale()
            
            --obj.transform.localScale = Vector3(ratio, ratio, ratio)
            
            
            EventHelper.SetDrag(fields.UITexture_Partner,function(o,delta)
                local vecRotate = Vector3(0,-delta.x,0)
                obj.transform.localEulerAngles = obj.transform.localEulerAngles + vecRotate
            end)
        end)
        
        local oldPos = fields.UISprite_BG.gameObject.transform.localPosition
        fields.UISprite_BG.gameObject.transform.localPosition = Vector3(oldPos.x,oldPos.y,600)
               
    end
    
    if group:IsMatchLevel() then
        fields.UILabel_GroupName.text = group:GetGroupName()    
    else
        fields.UILabel_GroupName.text = group:GetGroupName() .. string.format( LocalString.HeroBook.OpenLevel, group:GetOpenLevel() )
    end

 --   fields.UILabel_PartnerName.text = ColorUtil.GetQualityColorText(heroEctype:GetQualityColor(),heroEctype:GetName())
  --  fields.UILabel_PartnerName.effectColor = ColorUtil.GetOutlineColor(heroEctype:GetQualityColor())
    ColorUtil.SetQualityColorText(fields.UILabel_PartnerName, heroEctype:GetQualityColor(), heroEctype:GetName())
    --effectColor
end

local function ShowPetItem(pet, uiItem)
    --BonusManager.SetRewardItem(uiItem,petItem,{notShowAmount=true})
    --pets[i] = {m_Id = petid, m_Icon = icon, qualityColor = qcolor}
    local texture = uiItem.Controls["UITexture_Icon"]
    local qualitySprite = uiItem.Controls["UISprite_Quality"]
    texture:SetIconTexture(pet.m_Icon)
    --printyellow("pet.m_QualityColor", pet.m_QualityColor)
    local qualityColor = colorutil.GetQualityColor(pet.m_QualityColor)
    qualitySprite.color = qualityColor
end


local function ShowPetGroupArea(group)
    local heroEctype = group:GetCurrentHeroEctype()
    local pets = group:GetPets()
    
    fields.UIList_PartnerlBag:Clear()
    --UIHelper.ResetItemNumberOfUIList(fields.UIList_PartnerlBag,#pets)
    --fields.UIList_PartnerlBag:Reposition()
    for i = 1, #pets do
        local uiItem = fields.UIList_PartnerlBag:AddListItem()
        --:GetItemByIndex(i-1)
        local pet = pets[i]
        ShowPetItem(pet, uiItem)
        
    end

    local refreshTimes = group:GetFreeRefreshTimes()
    if refreshTimes > 0 then
        fields.UIGroup_RepickFree.gameObject:SetActive(true)
        fields.UIGroup_RepickCharge.gameObject:SetActive(false)
        fields.UILabel_FreeTime.text = tostring(refreshTimes)
    else
        fields.UIGroup_RepickFree.gameObject:SetActive(false)
        fields.UIGroup_RepickCharge.gameObject:SetActive(true)
        fields.UILabel_FreeTime.text = ""
        fields.UILabel_Cost.text = group:GetChangeCost()
    end
    
    if group:IsMatchLevel() then
        fields.UIButton_Repick.isEnabled = true
        EventHelper.SetClick(fields.UIButton_Repick, function()
            local freeTimes = group:GetFreeRefreshTimes()
            if freeTimes > 0 then
                HeroBookManager.HeroChangeEctype(group:GetId())
            else
                local costMoney = group:GetChangeCost()
                UIManager.ShowAlertDlg({
                    immediate    = true,
                    content      = string.format(LocalString.HeroBook.Refresh_CostMoney, tostring(costMoney)),
                    callBackFunc = function()
                        HeroBookManager.HeroChangeEctype(group:GetId())
                    end,
                })
            end
        end)
    else
        fields.UIButton_Repick.isEnabled = false
    end
end

local function ShowChallengeInfo(group)
    local challengedTimes, totalTimes = group:GetChallengeTimesInfo()

    local timesStr = string.format( "%s/%s", tostring(totalTimes - challengedTimes), tostring(totalTimes))
    if totalTimes - challengedTimes > 0 then
        fields.UILabel_TimeCount.text = ColorUtil.GetColorStr(ColorUtil.ColorType.Green, timesStr)
    else
        fields.UILabel_TimeCount.text = ColorUtil.GetColorStr(ColorUtil.ColorType.Red_Item, timesStr)
    end
    

    fields.UILabel_Time.text = group:GetResetTimeStr()
end

local function ShowBonus(group)
    local heroEctype = group:GetCurrentHeroEctype()
    local items = heroEctype:GetItemsOfShow()
    UIHelper.ResetItemNumberOfUIList(fields.UIList_Awards,#items)
    for i = 1, #items do
        local uiItem = fields.UIList_Awards:GetItemByIndex(i-1)
        BonusManager.SetRewardItem(uiItem,items[i],{notShowAmount=true})
    end
end

local function ShowBottomItem(uiItem, group, index)
    local spriteSelect = uiItem.Controls["UISprite_Select"]
    local labelTitle = uiItem.Controls["UILabel_Chapter"]
    local textureGroup = uiItem.Controls["UITexture_Boss"]

    if HeroBookManager.GetCurrentGroupIndex() == index then
        spriteSelect.gameObject:SetActive(true)
    else
        spriteSelect.gameObject:SetActive(false)
    end
    textureGroup:SetIconTexture(group:GetGroupIcon())
    if group:IsMatchLevel() then
        ColorUtil.SetTextureColorGray(textureGroup, false)
    else
        ColorUtil.SetTextureColorGray(textureGroup, true)
    end

    labelTitle.text = group:GetGroupName()
    EventHelper.SetClick(uiItem, function()
        HeroBookManager.SetCurrentGroup(index)
    end)
end

local function ShowBottom(group)
    EventHelper.SetClick(fields.UIButton_ArrowsLeft, function()
        HeroBookManager.LastGroup()
    end)
    
    EventHelper.SetClick(fields.UIButton_ArrowsRight, function()
        HeroBookManager.NextGroup()
    end)

    local groupCount = HeroBookManager.GetGroupNumber()
    UIHelper.ResetItemNumberOfUIList(fields.UIList_Boss, groupCount)
    for i = 1, groupCount do
        local uiItem = fields.UIList_Boss:GetItemByIndex(i-1)
        local group = HeroBookManager.GetGroup(i)
        ShowBottomItem(uiItem, group, i)
    end

    local heroEctype = group:GetCurrentHeroEctype()
    if group:IsMatchLevel() then
        fields.UIButton_GO.isEnabled = true
        EventHelper.SetClick(fields.UIButton_GO, function()
            HeroBookManager.OpenHeroEctype(group:GetId(), heroEctype:GetId())
        end)
    else
        fields.UIButton_GO.isEnabled = false
    end
end




local function refresh(params)
    local currentGroup = HeroBookManager.GetCurrentGroup()
    
    if currentGroup ~= nil then
        ShowPetDisplayArea(currentGroup)
        ShowPetGroupArea(currentGroup)
        ShowChallengeInfo(currentGroup)
        ShowBonus(currentGroup)
        ShowBottom(currentGroup)
    end
end

local function destroy()

end

local function show(params)
    if params and type(params) == "table" and params.tabindex3 then
        HeroBookManager.SetCurrentGroup(params.tabindex3)
    end
end

local function hide()

end

local function update()
    if currentMonster and currentMonster.m_Object then
        currentMonster.m_Avatar:Update()--:update()
     --   currentMonster:UIScaleModify()
    end
end

local function init(params)
    name, gameObject, fields = unpack(params)
end

return {
    init    = init,
    show    = show,
    hide    = hide,
    update  = update,
    destroy = destroy,
    refresh = refresh,
}
