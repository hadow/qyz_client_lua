local HeroChallengeManager = require("ui.activity.herochallenge.herochallengemanager")
local TeamManager = require("ui.team.teammanager")
local LimitManager = require("limittimemanager")
local PlayerRole = require("character.playerrole"):Instance()
local EventHelper = UIEventListenerHelper
local Format = string.format

local m_GameObject
local m_Name
local m_Fields

local function destroy()
end

local function show(params)
end

local function hide()
end

local function update()
end

local function SetHeroTaskPanel(result)
    local DlgUIMain = require("ui.dlguimain")
    local EctypeManager = require("ectype.ectypemanager")
    DlgUIMain.SetCurTaskTabIndex(0)
    local UIToggle_Task = m_Fields.UIButton_TaskTab.gameObject.transform:GetComponent("UIToggle")
    UIToggle_Task:Set(true,false)
    local UIToggle_Partner = m_Fields.UIButton_PartnerTab.gameObject.transform:GetComponent("UIToggle")
    UIToggle_Partner:Set(false,false)
    local UIToggle_Team = m_Fields.UIButton_TeamTab.gameObject.transform:GetComponent("UIToggle")
    UIToggle_Team:Set(false,false)
    m_Fields.UIGroup_ItemTeam.gameObject:SetActive(false)
    m_Fields.UIGroup_ItemPartner.gameObject:SetActive(false)
    if EctypeManager.IsInEctype() then
        m_Fields.UIGroup_ItemTask.gameObject:SetActive(false)
        m_Fields.UIGroup_HeroChallenge.gameObject:SetActive(false)        
    else
        m_Fields.UIGroup_ItemTask.gameObject:SetActive(not result)
        m_Fields.UIGroup_HeroChallenge.gameObject:SetActive(result)
    end      
end

local function RefreshHeroTaskPanel()
    if TeamManager.IsInHeroTeam() then
        local taskDescription = HeroChallengeManager.GetCurTaskDescription()
        local times = LimitManager.GetDayLimitTime(cfg.cmd.ConfigId.HERO_TASK,0)
        if times < HeroChallengeManager.GetMaxBonusCount() then
            m_Fields.UILabel_HeroTaskTitle.text = Format(LocalString.HeroChallenge_Title,times + 1)
        else
            m_Fields.UILabel_HeroTaskTitle.text = Format(LocalString.HeroChallenge_Full)
        end
        m_Fields.UILabel_HeroTaskContent.text = taskDescription    
        EventHelper.SetClick(m_Fields.UILabel_HeroTaskContent,function()
            if TeamManager.IsLeader(PlayerRole:GetId()) == true then
                HeroChallengeManager.OpenTask()
            end
        end)
        EventHelper.SetClick(m_Fields.UIButton_Quit,function()
            local UIManager = require("uimanager")
             UIManager.ShowAlertDlg({immediate = true,content = LocalString.HeroChallenge_QuitWarning,callBackFunc = function()
                 TeamManager.SendQuitTeam()
             end})        
        end)
        SetHeroTaskPanel(true)
    else
        SetHeroTaskPanel(false)
    end
end

local function refresh()
    RefreshHeroTaskPanel()
end

local function init(name,gameObject,fields)
    m_Name = name
    m_GameObject = gameObject
    m_Fields = fields
end

return {
    init = init,
    show = show,
    hide = hide,
    update = update,
    destroy = destroy,
    refresh = refresh,
    RefreshHeroTaskPanel = RefreshHeroTaskPanel,
    SetHeroTaskPanel = SetHeroTaskPanel,
}
