local EffectInstanceType = enum
{
    "Stand",
    "Follow",
    "Trace",
    "TracePos",
    "BindToCamera",
    "UIStand",
    "StandTarget",
    "FollowTarget",
    --"SpaceLink",
}

local GenderType = enum
{
    "Male=0",
    "Female=1",
}

local ProfessionType = enum {
    "None = 0",
    "QingYunMen = 1",
    "TianYinSi = 2",
    "GuiWangZong = 3",
}

local EffectInstanceBindType = enum
{
    "Body=0",
    "Head",
    "Foot",
    "LeftHand",
    "RightHand",
    "LeftFoot",
    "RightFoot",
    "LeftWeapon",
    "RightWeapon",
}

local MapType = enum
{
    "WorldMap = 0",
    "EctypeMap = 1",
    "FamilyStation = 2",
}



local BoneNames = {}
--BoneNames[EffectInstanceBindType.Body] = "Bip001 Spine"
BoneNames[EffectInstanceBindType.LeftHand] = "Bip001 L Hand"
BoneNames[EffectInstanceBindType.RightHand] = "Bip001 R Hand"
BoneNames[EffectInstanceBindType.LeftFoot] = "Bip001 L Foot"
BoneNames[EffectInstanceBindType.RightFoot] = "Bip001 R Foot"
BoneNames[EffectInstanceBindType.LeftWeapon] = "weapon_L"
BoneNames[EffectInstanceBindType.RightWeapon] = "weapon_R"


local EffectInstanceAlignType = enum
{
    "None",
    "LeftTop",
    "Left",
    "LeftBottom",
    "Top",
    "Center",
    "Bottom",
    "RightTop",
    "Right",
    "RightBottom",
}

local TraceType = enum
{
    "Line",
    "Bezier",
    "Line2D",
}

local CameraShakeType = enum
{
  "NoShake",
  "Normal" ,
  "Horizontal",
  "Vertical",
}


local ESpecialType = enum
{
  "None",
  "Bomb",
  "Ray",
}

local EffectLevel = enum
{
  "None",
  "All",
  "NotSkill",
}

local SkillType = enum
{
    "Immediately",                                    -- 即时触发技能
    "Fly",                                            -- 延迟结算(飞行)
    "CallBack",                                       -- 正向引导(吟唱)（已废弃）
    "KeepCall",                                       -- 持续引导(已废弃)
    "Bomb",                                           -- 炸弹类
    "Ray",                                            -- 射线类
    "Qte",                                            -- QTE类
    "Talisman",                                       -- 法宝技能
}

local CharacterType = enum
{

  "Character = 1",
  "PlayerRole = bit.lshift (1,1)",
  "Player = bit.lshift (1,2)",
  "Monster = bit.lshift (1,3)",
  "Npc = bit.lshift (1,4)",
  "Pet = bit.lshift (1,5)" ,
  "Boss = bit.lshift (1,6)",
  "Mount = bit.lshift(1,7)",
  "Mineral = bit.lshift(1,8)",
  "DropItem= bit.lshift(1,9)",
  "Portal = bit.lshift(1,10)",
  "RolePet = bit.lshift(1,11)",
  "Talisman = bit.lshift(1,12)",
  "Rune = bit.lshift(1,13)",
  "FamilyCityTower = bit.lshift(1,14)",
}

local CharState = enum
{
  "None = 0",
  "Freeze = 1",   --can not move and animation 冰冻
  "Vertigo = bit.lshift (1,1)", --can not move or skill, can animation  眩晕
  "Invincible = bit.lshift (1,2)", --no drophp,no hurtanim, no fly 金身
  "Silence = bit.lshift (1,3)", --no hurtanim, no fly 沉默
  "Air = bit.lshift (1,4)", --滞空
  "Lock = bit.lshift (1,5)", --can not move,
  "Fixbody = bit.lshift (1,6)", --only no fly
}

local WorkType = enum
{
  "None",
  "Idle",
  "Move",
  "MoveEnd",
  "Jump",
  "NormalSkill",
  "TalismanSkill",
  "BeAttacked",
  "Dead",
  "Relive",
  "Fly",
  "FreeAction",
  "PathFly",
}

local MoveType = enum
{
  "Normal",
  "CastSkill",
  "ReqNpc",
}

