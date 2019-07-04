local CharacterManager  = require("character.charactermanager")
local Network           = require("network")
local Player            = require("character.player")
local Npc               = require("character.npc")
local Monster           = require("character.monster")
local Boss              = require("character.boss")
local Mineral           = require("character.mineral")
local SceneManager      = require("scenemanager")
local HumanoidAvatar    = require("character.avatar.humanoidavatar")
local defineenum        = require("defineenum")
local Pet               = require("character.pet.pet")
local ConfigManager     = require("cfg.configmanager")
local EctypeManager     = require("ectype.ectypemanager")
local WorkType          = defineenum.WorkType
local CharacterType     = defineenum.CharacterType
local GameEvent         = require("gameevent")

local rebornNpcs        = {}
local newYearNpcs       = {}
---------------------------------------------------------------------------------------------------------
--发送协议

--===============================================================================================
--地图相关
--===============================================================================================

local function ChangeMapReady()
    local re = map.msg.CReady({})
    Network.send(re)
end

local function onmsg_ChangeMapReady(msg)
    CharacterManager.ClearInvalidCharacter()
    PlayerRole:Instance():SetRideState()
end


local function onmsg_SEnter(msg)
    local mapData = ConfigManager.getConfigData("worldmap",msg.worldid)
    local sceneName = (mapData ~= nil) and mapData.scenename or ""

    local needLoad = PlayerRole:Instance().m_MapInfo:NeedLoadMapOnEnterWorld(msg.worldid)

    if EctypeManager.IsInEctype() then
        printyellow("in ectype and LeaveEctype")
        EctypeManager.LeaveEctype()
    end
    if needLoad == true  then
        SceneManager.load(Local.MaincityDlgList, sceneName, function()
            --EctypeManager.AlterNeedLoad(true)
            ChangeMapReady()
            EctypeManager.OnLeave()
            if PlayerRole.Instance().m_MapInfo.m_Callback then
                callback = PlayerRole.Instance().m_MapInfo.m_Callback
                PlayerRole.Instance().m_MapInfo.m_Callback = nil
                callback()
            end
        end )
    else
        local UIManager=require"uimanager"
        local PlotManager = require"plot.plotmanager"
        if not PlotManager.IsPlayingCutscene() then
            for i,v in pairs(Local.MaincityDlgList) do
                UIManager.show(v)
            end
        end
        if not EctypeManager.IsInEctype() then
            CharacterManager.AddPortals()
        end
        ChangeMapReady()
        EctypeManager.OnLeave()
        UIManager.hide("dlgloading")
    end
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character == nil and msg.roleid == PlayerRole.Instance().m_Id then
        CharacterManager.AddCharacter(msg.roleid,PlayerRole:Instance())
    end
    PlayerRole.Instance():sync_SEnterWorld(msg)
    CharacterManager.ResetCharacterOutDated()
end

local function onmsg_SLeaveWorld(msg)
    EctypeManager.BackUpEnterUI()
    CharacterManager.LeaveCurrentScene()
end


local function onmsg_SNearbyPlayerEnter(msg)
    local player = CharacterManager.GetCharacter(msg.roleid)
    if player then
        player = CharacterManager.UpdatePlayer(player,msg)

    else
        player = CharacterManager.CreatePlayer(msg,CharacterManager.NeedSimplify(msg.roleid))
    end
    if player:IsRole() then
        --printyellow("Role+++++++++++++++++")
        player:sync_SNearbyPlayerEnter()
        if EctypeManager.IsInEctype() then
            EctypeManager.RoleEnterEctype()
        end
    end
    if player:IsPlayer() then
        player:SetLoverName(msg.lovername)
    end
    player:InitState(msg.fightercommon)
    return player
end

