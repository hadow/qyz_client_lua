local EventHelper = UIEventListenerHelper
local uimanager 	= require "uimanager"
local SkillManager  = require "character.skill.skillmanager"
local RoleSkill     = require "character.skill.roleskill"
local PlayerRole    = require "character.playerrole"
--------------------------------------------------------------------------------------------

local tabname = "skill.tabskill"
local gameObject
local name
local fields
local CurrentSkillGroup = 1
local Rotate0           = Vector3(0,0,0)
local Rotate180         = Vector3(0,0,180)
local RotateNegative180 = Vector3(0,0,-180)
local Delta             = 20
local RoleSkillInfo = nil

local DialogType = enum
{
    "Equipe",
    "Upgrade",
    "Evolve",
}

local function OpenDialog(dialogType)
    fields.UIGroup_SkillUpdate.gameObject:SetActive(true)
    if dialogType == DialogType.Equipe then
        fields.UIGroup_SkillEquip.gameObject:SetActive(true)
        fields.UIGroup_Upgrade.gameObject:SetActive(false)
        fields.UIGroup_Advanced.gameObject:SetActive(false)

    elseif dialogType == DialogType.Upgrade then
        fields.UIGroup_SkillEquip.gameObject:SetActive(false)
        fields.UIGroup_Upgrade.gameObject:SetActive(true)
        fields.UIGroup_Advanced.gameObject:SetActive(false)

    elseif dialogType == DialogType.Evolve then
        fields.UIGroup_SkillEquip.gameObject:SetActive(false)
        fields.UIGroup_Upgrade.gameObject:SetActive(true)
        fields.UIGroup_Advanced.gameObject:SetActive(true)
    end
end

local function CloseDialog()
    fields.UIGroup_SkillUpdate.gameObject:SetActive(false)
end



local function SetCurrentSkillGroup(groupid)
    CurrentSkillGroup = groupid
    fields.UILabel_SwtichGroup.text = mathutils.TernaryOperation(CurrentSkillGroup==1,LocalString.DlgSkill_UILabel_SwtichGroup1, LocalString.DlgSkill_UILabel_SwtichGroup2)
end

local function DragSkillGroup(draggroup,dragup)
    --printyellow("currentgroup ",CurrentSkillGroup)
    --printyellow(draggroup,dragup)
    if CurrentSkillGroup == draggroup then
        if draggroup == 1 then
            if dragup then
                fields.TweenRotation_Skill.from =Rotate180
                fields.TweenRotation_Skill.to = Rotate0
            else
                fields.TweenRotation_Skill.from = RotateNegative180
                fields.TweenRotation_Skill.to = Rotate0
            end
        else
            if dragup then
                fields.TweenRotation_Skill.from = Rotate0
                fields.TweenRotation_Skill.to = RotateNegative180
            else
                fields.TweenRotation_Skill.from = Rotate0
                fields.TweenRotation_Skill.to = Rotate180
            end
        end
        --printt(fields.TweenRotation_Skill.from)
        --printt(fields.TweenRotation_Skill.to)
        fields.TweenRotation_Skill.transform.localEulerAngles = fields.TweenRotation_Skill.from
        fields.TweenRotation_Skill:ResetToBeginning()
        fields.TweenRotation_Skill:PlayForward()
        SetCurrentSkillGroup(mathutils.TernaryOperation(CurrentSkillGroup==1,2,1))
    end
end





local function IsEqupied(skillid)
    local isequiped = false
    for i = 0,fields.UIList_Skill_Equiped.Count -1 do
        local item  = fields.UIList_Skill_Equiped:GetItemByIndex(i)
        if item.Id == skillid then
            isequiped = true
            break
        end
    end
    return isequiped
end

local function GetEqupiedItem(skillid)
    for i = 0,fields.UIList_Skill_Equiped.Count -1 do
        local item  = fields.UIList_Skill_Equiped:GetItemByIndex(i)
        if item.Id == skillid then
            return item
        end
    end
    return nil
end

local function UnEquip(skillid)
    if IsEqupied(skillid) then
        local item =GetEqupiedItem(skillid)
        index = item.Index % 3
        currentindex = item.Index
        for i = index ,2 do

            --printyellow("currentindex",currentindex)
            local currentItem = fields.UIList_Skill_Equiped:GetItemByIndex(currentindex)
            if i <  2  then

                --printyellow("move",currentindex)
                local nextItem = fields.UIList_Skill_Equiped:GetItemByIndex(currentindex+1)
                currentItem.Id = nextItem.Id
                currentItem.Data = nextItem.Data
            else
                --printyellow("clear",currentindex)
                currentItem.Id = 0
                currentItem.Data = nil
            end
            currentindex = currentindex + 1
        end
    end

