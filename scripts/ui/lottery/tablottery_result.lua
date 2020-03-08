--local tablottery_result  = require "ui.lottery.tablottery_result"
local unpack         = unpack
local print          = print
local EventHelper    = UIEventListenerHelper
local uimanager      = require("uimanager")
local network        = require("network")
local lotterymanager = require "ui.lottery.lotterymanager"

local LimitManager   = require("limittimemanager")
local ItemEnum 		 = require("item.itemenum")
local ItemManager    = require("item.itemmanager")
local ItemIntroduct  = require("item.itemintroduction")
local Pet            = require"character.pet.pet"
local Talisman       = require("character.talisman.talisman")
local PlayerRole     = require "character.playerrole"



local gameObject
local name
local fields
local dialogname = "lottery.dlglottery"
local tabname = "lottery.tablottery_result"

local lotterydatas
local showresults = {}
local showindex = 0
local showtime = 0
local ShowInterval = 0.2
local showcharacter
local quality_showeffects --根据品质显示不同特效组
local quality_ranks --根据品质显示不同Sprite




local ShowState = enum{
    "None",
    "Before",
    "Show",
    "Stop",
    "Interrupt", --被其它页面中断
    "Finish",
}



local CurrentState = ShowState.None
local InterruptState = ShowState.None

local function SetState(state)
     printyellow("tablottery SetState " ,utils.getenumname(ShowState,state))
    if state == ShowState.Interrupt then 
        InterruptState = CurrentState
    end 

    CurrentState = state
end

local function SetOptionActive(active)
    uimanager.call("dlgdialog","SetListCurrencyActive",active)
    uimanager.call("dlgdialog","SetReturnButtonActive",active)
    if fields.UIGroup_Options.gameObject.activeSelf ~=active then
	    fields.UIGroup_Options.gameObject:SetActive(active)
    end
end 

local function release()

    if showcharacter then
        showcharacter:release()
        showcharacter = nil
    end
end

local function SetModelOffset(go,itemid)
    local modeloffset = ConfigManager.getConfigData("lotteryitemoffset",itemid)
    if modeloffset and go then
        go.transform.localPosition = Vector3(modeloffset.x,modeloffset.y,modeloffset.z)
        go.transform.localScale = Vector3(modeloffset.scale,modeloffset.scale,modeloffset.scale)
    else
        go.transform.localPosition = Vector3.zero
        go.transform.localScale = Vector3.one
    end
end

local function RefreshQualityEffect(quality)
     for q,groups in pairs(quality_showeffects) do
        for _,group in ipairs(groups) do
            group.gameObject:SetActive(quality == q)
        end
    end
end


local function RefreshModel(showinfo)
    --printyellow("refresh model")
    release()
    fields.UITexture_Character.gameObject:SetActive(showinfo.itemtype == ItemEnum.ItemBaseType.Pet)
    fields.UITexture_Talisman.gameObject:SetActive(showinfo.itemtype == ItemEnum.ItemBaseType.Talisman)

    if showinfo.itemtype == ItemEnum.ItemBaseType.Pet then
        local pet = ConfigManager.getConfigData("petbasicstatus",showinfo.itemid)
        if pet then
            local modeldata = ConfigManager.getConfigData("model",pet.modelname)
            if IsNullOrEmpty(modeldata.portrait) then
                logError("show lottery config error please check! petid:",showinfo.itemid)
            else
                --printyellow("set texture ",modeldata.portrait)
                fields.UITexture_Character:SetIconTexture(modeldata.portrait)
            end
        end
    elseif showinfo.itemtype == ItemEnum.ItemBaseType.Talisman then
        showcharacter = Talisman:new()
        showcharacter.m_AnimSelectType= cfg.skill.AnimTypeSelectType.UI
        showcharacter:RegisterOnLoaded(function(go)
            if IsNull(showcharacter.m_Object)  then printyellow("no object??") return end
            local trans         = showcharacter.m_Object.transform
            trans.parent        = fields.UITexture_Talisman.gameObject.transform
            trans.localRotation = Quaternion.identity
            ExtendedGameObject.SetLayerRecursively(showcharacter.m_Object, define.Layer.LayerUI)
            --showcharacter:UIScaleModify()
            SetModelOffset(showcharacter.m_Object,showinfo.itemid)
        end)
        showcharacter:init(showinfo.item,PlayerRole:Instance())

    end


    local quality = showinfo.showitem:GetQuality()
    RefreshQualityEffect(quality)


    fields.UITexture_Rank:SetIconTexture(quality_ranks[quality])

    EventHelper.SetPlayTweensFinish(fields.UIPlayTweens_Show,function()
        fields.UITexture_Background.gameObject:SetActive(true)
	end)
    fields.UITexture_Background.gameObject:SetActive(false)
	fields.UIPlayTweens_Show:Play(true)
