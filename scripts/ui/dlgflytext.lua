--local dlgflytext = require "ui.dlgflytext"
local unpack = unpack
local print = print
local math = math
local EventHelper = UIEventListenerHelper
local uimanager = require("uimanager")
local flytext = require "flytext"
local PlayerRole
local gameObject
local dmgText
local ShowDmg
local name
local mFlyTextManagers
local DamageTypeText = {}
local GraphicSettingMgr = require"ui.setting.graphicsettingmanager"
local CountDowns = nil
local CountDownsTime = nil

local Container = {}
local ItemFlyTextList={}
local SystemFlyTextList={}
local ItemDelayTime=0.2
local SystemDelayTime=0.3
local ItemFlyTime=ItemDelayTime
local SystemFlyTime=SystemDelayTime
local function AddSystemInfo(info)
    table.insert(SystemFlyTextList,info)
end

local function AddItemInfo(info)
    table.insert(ItemFlyTextList,info)
end

local function ShowCountDown(time)
    CountDowns = {
        [3] = (time>=3) and true or false,
        [2] = (time>=2) and true or false,
        [1] = (time>=1) and true or false,
        [0] = (time>=0) and true or false,
    }
    CountDownsTime = time
    uimanager.show(name)
end

local function AddInfo(strText,attacker,beattacker,info)
    --printyellow(string.format("[dlgflytext:AddInfo] ShowDmg=[%s]!", ShowDmg))
    if not ShowDmg then return end
    local data = info.DetailInfo

    if data.ismiss~=0 then
        if attacker and attacker.m_Object then
            mFlyTextManagers[flytext.FlyTextType.Block]:Add(LocalString.FlyText[4],attacker,info)
        end
        if beattacker and beattacker.m_Object then
            mFlyTextManagers[flytext.FlyTextType.Dodge]:Add(LocalString.FlyText[5],beattacker,info)
        end
    else
        if beattacker:GetId() == PlayerRole.Instance():GetId() then
            mFlyTextManagers[flytext.FlyTextType.Red]:Add(tostring(strText),beattacker,info)
            return
        end
        local type = 0
        if data.islucky~=0 then
            type = type+0x1
        end
        if data.isexcellent~=0 then
            type = type+0x2
        end
        if data.iscrit~=0 then
            type = type+0x4
        end
        if beattacker and beattacker.m_Object then
            mFlyTextManagers[DamageTypeText[type].type]:Add(DamageTypeText[type].text..tostring(strText),beattacker,info)
        end
    end
end

local function AddHealInfo(strText,beattacker)
    --printyellow(string.format("[dlgflytext:AddInfo] AddHealInfo=[%s]!", ShowDmg))
    if not ShowDmg then return end
    -- printyellow(strText,beattacker)
    mFlyTextManagers[flytext.FlyTextType.Green1]:Add(strText,beattacker)
end

local fields

local function ClearAllFlytext()
    fields.UIList_FlyTextSystemInfo:Clear()
    fields.UIList_FlyTextItemInfo:Clear()
    fields.UIList_FlyTextDamage:Clear()
    fields.UIList_FlyTextBlock:Clear()
    fields.UIList_FlyTextDodge:Clear()
    fields.UIList_FlyTextCrit_White:Clear()
    fields.UIList_FlyTextCrit_Blue01:Clear()
    fields.UIList_FlyTextCrit_Blue02:Clear()
    fields.UIList_FlyTextCrit_Green01:Clear()
    fields.UIList_FlyTextCrit_Green02:Clear()
    fields.UIList_FlyTextCrit_Golden:Clear()
    fields.UIList_FlyTextCrit_Purple01:Clear()
    fields.UIList_FlyTextCrit_Purple02:Clear()
    fields.UIList_FlyTextDamageSelf:Clear()
end

local function destroy()
    --print(name, "destroy")
    ClearAllFlytext()
end

local function show(params)
    local pos = gameObject.transform.localPosition
    local newPos = Vector3(pos.x,pos.y,2000)
    gameObject.transform.localPosition = newPos
    --print(name, "show")
    ShowDmg = not GraphicSettingMgr.IsFlyTextHided()
    --printyellow(string.format("[dlgflytext:show] ShowDmg = %s!", ShowDmg))
    PlayerRole = require"character.playerrole"

end

local function hide()
    -- for _,v in pairs(mFlyTextManagers) do
    --     v:RemoveAll()
    -- end

    --print(name, "hide")
end

local function SetEnable(b)
    --printyellow(string.format("[dlgflytext:SetEnable] SetEnable %s!", b))
    ShowDmg = b
end

local function ShowFlyCountDown(go,num)
    local uiWidget = go:GetComponent("UIWidget")
    local uiTweenAlpha = go:GetComponent("TweenAlpha")
    local uiTweenScale = go:GetComponent("TweenScale")
  --  if uiWidget then
    uiWidget.alpha = 1
  --  end
  --  if uiTweenAlpha then
    uiTweenAlpha:ResetToBeginning()
    uiTweenAlpha.enabled = true
  --  end
  --  if uiTweenScale then
    uiTweenScale:ResetToBeginning()
    uiTweenScale.enabled = true
   -- end
end