local function onmsg_SNearbyPetEnter(msg)
    local pet = CharacterManager.GetCharacter(msg.agentid)
    local master = CharacterManager.GetCharacter(msg.owenrid)
    if pet then
        pet = CharacterManager.UpdatePet(pet,msg,master)
    else
        -- pet = CharacterManager.CreatePet(msg,true,master)
        pet = CharacterManager.CreatePet(msg,not master or master:IsSimplified(),master)
    end
    if master and master:IsRole() then
        pet.m_ListenerGroup:AddAttributeListener("dlguimain_partner_attributes",
        CharacterManager.RefreshPetAttributes,false)
    end
    pet:InitState(msg.fightercommon)
    return pet
end


local function onmsg_SNearbyNPCEnter(msg)
    local taskmanager = require "taskmanager"
    local HeroChallengeManager = require("ui.activity.herochallenge.herochallengemanager")
    local resurgencebiyaomanager = require "ui.resurgencebiyao.resurgencebiyaomanager"
    local NewYearManager= require("ui.newyear.newyearmanager")
    local npc = CharacterManager.GetCharacter(msg.agentid)
    local npcData = ConfigManager.getConfigData("npc", msg.npcid)

    local isRebornNpc = false
    if rebornNpcs[msg.npcid] and rebornNpcs[msg.npcid] > 0 then
        isRebornNpc = true
    end
    local isNewYearNpcs = false
     if newYearNpcs[msg.npcid] and newYearNpcs[msg.npcid] > 0 then
        isNewYearNpcs = true
    end
    

    if npc == nil then
        local bHide = false
        if isRebornNpc then
            bHide = not resurgencebiyaomanager.npcShowOrHide(msg.npcid)
        elseif isNewYearNpcs then
            bHide = not NewYearManager.npcShowOrHide(msg.npcid)
        elseif npcData and npcData.isexclusive then
            if taskmanager.IsExclusiveNpcShowHide(msg.npcid) or HeroChallengeManager.IsNeedShowNPC(msg.npcid) then
                bHide = false
            else
                bHide = true
            end
        end

        npc = Npc:new(bHide,msg)
        if not bHide then
            npc:RegisterOnLoaded(function()
                npc:Show()
            end)
            npc:init(msg.agentid,msg.npcid,true)
        end
        npc = CharacterManager.AddCharacter(msg.agentid, npc)
    else
        if isRebornNpc then
            if resurgencebiyaomanager.npcShowOrHide(msg.npcid) then
                npc:Show()
            else
                npc:Hide()
            end
        elseif isNewYearNpcs then
            if NewYearManager.npcShowOrHide(msg.npcid) then
                npc:Show()
            else
                npc:Hide()
            end
        elseif npcData and npcData.isexclusive then
            if taskmanager.IsExclusiveNpcShowHide(msg.npcid) or HeroChallengeManager.IsNeedShowNPC(msg.npcid) then
                npc:Show()
            else
                npc:Hide()
            end
        else
            npc:Show()
        end
    end
    npc.m_outDated = false
    -- npc.m_Name = msg.name
    npc:SetPos(cloneVector3(msg.position))
    npc:SetRotationImmediate(Vector3(msg.orient.x,0,msg.orient.z))

    return npc
end


local function onmsg_SNearbyMonsterEnter(msg)
    --printyellow("onmsg_SNearbyMonsterEnter, agent_id is: ", msg.agent_id)
    local monster = CharacterManager.GetCharacter(msg.agentid)
    if monster == nil then
        --local monsterid
        local monsterCfg = ConfigManager.getConfigData("monster",msg.monsterid)
        monster = ((( monsterCfg ~= nil and monsterCfg.isboss == true ) and Boss:new()) or Monster:new())
        monster.m_HideWhenCreate = true
        monster:init(msg.agentid, msg.monsterid,true)
        monster = CharacterManager.AddCharacter(msg.agentid,monster)
    end

    monster.m_outDated = false
    monster.m_Camp  = msg.fightercommon.camp
    monster.m_Level = msg.level
    monster.m_IsBorn = msg.fightercommon.isborn
    monster:ChangeAttr(msg.fightercommon.attrs)
    monster:InitState(msg.fightercommon)
   -- monster:
    return monster