end


local function Equip(item)
    local isfull = true
    for i = 0,2 do
        local equipedindex = 3*(CurrentSkillGroup-1) + i
        local equipeditem  = fields.UIList_Skill_Equiped:GetItemByIndex(equipedindex )
        if equipeditem.Id == 0 then
            isfull = false
            equipeditem.Id = item.Id
            equipeditem.Data = item.Data
            break
        end
    end
    if isfull then
        uimanager.ShowSystemFlyText(LocalString.DlgSkill_EquipFull )
    end
end


local function RefreshUnEquipeList()
    for i = 0,fields.UIList_Skill_UnEquipe.Count -1 do
        local item  = fields.UIList_Skill_UnEquipe:GetItemByIndex(i)
        item:SetIconTexture(item.Data:GetSkill():GetSkillIcon())
        local UISprite_choose = item.Controls["UISprite_choose"]
        UISprite_choose.gameObject:SetActive(IsEqupied(item.Id))
    end
end

local function RefreshEquipedList()

     for i = 0,fields.UIList_Skill_Equiped.Count -1 do
        local item  = fields.UIList_Skill_Equiped:GetItemByIndex(i)
        if item.Id ~=0  then
            --printyellow(item.Data:GetSkill():GetSkillIcon())
            item:SetIconTexture(item.Data:GetSkill():GetSkillIcon())
        else
            item:SetIconTexture("null")
        end

    end

    RefreshUnEquipeList()
end




local function RefreshEquipedSkill()
    OpenDialog(DialogType.Equipe)
    local EquipedSkills   = RoleSkillInfo:GetEquipedSkills()
    for i = 0,fields.UIList_Skill_Equiped.Count -1 do
        local item  = fields.UIList_Skill_Equiped:GetItemByIndex(i)
        if EquipedSkills[i+1] then
            item.Id = EquipedSkills[i+1]
            item.Data = RoleSkillInfo:GetSkillInfoBySkillId(EquipedSkills[i+1])
        else
            item.Id = 0
        end
    end


    fields.UIList_Skill_UnEquipe:Clear()
    for _,skillinfo in pairs(RoleSkillInfo:GetAllSkills()) do
        if skillinfo.actived and not skillinfo:GetSkill():IsPassive() then --这块还要加个 主动技能的条件
            local item = fields.UIList_Skill_UnEquipe:AddListItem()
            item.Id = skillinfo.skillid
            item.Data = skillinfo
        end
    end

    RefreshEquipedList()


    EventHelper.SetListClick(fields.UIList_Skill_UnEquipe, function(item)
         --printt(item.Data)

         if not IsEqupied(item.Id) then
            Equip(item)
        else
            UnEquip(item.Id)

        end

        RefreshEquipedList()

    end )

    EventHelper.SetListClick(fields.UIList_Skill_Equiped, function(item)
         --printt(item.Data)
         if item.Id == 0 then
            return
         end
         UnEquip(item.Id)
         RefreshEquipedList()
    end )


end





local function RefreshMoney()
    fields.UILabel_MoneyAll.text = string.format("/%s",PlayerRole:Instance():GetCurrency(cfg.currency.CurrencyType.XuNiBi)  )
    --printt(PlayerRole:Instance().currencys)
    fields.UILabel_ZaoHuaZhiAll.text = string.format("/%s",PlayerRole:Instance():GetCurrency(cfg.currency.CurrencyType.ZaoHua)  )
end


