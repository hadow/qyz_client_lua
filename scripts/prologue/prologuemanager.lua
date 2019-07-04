local NetWork=require("network")
local UIManager=require("uimanager")
local ectypetools = require("ectype.ectypetools")
local PlayerRole = require("character.playerrole")
local GuideManager = require("noviceguide.noviceguidemanager")
local EctypeManager = require"ectype.ectypemanager"
local CGManager = require("ui.cg.cgmanager")
local ConfigManager = require("cfg.configmanager")
local AudioMgr = require"audiomanager"
local gameevent         = require "gameevent"

local m_PrologueCfg
local m_IsPrefixVedioPlayed = false

--new surfix prologue
local m_CreateRoleID
local m_NeedPlaySurfixPrologue

local function GetFightPower(profession)
    if m_PrologueCfg then
        return m_PrologueCfg.professionequips[profession].battlepower
    else
        return 0
    end
end

local function GetSkillOrder(profession)
    if m_PrologueCfg then
        return m_PrologueCfg.professionequips[profession].skillorder
    else
        return nil
    end
end

local function IsPrologueEctype(ectypeid)
    if m_PrologueCfg then
        return m_PrologueCfg.id == ectypeid
    else
        return false
    end
end

local function IsInPrologue()
    if EctypeManager.IsInEctype() and EctypeManager.GetEctype().m_EctypeType == cfg.ectype.EctypeType.PROLOGUE then
        return true
    else
        return false
    end
end

local function IsGuidingFly()
    --printyellow(string.format("[prologuemanager:IsGuidingFly] GuideManager.GetGuideId()=%s, m_PrologueCfg.flyguideid=%s, GuideManager.HasFinishedGuide(m_PrologueCfg.flyguideid)=%s.", GuideManager.GetGuideId(), m_PrologueCfg.flyguideid, GuideManager.HasFinishedGuide(m_PrologueCfg.flyguideid)))
    --return cfg.guide.NoviceGuide.CONTROLLER==0 or GuideManager.GetGuideId() == m_PrologueCfg.flyguideid or GuideManager.HasFinishedGuide(m_PrologueCfg.flyguideid)
    -- return true
    local layoutIds = EctypeManager.GetPrologueLayoutIds()
    for _,id in pairs(layoutIds) do
        if id == 7 then return true end
    end
    return false
end

local function IsInNavArea()
    if m_PrologueCfg and IsInPrologue() then
        local areaid = m_PrologueCfg.flyregionid
        local vertices = EctypeManager.GetEctype():GetArea(areaid)
        -- printyellow(string.format("[prologuemanager:IsInNavArea] areaid=%s, vertices=%s.", areaid, vertices))
        return ectypetools.CheckInTheArea(PlayerRole:Instance():GetPos(), vertices)
    else
        return false
    end
end

local function StartFly()
end

local function OnNavStop()
    -- printyellow("[prologuemanager:OnNavStop] prologue fly nav stop!")
end

local function OnNavEnd()
    -- printyellow("[prologuemanager:OnNavEnd] prologue fly nav end!")
    if m_PrologueCfg then
        local targetPos       = Vector3(m_PrologueCfg.flyendareax, 0, m_PrologueCfg.flyendareaz)
        -- printyellow(string.format("[prologuemanager:OnNavEnd] start fly to target position(%s,0,%s).", m_PrologueCfg.flyendareax, m_PrologueCfg.flyendareaz))
        PlayerRole:Instance():StartPathFly(m_PrologueCfg.flyrouteid, targetPos)
    end
end

local function NavToFlyPosition()
    print("IsInPrologue()",IsInPrologue())
    print("IsGuidingFly()",IsGuidingFly())
    print("IsInNavArea()",IsInNavArea())
    printt(m_PrologueCfg)
    if IsInPrologue() and IsGuidingFly() and IsInNavArea() and m_PrologueCfg then
        local param         = {
            targetPos       = Vector3(m_PrologueCfg.flystartareax, 0, m_PrologueCfg.flystartareaz),
            stopCallback = OnNavStop,
            callback = OnNavEnd,
        }
        -- printyellow("[prologuemanager:NavToFlyPosition] start nav to fly position!")
        PlayerRole:Instance():navigateTo(param)
    else
        -- printyellow(string.format("[prologuemanager:NavToFlyPosition] can't nav to fly position!IsInPrologue()=%s, IsGuidingFly()=%s, IsInNavArea()=%s, m_PrologueCfg=%s.", IsInPrologue(), IsGuidingFly(), IsInNavArea(), m_PrologueCfg))
    end
end

