local defineenum    = require "defineenum"
local BagManager    = require "character.bagmanager"
local CheckCmd      = require "common.checkcmd"
local ItemManager   = require "item.itemmanager"
local ConfigManager = require "cfg.configmanager"
local UIManager     = require "uimanager"
local NetWork       = require "network"
local VipChargeManger = require "ui.vipcharge.vipchargemanager"
local TeamManager = require("ui.team.teammanager")
local EventHelper   = UIEventListenerHelper

local name,gameObject,fields
local playerRole = nil
local isAutofight = false
local isNavigating = false
local autoFightSpriteGameObject = nil
local navigateSpriteGameObject = nil
local transDelayTime=nil

local function refresh()
end

local function CalculateTargetPos(params)
    local targetPos=params.targetPos
    if params and params.roleId then
        local stopLength=3
        if params.newStopLength then
            if params.newStopLength>stopLength then
                stopLength=params.newStopLength
            end
        end
        if params.eulerAnglesOfRole then
            local dir=Vector3(0,0,0)
            if params.eulerAnglesOfRole then
                if (params.eulerAnglesOfRole.x~=0) and (params.eulerAnglesOfRole.z~=0) then
                    dir=Vector3(params.eulerAnglesOfRole.x,0,params.eulerAnglesOfRole.z)
                else
                    for index,value in pairs(params.eulerAnglesOfRole) do
                        if index==2 then
                            dir.x=value
                        elseif index==4 then
                            dir.z=value
                        end
                    end
                end
                local tempTargetPos = targetPos + stopLength*dir
                local MapManager=require"map.mapmanager"
                if MapManager.IsValidNavigatePos({pos=tempTargetPos,mapId=params.mapId})==true then
                    targetPos=tempTargetPos
                end
            end
        end
    end
    return params.mapId,targetPos
end

local function UseFlySymbol(requireitemid, dayLimit)
    if transDelayTime and (os.time()-transDelayTime)<cfg.map.Transport.COLDTIME then
        return
    end
    local validate1,info1 = CheckCmd.CheckData({data = requireitemid})
    if validate1 then
        local validate, info = CheckCmd.CheckData( {data=dayLimit,moduleid=cfg.cmd.ConfigId.TRANSPORT,cmdid=0})
        if validate then
            local targetInfo = PlayerRole:Instance():GetNaivgateParams()
            local mapId,pos=CalculateTargetPos(targetInfo)
            if mapId == nil then
                mapId = PlayerRole:Instance():GetMapId()
            end
            PlayerRole:Instance():stop()
            transDelayTime=os.time()
            local msg = lx.gs.map.msg.CTransferWorldUseItem({worldid=mapId,position=pos})
            NetWork.send(msg)            
        else
            if (Local.HideVip~=true) then
                UIManager.ShowAlertDlg({
                    immediate    = true,
                    content         = LocalString.Fly_VIPNotEnough, 
                    callBackFunc    = function()
                        VipChargeManger.ShowVipChargeDialog()
                end})
            end
        end
    else
        ItemManager.GetSource(requireitemid.itemid,"dlguimain")
    end
end

local function CanUseFlySymbol()
    local result=true
    if PlayerRole:Instance():GetMapId()==22 or TeamManager.IsInHeroTeam() then
        result=false
    end
    return result
end

local function SetFlySymbol()
    if CanUseFlySymbol()==true then
        fields.UISprite_FlyIcon.gameObject:SetActive(true)       
        local transportData = ConfigManager.getConfig("transport")
        local flyNum = BagManager.GetItemNumById(transportData.requireitemid.itemid)
        fields.UILabel_FlyAmount.text = ("X" .. tostring(flyNum))
        local validate2, info2 = CheckCmd.CheckData({data = transportData.minlvl})
        if (not validate2) then
            EventHelper.SetClick(fields.UISprite_FlyIcon, function()
                UIManager.ShowSystemFlyText(string.format(LocalString.Fly_LevelNotEnough, transportData.minlvl.level))
            end)
        else  
            EventHelper.SetClick(fields.UISprite_FlyIcon, function()
                UseFlySymbol(transportData.requireitemid, transportData.daylimit)
            end)
        end
    else
        fields.UISprite_FlyIcon.gameObject:SetActive(false)  
    end
end

local function SetAutoFightSprite(b)
    isAutofight = b
    autoFightSpriteGameObject:SetActive(b)
    if b == true then
        navigateSpriteGameObject:SetActive(false)
    end
end


local function SetTargetHoming(params)
    fields.UIGroup_HurtTips.gameObject:SetActive(true)
    if params and params.pathFinding == true then
        navigateSpriteGameObject.gameObject:SetActive(true)
        SetFlySymbol()
        SetAutoFightSprite(false)
    else
        navigateSpriteGameObject.gameObject:SetActive(false)
    end
end

local function CloseTargetHoming()
    navigateSpriteGameObject:SetActive(false)
end

local function update()
end

local function SetTipsByPlayerState()
    isNavigating = playerRole:IsNavigating()
    if autoFightSpriteGameObject.activeSelf ~= isAutofight then
        autoFightSpriteGameObject:SetActive(isAutofight)
    end
    if isAutofight == true then
        if navigateSpriteGameObject.activeSelf == true then
            navigateSpriteGameObject:SetActive(false)
        end 
    else
        if autoFightSpriteGameObject.activeSelf == true then
            autoFightSpriteGameObject:SetActive(false)
        end
        if navigateSpriteGameObject.activeSelf ~= isNavigating then
            navigateSpriteGameObject:SetActive(isNavigating)
        end
    end
end

local function second_update()
end

local function init(dlgname,dlggameObject,dlgfields,params)
    name,gameObject,fields = dlgname,dlggameObject,dlgfields
    playerRole = PlayerRole:Instance()
    autoFightSpriteGameObject = fields.UIGroup_AutoFighting.gameObject
    navigateSpriteGameObject = fields.UIGroup_TargetHoming.gameObject
    fields.UILabel_PathFinding.gameObject:SetActive(true)
end

local function show()
    SetAutoFightSprite(false)
    SetTipsByPlayerState()
end

local function hide()
end

local function destroy()
end

return {
    init    = init,
    show    = show,
    update  = update,
    second_update = second_update,
    refresh = refresh,
    hide    = hide,
    destroy = destroy,
    SetAutoFightSprite = SetAutoFightSprite,
    SetTargetHoming = SetTargetHoming,
    CloseTargetHoming = CloseTargetHoming,
}