local function RefreshUpgradeSkill(skillinfo)
    -- printyellow("RefreshUpgradeSkill(skillinfo)",skillinfo.skillid,skillinfo.level)
    --printt(skillinfo:GetSkill())

    local skill =  skillinfo:GetSkill()
    if skill ==nil then
        logError("skill config error: skillid: ",skillinfo.skillid)
        return
    end
    fields.UILabel_SkillName01.text = skill:GetSkillName()

    fields.UILabel_LV01.text =string.format("Lv:%s%s",skillinfo.level,RoleSkill.GetAmuletLabel(skill) )
    fields.UILabel_Discription01.text = skill:GetSkillDetailDesc(skillinfo.level+RoleSkill.GetAmuletLevel(skill))
    fields.UITexture_Skill01:SetIconTexture(skill:GetSkillIcon())
    fields.UISprite_Warning_Update.gameObject:SetActive(RoleSkill.ShowRedDot(skillinfo))

    if skill:IsMaxLevel(skillinfo.level) then
        --已经满级
        OpenDialog(DialogType.Upgrade)
        fields.UISprite_Discription.gameObject:SetActive(true)
        fields.UILabel_Discription.text       = skill:GetSkillDescription()
        fields.UILabel_LV02.text              = "Lv:Max"
        fields.UILabel_Discription02.text     = LocalString.DlgSkill_Level_Max
        fields.UILabel_Money.text             = 0
        fields.UILabel_ZaoHuaZhi.text         = 0
        fields.UIButton_Update.gameObject:SetActive(false)
        fields.UISprite_ZaoHuaZhiBG.gameObject:SetActive(false)
        fields.UILabel_Tips.text = LocalString.DlgSkill_Level_Max
        fields.UILabel_Tips.color = Color.yellow
        fields.UIGroup_Resources.gameObject:SetActive(false)
    elseif skill:CanUpgrade(skillinfo.level) then
        --可以升级
        OpenDialog(DialogType.Upgrade)
        fields.UISprite_Discription.gameObject:SetActive(true)
        fields.UILabel_Discription.text       = skill:GetSkillDescription()
        fields.UILabel_LV02.text              = string.format("Lv:%s%s",skillinfo.level+1,RoleSkill.GetAmuletLabel(skill) )
        fields.UILabel_Discription02.text     = skill:GetSkillDetailDesc(skillinfo.level+1+RoleSkill.GetAmuletLevel(skill))

        fields.UILabel_Update.text            = LocalString.DlgSkill_UILabel_SkillUp1
        fields.UILabel_Money.text             = skill:GetUpgradeCost1(skillinfo.level+1)
        fields.UILabel_ZaoHuaZhi.text         = skill:GetUpgradeCost2(skillinfo.level+1)

        fields.UISprite_ZaoHuaZhiBG.gameObject:SetActive(skill:GetUpgradeCost2(skillinfo.level+1)>0)

        fields.UIButton_Update.gameObject:SetActive(true)
        EventHelper.SetClick(fields.UIButton_Update, function(item)
             RoleSkill.UpgradeSkill(skill,skillinfo.level+1)
        end )

        if skill:RoleLevelAchieve(PlayerRole:Instance().m_Level,skillinfo.level+1) then
            fields.UILabel_Tips.text = ""-- LocalString.DlgSkill_CanUpgrade
            fields.UILabel_Tips.color = Color.green
            UITools.SetButtonEnabled(fields.UIButton_Update,true)
            fields.UIGroup_Resources.gameObject:SetActive(true)
        else
            fields.UILabel_Tips.text = string.format(LocalString.DlgSkill_CanUpgradeLevel,skill:GetRequirelv(skillinfo.level+1))
            fields.UILabel_Tips.color = Color.red
            UITools.SetButtonEnabled(fields.UIButton_Update,false)
            fields.UIGroup_Resources.gameObject:SetActive(false)
        end

    elseif skill:CanEvolve(skillinfo.level) then
        --可以进阶
        OpenDialog(DialogType.Evolve)
        fields.UISprite_Discription.gameObject:SetActive(false)
        fields.UILabel_LV02.text              = string.format("Lv:%s%s",1,RoleSkill.GetAmuletLabel(skill) )
        fields.UILabel_Discription02.text     = skill:GetEvolveSkill():GetSkillDetailDesc(1+RoleSkill.GetAmuletLevel(skill))
        fields.UILabel_Update.text            = LocalString.DlgSkill_UILabel_SkillUp2
        fields.UILabel_Money.text             = 0
        fields.UILabel_Money.text             = skill:GetEvolveCost1()
        fields.UILabel_ZaoHuaZhi.text         = skill:GetEvolveCost2()

        fields.UISprite_ZaoHuaZhiBG.gameObject:SetActive(skill:GetEvolveCost1()>0)
        fields.UILabel_SkillName02.text            = skill:GetEvolveSkill():GetSkillName()
        fields.UITexture_Skill02:SetIconTexture(skill:GetEvolveSkill():GetSkillIcon())
        fields.UIButton_Update.gameObject:SetActive(true)
        EventHelper.SetClick(fields.UIButton_Update, function(item)
             RoleSkill.EvolveSkill(skill)
        end )

        if skill:RoleLevelAchieve(PlayerRole:Instance().m_Level,skillinfo.level+1) then
            fields.UILabel_Tips.text = ""-- LocalString.DlgSkill_CanEvolve
            fields.UILabel_Tips.color = Color.green
            UITools.SetButtonEnabled(fields.UIButton_Update,true)
            fields.UIGroup_Resources.gameObject:SetActive(true)
        else
            fields.UILabel_Tips.text = string.format(LocalString.DlgSkill_CanEvolveLevel,skill:GetEvolveRequirelv())
            fields.UILabel_Tips.color = Color.red
            UITools.SetButtonEnabled(fields.UIButton_Update,false)
            fields.UIGroup_Resources.gameObject:SetActive(false)
        end
    end

    RefreshMoney()
    uimanager.RefreshRedDot()