end


local function startshow()
    printyellow("startshow()")
    uimanager.refresh(tabname)
    showindex = 1
    showtime = 0
    SetOptionActive(false)
    fields.UIGroup_Result.gameObject:SetActive(false)
    fields.UIGroup_WholeCard.gameObject:SetActive(false)
    fields.UIGroup_Start.gameObject:SetActive(true)
    fields.UIList_Rewards:Clear()
    SetState(ShowState.Before)
    EventHelper.SetPlayTweensFinish(fields.UIPlayTweens_Timer,function()
        if CurrentState == ShowState.Before then
            SetState(ShowState.Show)
            fields.UIGroup_Result.gameObject:SetActive(true)
        end
	end)
    fields.UIPlayTweens_Timer:Play(true)
    fields.UIPlayTweens_Timeline:Play(true)
end
--显示抽卡结果
local function showresult(results,datas)
    --printt(results)
    lotterydatas = datas
    showresults = results
    SetState(ShowState.None)
    if uimanager.isshow(tabname) then
        startshow()
    else
        uimanager.showdialog(tabname)
    end
end


local function destroy()
    -- print(name, "destroy")
    release()
    SetState(ShowState.None)
    fields.UIGroup_Result.gameObject:SetActive(false)
    lotterydatas = nil
    showresults = nil
end

local function show(params)
    -- print(name, "show")
    printyellow(InterruptState,ShowState.None,InterruptState ~= ShowState.None)
    if CurrentState == ShowState.Interrupt then 
        if InterruptState == ShowState.Before then
            startshow()
        else
            SetOptionActive(false)
            SetState(InterruptState)
        end
        InterruptState = ShowState.None
    elseif CurrentState == ShowState.None then 
        startshow() 
    end 
    
end

local function hide()
    -- print(name, "hide")
    if CurrentState == ShowState.Before or CurrentState == ShowState.Show or CurrentState == ShowState.Stop then
        SetState(ShowState.Interrupt)
    end
end

local function refresh(params)
    --print(name, "refresh")
     --printyellow("fields.UIList_Option.Count",fields.UIList_Option.Count)
    for index = 0,fields.UIList_Option.Count-1 do
        local item = fields.UIList_Option:GetItemByIndex(index)
        item.Data = lotterydatas[index+1]

        item:SetText("UILabel_Msg",item.Data:GetMsg())
        item.Controls["UISprite_Icon"].spriteName = item.Data:GetIcon()
        item:SetText("UILabel_Amount",item.Data:GetAmount())
        item:SetText("UILabel_Discription",item.Data:Desc())
        local button = item.Controls["UIButton_Pray"]
        EventHelper.SetClick(button, function()
            lotterymanager.CPickCard(item.Data)
        end )
    end
end



local function updatestate_before()

end


local function updatestate_show()
    if showtime < ShowInterval then
        showtime = showtime + Time.deltaTime
    else
        if showindex <= #showresults then
            showtime = 0
            local showresult = showresults[showindex]
            showindex = showindex+1

            local item = fields.UIList_Rewards:AddListItem()
            item.Id = showresult.showitemid
            item.Data = showresult.showitem
            item:SetIconTexture(showresult.showitem:GetIconPath())
            item:SetText("UILabel_Count",string.format("X%s",showresult.showitem:GetNumber()))
            colorutil.SetQualityColorText(item.Controls["UILabel_Name"],showresult.showitem:GetQuality(),showresult.showitem:GetName())
            item.Controls["UISprite_Quality"].color = colorutil.GetQualityColor(showresult.showitem:GetQuality())
            --printyellow("isfragment",showresult.showitem:GetBaseType(),ItemEnum.ItemBaseType.Item)

		    item.Controls["UISprite_Fragment"].gameObject:SetActive(showresult.showitem:GetBaseType() == ItemEnum.ItemBaseType.Fragment)

            if showresult.wholecard then
                fields.UILabel_Reward.text = showresult.title
                fields.UIGroup_WholeCard.gameObject:SetActive(true)
                fields.UILabel_Splite.gameObject:SetActive(showresult.issplit)
                RefreshModel(showresult)
                SetState(ShowState.Stop)
            end


        else
            SetState(ShowState.Finish)
            SetOptionActive(true)
        end
    end
