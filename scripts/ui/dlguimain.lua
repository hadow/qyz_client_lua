local DlgUIMain_Combat = require("ui.dlguimain_combat")
local DlgUIMain_RoleInfo = require("ui.dlguimain_roleinfo")
local DlgUIMain_HPTip = require("ui.dlguimain_hptip")
local DlgUIMain_MicroPhone = require("ui.dlguimain_microphone")
local DlgUIMain_Novice = require("ui.dlguimain_novice")
local DlgUIMain_HeroChallenge = require("ui.dlguimain_herochallenge")
local dlguimain_partner = require"ui.partner.dlguimain_partner"
local dlguimain_hide = require("ui.dlguimain_hide")
local PetManager    = require"character.pet.petmanager"
local OtherCharacterHead = require("ui.uimain.othercharacterhead")
local PlayerStateTip = require("ui.uimain.playerstatetip")
local RecommendEquipTip = require("ui.uimain.recommendequip")
local UIMain_Anchor = require("ui.uimain.uimain_anchor")
local UIMain_Function = require("ui.uimain.uimain_function")
local DlgUIMain_ActivityTip = require("ui.activity.dlguimain_activitytip")
local DlgUIMain_Task = require("ui.dlguimain_task")
local DlgUIMain_OfflineExp = require("ui.dlguimain_offlineexp")
local DlgUIMain_Team = require("ui.dlguimain_team")
local DlgUIMain_DeclareWar = require("ui.uimain.uimain_declarewar")
local DlgUnlock = require"ui.common.dlgdialogbox_unlock"
local DlgNext = require"ui.common.dlgdialogbox_nextday"
local MaimaiHelpManger = require("ui.maimai.maimaihelpmanager")
local MapManager =require("map.mapmanager")
local Activityexpmanager = require"ui.activity.activityexp.activityexpmanager"
local ActivityTipMgr           = require("ui.activity.activitytipmanager")
local format = string.format
local EventHelper = UIEventListenerHelper
local uimanager = require("uimanager")
local defineenum = require "defineenum"
local PlayerRole
local taskmanager = require "taskmanager"
local miningmanager = require "miningmanager"
local charactermanager = require "character.charactermanager"
local ConfigManager = require "cfg.configmanager"
local EctypeManager = require"ectype.ectypemanager"
local DlgEctypeManager = require"ui.ectype.dlgectypemanager"
local DlgActivityManager = require"ui.activity.dlgactivitymanager"
local LotteryManager = require "ui.lottery.lotterymanager"
local ShopManager = require "shopmanager"
local BagManager = require "character.bagmanager"
local WelfareManager = require "ui.welfare.welfaremanager"
local RankManager = require "ui.rank.rankmanager"
local DlgMain_Open = require("ui.dlgmain_open.main_openmanager")
local TournamentManager   =require("ui.activity.tournament.tournamentmanager")
local ModuleLockManager = require("ui.modulelock.modulelockmanager")
local Paomadeng = require"paomadeng.paomadengmanager"
local TeamManager
local OperationActivity = require("ui.operationactivity.operationactivitymanager")
local lotteryfragmentmgr = require"ui.lottery.lotteryfragment.lotteryfragmentmanager"
local springfestivalinfo = require"ui.activity.springfestival.springfestivalinfo"
local redpacketinfo = require"ui.activity.redpacket.redpacketinfo"
local Camera = UnityEngine.Camera.main
local CameraManager = require("cameramanager")
local CharacterType = defineenum.CharacterType
local NpcStatusType = defineenum.NpcStatusType
local TaskType   = defineenum.TaskType


local gameObject
local name
local fields

local NpcStatusType = defineenum.NpcStatusType
local TaskType   = defineenum.TaskType



local curTaskTabIndex = 0
local refreshMapInfo = 0
local textList
local playerRole
local showing = nil
local showBuffDscriptionTime = 5
local showingEffectId
local showingEffectIdx
local TimerBuffDescription

local Camera = UnityEngine.Camera.main
local CameraManager = require"cameramanager"
local subFunctions = {}

local IsIntheGround

local m_expPrg
local m_WMiniMapScaleRatio=1
local m_HMiniMapScaleRatio=1
local m_ShowDis=50
local Countdown = 0

local m_IsLotteryShowed = nil


local ModuleList     = {}
local MapPlayerObjList = { }
local MapMonsterObjList = {}
local MapNPCObjList = {}
local uiBuffs = {}
local HeadPlayerIcons = {"Sprite_PersonName","Sprite_NameMask","IconFunction_HiddenRole"}
local m_MarriageBroadcastQueue = {}
local m_MarriageBroadcastSecond = 0
local m_IsShowMarriageBroadcast = false

local NextDay = {}
NextDay.n_MoudleShowTime = 0 --用于控制下级功能按钮显示
NextDay.isOpen = false
local  NextFunIsShow = true



local function to2num(value)
    str = tostring(value + 100)
    return str:sub(2)
end

local historyKillMonsterExp = 0

local function updatePlayerRolesEffect(isInit)
    local MaxEffectCount = 5
    if TimerBuffDescription then
        TimerBuffDescription = TimerBuffDescription + Time.deltaTime
        if TimerBuffDescription > showBuffDscriptionTime then
            TimerBuffDescription = nil
            fields.UISprite_BuffDiscription.gameObject:SetActive(false)
        end
    end
    local lst = playerRole.m_Effect:GetEffectList()
    if playerRole.m_Effect:Altered() or isInit then
        playerRole.m_Effect:ChangeAltered()
        local effectList = playerRole.m_Effect:GetEffectList()
        showing = nil

        for i=1,5 do
            if effectList[i] then
                uiBuffs[i].UISprite_Buff.gameObject:SetActive(true)
                uiBuffs[i].UISprite_Buff.spriteName =effectList[i].icon
            else
                uiBuffs[i].UISprite_Buff.gameObject:SetActive(false)
            end
        end
    end
end

local function InitBuffs()
    uiBuffs = {}
    fields.UISprite_BuffDiscription.gameObject:SetActive(false)
    TimerBuffDescription = nil
    fields.UIList_Buff:Clear()
    for i=1,5 do
        local item = fields.UIList_Buff:AddListItem()
        local UISprite_Buff = item.Controls["UISprite_Buff"]
        uiBuffs[i] = {}
        uiBuffs[i].item = item
        uiBuffs[i].UISprite_Buff = UISprite_Buff
        uiBuffs[i].eid = nil
    end
    updatePlayerRolesEffect(true)
end

--==========================================================================================


----------------------------------------------------------------------

local function UpdateAroundObject()
    local characters=charactermanager.GetCharacters()
    local i=0
    local j=0
    local k=0
    for id, character in pairs(characters) do
        local playerRolePos=PlayerRole:Instance():GetRefPos()
        local characterPos=character:GetRefPos()
        if mathutils.DistanceOfXoZ(characterPos,playerRolePos)<m_ShowDis then
            local pos=Vector3((characterPos.x-playerRolePos.x)*m_WMiniMapScaleRatio,(characterPos.z-playerRolePos.z)*m_HMiniMapScaleRatio,0)
            local targetObj=nil
            local UISprite_MapBgObj=fields.UISprite_MapBG.gameObject
            if (character:IsPlayer()) and (not character:IsRole()) then
                i=i+1
                if MapPlayerObjList[i] then
                    targetObj=MapPlayerObjList[i]
                else
                    local playerObj=fields.UISprite_Player.gameObject
                    targetObj=NGUITools.AddChild(UISprite_MapBgObj,playerObj)
                    table.insert(MapPlayerObjList,targetObj)
                end
            elseif character:IsNpc() then
                if (character.m_Object) and (character.m_Object.activeSelf) then
                    j=j+1
                    if MapNPCObjList[j] then
                        targetObj=MapNPCObjList[j]
                    else
                        local npcObj=fields.UISprite_NPC.gameObject
                        targetObj=NGUITools.AddChild(UISprite_MapBgObj,npcObj)
                        table.insert(MapNPCObjList,targetObj)
                    end
                 end
            elseif character:IsMonster() then
                k=k+1
                if MapMonsterObjList[k] then
                    targetObj=MapMonsterObjList[k]
                else
                    local monsterObj=fields.UISprite_Monster.gameObject
                    targetObj=NGUITools.AddChild(UISprite_MapBgObj,monsterObj)
                    table.insert(MapMonsterObjList,targetObj)
                end
            end
            if targetObj then
                targetObj:SetActive(true)
                targetObj.transform.localPosition=pos
            end
        end
    end
    local x=0
    for x=(i+1),#MapPlayerObjList do
        if not IsNull(MapPlayerObjList[x]) then
            MapPlayerObjList[x]:SetActive(false)
        end
    end
    for x=(j+1),#MapNPCObjList do
        if not IsNull(MapNPCObjList[x]) then
            MapNPCObjList[x]:SetActive(false)
        end
    end
    for x=(k+1),#MapMonsterObjList do
        if not IsNull(MapMonsterObjList[x]) then
            MapMonsterObjList[x]:SetActive(false)
        end
    end
end

local function UpdateMiniMapInfo()
    if not EctypeManager.IsInEctype() then
        if PlayerRole:Instance() and PlayerRole:Instance().m_Object then
            if refreshMapInfo and os.time() - refreshMapInfo >= 1 then
                refreshMapInfo = os.time()
                local mPlayerTransform = PlayerRole:Instance().m_Object.transform
                local UISprite_Player = fields.UISprite_PlayerRole
                UISprite_Player.transform.rotation = Quaternion.Euler(0, 0, - mPlayerTransform.rotation.eulerAngles.y)
                local UITexture_Map=fields.UITexture_Map
                UITexture_Map.transform.localPosition =MapManager.GetTransferCoord(mPlayerTransform.position,m_WMiniMapScaleRatio,m_HMiniMapScaleRatio)
                fields.UILabel_XY.text = math.ceil(mPlayerTransform.position.x) .. "," .. math.ceil(mPlayerTransform.position.z)
                UpdateAroundObject()
            end
        end
    end
end

local elapsedtime = -60

local function UpdateTime()
    if os.time()- elapsedtime > 60 then
        local ttime
        elapsedtime = os.time()
        ttime = os.date("*t")
        fields.UILabel_Time.text = string.format("%2d:%.2d", ttime.hour, ttime.min)
    end