end


local function onmsg_SNearbyMineEnter(msg)
    local taskmanager = require "taskmanager"
    local mine = CharacterManager.GetCharacter(msg.agentid)
    if mine == nil then
        mine = Mineral:new()
        -- 浠诲姟鐭块渶瑕佸垽鏂槸鍚﹂殣钘�
        mine:RegisterOnLoaded( function()
            if not taskmanager.IsMineNeedHide(msg.mineid) then
               mine:Show()
            else
               mine:Hide()
               printyellow("mine is hide:"..tostring(msg.mineid))
            end
        end )
        mine:init(msg.agentid, msg.mineid, true)
        mine = CharacterManager.AddCharacter(msg.agentid, mine)
    else
        -- 浠诲姟鐭块渶瑕佸垽鏂槸鍚﹂殣钘�
        if taskmanager.IsMineNeedHide(msg.mineid) then
            mine:Hide()
            printyellow("mine is hide:"..tostring(msg.mineid))
        else
            mine:Show()
        end
    end

    mine.m_outDated = false
    mine.m_MineralState = msg.state
    mine:SetPos(cloneVector3(msg.position))
    mine:SetRotationImmediate(Vector3(msg.orientx,0,msg.orient.z))
    return mine
end


local function onmsg_SNearbyRuneEnter(msg)
    local rune = CharacterManager.GetCharacter(msg.agentid)

    if rune == nil then
        local Rune = require "character.rune"
        rune = Rune:new()
        rune:init(msg.agentid,msg.runeid)
        rune = CharacterManager.AddCharacter(msg.agentid,rune)
    end
    rune:SetPos(Vector3(msg.position.x, msg.position.y, msg.position.z))
    rune:SetRotationImmediate(Vector3(msg.orientx,0,msg.orient.z))
end




local function onmsg_SNearbyAgentLeave(msg)
    for i, roleid in pairs(msg.agentids) do
        local character = CharacterManager.GetCharacter(roleid)
        if character and roleid ~= PlayerRole.Instance().m_Id then
            if character.m_Type == CharacterType.Player and character.m_Mount then
                character:DeviatePlayerFromMount(false)
            end
            CharacterManager.RemoveCharacter(roleid)
        end
    end