local function update()
    if CountDownsTime ~= nil and CountDowns ~= nil then
        CountDownsTime = CountDownsTime - Time.unscaledDeltaTime
        if CountDownsTime < 3 and CountDowns[3] == true then
            CountDowns[3] = false
            ShowFlyCountDown(Container[3],3)
        elseif CountDownsTime < 2 and CountDowns[2] == true then
            CountDowns[2] = false
            ShowFlyCountDown(Container[2],2)
        elseif CountDownsTime < 1 and CountDowns[1] == true then
            CountDowns[1] = false
            ShowFlyCountDown(Container[1],1)
        elseif CountDownsTime < 0 and CountDowns[0] == true then
            CountDowns[0] = false
            ShowFlyCountDown(Container[0],0)
            CountDownsTime = nil
            CountDowns = nil
        end
    end
    if #ItemFlyTextList>0 then
        ItemFlyTime=ItemFlyTime+Time.deltaTime
        if ItemFlyTime>=ItemDelayTime then
            local info=ItemFlyTextList[1]
            table.remove(ItemFlyTextList,1)
            mFlyTextManagers[flytext.FlyTextType.ItemInfo]:Add(info)
            ItemFlyTime=0
        end
    end
    if #SystemFlyTextList>0 then
        SystemFlyTime=SystemFlyTime+Time.deltaTime
        if SystemFlyTime>=SystemDelayTime then
            local info=SystemFlyTextList[1]
            table.remove(SystemFlyTextList,1)
            mFlyTextManagers[flytext.FlyTextType.SystemInfo]:Add(info)
            SystemFlyTime=0
        end
    end
    --print(name, "update")

    --if Input.GetKeyDown(KeyCode.P) then AddSystemInfo("123") end
    --if Input.GetKeyDown(KeyCode.Q) then mFlyTextManagers[flytext.FlyTextType.Damage]:Add("33334") end
end

local function late_update()
    for _,manager in pairs(mFlyTextManagers) do
        manager:Update()
    end
end

local function refresh(params)
    --print(name, "refresh")

end



local function init(params)
    name, gameObject, fields = unpack(params)
    ShowDmg = true
    DamageTypeText[0x0] = {text = "",type = flytext.FlyTextType.Damage}
    DamageTypeText[0x1] = {text = LocalString.FlyText[1], type=flytext.FlyTextType.Blue1}
    DamageTypeText[0x2] = {text = LocalString.FlyText[2], type=flytext.FlyTextType.Purple1}
    DamageTypeText[0x4] = {text = LocalString.FlyText[3], type=flytext.FlyTextType.CritWhite}
    DamageTypeText[0x1+0x2] = {text = LocalString.FlyText[2],type = flytext.FlyTextType.Purple2}
    DamageTypeText[0x1+0x4] = {text = LocalString.FlyText[1],type = flytext.FlyTextType.Blue2}
    DamageTypeText[0x2+0x4] = {text = LocalString.FlyText[2],type = flytext.FlyTextType.Purple2}
    DamageTypeText[0x1+0x2+0x4] ={text = LocalString.FlyText[3],type = flytext.FlyTextType.Golden}


    Container = {
        [3] = gameObject.transform:Find("Group_CountDown/Container_3").gameObject,
        [2] = gameObject.transform:Find("Group_CountDown/Container_2").gameObject,
        [1] = gameObject.transform:Find("Group_CountDown/Container_1").gameObject,
        [0] = gameObject.transform:Find("Group_CountDown/Container_Start").gameObject,
    }

    mFlyTextManagers = {}
    mFlyTextManagers[flytext.FlyTextType.SystemInfo] = flytext.SystemInfoFlyTextManager:new(fields.UIList_FlyTextSystemInfo,true)
    mFlyTextManagers[flytext.FlyTextType.ItemInfo] = flytext.ItemInfoFlyTextManager:new(fields.UIList_FlyTextItemInfo,true)
    mFlyTextManagers[flytext.FlyTextType.Damage] = flytext.DamageFlyTextManager:new(fields.UIList_FlyTextDamage)
    mFlyTextManagers[flytext.FlyTextType.Block] = flytext.BlockFlyTextManager:new(fields.UIList_FlyTextBlock)
    mFlyTextManagers[flytext.FlyTextType.Dodge] = flytext.DodgeFlyTextManager:new(fields.UIList_FlyTextDodge)
    mFlyTextManagers[flytext.FlyTextType.CritWhite] = flytext.CritWhiteFlyTextManager:new(fields.UIList_FlyTextCrit_White)
    mFlyTextManagers[flytext.FlyTextType.Blue1] = flytext.Blue1FlyTextManager:new(fields.UIList_FlyTextCrit_Blue01)
    mFlyTextManagers[flytext.FlyTextType.Blue2] = flytext.Blue2FlyTextManager:new(fields.UIList_FlyTextCrit_Blue02)
    mFlyTextManagers[flytext.FlyTextType.Purple1] = flytext.Purple1FlyTextManager:new(fields.UIList_FlyTextCrit_Purple01)
    mFlyTextManagers[flytext.FlyTextType.Purple2] = flytext.Purple2FlyTextManager:new(fields.UIList_FlyTextCrit_Purple02)
    mFlyTextManagers[flytext.FlyTextType.Golden] = flytext.GoldenFlyTextManager:new(fields.UIList_FlyTextCrit_Golden)
    mFlyTextManagers[flytext.FlyTextType.Red] = flytext.SelfWhiteFlyTextManager:new(fields.UIList_FlyTextDamageSelf)
    mFlyTextManagers[flytext.FlyTextType.Green1] = flytext.Green1FlyTextManager:new(fields.UIList_FlyTextCrit_Green01)
    mFlyTextManagers[flytext.FlyTextType.Green2] = flytext.Green2FlyTextManager:new(fields.UIList_FlyTextCrit_Green02)

end



return {
    init = init,
    show = show,
    hide = hide,
    update = update,
    late_update = late_update,
    destroy = destroy,
    refresh = refresh,
    AddInfo = AddInfo,
    AddItemInfo = AddItemInfo,
    AddSystemInfo = AddSystemInfo,
    ShowCountDown = ShowCountDown,
    AddHealInfo = AddHealInfo,
    SetEnable   = SetEnable,
}