end

local function RefreshMiniMap()
    local UITexture_Map=fields.UITexture_Map
    local ConfigManager=require"cfg.configmanager"
    local mapData=ConfigManager.getConfigData("worldmap",PlayerRole:Instance():GetMapId())
    if mapData then
        local sceneName=mapData.scenename
        local sceneData=ConfigManager.getConfigData("scene",sceneName)
        local thunbnailSize=sceneData.thunbnailsize
        local sceneSize=sceneData.scenesize
        UITexture_Map:SetIconTexture(sceneName)
        UITexture_Map.width=thunbnailSize
        UITexture_Map.height=thunbnailSize
        m_WMiniMapScaleRatio = thunbnailSize / sceneSize
        m_HMiniMapScaleRatio = thunbnailSize / sceneSize
	      local UISprite_MapBG=fields.UISprite_MapBG
        local showAreaSize=UISprite_MapBG.width/2
        m_ShowDis=showAreaSize*sceneSize/thunbnailSize
    end
end

local function DetectCharacterClick()
    local clickEvent = false
    local clickPos = Vector3(0,0,0)
    if Input.GetMouseButtonDown(0) then
        clickEvent = true
        clickPos = Input.mousePosition
      --  printyellow("dlguimain 1")
    elseif Input.touchCount > 0 and Input.GetTouch(0).phase == TouchPhase.Began then
        clickEvent = true
        clickPos = Input.mousePosition
    end
    if clickEvent then
        -- printyellow("Left Click")
        local NoviceGuideManager=require"noviceguide.noviceguidemanager"
        if (not uimanager.isshow("dlguimain")) or (NoviceGuideManager.IsGuiding()) or (uimanager.isshow("dlgalert_reminder_singlebutton")) or (uimanager.isshow("dlgalert_reminderimportant")) or (uimanager.isshow("dlgalert_reminder")) then
            return
        end
        local ray = Camera:ScreenPointToRay(clickPos)
        local ret = false
        local hit = nil
        ret, hit = Physics.Raycast(ray, hit)
        if ret and hit and hit.collider and hit.transform then
            local gameObj = hit.collider.gameObject
            local characters = charactermanager.GetCharacters()
            for id, char in pairs(characters) do
                if char.m_Object and char.m_Object == gameObj then
                    OtherCharacterHead.SetHeadInfo(true, char)
                    if not char:IsRole() and not char:IsMineral() and not char:IsNpc() then
                        PlayerRole:Instance():SetTarget(char)
                    end
                elseif not char:IsSimplified() and  char:IsPlayer() and char:IsClick(gameObj) then
                    OtherCharacterHead.SetHeadInfo(true, char)
                end
                -- 矿物
                if char.m_Type == CharacterType.Mineral and char.m_Object == gameObj and miningmanager.GetCurMineID() ~= char.m_Id then
                    if miningmanager.IsCanBeMined(char.m_Id) then
                        miningmanager.NavigateToMine(char.m_Id, char:GetPos())
                    end
                    break
                end

                -- NPC
                if char.m_Type == CharacterType.Npc and char.m_Object == gameObj then
                    local npcstatus = taskmanager.GetNpcStatus(char.m_CsvId)
                    if npcstatus and npcstatus ~= NpcStatusType.None then
                        local allNpcStatus = taskmanager.GetAllNpcStatus(char.m_CsvId)
                        local taskid = 0
                        -- 优先顺序：主线>支线>家族环
                        local priority = 0
                        for _key, _value in pairs(allNpcStatus) do
                            if _value == npcstatus then
                                local tasktype = taskmanager.GetTaskType(_key)
                                if tasktype == TaskType.Mainline then
                                     taskid = _key
                                     break
                                elseif tasktype == TaskType.Branch and priority < 2 then
                                    taskid = _key
                                    priority = 2
                                elseif tasktype == TaskType.Family and priority < 1 then
                                    taskid = _key
                                    priority = 1
                                end
                            end
                        end

                        local task = taskmanager.GetTask(taskid)
                        if npcstatus == NpcStatusType.CanAcceptTask then
                            taskmanager.AcceptTask(char.m_CsvId, task.id)
                        elseif npcstatus == NpcStatusType.CanCommitTask then
                            taskmanager.NavigateToRewardNPC(char.m_CsvId, task.id)
                        end
                    else
                        local heroChallengeManager = require("ui.activity.herochallenge.herochallengemanager")
                        if char.m_CsvId == 23000385 then      --家族广场对应的黑市商人
                            uimanager.showdialog("dlgshop_common",nil,3)
                        elseif char.m_CsvId == 23000384 then  --家族广场对应的仙府聚宴管理者
                            uimanager.show("family.dlgbanquet")
                        elseif char.m_CsvId == 23000454 then  --药店
							              local CarryShopManager = require"ui.carryshop.carryshopmanager"
							              local items = CarryShopManager.GetItemsByLevel(PlayerRole:Instance().m_Level)
							              uimanager.showdialog("carryshop.dlgcarryshop",{items = items})
						            elseif char.m_CsvId==23000455 then --仓库
							              uimanager.showdialog("dlgwarehouse")
							          elseif char.m_CsvId == heroChallengeManager.GetNpcId() then  --英雄挑战副本npc
							              heroChallengeManager.DisplayNpcTalk()
							          elseif char.m_CsvId == heroChallengeManager.GetCurTaskNpc() then
							              heroChallengeManager.OpenTask()
                        else
                            --复活碧瑶
                            local ResurgenceBiyaoManager= require "ui.resurgencebiyao.resurgencebiyaomanager"
                            local rebornData = ResurgenceBiyaoManager.getLocalConfig()
                            if rebornData then
                                if char.m_CsvId==rebornData.npcmsg1.npcid then
                                    uimanager.show("resurgencebiyao.dlgalert_delivery",{HeroData = rebornData.npcmsg1})
                                end
                                if char.m_CsvId==rebornData.npcmsg2.npcid then
                                    uimanager.show("resurgencebiyao.dlgalert_delivery",{HeroData = rebornData.npcmsg2})
                                end
                                if char.m_CsvId==rebornData.npcmsg1.winnpc then
                                    local heroData = {}
                                    heroData.talkdecs = rebornData.npcmsg1.winnpctalk
                                    heroData.npchead = rebornData.npcmsg1.winnpchead
                                    heroData.npcname = rebornData.npcmsg1.winnpcname
                                    uimanager.show("resurgencebiyao.dlgalert_delivery",{HeroData = heroData,justTalk = true})
                                end
                            end     
						end
                    end
                    break
                end
            end
        end
    end
end

local function refreshTime(time)
    if time >300 then
        time = 300
    end
    if time < 100 then
		    fields.UILabel_DelayTime.text = string.format("[FFFFFF] %dms",time)
	  elseif time < 500 then
		    fields.UILabel_DelayTime.text = string.format("[FFD700] %dms",time)
	  else
		    fields.UILabel_DelayTime.text = string.format("[FF0000] %dms",time)
	  end
end

local function RefreshFPS(str)
    fields.UILabel_FPS.text=str
end

local function ClickOnCharacter(position)
    dlguimain_hide.ClickOnCharacter(position)
end

local function DragingJoystick()
    dlguimain_hide.DragingJoystick()
end

local function ClickSetRedDot(type)
    local module=ModuleList[type]
    if module then
        local moduleData=ConfigManager.getConfigData("uimainreddot",type)
        if moduleData.dottype==cfg.ui.DotType.ONCE then
            module.click=true
        end
    end
end

local function OnButton_Partner()
    uimanager.showdialog("partner.dlgpartner_list")
end

local function OnButton_Pray()
    uimanager.showdialog("lottery.dlglottery")
end

local function OnButton_Bag()
    ClickSetRedDot(cfg.ui.FunctionList.BAG)
    local bagmanager = require("character.bagmanager")
    uimanager.showdialog("playerrole.dlgplayerrole",nil,2)
end

local function OnButton_Shop()
    ClickSetRedDot(cfg.ui.FunctionList.SHOP)
    uimanager.showdialog("dlgshop_common",nil,1)
end

local function OnButton_Welfare()
    ClickSetRedDot(cfg.ui.FunctionList.WELFARE)
    uimanager.showdialog("welfare.dlgwelfaremain")
end

local function OnButton_Liveness()
    ClickSetRedDot(cfg.ui.FunctionList.LIVENESS)
    uimanager.showdialog("guide.dlglivenessmain")
end

local function OnButton_Ectype()
    if TeamManager.IsInHeroTeam() then
        TeamManager.ShowQuitHeroTeam()
    else
        ClickSetRedDot(cfg.ui.FunctionList.ECTYPE)
        uimanager.showdialog("ectype.dlgentrance_copy")
    end
end

local function OnButton_Activity()
    ClickSetRedDot(cfg.ui.FunctionList.ACTIVITY)
    uimanager.showdialog("activity.dlgactivity")
end

local function OnButton_Head()
    --uimanager.showdialog("dlgmain_open")
    uimanager.showdialog("playerrole.dlgplayerrole")
end

local function OnButton_Family()
    ClickSetRedDot(cfg.ui.FunctionList.FAMILY)
    local mgr = require("family.familymanager")
    mgr.OpenDlg()
end

local function OnButton_RankList()
	ClickSetRedDot(cfg.ui.FunctionList.RANKLIST)
    uimanager.showdialog("rank.dlgranklist")
end

local function OnButton_Friend()
    uimanager.showdialog("friend.dlgfriend")
end

local function OnButton_Strech()
	  local channelid = Game.Platform.Interface.Instance:GetSDKPlatform()
	  if channelid == 39 then
		    if fields.UIButton_QQVip.gameObject.activeSelf then
			      fields.UIButton_QQVip.gameObject:SetActive(false)
		    else
			      fields.UIButton_QQVip.gameObject:SetActive(true)
		    end
	  end
end

local function OnButton_ExtraExp()
    if TeamManager.IsInHeroTeam() then
        TeamManager.ShowQuitHeroTeam()
    else
        uimanager.showdialog("dlgdailyexp")
    end
end