local JumpType = enum
{
  "Normal",
  "Fall",
}
local MountType = enum
{
  "Attaching",
  "Ride",
  "Up",
  "Fly",
  "Down",
  "ToPointLand"
}

local EventType = enum
{
  "None",
  "Skill",
  "BeAttacked",
  "MoveEnd",
  "Move",
  "Jump",
  "Dead",
  "Relive",
  "Fly",
  "FreeAction",
  "PathFly",
}

local AniStatus = enum
{
  "Idle =0",
  "Run = 1",
  "RunEnd = 2",
  "Jump",
  "JumpLoop",
  "JumpEnd",
  "Skill1",
  "Skill2",
  "Skill3",
  "Skill4",
  "StandRide",
  "RunRide", --11
  "Stand",
  "Running",
  "Trotting", --14
  "Faint",
  "Hurt",
  "Feijian",
  "Death",
  "Caiji",
  "Combat",
  "Float",
  "Qishen",
  "Flying",
  "FlyStart",
  "Jumpend_Zhandou",
  "Jump_Zhandou",
  "JumpLoop_Zhandou",
  "Skill06_1",
  "Skill06_2",
  "Skill06_3",
  "Skill07",
  "Skill08",
  "Attack01End",
  "Attack02End"
}

local ImpactType = enum
{
    "ChangeAttr = 1",
    "ChangeCoeff",
    "Summon",
    "Vertigo",
    "AddBuff",
    "Hurt",
    "PaBody",
    "Invincible",
    "LockMove",
    "Shake",
    "FallProtect",
    "Max = FallProtect"
}
local DeadType = enum
{
    "DeadGround = 0",
    "DeadWhip = 1",
    "DeadStill =2",
    "DeadLikeNotDead = 3",
}

local UpdateState = enum   {
        "Init = 0",
        "InitSDK",
        "UnZipData",
        "CheckNextState",
        "UpdateApp",
        "UpdateResource",
        "StartGame",
    };

local NpcStatusType = enum {
    "None",
    "CanAcceptTask",
    "CanCommitTask",
}

local TaskStatusType = enum{
    "None",
    "Accepted",
    "Doing",
    "UnCommitted",
    "Completed",
}

local TaskType = enum {
    "Mainline=1",
    "Branch=2",
    "Family=3",
}

local TaskNavModeType = enum {
    "Default=1",
    "AccordingMapConnection=2",
    "DirectTransfer=3",
}



local BonusType = enum {
    "Currency",
    "Currencys",
    "Item",
    "Items",
    "MultiBonus",
    "RandomBonus",
}

local HumanoidAvatarDetailType = enum{
    "ARMOUR=1",
    "FASHION=2",
    "DEFAULTWEAPON=3",
    "DEFAULTARMOUR=4",
    "WEAPON=5",
    "CREATEWEAPON=6",
    "CREATEARMOUR=7",
    "COUNT=8",
}

local MonsterAudioType = enum{
    "BEATTACK",
    "DEAD",
    "PATROL",
}

local NoviceGuideType = enum{
    "NONE",
    "TRIGGERNEXT",
    "HIDEOBJ",
    "FINDOBJ",
    "CANNOTFINDOBJ",
    "SHOWEFFECT",
    "SHOWINGGUIDE",
}

local ModuleStatus = enum{
    "LOCKED",
    "UNLOCK",
}

local CharacterAbilities = enum{
    "NORMALSKILL=0x01",
    "SKILL=0x02",
    "ITEM=0x04",
    "MOVE=0x08",
    "ALLENABLE=0x0F"
}

local AudioPriority = enum
{
  "Attack", --攻击音效
  "BeAttack", --被击音效
  "ActionEffect", --动作声效（脚步声音等）
  "Default", --默认
}

local MountActiveStatus = enum
{
    "None",
    "Get",
    "Actived",
}

local AutoAIState = enum
{
    "any",
    "none",
    "idle",
    "attack",
    "joymove",
    "automove",
}

local AutoAIEvent = enum
{
    "monster",   --有可攻击的怪
    "nomonster", --没有怪了
    "joy",       --摇杆开始移动
    "joystop",   --摇杆移动结束
    "skillover", --技能结束
    "skillbreak",--技能中断
    "automove", --导航回挂机起始位置
    "backtopos",--返回挂机起始位置
    "start",    --启动
    "stop",     --停止

}