local function PlayPrefixVedio(callback)
    if m_IsPrefixVedioPlayed then
        if callback then
            callback()
        end
    else
        m_IsPrefixVedioPlayed = true
        if m_PrologueCfg then
            --print(string.format("[prologuemanager:PlayPrefixVedio] play Prefix cg [%s] on creating first role!", m_PrologueCfg.cg_create_first_role))
            CGManager.PlayCG(m_PrologueCfg.cg_create_first_role, callback, m_PrologueCfg.cg_create_first_role_mode)
        else
            -- printyellow("[prologuemanager:PlayPrefixVedio] m_PrologueCfg null! play Prefix cg failed!")
        end
    end
end

local function PlaySurfixVedio(callback)
    if m_PrologueCfg then
        --printyellow(string.format("[prologuemanager:PlaySurfixVedio] play Surfix cg [%s] after create role!", m_PrologueCfg.cg_ectype_end))
        --UIManager.showdialog("common.dlgblack")
        m_NeedPlaySurfixPrologue = false
        m_CreateRoleID = nil
        CGManager.PlayCG(m_PrologueCfg.cg_ectype_end, callback, m_PrologueCfg.cg_ectype_end_mode)
        --printyellow(string.format("[prologuemanager:PlaySurfixVedio] play Surfix cg [%s] end!", m_PrologueCfg.cg_ectype_end))
    else
        -- printyellow("[prologuemanager:PlaySurfixVedio] m_PrologueCfg null! play Surfix cg failed!")
    end
end

local function onmsg_SEndPrologue(msg)
    -- printyellow("[prologuemanager:onmsg_SEndPrologue] receive:", msg)

    if msg.errcode == 0 then
        local PlotManager = require("plot.plotmanager")
        PlotManager.CutscenePlay("caomiao_1")
    else
        --Game.Platform.Interface.Instance:Logout()
        local login = require"login"
	    login.logout(login.LogoutType.to_login)
        --login.role_logout(login.LogoutType.to_login)
    end
end

local function onmsg_SOpenLayout(msg)
    -- printyellow("[prologuemanager:onmsg_SOpenLayout] OpenLayout:", msg)
    if IsInPrologue() and m_PrologueCfg then
        local bgmusicid = m_PrologueCfg.banmusic[msg.layout.id]
        if bgmusicid and bgmusicid>0 then
            -- printyellow(string.format("[prologuemanager:onmsg_SOpenLayout] OpenLayout [%s], playbg [%s].", msg.layout.id, bgmusicid))
            AudioMgr.PlayBackgroundMusic(bgmusicid)
        else
            -- printyellow(string.format("[prologuemanager:onmsg_SOpenLayout] OpenLayout [%s], found no bg music.", msg.layout.id))
        end
    end
end

local function onmsg_SCreateRole(msg)
    m_CreateRoleID = (msg and msg.newinfo) and msg.newinfo.roleid or nil
    --printyellow(string.format("[prologuemanager:onmsg_SCreateRole] set m_CreateRoleID= [%s].", m_CreateRoleID))
end

local function NeedPlaySurfixPrologue()
    return m_NeedPlaySurfixPrologue
end

local function onmsg_SRoleLogin(msg)
    if msg and msg.err == lx.gs.login.SRoleLogin.OK then
        if m_CreateRoleID then
            m_NeedPlaySurfixPrologue = m_CreateRoleID==msg.roledetail.roleid
        else
            m_NeedPlaySurfixPrologue = false
        end          
        --printyellow(string.format("[prologuemanager:onmsg_SRoleLogin] set m_NeedPlaySurfixPrologue= [%s].", m_NeedPlaySurfixPrologue))
    end
end

--[[
local function onmsg_SReady()
    if NeedPlaySurfixPrologue() then
        PlaySurfixVedio()
    end
end
--]]

local function reset()
    m_IsPrefixVedioPlayed = false
    m_CreateRoleID = nil
    m_NeedPlaySurfixPrologue = false
end

local function OnLogout()
    reset()
end

local function init()
    m_PrologueCfg= ConfigManager.getConfig("prologue")
    if nil == m_PrologueCfg then
        -- printyellow("[prologuemanager:init] prologue config nil!")
    end

    reset()

	gameevent.evt_system_message:add("logout", OnLogout)
    NetWork.add_listeners({
        { "map.msg.SOpenLayout",onmsg_SOpenLayout},
        { "lx.gs.login.SCreateRole", onmsg_SCreateRole },
        { "lx.gs.login.SRoleLogin", onmsg_SRoleLogin },
        --{ "map.msg.SReady",               onmsg_SReady        },
    })
end

return
{
    init     = init,
    IsInPrologue = IsInPrologue,
    NavToFlyPosition = NavToFlyPosition,
    IsGuidingFly = IsGuidingFly,
    IsPrologueEctype = IsPrologueEctype,
    PlayPrefixVedio = PlayPrefixVedio,
    PlaySurfixVedio = PlaySurfixVedio,
    onmsg_SEndPrologue = onmsg_SEndPrologue,
    GetSkillOrder = GetSkillOrder,
    GetFightPower = GetFightPower,
    NeedPlaySurfixPrologue = NeedPlaySurfixPrologue,
}