local function ExtraExp_UnRead()
    local expdata = ConfigManager.getConfigData("exptable", PlayerRole:Instance().m_Level)
    if expdata ~= nil then
        local remainExp = expdata.bonusexp - PlayerRole:Instance().m_TodayKillMonsterExtraExp
        if remainExp > 0 then
            return true
        else
            return false
        end
    end
    return false
end


local function OnButton_Battle()
    if TeamManager.IsInHeroTeam() then
        TeamManager.ShowQuitHeroTeam()
    else
        ClickSetRedDot(cfg.ui.FunctionList.BATTLE)
        uimanager.showdialog("arena.dlgarena")
    end
end

local function OnButton_OperationActivity()
    uimanager.showdialog("operationactivity.dlgoperationactivity")
end

local function OnUIGroup_Vip()
	  uimanager.showdialog("vipcharge.dlgprivilege_vip")
end

local function StrechUnRead()
    return ((ModuleLockManager.GetModuleStatusByType(cfg.ui.FunctionList.BATTLE)==defineenum.ModuleStatus.UNLOCK) and require("ui.arena.modulearena").UnRead())
           or ((ModuleLockManager.GetModuleStatusByType(cfg.ui.FunctionList.ACTIVITY)==defineenum.ModuleStatus.UNLOCK) and DlgActivityManager.UnRead())
           or ((ModuleLockManager.GetModuleStatusByType(cfg.ui.FunctionList.FAMILY)==defineenum.ModuleStatus.UNLOCK) and require("family.familymanager").UnRead())
           or ((ModuleLockManager.GetModuleStatusByType(cfg.ui.FunctionList.ECTYPE)==defineenum.ModuleStatus.UNLOCK) and DlgEctypeManager.UnRead())
end

local function OnButtonStar()
    uimanager.showdialog("friend.dlgfriend",{listIndex=2})
end

local function OnButtonLottery()
    uimanager.showdialog("lottery.lotteryfragment.dlglotteryfragment")
end

local function OnButtonSpringFestival()
    uimanager.showdialog("activity.springfestival.dlgspringfestivalgifts")
end

local function OnButtonSendRedPacket()
    uimanager.showdialog("activity.redpacket.dlgsendred")
end

local function OnButtonReceiveRedPacket()
    uimanager.showdialog("activity.redpacket.dlgred")
end

local function OnButtonFirstCharge()
    --uimanager.showdialog("vipcharge.dlgfirstofcharge")
    uimanager.showdialogonlyself("vipcharge.dlgfirstofcharge")
end

local function OnButtonReCharge()
    uimanager.showdialog("vipcharge.dlgrecharge")
end

local function OnButtonSpringBonus()
    uimanager.showdialog("springbonus.dlgspringbonus")
end

--local function OnButtonSkill()
--    uimanager.showdialog("skill.dlgskill")
--end

--local function OnButtonMaimai()
--    uimanager.showdialog("maimai.dlgmaimai")
--end

--local function OnButtonPokedex()
--    uimanager.showdialog("illustrates.dlgillustrate")
--end

--local function OnButtonAuction()
--    uimanager.showdialog("exchange.dlgexchange")
--end

--local function OnButtonPharmacy()
--
--    local CarryShopManager = require("ui.carryshop.carryshopmanager")
--    CarryShopManager.NavigateToCarryShopNPC()
--end

--local function OnButtonCornucopia()
--    uimanager.showdialog("cornucopia.dlgcornucopia")
--end

--local function OnButtonAchievement()
--    uimanager.showdialog("achievement.dlgachievement")
--end

--local function OnButtonTitle()
--    uimanager.showdialog("title.dlgtitle")
--end


local function RegisterAllModules()
    ModuleList=
    {
        [cfg.ui.FunctionList.BAG]           = {click=false,icon=fields.UIButton_Bag,redDotFunc=(BagManager.UnRead),callBackFunc=OnButton_Bag},
        [cfg.ui.FunctionList.WELFARE]       = {icon=fields.UIButton_AwardCenterIcon,redDotFunc=(WelfareManager.UnRead),callBackFunc=OnButton_Welfare},
        [cfg.ui.FunctionList.RANKLIST]      = {icon=fields.UIButton_Ranklist,redDotFunc=(RankManager.UnRead),callBackFunc=OnButton_RankList},
	      [cfg.ui.FunctionList.SHOP]          = {icon=fields.UIButton_ShopIcon,redDotFunc=(ShopManager.UnRead),callBackFunc=OnButton_Shop},
        [cfg.ui.FunctionList.ECTYPE]        = {icon=fields.UIButton_Instance,redDotFunc=(DlgEctypeManager.UnRead),callBackFunc=OnButton_Ectype},
        [cfg.ui.FunctionList.ACTIVITY]      = {icon=fields.UIButton_Activity,redDotFunc=(DlgActivityManager.UnRead),callBackFunc=OnButton_Activity},
        [cfg.ui.FunctionList.PRAY]          = {icon=fields.UIButton_Pray,redDotFunc=(LotteryManager.UnRead),callBackFunc=OnButton_Pray},
        [cfg.ui.FunctionList.HEAD]          = {icon=fields.UISprite_HeroHeadAll,redDotFunc=(DlgMain_Open.UnRead),callBackFunc=OnButton_Head},
        [cfg.ui.FunctionList.FAMILY]        = {icon=fields.UIButton_Family,redDotFunc=(require("family.familymanager").UnRead),callBackFunc=OnButton_Family},
        [cfg.ui.FunctionList.MOUNTSHORTCUT] = {icon=fields.UIButton_Ride,callBackFunc = DlgUIMain_Combat.OnButton_Ride},
        [cfg.ui.FunctionList.PARTNER]       = {icon=fields.UIButton_Partner,callBackFunc=OnButton_Partner,redDotFunc=PetManager.UnRead},
        [cfg.ui.FunctionList.FRIEND]        = {icon=fields.UIButton_Friend,redDotFunc=(require("ui.friend.friendmanager").UnRead),callBackFunc=OnButton_Friend},
        [cfg.ui.FunctionList.DAILYEXTRAEXP] = {icon=fields.UISprite_KillEXP,redDotFunc=ExtraExp_UnRead, callBackFunc=OnButton_ExtraExp},
        [cfg.ui.FunctionList.BATTLE]        = {icon=fields.UIButton_Battlefield,redDotFunc=(require("ui.arena.modulearena").UnRead),callBackFunc=OnButton_Battle},
        [cfg.ui.FunctionList.TFBOYS]        = {icon=fields.UIButton_ActivityIcon,redDotFunc=(OperationActivity.UnRead),callBackFunc=OnButton_OperationActivity},
        [cfg.ui.FunctionList.PLUSSIGN]      = {icon=fields.UIButton_Stretch,redDotFunc=(StrechUnRead),callBackFunc=OnButton_Strech},
        [cfg.ui.FunctionList.LIVENESS]      = {icon=fields.UIButton_Active,redDotFunc=(require("guide.livenessmanager").UnRead),callBackFunc=OnButton_Liveness},
        [cfg.ui.FunctionList.VIPLEVEL]      = {icon=fields.UIGroup_Vip,redDotFunc=(require("ui.vipcharge.vipchargemanager").UnRead),callBackFunc=OnUIGroup_Vip},
        [cfg.ui.FunctionList.IDOL]          = {icon=fields.UIButton_Stars, redDotFunc=(require("ui.friend.friendmanager")).ShowRewardsRedDot,callBackFunc=OnButtonStar},
		    [cfg.ui.FunctionList.FIRSTCHARGE]   = {icon=fields.UISprite_FirstOfCharge,redDotFunc=(require("ui.vipcharge.vipchargemanager")).UnReadFirstCharge,callBackFunc=OnButtonFirstCharge},
		    [cfg.ui.FunctionList.RECHARGE]      = {icon=fields.UISprite_Recharge,redDotFunc=(require("ui.vipcharge.vipchargemanager")).UnReadReCharge,callBackFunc=OnButtonReCharge},
        [cfg.ui.FunctionList.LOTTERY]       = {icon=fields.UIButton_Lottery, redDotFunc=(require("ui.lottery.lotteryfragment.lotteryfragmentmanager")).UnRead,callBackFunc=OnButtonLottery},
        [cfg.ui.FunctionList.SPRINGFESTIVAL]       = {icon=fields.UIButton_Login, redDotFunc=(require("ui.activity.springfestival.springfestivalmanager")).UnRead,callBackFunc=OnButtonSpringFestival},
        [cfg.ui.FunctionList.SENDREDPACKET]       = {icon=fields.UIButton_Red, redDotFunc=(require("ui.activity.redpacket.redpacketmanager")).UnReadSend,callBackFunc=OnButtonSendRedPacket},
        [cfg.ui.FunctionList.RECEIVEREDPACKET]       = {icon=fields.UIButton_RedGet, redDotFunc=(require("ui.activity.redpacket.redpacketmanager")).UnReadReceive,callBackFunc=OnButtonReceiveRedPacket},
        [cfg.ui.FunctionList.SPRINGBONUS]   = {icon=fields.UIButton_Spring,redDotFunc=require("ui.springbonus.springbonusmanager").UnRead,callBackFunc=OnButtonSpringBonus},
        --new add
        [cfg.ui.FunctionList.SKILL]         ={icon=fields.UIButton_Skill,redDotFunc=require("character.skill.roleskill").UnRead,callBackFunc=function () uimanager.showdialog("skill.dlgskill") end},
        [cfg.ui.FunctionList.MAIMAI]        ={icon=fields.UIButton_Maimai,callBackFunc=function ()uimanager.showdialog("maimai.dlgmaimai") end},
        [cfg.ui.FunctionList.ILLUSTRATION]  ={icon=fields.UIButton_Pokedex,redDotFunc=require("character.pet.petmanager").HaveAwardPet,callBackFunc=function () uimanager.showdialog("illustrates.dlgillustrate") end},
        [cfg.ui.FunctionList.EXCHANGE]      ={icon=fields.UIButton_Auction,redDotFunc=require("ui.exchange.exchangemanager").UnRead,callBackFunc=function () uimanager.showdialog("exchange.dlgexchange")
        end},
        [cfg.ui.FunctionList.PHARMACY]      ={icon=fields.UIButton_Shop,callBackFunc=function()
            local CarryShopManager = require("ui.carryshop.carryshopmanager")
            CarryShopManager.NavigateToCarryShopNPC()
        end},
        [cfg.ui.FunctionList.CORNUCOPIA]    ={icon=fields.UIButton_ResourseEx,redDotFunc=require("ui.cornucopia.compressmanager").UnRead,callBackFunc=function ()
            uimanager.showdialog("cornucopia.dlgcornucopia")

        end},
        [cfg.ui.FunctionList.ACHIEVEMENT]   ={icon=fields.UIButton_Achievement,redDotFunc=require("ui.achievement.achievementmanager").UnRead,callBackFunc=function ()
            uimanager.showdialog("achievement.dlgachievement")
        end},
        [cfg.ui.FunctionList.TITLE]         ={icon=fields.UIButton_Title,redDotFunc=require("ui.title.titlemanager").UnRead,callBackFunc=function ()
            uimanager.showdialog("title.dlgtitle")
        end},
        [cfg.ui.FunctionList.MAIL]          ={icon=fields.UIButton_Email,redDotFunc=require("ui.mail.mailmanager").UnRead,callBackFunc=function()
            uimanager.showdialog("mail.dlgmail")
        end},
        [cfg.ui.FunctionList.SETTING]       ={icon=fields.UIButton_Community,redDotFunc=require("character.settingmanager").UnRead,callBackFunc=function()
            uimanager.showdialog("dlgautofight")
        end },
        [cfg.ui.FunctionList.MOUNT]         ={icon=fields.UIButton_Ride,redDotFunc=require("ui.ride.ridemanager").UnRead,callBackFunc=function()
            uimanager.showdialog("ride.dlgridedisplay")
        end},
        [cfg.ui.FunctionList.FASHION]       ={icon=fields.UIButton_Fashion,redDotFunc=require("character.fashionmanager").UnRead,callBackFunc=function()
            uimanager.showdialog("dlgfashion",{fashiontype="role"})
        end},



    }
