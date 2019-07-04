--local SceneManager = require "scenemanager"
--local CameraManager = require"cameramanager"
--local ConfigManager = require"cfg.configmanager"
local PlayerRole = require"character.playerrole"
local Layout = require "ectype.layout"
local network = require"network"
local uimanager = require"uimanager"
local tools = require"ectype.ectypetools"
local Ectype = require"ectype.ectypebase"
local ConfigManager = require"cfg.configmanager"
local ResourceManager = require"resource.resourcemanager"

local dlgectype
local dlgmain
local ui
-- class Daily
local Arena = Class:new(Ectype)

function Arena:__new(entryInfo)
    Ectype.__new(self,entryInfo,cfg.ectype.EctypeType.ARENA)
    self.m_RemainTime       = entryInfo.remaintime/1000
    self.m_PlayerRole       = PlayerRole.Instance()
    self.m_CurrentReviveTime= 0

    self.m_ArrowObject = nil
    self.m_Enemy = nil

    self.m_IsBeginFight = false

    self.m_ArenaConfig = ConfigManager.getConfig("arenaconfig")
    self.m_ArrowDistance = self.m_ArenaConfig.arrowdistance
end

function Arena:SendRevive()
    local msg=map.msg.CRevive({})
    network.send(msg)
end

function Arena:GetEctypeInfo()
    return ConfigManager.getConfig("arenaectype")
end


function Arena:OnEnd(msg)
    Ectype.OnEnd(self,msg)
    if msg.errcode==0 then
        local ArenaManager = require("ui.arena.single.arenamanager")
    --    ArenaManager.AddSuccessCount()
    end
    uimanager.hide("ectype.dlguiectype")
    uimanager.showdialog("ectype.dlggrade",
            {   result      = (((msg.errcode==0) and true) or false),
                bonus       = msg.bonus,
                text        = (((msg.errcode==0) and string.format(LocalString.Arena.ArenaGrade_Success,msg.newrank)) or LocalString.Arena.ArenaGrade_Failure),
                callback    = function()
                                uimanager.hidedialog("ectype.dlggrade")
                                uimanager.show("ectype.dlguiectype")
                                network.send(lx.gs.map.msg.CLeaveMap({}))
                            end})

    if self.m_ArrowObject then
        ResourceManager.Destroy(self.m_ArrowObject)
        self.m_ArrowObject = nil
    end
--  uimanager.show("ectype.dlggrade",{showArena = true,errcode = msg.errcode, newrank = msg.newrank, bonus = msg.bonus})
end



function Arena:BeginFight(msg)
    Ectype.BeginFight(self, msg)
    self:RemoveAllAirWallArea()
    uimanager.call("dlguimain","SwitchAutoFight",true)
    self.m_IsBeginFight = true
end

function Arena:OnUpdateLoadingFinished()
    Ectype.OnUpdateLoadingFinished(self)
    self.m_EctypeUI = self.m_EctypeUI or require("ui." .. self.m_UI)
    self.m_EctypeUI.InsertMissionInfomation(0, { LocalString.Arena.EctypeInfo[1],"" } ,nil)
    self.m_EctypeUI.ShowGoal()
end

function Arena:GetEnemy()
    if self.m_Enemy then
        return self.m_Enemy
    end
    local CharacterManager = require("character.charactermanager")
    local chars = CharacterManager.GetCharacters()
    if chars then
        for i, char in pairs(chars) do
            if char:IsPlayer() and (not char:IsRole()) then
                self.m_Enemy = char
            end
        end
    end
    return self.m_Enemy
end
function Arena:GetArrowObject()
    if self.m_ArrowObject then
        return self.m_ArrowObject
    end
    self.m_ArrowObject = UnityEngine.GameObject("ArrowObject")
    ResourceManager.LoadObject(self.m_ArenaConfig.arrowindex, {}, function(asset_obj)
        if asset_obj then
            if not IsNull(self.m_ArrowObject) then
                asset_obj.transform.parent = self.m_ArrowObject.transform
                asset_obj.transform.localPosition = Vector3(0,0,0)
                -- asset_obj.transform.localRotation = Quaternion.Euler(0,90,0)
                asset_obj.transform.localScale =  Vector3(1,1,1)
            else
                ResourceManager.Destroy(asset_obj)
            end
        end
    end)

end



function Arena:ArrowUpdate()
    if self.m_IsBeginFight == true then
        local ememy = self:GetEnemy()
        local arrowObj = self:GetArrowObject()
        if arrowObj and PlayerRole:Instance().m_Object and ememy and ememy.m_Object then
            local playerTrans = PlayerRole:Instance().m_Object.transform
            local enemyTrans = ememy.m_Object.transform

            local currentDis = mathutils.DistanceOfXoZ(playerTrans.position, enemyTrans.position)
            if currentDis < self.m_ArrowDistance then
                if arrowObj.activeSelf == true then
                    arrowObj:SetActive(false)
                end
            else
                if arrowObj.activeSelf == false then
                    arrowObj:SetActive(true)
                end
            end
            arrowObj.transform.position = playerTrans.position
            --local direction = enemyTrans.position - arrowObj.transform.position
            arrowObj.transform:LookAt(playerTrans.position);


        end
    end
end

function Arena:Update()
    Ectype.Update(self)
    self:ArrowUpdate()
end

function Arena:late_update()

end

return Arena