local Channels = enum{
	"LAOHU=9",
	"OPPO=8",
	"HUAWEI=7",
	"VIVO=38",
	"COOLPAD=44",
	"MEIZU=68",
	"AMIGO=43",
	"LENOVO=40",
	"YINGYONGBAO=57",
    "SANQI=39",
	"OTHERS=0",
}

local GrahpicQuality = enum{
    "Low=1",
    "Mid",
    "High",
    "Extreme",
}

local PortalEffectType=enum
{   --传送门特效类型
    "HIDE=0",   --隐藏
    "STEREO=1", --立体
    "GROUND=2",  --落地
}

local PortalTransMode=enum
{   --传送模式
    "DIRECT=0",  --直接传
    "FLY=1",     --飞行
}

local PuerAirOperType=enum
{
    "LEVEL=0",
    "AWAKE=1",
    "STAR=2",
}

local LimitType =
{
    DAY      = 1,
    WEEK     = 2,
    MONTH    = 3,
    LIFELONG = 4,
    NO_LIMIT = -1,
}

local NotifyType =
{
    RoleChangeLevel         = "role_change_level",
    RoleChangeName          = "role_change_name",
    RoleChangeVipLevel      = "role_change_viplevel",
    RoleChangeAttribute     = "role_change_attribute",
    RoleChangeEquip         = "role_change_equip",
    RoleChangeMount         = "role_change_mount",
    RoleChangePKState       = "role_change_pkstate",
    RoleChangeTarget        = "role_change_target",
    RoleEnterPKZone         = "role_enter_pkzone",
    RoleLeavePKZone         = "role_leave_pkzone",
    ChangeCurrency          = "change_currency",


    MapMsgEnterEctype       = "map_msg_enter_ectype",
    MapMsgEnterEctypeReady  = "map_msg_enter_ectype_ready",

    CutsceneLoad        = "plotcutscene_load",
    CutsceneStart       = "plotcutscene_start",
    CutsceneEnd         = "plotcutscene_end",
    SceneLoadStart      = "loadscene_start",
    SceneLoadEnd        = "loadscene_end",
    FamilyWarStateChange = "familywar_statechange",
}

local MIN_HEIGHT=-3.4e+38


local RewardDistributionType =
{
    Territory = 1,
    RoundRobin = 2,
}

return
{
  EffectInstanceType = EffectInstanceType,
  EffectInstanceBindType = EffectInstanceBindType,
  EffectInstanceAlignType = EffectInstanceAlignType,
  TraceType = TraceType,
  CameraShakeType = CameraShakeType,
  ESpecialType = ESpecialType,
  EffectLevel =EffectLevel,
  CharacterType = CharacterType,
  MapType = MapType,
  CharState = CharState,
  WorkType = WorkType,
  MoveType = MoveType,
  JumpType = JumpType,
  EventType = EventType,
  AniStatus = AniStatus,
  SkillType = SkillType,
  ImpactType = ImpactType,
  DeadType = DeadType,
  UpdateState = UpdateState,
  NpcStatusType = NpcStatusType,
  TaskStatusType = TaskStatusType,
  TaskType = TaskType,
  TaskNavModeType = TaskNavModeType,
  MountType=MountType,
  BoneNames = BoneNames,
  MinHeight=MIN_HEIGHT,
  BonusType=BonusType,
  GenderType=GenderType,
  HumanoidAvatarDetailType = HumanoidAvatarDetailType,
  MonsterAudioType = MonsterAudioType,
  NoviceGuideType = NoviceGuideType,
  ModuleStatus = ModuleStatus,
  MountActiveStatus = MountActiveStatus,
  CharacterAbilities    = CharacterAbilities,
  AudioPriority = AudioPriority,
  AutoAIEvent = AutoAIEvent,
  AutoAIState = AutoAIState,
  Channels = Channels,
  GrahpicQuality = GrahpicQuality,
  PortalEffectType = PortalEffectType,
  PortalTransMode = PortalTransMode,
  NotifyType = NotifyType,
  LimitType = LimitType,
  RewardDistributionType = RewardDistributionType,
  PuerAirOperType = PuerAirOperType,
}