end

local function GetModule(type)
    return ModuleList[type]
end

local function RefreshModuleByType(type)
    local moduleData=ModuleList[type]
    if moduleData then
        local configData=ConfigManager.getConfigData("uimainreddot",type)
        local conditionData=ConfigManager.getConfigData("moduleunlockcond",configData.conid)
        local status=ModuleLockManager.GetModuleStatusByType(type)
        if status==defineenum.ModuleStatus.LOCKED then  --未解锁
            if configData.opentype==cfg.ui.FunctionOpenType.APPEAR then
                moduleData.icon.gameObject:SetActive(false)
            elseif configData.opentype==cfg.ui.FunctionOpenType.UNLOCK then
                local lockObj=moduleData.icon.gameObject.transform:Find("UISprite_Lock")
                if lockObj then
                    lockObj.gameObject:SetActive(true)
                end
                local redDotSprite=moduleData.icon.gameObject.transform:Find("UISprite_Warning")
                if redDotSprite then
                    redDotSprite.gameObject:SetActive(false)
                end
                EventHelper.SetClick(moduleData.icon,function()
                    if conditionData then
                        local text=""
                        if conditionData.openlevel~=0 then
                            text=(conditionData.openlevel)..(LocalString.WorldMap_OpenLevel)
                        elseif conditionData.opentaskid~=0 then
                            local taskData=ConfigManager.getConfigData("task",conditionData.opentaskid)
                            if taskData then
                                text=string.format(LocalString.CompleteTaskOpen,taskData.basic.name)
                            end
                        end
                        uimanager.ShowSystemFlyText(text)
                    end

                end)
            end
        elseif status==defineenum.ModuleStatus.UNLOCK then  --已解锁
            if configData.opentype==cfg.ui.FunctionOpenType.APPEAR then
                moduleData.icon.gameObject:SetActive(true)
            elseif configData.opentype==cfg.ui.FunctionOpenType.UNLOCK then
                local lockObj=moduleData.icon.gameObject.transform:Find("UISprite_Lock")
                if lockObj then
                    lockObj.gameObject:SetActive(false)
                end
                local redDotSprite=moduleData.icon.gameObject.transform:Find("UISprite_Warning")
                if redDotSprite then
                    if configData and (((configData.dottype==cfg.ui.DotType.ONCE) and (moduleData.click)) or (configData.dottype==cfg.ui.DotType.NONE)) then
                        redDotSprite.gameObject:SetActive(false)
                    else
                        if moduleData.redDotFunc~=nil then
                            redDotSprite.gameObject:SetActive(moduleData.redDotFunc())
                        end
                    end
                end
            end
            EventHelper.SetClick(moduleData.icon,function()
                if moduleData.callBackFunc then
                    moduleData.callBackFunc()
                end
            end)
        end
    end
end

local function RefreshAllModules()
    for id,moduleData in pairs(ModuleList) do
        RefreshModuleByType(id)
    end
end

local function RefreshRedDotType(type)
    local module=ModuleList[type]
    if module then
        module.click=false
        if (uimanager.isshow(name)) then
            local redDotSprite=module.icon.gameObject.transform:Find("UISprite_Warning")
            local configData=ConfigManager.getConfigData("uimainreddot",type)
            if redDotSprite  and configData and (configData.dottype~=cfg.ui.DotType.NONE) then
                redDotSprite.gameObject:SetActive(module.redDotFunc())
            else
                redDotSprite.gameObject:SetActive(false)
            end
        end
    end
end

local function RefreshMapName()
    -- 设置小地图显示
    local UILabel_MapName = fields.UILabel_MapName
    local UILabel_Line = fields.UILabel_Line
    local worldMapData = ConfigManager.getConfigData("worldmap", PlayerRole:Instance():GetMapId())
    local mapNameText = ""
    if worldMapData and worldMapData.mapname then
        mapNameText = worldMapData.mapname
    end
    UILabel_MapName.text = mapNameText
    local familymgr = require("family.familymanager")
    if familymgr.IsInStation() then
        UILabel_Line.text = ""
    else
        UILabel_Line.text =(PlayerRole:Instance().m_MapInfo:GetLineId()) ..(LocalString.LineMap_Line)
    end

end

local function RefreshTaskList()
    DlgUIMain_Task.RefreshTaskList()
end

local function  OnQuitFamily()
    RefreshTaskList()
    if uimanager.isshow("dlgtask") then
        uimanager.call("dlgtask","OnQuitFamily")
    end
end

local function  ShowGetOfflineExpUI()
    DlgUIMain_OfflineExp.ShowGetOfflineExpUI()
end

local function PaomadengShow()
	  if not Paomadeng.IsPaomadengMsgEmpty() then
 		    fields.UILabel_SystemMessage.transform.localPosition = Paomadeng.GetCurPostionPaomadeng()
	  end
end

local function late_update()
    for _,d in pairs(subFunctions) do
        if d.late_update then
           d.late_update()
        end
    end
end

local function SetLotteryEnabled(value)
    if nil~=value and value~=m_IsLotteryShowed then
        m_IsLotteryShowed = value
        fields.UIButton_Lottery.gameObject:SetActive(m_IsLotteryShowed)
    end
end

local m_IsSpringFestivalShowed = nil
local function SetSpringFestivalEnabled(value)
    if nil~=value then
        if  value~=m_IsSpringFestivalShowed then
            m_IsSpringFestivalShowed = value
            fields.UIButton_Login.gameObject:SetActive(m_IsSpringFestivalShowed)        
        end

        if true==m_IsSpringFestivalShowed then
            local currentdailybonus = springfestivalinfo.GetCurrentDailyBonus()
            local stringbutton = LocalString.Spring_Festival_Award_Fetched_Button
            if currentdailybonus then
                if springfestivalinfo.IsDailyBonusFetched(currentdailybonus) then
                    stringbutton = LocalString.Spring_Festival_Award_Fetched_Button
                else
                    if springfestivalinfo.GetLoginTime()>=currentdailybonus.time then
                        stringbutton = LocalString.Spring_Festival_Award_Ready
                    else
                        stringbutton = timeutils.getDateTimeString(springfestivalinfo.GetFetchCountdown(), "mm:ss")               
                    end
                end    
            end            
            fields.UILabel_Login.text = stringbutton
        end
    end
end

local m_IsSendRedPacketShowed = nil
local function SetSendRedPacketEnabled(value)
    if nil~=value and value~=m_IsSendRedPacketShowed then
        m_IsSendRedPacketShowed = value
        fields.UIButton_Red.gameObject:SetActive(m_IsSendRedPacketShowed)
    end
end

local m_IsReceiveRedPacketShowed = nil
local function SetReceiveRedPacketEnabled(value)
    if nil~=value then
        if true==value then
            fields.UILabel_RedGet.text = redpacketinfo.GetUnfetchedCount()
        end
        if value~=m_IsReceiveRedPacketShowed  then        
            m_IsReceiveRedPacketShowed = value
            fields.UIButton_RedGet.gameObject:SetActive(m_IsReceiveRedPacketShowed)        
        end
    end
end

local function update()
    for _, d in pairs(subFunctions) do
        if d.update then
            d.update()
        end
    end
    --status.EndSample()

    --status.BeginSample("DlgUIMain_Combat update")
    DlgUIMain_Combat.update()
    --status.EndSample()

    --status.BeginSample("DlgUIMain_RoleInfo update")
    DlgUIMain_RoleInfo.update()
    --status.EndSample()

    --status.BeginSample("DlgUIMain_HPTip update")
    DlgUIMain_HPTip.update()
    --status.EndSample()

    --status.BeginSample("updatePlayerRolesEffect")
    updatePlayerRolesEffect()
    --status.EndSample()
	PaomadengShow()
--    Paomadeng.update()

    -- updateCharacterInfoOnUI()
    -- local UISprite_Skill03 = fields.UISprite_Skill03
    --status.BeginSample("update for Task")



    DlgUIMain_Task.update()
    DlgUIMain_OfflineExp.update()

    --status.EndSample()

    --status.BeginSample("DetectCharacterClick")
        -- 射线检测Character是否选中
        DetectCharacterClick()
    --status.EndSample()

    --status.BeginSample("UpdateMiniMapInfo")
        UpdateMiniMapInfo()
    --status.EndSample()

    --status.BeginSample("UpdateTime")
        UpdateTime()
    --status.EndSample()

	--status.BeginSample("DlgUIMain_MicroPhone update")
		DlgUIMain_MicroPhone.update()
	--status.EndSample()

    --status.BeginSample("PaomadengShow")
	--PaomadengShow()
    --status.EndSample()

    --status.BeginSample("DlgUIMain_ActivityTip update")
    DlgUIMain_ActivityTip.update()
    --status.EndSample()

    --lottery
    SetLotteryEnabled(lotteryfragmentmgr.IsLotteryOpen())