end

local function RefreshUIButton_SkillUp(item,enabled,canevolve,callback)
    if canevolve then
        item:SetText("UILabel_SkillUp",LocalString.DlgSkill_UILabel_SkillUp2)
    else
        item:SetText("UILabel_SkillUp",LocalString.DlgSkill_UILabel_SkillUp1)
    end
    local button                         = item.Controls["UIButton_SkillUp"]
    UITools.SetButtonEnabled(button,enabled)
    if callback then
        EventHelper.SetClick(button, callback )
    end
end

local function PlayUpgradeEffect()
    if uimanager.isshow(tabname) then
        uimanager.PlayUIParticleSystem(fields.UIGroup_AnnealEffect_skillupdate.gameObject)
    end
end

local function PlayEvolveEffect()
    if uimanager.isshow(tabname) then
        uimanager.PlayUIParticleSystem(fields.UIGroup_AnnealEffect_SkillAdvanced.gameObject)
    end
end


--=====================================================================================================================================
local function refresh(params)
   --print(name, "refresh")
   local AllSkills       = RoleSkillInfo:GetAllSkills()
   local EquipedSkills   = RoleSkillInfo:GetEquipedSkills()
   --fields.UIList_Skill:Clear()
   if AllSkills then
       local index = 0
       for _,skillinfo in pairs(AllSkills) do
            local item = fields.UIList_Skill:GetItemByIndex(index)
            if item == nil then
                item                           = fields.UIList_Skill:AddListItem()
            end
            index = index +1
            local UISprite_SkillBG               = item.Controls["UISprite_SkillBG"]
            local UISprite_Warning               = item.Controls["UISprite_Warning"]
            local UILabel_Tips                   = item.Controls["UILabel_Tips"]
            local UITexture_Skill                = item.Controls["UITexture_Skill"]

            item.Id                              = skillinfo.skillid
            item.Data                            = skillinfo
            --printt(skillinfo)
            --printyellow(skillinfo:GetSkill():GetSkillIcon())
            local skill =  skillinfo:GetSkill()
            if skill ==nil then
                logError("skill config error: skillid: ",skillinfo.skillid)
                return
            end
            EventHelper.SetClick(UISprite_SkillBG, function()
                uimanager.show("skill.dlgdialogbox_skill",{skillinfo = skillinfo})
            end )
            
            item:SetIconTexture(skill:GetSkillIcon())
            item:SetText("UILabel_SkillName",skill:GetSkillName())
            viewutil.SetTextureGray(UITexture_Skill,not skillinfo.actived)

            UISprite_Warning.gameObject:SetActive(RoleSkill.ShowRedDot(skillinfo))
            if skillinfo.actived then
                item:SetText("UILabel_LV",string.format("Lv:%s%s",skillinfo.level,RoleSkill.GetAmuletLabel(skill) ))
                if skill:IsMaxLevel(skillinfo.level) then
                    --已经满级
                    RefreshUIButton_SkillUp(item,false,false,nil)
                    UILabel_Tips.text = LocalString.DlgSkill_Level_Max
                    UILabel_Tips.color = Color.yellow
                elseif skill:CanUpgrade(skillinfo.level) then
                    --可以升级
                    if skill:RoleLevelAchieve(PlayerRole:Instance().m_Level,skillinfo.level+1) then
                        RefreshUIButton_SkillUp(item,true,false,function()
                                            RefreshUpgradeSkill(skillinfo)
                                        end)
                        UILabel_Tips.text = ""-- LocalString.DlgSkill_CanUpgrade
                        UILabel_Tips.color = Color.green
                    else
                        RefreshUIButton_SkillUp(item,false,false,nil)
                        UILabel_Tips.text = string.format(LocalString.DlgSkill_CanUpgradeLevel,skill:GetRequirelv(skillinfo.level+1))
                        UILabel_Tips.color = Color.red
                    end

                elseif skill:CanEvolve(skillinfo.level) then
                    --可以进阶
                    if skill:RoleLevelAchieve(PlayerRole:Instance().m_Level,skillinfo.level+1) then
                        RefreshUIButton_SkillUp(item,true,true, function()
                            RefreshUpgradeSkill(skillinfo)
                        end )

                        UILabel_Tips.text = ""-- LocalString.DlgSkill_CanEvolve
                        UILabel_Tips.color = Color.green
                    else
                        RefreshUIButton_SkillUp(item,false,true, nil)
                        UILabel_Tips.text = string.format(LocalString.DlgSkill_CanEvolveLevel,skill:GetEvolveRequirelv())
                        UILabel_Tips.color = Color.red
                    end

                end

            else
                item:SetText("UILabel_LV","")
                RefreshUIButton_SkillUp(item,false,false, nil)
                UILabel_Tips.text = string.format(LocalString.DlgSkill_Active_Level,skill:GetRequirelv(1))
                UILabel_Tips.color = Color.white


            end

        end
    end