end

local function updatestate_stop()

end

local function update()
    -- print(name, "update")

    if CurrentState == ShowState.Before then
        updatestate_before()
    elseif CurrentState == ShowState.Show then
        updatestate_show()
    elseif CurrentState == ShowState.Stop then
        updatestate_stop()
    end
    if showcharacter then
        showcharacter.m_Avatar:Update()
    end
end


local function second_update(now)
    for index = 0,fields.UIList_Option.Count-1 do
        local item = fields.UIList_Option:GetItemByIndex(index)
        --printt(item.Data)
        if item.Data.m_TextureData.iscooldown then
            local UILabel_Msg           = item.Controls["UILabel_Msg"]
            if not item.Data:IsCoolDown() then
                UILabel_Msg.gameObject:SetActive(true)
                uimanager.refresh(tabname)
            else
                if UILabel_Msg.gameObject.activeInHierarchy then
                    UILabel_Msg.gameObject:SetActive(false)
                    uimanager.refresh(tabname)
                end
            end
        end
    end
end


local function init(params)
    name, gameObject, fields = unpack(params)
      --print(name, "init")
    uimanager.SetAnchor(fields.UITexture_Pray)
    uimanager.SetAnchor(fields.UITexture_Texture)
    quality_showeffects = {
        [cfg.item.EItemColor.BLUE] = {fields.UIGroup_Blue},
        [cfg.item.EItemColor.PURPLE] = {fields.UIGroup_Purple},
        [cfg.item.EItemColor.ORANGE] = {fields.UIGroup_Orange--[[,fields.UIGroup_Effect_Orange--]]},
        [cfg.item.EItemColor.RED] = {fields.UIGroup_Red--[[,fields.UIGroup_Effect_Red--]]},
    }


    quality_ranks = {
        [cfg.item.EItemColor.PURPLE] = "Texture_Excellent",
        [cfg.item.EItemColor.ORANGE] = "Texture_Perfect",
        [cfg.item.EItemColor.RED] = "Texture_Peerless",
    }

         --返回
    EventHelper.SetClick(fields.UITexture_Background, function()
        fields.UIGroup_WholeCard.gameObject:SetActive(false)
        RefreshQualityEffect()

        SetState(ShowState.Show)
    end )
    -- 显示随机奖励里的单个物品
--	EventHelper.SetListClick(fields.UIList_Rewards, function(listItem)
--		ItemIntroduct.DisplayItem( {
--			item = listItem.Data ,
--			variableNum = false,
--			-- bInCenter = true,
--			buttons =
--			{
--				{ display = false, text = "", callFunc = nil },
--				{ display = false, text = "", callFunc = nil },
--				{ display = false, text = "", callFunc = nil }
--			}
--		} )
--	end )




end

--不写此函数 默认为 UIShowType.Default
local function uishowtype()
    --return UIShowType.Default
    --return UIShowType.ShowImmediate--强制在showtab页时 不回调showtab
    return UIShowType.Refresh  --强制在切换tab页时回调show
    --return bit.bor(UIShowType.ShowImmediate,UIShowType.Refresh)
end

local function ondlgdialogrefresh() 
    SetOptionActive(not (CurrentState == ShowState.Before or CurrentState == ShowState.Show or CurrentState == ShowState.Stop))
end 




return {
    init            = init,
    show            = show,
    hide            = hide,
    update          = update,
    second_update   = second_update,
    destroy         = destroy,
    refresh         = refresh,
    uishowtype      = uishowtype,
    showresult      = showresult,
    ondlgdialogrefresh = ondlgdialogrefresh,
}