end

local function AddMarriageBroadcast(params)
    m_MarriageBroadcastQueue:Push(params)
end

local function DisplayMarriageBroadcast(info)
    if info then
        fields.UILabel_Marriage.text = info
        fields.UIGroup_MarriageBrpadcast.gameObject:SetActive(true)
        m_MarriageBroadcastSecond = 0
        m_IsShowMarriageBroadcast = true
    end
end

local function refreshNextDayTime()
    if Countdown > 0 then
        fields.UISprite_Next_Warning.gameObject:SetActive(false)
        fields.UILabel_NextDayTime.text = timeutils.getDateTimeString(Countdown,"hh:mm:ss")
    else
        fields.UISprite_Next_Warning.gameObject:SetActive(true)
        fields.UILabel_NextDayTime.text = LocalString.Task_GetReward
    end
end

local function setNxtFunIsShow(show)
    if show~=NextFunIsShow then
        fields.UIPlayTweens_NextTween.gameObject:SetActive(show)
        NextFunIsShow = show
        NextDay.n_MoudleShowTime = 0
    end
end

NextDay.PlayAnimation  = function(forward)
    NextDay.isOpen = not forward
    fields.UIPlayTweens_NextTween.gameObject:SetActive(true)
    EventHelper.SetPlayTweensFinish(fields.UIPlayTweens_NextTween,function()
        if NextDay.isOpen then
            fields.UISprite_PointRight.gameObject:SetActive(true)
            fields.UISprite_PointLeft.gameObject:SetActive(false)
        else
            fields.UISprite_PointRight.gameObject:SetActive(false)
            fields.UISprite_PointLeft.gameObject:SetActive(true)
        end
    end)
    fields.UIPlayTweens_NextTween:Play(forward)
end

local function second_update(now)
    for _,d in pairs(subFunctions) do
        if d.second_update then
            d.second_update()
        end
    end
    if m_IsShowMarriageBroadcast then
        m_MarriageBroadcastSecond = m_MarriageBroadcastSecond + 1
        if m_MarriageBroadcastSecond == 5 then
            fields.UIGroup_MarriageBrpadcast.gameObject:SetActive(false)
        elseif m_MarriageBroadcastSecond == 6 then
            m_IsShowMarriageBroadcast = false
        end
    end
    if getn(m_MarriageBroadcastQueue) and not m_IsShowMarriageBroadcast then
        local info = m_MarriageBroadcastQueue:Pop()
        DisplayMarriageBroadcast(info)
    end

    NextDay.n_MoudleShowTime = NextDay.n_MoudleShowTime + 1
    if Countdown >= 0 then
        Countdown = Countdown -1
        refreshNextDayTime()
    end

    if NextDay.n_MoudleShowTime == 1 and NextFunIsShow then
        fields.UISprite_PointRight.gameObject:SetActive(false)
        fields.UISprite_PointLeft.gameObject:SetActive(true)
        NextDay.PlayAnimation(false)
    end

    if NextDay.n_MoudleShowTime == 16 and NextFunIsShow then
        NextDay.PlayAnimation(true)
    end
    local ResurgenceBiyaoManager= require "ui.resurgencebiyao.resurgencebiyaomanager"
    if ResurgenceBiyaoManager.getLocalOpenState()~= ResurgenceBiyaoManager.getOpenState() then
        DetectCharacterClick()
        ResurgenceBiyaoManager.synchroOpenState()
    end


    local expdata = ConfigManager.getConfigData("exptable", PlayerRole:Instance().m_Level)
    if expdata ~= nil and expdata.bonusexp > 0 then
        local totalExtraExpLimit = expdata.bonusexp
        if PlayerRole:Instance().m_worldlevelrate > 0 then
            totalExtraExpLimit = math.floor(totalExtraExpLimit * PlayerRole:Instance().m_worldlevelrate)
        end
        local curKillMonsterExp = math.floor(100*PlayerRole:Instance().m_TodayKillMonsterExtraExp / totalExtraExpLimit)
        if curKillMonsterExp ~= historyKillMonsterExp then
            historyKillMonsterExp = curKillMonsterExp
            fields.UISlider_KillEXP.value = 1.0 - PlayerRole:Instance().m_TodayKillMonsterExtraExp / totalExtraExpLimit
            RefreshRedDotType(cfg.ui.FunctionList.DAILYEXTRAEXP)
        end
    end

    --SpringFestival
    SetSpringFestivalEnabled(springfestivalinfo.IsActivityOpen())
    SetSendRedPacketEnabled(redpacketinfo.IsActivityOpen())
    SetReceiveRedPacketEnabled(redpacketinfo.GetUnfetchedCount()>0 and redpacketinfo.GetReceiveCount()<redpacketinfo.GetReceiveLimit())
end

local function HideRideButton(close)
    if ModuleLockManager.GetModuleStatusByType(cfg.ui.FunctionList.MOUNTSHORTCUT) == defineenum.ModuleStatus.UNLOCK then
        fields.UIButton_Ride.gameObject:SetActive(not close)
    end
end

local function RefreshInfoButton()
    local InfoManager=require"assistant.infomanager"
    if InfoManager.IsNormalEmpty() then
        fields.UIButton_Information.gameObject:SetActive(false)
    else
        fields.UIButton_Information.gameObject:SetActive(true)
        EventHelper.SetClick(fields.UIButton_Information,function()
            InfoManager.DisplayNormalInfo()
        end)
    end
end