end
---------------------------------------------------------------------------------------------------------
--[[
    浜虹墿灞炴�х浉鍏充俊鎭殑鍙樻洿
]]
local function onmsg_SChangeName(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        -- character.m_Name = msg.name
        character:ChangeName(msg.name)
    end
end
local function onmsg_SChangeLevel(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        character:ChangeLevel(msg.level)
    end
end
local function onmsg_SChangeVipLevel(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        character:ChangeVipLevel(msg.level)
    end
end
-----------------------------------------------------------
local function onmsg_SChangeFamily(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character and character.ChangeFamily then
        -- character.m_FamilyName = msg.name
        character.m_FamilyID = msg.familyid
        character:ChangeFamily(msg.familyname)
    end
end
local function onmsg_SChangeTitle(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        character:ChangeTitle(msg.titleid)
    end
end
-----------------------------------------------------------
local function onmsg_SChangeAttrs(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        character:ChangeAttr(msg.attrs)
    end
end
-----------------------------------------------------------
local function onmsg_SChangeEquip(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        character:ChangeEquip(msg.equips)
    end
end
local function onmsg_SChangeDress(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        -- character.m_Dress = msg.dressid
        character:ChangeDress(msg.dressid)
        -- character.m_Avatar:Dress(character.m_Profession,character.m_Gender, HumanoidAvatar.EquipDetailType.FASHION, msg.dressid)
    end
end
local function onmsg_SChangeFabao(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    local ItemManager = require("item.itemmanager")
    if character and character.m_Id ~= PlayerRole:Instance().m_Id and character:IsPlayer() then
        character:ChangeFabao(msg.fabaokey)
    end
end
-----------------------------------------------------------

local function onmsg_SChangeRide(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        character:ChangeRide(msg)
    end
end

local function onmsg_SChangeSkill(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then

    end
end

---------------------------------------------------------------------------------------------------------
--[[
    浜虹墿琛屼负鐩稿叧
]]
--local WorkType          = defineenum.WorkType
local function onmsg_SMove(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        if not character:IsRole() then
            if character:IsAttacking() then
                 character.AttackActionFsm:BreakCurrentSkill()
            end
            if character:IsBeAttacked() then
                character.WorkMgr:StopWork(WorkType.BeAttacked)
            end
        end
        character.m_TransformSync:SyncMoveTo(msg)
    end
end

local function onmsg_SOrient(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        if not character:IsRole() then
            character.m_TransformSync:SyncOrient(msg)
        end

    end
end



local function onmsg_SStop(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        character.m_TransformSync:SyncStop(msg)
    end
end



local function onmsg_SSkillInterrupt(msg)
    local attacker = CharacterManager.GetCharacter(msg.roleid)
    if attacker == nil then
        return
    end
    attacker:BreakSkill(msg.skillid)
end

local function onmsg_SSkillPerform(msg)
    local attacker = CharacterManager.GetCharacter(msg.attackerid)
    if attacker == nil then
        return
    end
    attacker:OnSkillPerform(msg)
end



local function onmsg_SSkillAttack(msg)
    if not CharacterManager.SkillAttack(msg) then return end
    local dlgflytext = require "ui.dlgflytext"
    for _,HealInfo in pairs(msg.heals) do
        local beAttacker = CharacterManager.GetCharacter(HealInfo.defencerid)
        if beAttacker then
            -- printyellow("add heal",beAttacker.m_Name,HealInfo.heal)
            dlgflytext.AddHealInfo(tostring(HealInfo.heal),beAttacker)
        end
    end
end

local function onmsg_BeSkillAttack(msg)
    local char = CharacterManager.GetCharacter(msg.roleid)
    if char then
        if char:IsPet() and (char:GetCsvId() == 22100046) and (msg.hp == 0) then
        else
            for _,attack in pairs(msg.attacks) do           
                char:OnBeAttacked(nil,nil,cfg.skill.AnimType.Hit,attack)
            end
        end
        char:ChangeAttr( { [cfg.fight.AttrId.HP_VALUE] = msg.hp } )
    end
end

local function onmsg_FlyWeaponAttack(msg)
    local FlyingWeaponManager = require "character.skill.traceweapon.flyingweaponmanager"
    FlyingWeaponManager.OnAttack(msg.attackerid,msg.skillid,msg.objectid)
    return CharacterManager.SkillAttack(msg)
end

local function onmsg_SDead(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        character:Death()
    end
end

local function onmsg_SRevive(msg)

    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        character:Revive()
        local uimanager = require "uimanager"
        if uimanager.isshow("dlguimain") then
            local DlgUIMain_Team = require("ui.dlguimain_team")
            DlgUIMain_Team.RefreshTeamMemberHp({id = msg.roleid})
        end
    end
end

local function onmsg_AddEffect(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
         character:AddEffect(msg.effect)
    end
end

local function onmsg_RemoveEffect(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        character:RemoveEffect(msg.id)
    end
end

local function onmsg_SCurveFlyBegin(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character and character:IsPlayer() then
        character:sync_SPathFlyBegin(
            Vector3(msg.curposition.x, msg.curposition.y, msg.curposition.z),
            msg.curveid,
            Vector3(msg.dstposition.x, msg.dstposition.y, msg.dstposition.z),
            msg.portalid)
    end
end

local function onmsg_SBeginTransform(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        character.m_ShapeShift:AddTransformEffect(msg.effectid,msg.remaintime)
    end
end

local function onmsg_SEndTransform(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character then
        character.m_ShapeShift:RemoveTransformEffect()
    end
end

local function onmsg_SEffectRevive(msg)
    local partner = CharacterManager.GetCharacter(msg.roleid)
    if partner then
        partner:PlayReviveEffect(msg.effectid)
    end
end

local function onmsg_SCurveFlyEnd(msg)
    local character = CharacterManager.GetCharacter(msg.roleid)
    if character and character:IsPlayer() then
        if character:IsRole() then
            local RideManager = require "ui.ride.ridemanager"
            RideManager.Ride(character.m_MountId,cfg.equip.RideType.NONE)
        end
        if  msg.orient then
            character:sync_SPathFlyEnd(
                Vector3(msg.orient.x, msg.orient.y, msg.orient.z))
        end
    end
end

---------------------------------------------------------------------------------------------------------
--[[
    鍏朵粬
]]

local function onmsg_STransferWorldUseItem(msg)
    if PlayerRole.Instance()  then
        if msg.worldid == PlayerRole:Instance():GetMapId() then
            PlayerRole:Instance():stop()
            PlayerRole.Instance():sync_SEnter(msg)
        end
    end
end


local function onmsg_SEctypeInfo(msg)
    local player = PlayerRole:Instance()
    if 0 == getn(msg.climbtowers) then
        player.m_ClimbTowerInfo ={[60430001] = {maxfloorid = 0,costtime = 0}}
    else
        player.m_ClimbTowerInfo = msg.climbtowers
    end
    player.m_Chapters = msg.chapters
end

--local function onmsg_SPickItem(msg)
--    local item = CharacterManager.GetCharacter(msg.itemagentid)
--    if item then
--        item.m_Picked = true
--        item.m_BelongToSelf=true
--    end
--end

local function onmsg_SItemChange(msg)
    local item = CharacterManager.GetCharacter(msg.roleid)
    if item then
        item.m_State = msg.state
    end
end

local function onmsg_KillOther(msg)
    local uimanager = require"uimanager"
    local sysInfo = string.format(LocalString.UnderGroundText.Kill,msg.defencername)
    uimanager.call("dlgflytext","AddSystemInfo",sysInfo)
    local ChatManager = require"ui.chat.chatmanager"
    ChatManager.AddMessageInfo{channel=cfg.chat.ChannelType.SYSTEM,text=sysInfo}
end

local function onmsg_BeKillByOther(msg)
    local uimanager = require"uimanager"
    if msg.defencer and msg.defencer == PlayerRole:Instance().m_Id then
        local sysInfo = string.format(LocalString.UnderGroundText.BeKilled,msg.attackername)
        uimanager.call("dlgflytext","AddSystemInfo",sysInfo)
        local ChatManager = require"ui.chat.chatmanager"
        ChatManager.AddMessageInfo{channel=cfg.chat.ChannelType.SYSTEM,text=sysInfo}
    end
end

local function onmsg_ChangePKState(msg)
    local player = CharacterManager.GetCharacter(msg.roleid)
    player:ChangePKState(msg.pkstate)
end

local function onmsg_ChangePetStarLevel(msg)
    local pet = CharacterManager.GetCharacter(msg.roleid)
    if pet then
        -- pet.m_StarLevel = msg.level
        pet:ChangeStarLevel(msg.level)
    end
end

local function onmsg_ChangePetAwakeLevel(msg)
    local pet = CharacterManager.GetCharacter(msg.roleid)
    if pet then
        -- pet.m_AwakeLevel = msg.level
        pet:ChangeAwakeLevel(msg.level)
        -- self:ShowTexture()
    end
end

local function onmsg_ChangeHP(msg)
    local char = CharacterManager.GetCharacter(msg.roleid)
    if char then
        -- char:ChangeHP(msg.hp)
        char:ChangeAttr( { [cfg.fight.AttrId.HP_VALUE] = msg.hp } )
    end
end

local function onmsg_ChangePetSkin(msg)
    CharacterManager.ChangePetSkin(msg.roleid,msg.skinid)
end

local function onmsg_SEnterPKSafeZone(msg)
   -- printyellow("=====================================================")
    local UIManager = require("uimanager")
    local content = LocalString.WorldMap_EnterPKSafeZone
    UIManager.ShowSystemFlyText(content)
end

local function onmsg_SLeavePKSafeZone(msg)
   -- printyellow("=====================================================")
    local UIManager = require("uimanager")
    local content = LocalString.WorldMap_LeavePKSafeZone
    UIManager.ShowSystemFlyText(content)
end

local function onmsg_SChangeLoverName(msg)
    local char = CharacterManager.GetCharacter(msg.roleid)
    if char:IsPlayer() then
        char:SetLoverName(msg.lovername)
    end
end

local function onmsg_SChangeDeclareWarFamilys(msg)
    local char = CharacterManager.GetCharacter(msg.roleid)
    if char and char:IsPlayer() then
        if msg.hasdeclarewar ~= nil then
            char:ChangeDeclareWarFamilys(msg.familys)
        end
        if char:IsRole() then
            GameEvent.evt_notify:trigger(defineenum.NotifyType.FamilyWarStateChange, {})
        end
    end
end

local function NPCRebornSetting()
    local data = ConfigManager.getConfig("reborn")
    for _,rebornData in pairs(data) do
        if rebornData.npcmsg1 ~= nil and rebornData.npcmsg1.npcid ~= nil and rebornData.npcmsg1.npcid > 0 then
            rebornNpcs[rebornData.npcmsg1.npcid] = rebornData.npcmsg1.npcid
            if rebornData.npcmsg1.winnpc ~= nil and rebornData.npcmsg1.winnpc > 0 then
                rebornNpcs[rebornData.npcmsg1.winnpc] = rebornData.npcmsg1.winnpc
            end
        end
        if rebornData.npcmsg2 ~= nil and rebornData.npcmsg2.npcid ~= nil and rebornData.npcmsg2.npcid  > 0 then
            rebornNpcs[rebornData.npcmsg2.npcid] = rebornData.npcmsg2.npcid
            if rebornData.npcmsg2.winnpc ~= nil and rebornData.npcmsg2.winnpc  > 0 then
                rebornNpcs[rebornData.npcmsg2.winnpc] = rebornData.npcmsg2.winnpc
            end
        end
    end
end

local function init()
    bLoadMap = true
    Network.add_listeners( {
        --[[
            鍦板浘鐩稿叧
        ]]
        { "map.msg.SEnterWorld",          onmsg_SEnter                },
        { "lx.gs.map.msg.SLeaveMap",      onmsg_SLeaveWorld           },
        { "map.msg.SReady",               onmsg_ChangeMapReady        },


        { "map.msg.SNearbyPlayerEnter",   onmsg_SNearbyPlayerEnter    },
        { "map.msg.SNearbyNPCEnter",      onmsg_SNearbyNPCEnter       },
        { "map.msg.SNearbyMonsterEnter",  onmsg_SNearbyMonsterEnter   },
        { "map.msg.SNearbyMineEnter",     onmsg_SNearbyMineEnter      },
        --{ "map.msg.SNearbyItemEnter",     onmsg_SNearbyItemEnter      },
        { "map.msg.SNearbyAgentLeave",    onmsg_SNearbyAgentLeave     },
        { "map.msg.SNearbyPetEnter",      onmsg_SNearbyPetEnter       },
        { "map.msg.SNearbyRuneEnter",      onmsg_SNearbyRuneEnter       },



        --[[
            浜虹墿灞炴�х浉鍏充俊鎭殑鍙樻洿
        ]]
        --浜虹墿鍚嶅瓧銆佺瓑绾с�乂IP绛夌骇鍙樻洿
        { "map.msg.SChangeName",          onmsg_SChangeName           },
        { "map.msg.SChangeLevel",         onmsg_SChangeLevel          },
        { "map.msg.SChangeVipLevel",      onmsg_SChangeVipLevel       },
        --浜虹墿瀹舵棌鍙婄О鍙峰彉鏇�
        { "map.msg.SChangeFamily",        onmsg_SChangeFamily         },
        { "map.msg.SChangeTitle",         onmsg_SChangeTitle          },
        --浜虹墿灞炴�у彉鏇�
        { "map.msg.SChangeAttrs",         onmsg_SChangeAttrs          },
        --浜虹墿瑁呭銆佹椂瑁呫�佹硶瀹濆彉鏇�
        { "map.msg.SChangeEquip",         onmsg_SChangeEquip          },
        { "map.msg.SChangeDress",         onmsg_SChangeDress          },
        { "map.msg.SChangeFabao",         onmsg_SChangeFabao          },
        --浜虹墿鍧愰獞銆佺姸鎬佹妧鑳藉彉鏇�
        { "map.msg.SChangeRide",          onmsg_SChangeRide           },
        { "map.msg.SChangeSkill",         onmsg_SChangeSkill          },
        { "map.msg.SChangeLoverName",     onmsg_SChangeLoverName      },
        { "map.msg.SChangeDeclareWarFamilys", onmsg_SChangeDeclareWarFamilys },
        --[[
            浜虹墿琛屼负鐩稿叧
        ]]
        { "map.msg.SOrient",              onmsg_SOrient                 },
        { "map.msg.SMove",                onmsg_SMove                 },
        { "map.msg.SStop",                onmsg_SStop                 },
        { "map.msg.SSkillPerform",        onmsg_SSkillPerform         },
        { "map.msg.SSkillAttack",         onmsg_SSkillAttack          },
        { "map.msg.SChangeHp",              onmsg_ChangeHP},
        { "map.msg.SBeSkillAttack",         onmsg_BeSkillAttack},
        { "map.msg.SFlyWeaponAttack",     onmsg_FlyWeaponAttack     },
        { "map.msg.SSkillInterrupt",      onmsg_SSkillInterrupt       },

        { "map.msg.SDead",                onmsg_SDead                 },
        { "map.msg.SRevive",              onmsg_SRevive               },

        { "map.msg.SAddEffect",           onmsg_AddEffect             },
        { "map.msg.SRemoveEffect",        onmsg_RemoveEffect          },

        { "map.msg.SCurveFlyBegin",            onmsg_SCurveFlyBegin             },
        { "map.msg.SCurveFlyEnd",            onmsg_SCurveFlyEnd             },
        --[[
            鍏朵粬
        ]]
        --{ "map.msg.SPickItem",            onmsg_SPickItem             },
        { "map.msg.SItemChange",          onmsg_SItemChange           },
        { "lx.gs.map.msg.SEctypeInfo",          onmsg_SEctypeInfo           },
        { "map.msg.STransferWorldUseItem",onmsg_STransferWorldUseItem },
        { "lx.gs.pet.msg.SGetPetInfo",          onmsg_SGetPetInfo           },
        { "lx.gs.pet.msg.SUpgradeLevel",        onmsg_UpgradeLevel},
        { "map.msg.SChangePKState",             onmsg_ChangePKState},

        { "lx.gs.map.msg.SKillOther",         onmsg_KillOther},
        { "lx.gs.map.msg.SBekillByOther",     onmsg_BeKillByOther},

        { "map.msg.SChangePetStarLevel",onmsg_ChangePetStarLevel},
        { "map.msg.SChangePetAwakeLevel",onmsg_ChangePetAwakeLevel},
        { "map.msg.SChangePetSkin",     onmsg_ChangePetSkin},

        { "map.msg.SEnterPKSafeZone", onmsg_SEnterPKSafeZone},
        { "map.msg.SLeavePKSafeZone", onmsg_SLeavePKSafeZone},
        
        { "map.msg.SBeginTransform", onmsg_SBeginTransform},
        { "map.msg.SEndTransform", onmsg_SEndTransform},
        { "map.msg.SEffectRevive",onmsg_SEffectRevive},
        
    } )

    NPCRebornSetting()
    --NPCNewYearSetting()
end

return {
    init = init,
}