end


local function destroy()
  --print(name, "destroy")
end

local function show(params)
    fields.UIGroup_AnnealEffect_skillupdate.gameObject:SetActive(false)
    fields.UIGroup_AnnealEffect_SkillAdvanced.gameObject:SetActive(false)
    local playerskilldata = PlayerRole:Instance().PlayerSkill:GetPlayerSkillByIndex(0)
    if playerskilldata then
        fields.UITexture_Attack:SetIconTexture(playerskilldata:GetCurrentSkill():GetSkillIcon())
    else
        fields.UITexture_Attack:SetIconTexture("null")
    end
end

local function hide()
  --print(name, "hide")
end

local function update()

end

local function init(params)
--	FriendManager.init()
   	name, gameObject, fields = unpack(params)
    RoleSkillInfo = RoleSkill.GetRoleSkillInfo()
    CloseDialog()

    EventHelper.SetClick(fields.UIButton_Skill, function()
        RefreshEquipedSkill()
    end )

    EventHelper.SetClick(fields.UIButton_Close, function()
         CloseDialog()
    end )

    EventHelper.SetListDrag(fields.UIList_Skill_Equiped, function(item,delta)
         --printt(item.Index)
         --printt(UICamera.currentTouch.totalDelta)
         local delta = UICamera.currentTouch.totalDelta
         local groupid = mathutils.TernaryOperation(item.Index >2,2, 1)
         if delta.x >Delta and delta.y >Delta then
            DragSkillGroup(groupid,true)
         elseif delta.x <-Delta and delta.y <-Delta then
            DragSkillGroup(groupid,false)
         end
    end )

    EventHelper.SetClick(fields.UIButton_SwtichGroup, function()
         if CurrentSkillGroup == 1 then
            DragSkillGroup(1,true)
         else
            DragSkillGroup(2,false)
         end
    end )

    EventHelper.SetClick(fields.UIButton_Left, function()
        DragSkillGroup(CurrentSkillGroup,false)
    end )

     EventHelper.SetClick(fields.UIButton_Right, function()
        DragSkillGroup(CurrentSkillGroup,true)
     end )


    EventHelper.SetClick(fields.UIButton_Sure, function()
        local equipskillpositions = {}
        for i=0,fields.UIList_Skill_Equiped.Count-1 do
            local item = fields.UIList_Skill_Equiped:GetItemByIndex(i)
            if item.Id ~= 0 then
                equipskillpositions [item.Id] =i+1
            end
        end
        RoleSkill.ChangeEquipActiveSkill(equipskillpositions)
    end )



end

--不写此函数 默认为 UIShowType.Default
local function uishowtype()
    --return UIShowType.Default
    --return UIShowType.ShowImmediate--强制在showtab页时 不回调showtab
    return UIShowType.Refresh  --强制在切换tab页时回调show
    --return bit.bor(UIShowType.ShowImmediate,UIShowType.Refresh)
end


return {
  init                      = init,
  show                      = show,
  hide                      = hide,
  update                    = update,
  destroy                   = destroy,
  refresh                   = refresh,
  CloseDialog               = CloseDialog,
  RefreshUpgradeSkill       = RefreshUpgradeSkill,
  RefreshMoney              = RefreshMoney,
  uishowtype                = uishowtype,
  PlayUpgradeEffect         = PlayUpgradeEffect,
  PlayEvolveEffect          = PlayEvolveEffect,
}