local function RefreshMaimaiHelpIcon()
    local helpDataList = MaimaiHelpManger.getHelpData()
    if #helpDataList > 0 and  helpDataList[#helpDataList].defencer then
        local helpData = helpDataList[#helpDataList]
        local MaimaiManager = require("ui.maimai.maimaimanager")
        local MaimaiHelper = require("ui.maimai.base.maimaihelper")
        local relation = MaimaiManager.GetMaimaiRelation(helpData.defencer)
        local mmInfo = MaimaiManager.GetMaimaiInfo()
        local content
        if relation ~= nil and mmInfo ~= nil then
            local playerMmInfo = mmInfo:GetById(helpData.defencer)
            local relationName = MaimaiHelper.GetRelationName(relation)
            if playerMmInfo ~= nil and relationName ~= nil and relationName ~= "" then
                content = string.format( LocalString.Maimai.MaimaiBeKilled, tostring(relationName),tostring(playerMmInfo:GetRole():GetName()), tostring(helpData.attackername) )
            end
        end
        EventHelper.SetClick(fields.UIButton_MaiMaiTip,function()
            uimanager.show("common.dlgdialogbox_common",{callBackFunc = function(dlgfields)
                dlgfields.UIGroup_Content_Three.gameObject:SetActive(false)
                dlgfields.UIGroup_TextWarp.gameObject:SetActive(false)
                dlgfields.UIGroup_Compare.gameObject:SetActive(false)
                dlgfields.UIGroup_TextWarp2.gameObject:SetActive(false)
                dlgfields.UIGroup_Button_1.gameObject:SetActive(false)
                dlgfields.UIGroup_Button_2.gameObject:SetActive(true)
                dlgfields.UIGroup_Resource.gameObject:SetActive(false)
                dlgfields.UIGroup_Reminder_Full.gameObject:SetActive(true)
                dlgfields.UIGroup_ItemUse.gameObject:SetActive(false)
                dlgfields.UILabel_Content_Single2.gameObject:SetActive(false)
                dlgfields.UILabel_Content_Single3.gameObject:SetActive(false)
                dlgfields.UIButton_Return.gameObject:SetActive(false)
                dlgfields.UIGroup_Option.gameObject:SetActive(true)
                dlgfields.UILabel_Title.text           = LocalString.TipText
                dlgfields.UILabel_Content_Single1.text = content
                dlgfields.UILabel_Return.text          = LocalString.CancelText
                dlgfields.UILabel_Sure.text            = LocalString.MAIMAIHELP
                dlgfields.UIGroup_Option.gameObject.transform.localPosition = Vector3(-132,-61,0)

                EventHelper.SetClick(dlgfields.UIToggle_Option,function ()
                    MaimaiHelpManger.changeNoticeState()
                end)

                EventHelper.SetClick(dlgfields.UIButton_Sure,function ()
                    local TeamManager=require"ui.team.teammanager"
                    TeamManager.SendGetPlayerLocation(helpData.defencer)
                    uimanager.hide("common.dlgdialogbox_common")
                end)
            end})
            MaimaiHelpManger.removeEndHelpData()
            RefreshMaimaiHelpIcon()
        end)
        fields.UIButton_MaiMaiTip.gameObject:SetActive(true)
    else
        fields.UIButton_MaiMaiTip.gameObject:SetActive(false)
    end
end

local function RefreshSpringBonusIcon()
    local SpringBonusManager = require("ui.springbonus.springbonusmanager")
    fields.UIButton_Spring.gameObject:SetActive(SpringBonusManager.IsInPeriod())
end

local function RefreshChargeIcon()
	  local VipChargeManager = require("ui.vipcharge.vipchargemanager")
	  if VipChargeManager.GetFirstPayUsed() == 1 then    --已充值已领取
		    fields.UISprite_FirstOfCharge.gameObject:SetActive(false)
		    fields.UISprite_Recharge.gameObject:SetActive(true)
	  else                                               --已充值未领取或者未充值
		    fields.UISprite_FirstOfCharge.gameObject:SetActive(true)
		    fields.UISprite_Recharge.gameObject:SetActive(false)
	  end
end

local function RefreshUnReadTip()
	  local ChatManager = require("ui.chat.chatmanager")
	  if ChatManager.GetTotalUnRead() > 0 then
		    fields.UIButton_MessageTip.gameObject:SetActive(true)
		    fields.UILabel_Message.text = ChatManager.GetTotalUnRead()
	  else
		    fields.UIButton_MessageTip.gameObject:SetActive(false)
	  end
end

local function AddMainScreenMessage(params)
	  if params.isTopMessage then
		    fields.UILabel_Chat_Top.text = params.str
	  else
		    local SettingChat = params.SettingChat
		    if not SettingChat then
			     textList:Add(params.str)
		    elseif SettingChat[params.channel].isTick == true then
			     textList:Add(params.str)
		    end
	  end
end

local function RefreshMainScreenMessage()
	local ChatManager = require("ui.chat.chatmanager")
	ChatManager.UpdateMainScreenMesssage(ChatManager.GetCurChannel(),textList)
end

local function RefreshBatteryLevel()
    if uimanager.GetIsLock() then
        return
    end
	  local batterylevel = tonumber(uimanager.GetBatteryLevel())
	  if batterylevel<25 then
		    fields.UISprite_Battery.spriteName = "Sprite_BatteryEmpty";
	  elseif batterylevel<50 then
		    fields.UISprite_Battery.spriteName = "Sprite_Battery1of3";
	  elseif batterylevel<75 then
		    fields.UISprite_Battery.spriteName = "Sprite_Battery2of3";
	  else
		    fields.UISprite_Battery.spriteName = "Sprite_BatteryFull";
	  end
end

local function refresh(params)
     --print(name, "refresh")
	RefreshChargeIcon()
	RefreshUnReadTip()
	RefreshMainScreenMessage()

        for _,d in pairs(subFunctions) do
            d.refresh(params)
        end
        DlgUIMain_Combat.refresh(params)
        DlgUIMain_RoleInfo.refresh(params)
		DlgUIMain_HPTip.refresh()
		DlgUIMain_MicroPhone.refresh()
		DlgUIMain_Novice.refresh()
        DlgUIMain_ActivityTip.refresh()
        DlgUIMain_Task.refresh()
        RefreshMapName()
        RefreshMiniMap()
        RefreshAllModules()
        RefreshInfoButton()
        RefreshMaimaiHelpIcon()
        RefreshSpringBonusIcon()
    if NextFunIsShow and DlgUnlock.unlockfunctiondata() then
        fields.UILabel_LabelName.text = DlgUnlock.unlockfunctiondata().name
        fields.UIButton_NextFunctionTips.gameObject:SetActive(true)
    else
        fields.UIButton_NextFunctionTips.gameObject:SetActive(false)
    end

    if not DlgNext.GetShowData() then
        fields.UISprite_NextDay.gameObject:SetActive(false)
    end

    TournamentManager.ShowEntrance()
    Game.JoyStickManager.singleton:Reset()
    refreshNextDayTime()

    if Activityexpmanager.GetOpenStatus() == 1 and Activityexpmanager.UnRead() then
        if not ActivityTipMgr.IsActivityRegistered(cfg.dailyactivity.ActivityTipEnum.ManHuangShouChao) then
            ActivityTipMgr.RegisterActivity(cfg.dailyactivity.ActivityTipEnum.ManHuangShouChao,nil,function ()
                local params = {}
                params.tabindex2 = cfg.dailyactivity.ActivityTipEnum.ManHuangShouChao
                uimanager.showdialog("activity.dlgactivity",params)
            end)
        end
    else
        if  ActivityTipMgr.IsActivityRegistered(cfg.dailyactivity.ActivityTipEnum.ManHuangShouChao) then
            ActivityTipMgr.UnregisterActivity(cfg.dailyactivity.ActivityTipEnum.ManHuangShouChao)
        end
    end
	  RefreshBatteryLevel()
    local ResurgenceBiyaoManager= require("ui.resurgencebiyao.resurgencebiyaomanager")
    if ResurgenceBiyaoManager.getOpenState()>0 then
        fields.UIButton_Biyao.gameObject:SetActive(true)
        local rebornData = ResurgenceBiyaoManager.getLocalConfig()
        fields.UIButton_Biyao.gameObject:SetActive(true)
        fields.UILabel_Biyao.text = rebornData.name
        local serverData = ResurgenceBiyaoManager.getserverData()
        local redDotSprite= fields.UIButton_Biyao.gameObject.transform:Find("UISprite_Warning")
        redDotSprite.gameObject:SetActive(false)
        if redDotSprite then
            if ResurgenceBiyaoManager.getRedSpriteState() then
                redDotSprite.gameObject:SetActive(true)
            else
                redDotSprite.gameObject:SetActive(false)
            end
        end
    else
        fields.UIButton_Biyao.gameObject:SetActive(false)
    end

end

local function destroy()
    for _,d in pairs(subFunctions) do
        d.destroy()
    end
    DlgUIMain_Combat.destroy()
    DlgUIMain_RoleInfo.destroy()
	DlgUIMain_HPTip.destroy()
	DlgUIMain_MicroPhone.destroy()
	DlgUIMain_Novice.destroy()
    DlgUIMain_ActivityTip.destroy()
    DlgUIMain_Task.destroy()
end

local function ClearChatArea()
	  fields.UILabel_Chat_Top.text = ""
	  textList:Clear()
end

local function show(params)
    InitBuffs()
    local cameraMode = CameraManager.GetCameraMode()
    fields.UISprite_Camera3D.gameObject:SetActive(not cameraMode)
    fields.UISprite_Camera25D.gameObject:SetActive(cameraMode)
    for _,d in pairs(subFunctions) do
        if d.show then
            d.show(params,true)
        end
    end
    DlgUIMain_Combat.show(params)
    DlgUIMain_RoleInfo.show(params)
	DlgUIMain_HPTip.show(params)
	DlgUIMain_MicroPhone.show(params)
	DlgUIMain_Novice.show(params)
    DlgUIMain_ActivityTip.show(params, true)
    DlgUIMain_Task.show(params)
    DlgUIMain_OfflineExp.show(params)
    fields.UIGroup_Vip.gameObject:SetActive(not Local.HideVip)
    fields.UIButton_Radio.gameObject:SetActive(true)
    fields.UIPlayTweens_NextTween.gameObject:SetActive(false)
    fields.UISprite_PointRight.gameObject:SetActive(false)
    if NextFunIsShow then
        NextDay.PlayAnimation(true)
        NextDay.n_MoudleShowTime = 0
    end
    Countdown = DlgNext.getlabelTimes()
    refreshNextDayTime()
    --lottery
    m_IsLotteryShowed = nil
    m_IsSpringFestivalShowed = nil
    m_IsSendRedPacketShowed = nil
    m_IsReceiveRedPacketShowed = nil
end

local function hide()
    for _,d in pairs(subFunctions) do
        if d.hide then
            d.hide()
        end
    end
    DlgUIMain_Combat.hide()
    DlgUIMain_RoleInfo.hide()
	DlgUIMain_HPTip.hide()
	DlgUIMain_MicroPhone.hide()
	DlgUIMain_Novice.hide()
	RecommendEquipTip.hide()
    DlgUIMain_ActivityTip.hide()
    DlgUIMain_Task.hide()
    NextFunIsShow = true
end


local function init(params)
    TeamManager = require("ui.team.teammanager")
    name, gameObject, fields = unpack(params)
    fields.UILabel_FPS.gameObject:SetActive(not (Local.HideFPS))
    fields.UIGroup_CharacterHead.gameObject:SetActive(true)
    fields.UIGroup_CharacterHead.gameObject.transform.localScale = Vector3.zero

    PlayerRole = require "character.playerrole"
    playerRole = PlayerRole:Instance()

    m_MarriageBroadcastQueue = Queue:new()

    RegisterAllModules()
    table.insert(subFunctions,dlguimain_partner)
    table.insert(subFunctions,dlguimain_hide)
    table.insert(subFunctions,OtherCharacterHead)
    table.insert(subFunctions,PlayerStateTip)
    table.insert(subFunctions,DlgUIMain_Team)
    table.insert(subFunctions,DlgUIMain_HeroChallenge)
    table.insert(subFunctions,DlgUIMain_DeclareWar)

    for _,d in pairs(subFunctions) do
        d.init(name,gameObject,fields,params)
    end
    UIMain_Anchor.ResetWidget(fields)
    UIMain_Function.init(name,gameObject,fields,params)
	RecommendEquipTip.init(name,gameObject,fields)

    EventHelper.SetClick(fields.UIButton_Radio,function()
        CameraManager.SetRotation(25,PlayerRole.Instance().m_Rotation.eulerAngles.y)
    end)
    fields.UIButton_MessageTip.gameObject:SetActive(false)
    fields.UIButton_MaiMaiTip.gameObject:SetActive(false)
    local textListTransform = fields.UISprite_ChatBackground.gameObject
    textList = textListTransform:GetComponent("UITextList")
	  ClearChatArea()
	  fields.UIGroup_SystemMessage.gameObject:SetActive(false)
    -- 初始化主页面的聊天框
    fields.UILabel_Channel.text = "[FFB14C][家族]"
    DlgUIMain_Combat.init(name, gameObject, fields, params)
    DlgUIMain_RoleInfo.init(name,gameObject,fields,params)
	DlgUIMain_HPTip.init(name,gameObject,fields,params)
	DlgUIMain_MicroPhone.init(name,gameObject,fields,params)
	DlgUIMain_Novice.init(name,gameObject,fields,params)
	DlgUIMain_ActivityTip.init(name,gameObject,fields,params)
    DlgUIMain_Task.init(name,gameObject,fields,params)
    DlgUIMain_OfflineExp.init(name,gameObject,fields,params)
    Paomadeng.init(name, gameObject, fields)
    fields.UIGroup_ItemTeam.gameObject:SetActive(false)
    fields.UIGroup_ItemTask.gameObject:SetActive(true)
    fields.UIGroup_ItemPartner.gameObject:SetActive(false)
    fields.UIGroup_TargetHoming.gameObject:SetActive(false)
    fields.UIButton_Matching.gameObject:SetActive(false)
	  --设置背景音乐的音量
	  local SettingManager = require("character.settingmanager")
	  local SettingSystem  = SettingManager.GetSettingSystem()
	  local AudioManager = require"audiomanager"
	  AudioManager.SetBackgroundMusicVolume(SettingSystem["Music"])
	  local SceneManager = require"scenemanager"
	  SceneManager.SetAudioVolumeInScene(SettingSystem["MusicEffect"]*0.4)
    fields.UISlider_KillEXP.value = 1.0
	  --初始化充值图标
	  local VipChargeManager = require"ui.vipcharge.vipchargemanager"
	  if Local.HideVip  then
		    fields.UISprite_FirstOfCharge.gameObject:SetActive(false)
		    fields.UISprite_Recharge.gameObject:SetActive(false)
	  end
	  --自动挂机设置
	  if SettingManager.GetRedDotAutoFightSetting() then
		    local roleconfig = ConfigManager.getConfig("roleconfig")
		    local autobanskill = roleconfig.autobanskill
		    if PlayerRole:Instance().m_Profession == cfg.role.EProfessionType.QINGYUNMEN  then -- 青云宗
			      if autobanskill[cfg.role.EProfessionType.QINGYUNMEN] and autobanskill[cfg.role.EProfessionType.QINGYUNMEN] >= 1 and autobanskill[cfg.role.EProfessionType.QINGYUNMEN] <= 6 then
				        SettingManager.SetSettingSkillByIndex(autobanskill[cfg.role.EProfessionType.QINGYUNMEN],false)
			      end
		    elseif PlayerRole:Instance().m_Profession == cfg.role.EProfessionType.TIANYINSI then -- 天音寺
			      if autobanskill[cfg.role.EProfessionType.TIANYINSI] and autobanskill[cfg.role.EProfessionType.TIANYINSI] >= 1 and autobanskill[cfg.role.EProfessionType.TIANYINSI] <= 6 then
				        SettingManager.SetSettingSkillByIndex(autobanskill[cfg.role.EProfessionType.TIANYINSI],false)
			      end
		    elseif PlayerRole:Instance().m_Profession == cfg.role.EProfessionType.GUIWANGZONG then -- 鬼王宗
			      if autobanskill[cfg.role.EProfessionType.GUIWANGZONG] and autobanskill[cfg.role.EProfessionType.GUIWANGZONG] >= 1 and autobanskill[cfg.role.EProfessionType.GUIWANGZONG] <= 6 then
				        SettingManager.SetSettingSkillByIndex(autobanskill[cfg.role.EProfessionType.GUIWANGZONG],false)
			      end
		    end
    end
    local UISprite_GetDown = fields.UISprite_GetDown
    UISprite_GetDown.gameObject:SetActive(false)
    refreshMapInfo = os.time()
    EventHelper.SetListClick(fields.UIList_Buff,function(item)
        local effect = playerRole.m_Effect:GetEffectByIndex(item.m_nIndex + 1)
        if effect then
            fields.UISprite_BuffDiscription.gameObject:SetActive(true)
            TimerBuffDescription = 0
            showingEffectId = effect.id
            showingEffectIdx = item.m_nIndex + 1
            fields.UILabel_BuffDiscription.text = effect.description
        end
    end)

    EventHelper.SetClick(fields.UISprite_MapBG, function()
		    if not(EctypeManager.IsInEctype()) then
			      uimanager.showdialog("map.dlgmap",{},2)
	      end
    end )

    EventHelper.SetClick(fields.UIWidget_EnterChat, function()
        uimanager.showdialog("chat.dlgchat01")
    end )
    EventHelper.SetClick(fields.UIWidget_EnterChat_Top, function()
        uimanager.showdialog("chat.dlgchat01")
    end )
    EventHelper.SetClick(fields.UISprite_FirstOfCharge, function() --首次充值
        uimanager.showdialog("vipcharge.dlgfirstofcharge")
    end )
    EventHelper.SetClick(fields.UISprite_Recharge, function() --非首次充值
        uimanager.showdialog("vipcharge.dlgrecharge")
    end )
    if Local.HideOperationActivity == true then
        fields.UIButton_ActivityIcon.gameObject:SetActive(false)
    else
        fields.UIButton_ActivityIcon.gameObject:SetActive(true)
    end
    EventHelper.SetClick(fields.UIButton_Biyao, function()
        if TeamManager.IsInHeroTeam() then
            TeamManager.ShowQuitHeroTeam()
        else
            uimanager.show("resurgencebiyao.dlgresurgencebiyao")
            --uimanager.show("newyear.dlgnewyeargifts")
        end
    end )
    EventHelper.SetClick(fields.UIButton_Jump, function()
        PlayerRole:Instance():Jump()
    end )
    EventHelper.SetPress(fields.UIButton_Jump, function(go, bPress)
        if PlayerRole:Instance().m_Mount and PlayerRole:Instance().m_Mount:IsAttach() then
            local MountType = defineenum.MountType
            if PlayerRole:Instance().m_Mount.m_MountState ~= MountType.Ride then
                PlayerRole:Instance().m_Mount:movedown(bPress)
            end
        end
    end )
    EventHelper.SetClick(fields.UIButton_TaskTab, function()
        fields.UIGroup_ItemTeam.gameObject:SetActive(false)
        fields.UIGroup_ItemPartner.gameObject:SetActive(false)
        fields.UIGroup_HeroChallenge.gameObject:SetActive(false)
        if EctypeManager.IsInEctype() then
            fields.UIGroup_ItemTask.gameObject:SetActive(false)
            EctypeManager.ShowTasks(true)
            curTaskTabIndex = 0
        elseif TeamManager.IsInHeroTeam() then
            fields.UIGroup_ItemTask.gameObject:SetActive(false)
            fields.UIGroup_HeroChallenge.gameObject:SetActive(true)
            curTaskTabIndex = 0
        else
            if curTaskTabIndex == 0 then
                uimanager.showdialog("dlgtask")
            else
                fields.UIGroup_ItemTask.gameObject:SetActive(true)
                curTaskTabIndex = 0
            end
        end
    end )
    EventHelper.SetClick(fields.UIButton_PartnerTab, function()
        local moduleData=GetModule(cfg.ui.FunctionList.PARTNER)
        if moduleData then
            local status=ModuleLockManager.GetModuleStatusByType(cfg.ui.FunctionList.PARTNER)
            if status==defineenum.ModuleStatus.LOCKED then
                local configData = ConfigManager.getConfigData("uimainreddot",cfg.ui.FunctionList.PARTNER)
                local conditionData=ConfigManager.getConfigData("moduleunlockcond",configData.conid)
                if conditionData then
                    local text=""
                    if conditionData.openlevel~=0 then
                        text=(conditionData.openlevel)..(LocalString.WorldMap_OpenLevel)
                    elseif conditionData.opentaskid~=0 then
                        local taskData=ConfigManager.getConfigData("task",conditionData.opentaskid)
                        if taskData then
                            text=string.format(LocalString.CompleteTaskOpen,taskData.basic.name)
                        end
                    end
                    uimanager.ShowSystemFlyText(text)
                end
                return
            end
        end
        if fields.UIGroup_ItemPartner.gameObject.activeSelf then
            if not EctypeManager.IsInEctype() then
                uimanager.showdialog("partner.dlgpartner_list")
            end
        else
            fields.UIGroup_ItemTeam.gameObject:SetActive(false)
            fields.UIGroup_ItemTask.gameObject:SetActive(false)
            fields.UIGroup_HeroChallenge.gameObject:SetActive(false)
            fields.UIGroup_ItemPartner.gameObject:SetActive(true)
            if EctypeManager.IsInEctype() then
                EctypeManager.ShowTasks(false)
            else
                curTaskTabIndex = 1
                dlguimain_partner.UpdateFieldPets()
            end
        end
    end )


    fields.UISprite_Close.gameObject:SetActive(true)
    fields.UISprite_Open.gameObject:SetActive(false)
    EventHelper.SetClick(fields.UIButton_Stretch, function()
        if fields.UISprite_Close.gameObject.activeSelf then
            fields.UISprite_Close.gameObject:SetActive(false)
            fields.UISprite_Open.gameObject:SetActive(true)
            fields.UISprite_Warning.gameObject:SetActive(false)
        else
            fields.UISprite_Close.gameObject:SetActive(true)
            fields.UISprite_Open.gameObject:SetActive(false)
        end
    end )


	--EventHelper.SetClick(fields.UIButton_QQVip, function()
    --    uimanager.showdialog("dlgqqvip")
    --
    --end )

    EventHelper.SetClick(fields.UIButton_TeamTab, function()
        fields.UIGroup_ItemTeam.gameObject:SetActive(true)
        fields.UIGroup_ItemTask.gameObject:SetActive(false)
        fields.UIGroup_ItemPartner.gameObject:SetActive(false)
        fields.UIGroup_HeroChallenge.gameObject:SetActive(false)
        if EctypeManager.IsInEctype() then
            EctypeManager.ShowTasks(false)
        else
            if curTaskTabIndex == 2 then
                if not EctypeManager.IsInEctype() then
                    uimanager.showdialog("team.dlgteam")
                end
            else
                curTaskTabIndex = 2
                DlgUIMain_Team.RefreshTeamInfo()
            end
        end
    end )

    EventHelper.SetClick(fields.UIButton_Camera,function()
        local b = CameraManager.ChangeMode()
        fields.UISprite_Camera3D.gameObject:SetActive(not b)
        fields.UISprite_Camera25D.gameObject:SetActive(b)

    end)
	  EventHelper.SetClick(fields.UIButton_Setting, function()
        uimanager.showdialog("dlgautofight")
    end)
    EventHelper.SetClick(fields.UIButton_HidePlayers,function()
        local hideMode = CharacterManager.SwitchHideRoles()
        fields.UISprite_HideRole.spriteName = HeadPlayerIcons[hideMode + 1]
    end)
    if DlgUnlock.unlockfunctiondata() then
        fields.UILabel_LabelName.text = DlgUnlock.unlockfunctiondata().name
        EventHelper.SetClick(fields.UIButton_NextFunctionTips, function() --即将开启
            if NextDay.isOpen then
                uimanager.show("common.dlgdialogbox_unlock")
                uimanager.hidemaincitydlgs()
            else
                NextDay.n_MoudleShowTime = 1
                NextDay.PlayAnimation(false)
            end
        end )
    else
        fields.UIButton_NextFunctionTips.gameObject:SetActive(false)
    end
    if DlgNext.GetShowData() then
        Countdown = DlgNext.getlabelTimes()
        EventHelper.SetClick(fields.UISprite_NextDay, function() --次日奖励
            uimanager.show("common.dlgdialogbox_nextday")
            uimanager.hidemaincitydlgs()
        end )
    else
        fields.UISprite_NextDay.gameObject:SetActive(false)
    end
	  EventHelper.SetClick(fields.UIButton_MessageTip,function ()
		    local ChatManager = require("ui.chat.chatmanager")
		    local list = ChatManager.GetRecentSpeakerList()
        uimanager.showdialog("chat.dlgchat01",{id = list[1].id, name = list[1].name,index = 2,isShowTip = true})
	  end)
    EventHelper.SetClick(fields.UIGroup_Vip, OnUIGroup_Vip)
    m_expPrg = fields.UIProgressBar_EXP.gameObject:GetComponent("UIProgressBar")
    EventHelper.SetClick(fields.UIButton_Lottery, OnButtonLottery)
	  --local channelid = Game.Platform.Interface.Instance:GetSDKPlatform()
	  --if channelid == 39 then
		--    fields.UIButton_QQVip.gameObject:SetActive(true)
	  --else
		--    fields.UIButton_QQVip.gameObject:SetActive(false)
	  --end

    EventHelper.SetClick(fields.UIButton_Warehouse,function()

        local depotmanager = require("character.depotmanager")
        depotmanager.NavigateToDepotNPC()
    end)

    EventHelper.SetClick(fields.UIButton_Mission,function ()

        uimanager.showdialog("dlgtask")
    end)
    local ResurgenceBiyaoManager= require("ui.resurgencebiyao.resurgencebiyaomanager")
    ResurgenceBiyaoManager.isShowNpc()
end

local function SetWeightsEnabled(weights, value)
    if weights and weights.Length>0 then
        for i = 1, weights.Length do
            weights[i].isEnabled = value
        end
    end
end

local function OnEnterLeavePrologue(isenter)
    local weights
    --聊天相关按钮置灰
    weights = fields.UIGroup_ChatArea.gameObject:GetComponentsInChildren(UIButton, true)
    SetWeightsEnabled(weights, not isenter)
    --头像相关按钮置灰
    weights = fields.UIGroup_HeroHead.gameObject:GetComponentsInChildren(UIButton, true)
    SetWeightsEnabled(weights, not isenter)
end

local function SwitchAutoFight(b)
    DlgUIMain_Combat.SwitchAutoFight(b)
end

local function EnterEctype()
    fields.UIGroup_FunctionsArea.gameObject:SetActive(false)
    fields.UIGroup_ItemTeam.gameObject:SetActive(false)
    fields.UIGroup_ItemTask.gameObject:SetActive(false)
    fields.UIGroup_ItemPartner.gameObject:SetActive(false)
    fields.UIGroup_HeroChallenge.gameObject:SetActive(false)
    curTaskTabIndex = 0
    dlguimain_partner.UpdateFieldPets()
    DlgUIMain_Combat.EnterEctype()
    if EctypeManager.IsBattleEctype() then
        local CharacterManager = require"character.charactermanager"
        CharacterManager.ShowAllHpProgress()
    end
    if EctypeManager.IsInEctype() then
        local ectype = EctypeManager.GetEctype()
        local basicInfo = ConfigManager.getConfigData("ectypebasic",ectype.m_ID)
        if basicInfo.enterfight then
            SwitchAutoFight(true)
        end
    end
end

local function LeaveEctype()
    fields.UIGroup_FunctionsArea.gameObject:SetActive(true)
    fields.UIGroup_ItemTeam.gameObject:SetActive(false)
    fields.UIGroup_ItemTask.gameObject:SetActive(false)
    fields.UIGroup_ItemPartner.gameObject:SetActive(false)
    fields.UIGroup_HeroChallenge.gameObject:SetActive(false)
    if curTaskTabIndex == 0 then
        if TeamManager.IsInHeroTeam() then
            fields.UIGroup_HeroChallenge.gameObject:SetActive(true)
        else
            fields.UIGroup_ItemTask.gameObject:SetActive(true)
        end
    elseif curTaskTabIndex == 1 then
        fields.UIGroup_ItemPartner.gameObject:SetActive(true)
    elseif curTaskTabIndex == 2 then
        fields.UIGroup_ItemTeam.gameObject:SetActive(true)
    end
    DlgUIMain_Combat.LeaveEctype()
    OnEnterLeavePrologue(false)
end

local function StopSkillsOperations()
    DlgUIMain_Combat.SetSkillsEnable(false)
    DlgUIMain_Combat.SetAttackEnable(false)
end

local function ResumeSkillsOperations()
    DlgUIMain_Combat.SetSkillsEnable(true)
    DlgUIMain_Combat.SetAttackEnable(true)
    PlayerRole.Instance().m_Effect:RefreshAbilitiesOnUI()
end

local function UnderGround(b)
   -- printyellow("UnderGround",tostring(b))
    IsIntheGround = b
end
local function DragSkillGroup(params)
    DlgUIMain_Combat.DragSkillGroup(params.groupid, true)
end

local function uishowtype()
    return UIShowType.Refresh
end

local function RefreshPetCD(parameter)
    dlguimain_partner.RefreshCD(parameter)
end

local function RefreshPetLevel(param)
    dlguimain_partner.RefreshLevel(param)
end

local function UpdateAttributes()
    DlgUIMain_RoleInfo.UpdateAttributes()
end

local function RefreshPKStateIcon()
    DlgUIMain_Combat.RefreshPKStateIcon()
end

local function RefreshAbilities()
    --DlgUIMain_Combat.RefreshAbilities()
end

local function RefreshPetAttributes(params)
    dlguimain_partner.OnAttrChange(params)
end

local function PartnerEquipCD(cd)
    dlguimain_partner.EquipCD(cd)
end

local function RefreshFieldPets()
    dlguimain_partner.UpdateFieldPets()
end

local function SetTarget(targetId)
    OtherCharacterHead.NeedSetHeadInfoById(targetId)
end

local function SetMatching(params)
    if fields ~= nil then
        fields.UIButton_Matching.gameObject:SetActive(params.matching)
        if params.matchmode == "teamfight" then
            EventHelper.SetClick(fields.UIButton_Matching,function()
                uimanager.showdialog("activity.dlgactivity",{},2)
                if params.callback then
                    params.callback()
                end
            end)
            fields.UISprite_March.spriteName = "Sprite_Gest"
        elseif params.matchmode == "teamspeed" then
            EventHelper.SetClick(fields.UIButton_Matching,function()
                uimanager.showdialog("activity.dlgactivity",{index=2},2)
                if params.callback then
                    params.callback()
                end
            end)
            fields.UISprite_March.spriteName = "Sprite_Grand"
        elseif params.matchmode == "multistory" then
            EventHelper.SetClick(fields.UIButton_Matching,function()
                uimanager.showdialog("ectype.dlgentrance_copy",{matchingbutton = true, index = 3},3)
				        local MultiEctypeManager = require("ui.ectype.multiectype.multiectypemanager")
				        uimanager.show("ectype.multiectype.dlgmultiectypematching",{lefttime = MultiEctypeManager.GetStoryEctypeLeftTime() , roleinfos = MultiEctypeManager.GetRoleInfos() ,title = MultiEctypeManager.GetTitle()})
                if params.callback then
                    params.callback()
                end
            end)
            fields.UISprite_March.spriteName = "Sprite_fight"
		    end
    end
end

local function RefreshRoleInfo()
    DlgUIMain_RoleInfo.RefreshRoleInfo()
end

local function GetCurTaskTabIndex()
    return curTaskTabIndex
end

local function SetCurTaskTabIndex(index)
    curTaskTabIndex = index
end

return {
    init = init,
    show = show,
    hide = hide,
    update = update,
    late_update = late_update,
    second_update = second_update,
    destroy = destroy,
    refresh = refresh,
    uishowtype = uishowtype,
    refreshTime = refreshTime,
    RefreshFPS = RefreshFPS,
    EnterEctype = EnterEctype,
    LeaveEctype = LeaveEctype,
    SetTargetHoming   =   PlayerStateTip.SetTargetHoming,
    CloseTargetHoming = PlayerStateTip.CloseTargetHoming,
    StopSkillsOperations = StopSkillsOperations,
    ResumeSkillsOperations = ResumeSkillsOperations,
    UnderGround = UnderGround,
    DragSkillGroup = DragSkillGroup,
    RefreshMapName = RefreshMapName,
    SwitchAutoFight = SwitchAutoFight,
    HideRideButton = HideRideButton,
	  RefreshRedDotType = RefreshRedDotType,
    SetAttackEnable = SetAttackEnable,
    SetSkillsEnable = SetSkillsEnable,
    RefreshPetCD = RefreshPetCD,
    DragingJoystick = DragingJoystick,
    RefreshPetLevel = RefreshPetLevel,
    SetAutoFightSprite = PlayerStateTip.SetAutoFightSprite,
    UpdateAttributes = UpdateAttributes,
    RefreshPKStateIcon = RefreshPKStateIcon,
    PartnerEquipCD      = PartnerEquipCD,
    RefreshPetAttributes= RefreshPetAttributes,
    RefreshFieldPets    = RefreshFieldPets,
    RefreshInfoButton = RefreshInfoButton,
    RefreshMaimaiHelpIcon = RefreshMaimaiHelpIcon,
    RefreshAbilities    = RefreshAbilities,
    SetTarget = SetTarget,
    SetMatching = SetMatching,
	  RefreshBatteryLevel = RefreshBatteryLevel,
    RefreshTaskList = RefreshTaskList,
    RefreshRoleInfo = RefreshRoleInfo,
    AddMarriageBroadcast = AddMarriageBroadcast,
    RefreshModuleByType = RefreshModuleByType,
    RefreshAllModules = RefreshAllModules,
    GetCurTaskTabIndex = GetCurTaskTabIndex,
    SetCurTaskTabIndex = SetCurTaskTabIndex,
    OnQuitFamily = OnQuitFamily,
	  RefreshUnReadTip = RefreshUnReadTip,
    setNxtFunIsShow = setNxtFunIsShow,
	  ClearChatArea = ClearChatArea,
	  AddMainScreenMessage = AddMainScreenMessage,
    ShowGetOfflineExpUI = ShowGetOfflineExpUI,

}
