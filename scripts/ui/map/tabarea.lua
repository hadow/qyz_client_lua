local Unpack = unpack
local EventHelper = UIEventListenerHelper
local UIManager = require("uimanager")
local ConfigManager=require("cfg.configmanager")
local CharacterManager=require "character.charactermanager"
local MapManager=require("map.mapmanager")
local NetWork = require("network")
local PlayerRole=require("character.playerrole")

local m_GameObject
local m_Name
local m_Fields
local m_NpcItem
local m_MonsterItem
local m_WarpItem
local m_WRatio
local m_HRatio
local m_IsExpand
local m_UITexture_AreaObj
local m_MapId=0
local m_NPCObjList={}
local m_MonsterObjList={}
local m_TeamMemberList={}
local m_RefreshTime=nil

local function LoadNPC()
    local npcObj=m_Fields.UISprite_NPCInAreaMap.gameObject
    local allNpcs=CharacterManager.GetAllNpcsByCsv()
    local UIList_NPC=m_NpcItem.Controls["UIList_Classification"]
    for _,npc in ipairs(allNpcs) do
        local targetObj=NGUITools.AddChild(m_UITexture_AreaObj,npcObj)
        targetObj:SetActive(true)
        table.insert(m_NPCObjList,targetObj)
        targetObj.transform.localPosition=MapManager.GetTransferCoordInArea(npc.position,m_WRatio,m_HRatio)
        local UIListItem_NPC=UIList_NPC:AddListItem()
        UIListItem_NPC.Id=npc.npcid
        UIListItem_NPC.Data=npc.position
        EventHelper.SetClick(UIListItem_NPC,function()
            UIManager.hidedialog("map.dlgmap")
            PlayerRole:Instance():navigateTo({
                targetPos = Vector3(npc.position.x,npc.position.y,npc.position.z),
                roleId = npc.npcid,
            --    eulerAnglesOfRole = npc.orientation,
                newStopLength = 1.5,
                callback = function ()
                end}
            )
        end)
        local UILabel_NPC=UIListItem_NPC.Controls["UILabel_SubName"]
        UILabel_NPC.text=ConfigManager.getConfigData("npc",npc.npcid).name
    end
    local UISprite_AddInNPC=m_NpcItem.Controls["UISprite_Add"]
    local UISprite_MinusInNPC=m_NpcItem.Controls["UISprite_Minus"]
    if #allNpcs==0 then
        UISprite_AddInNPC.gameObject:SetActive(false)
        UISprite_MinusInNPC.gameObject:SetActive(false)
    end
    EventHelper.SetClick(m_NpcItem,function()
        m_IsExpand.npcs=not (m_IsExpand.npcs)
        m_IsExpand.warps=false
        m_IsExpand.monsters=false
        if m_IsExpand.npcs==false then
            local UIToggle=m_NpcItem:GetComponent("UIToggle")
            UIToggle:Set(false)
        end
    end)
end

local function LoadMonsters()
    local monsterObj = m_Fields.UISprite_MonsterInAreaMap.gameObject
    local allMonsters=CharacterManager.GetAllPolygonRegions()
    local UIList_Monsters=m_MonsterItem.Controls["UIList_Classification"]
    for _,monster in ipairs(allMonsters) do
            --添加monster图标
        local targetObj=NGUITools.AddChild(m_UITexture_AreaObj,monsterObj)
        targetObj:SetActive(true)
        table.insert(m_MonsterObjList,targetObj)
        targetObj.transform.localPosition=MapManager.GetTransferCoordInArea(monster.position,m_WRatio,m_HRatio)
        local UIListItem_Monster=UIList_Monsters:AddListItem()
            --UIListItem_Monster.Id=monster.monsterid
        UIListItem_Monster.Data=monster.position
        EventHelper.SetClick(UIListItem_Monster,function()
            UIManager.hidedialog("map.dlgmap")
            PlayerRole:Instance():navigateTo({
                targetPos = Vector3(monster.position.x,monster.position.y,monster.position.z),
                callback  = function ()
                end
            })
        end)
        local UILabel_Monster=UIListItem_Monster.Controls["UILabel_SubName"]
        UILabel_Monster.text=monster.monsterName
    end
    local UISprite_AddInMonster=m_MonsterItem.Controls["UISprite_Add"]
    local UISprite_MinusInMonster=m_MonsterItem.Controls["UISprite_Minus"]
    if #allMonsters==0 then
        UISprite_AddInMonster.gameObject:SetActive(false)
        UISprite_MinusInMonster.gameObject:SetActive(false)
    end
    EventHelper.SetClick(m_MonsterItem,function()
        m_IsExpand.monsters=not (m_IsExpand.monsters)
        m_IsExpand.warps=false
        m_IsExpand.npcs=false
        if m_IsExpand.monsters==false then
            local UIToggle=m_MonsterItem:GetComponent("UIToggle")
            UIToggle:Set(false)
        end
    end)
end

local function LoadWarps()
    local allWarps=CharacterManager.GetAllWarps()
    local UIList_Warps=m_WarpItem.Controls["UIList_Classification"]
--    UIList_Warps:Clear()
    for _,warp in ipairs(allWarps) do
--            --添加传送点图标
--            local targetObj=NGUITools.AddChild(m_UITexture_AreaObj,monsterObj)
--            targetObj:SetActive(true)
--            targetObj.transform.localPosition=Vector3((warp.position.x)*ratio,(warp.position.z)*ratio,0)
        local UIListItem_Warp=UIList_Warps:AddListItem()
        UIListItem_Warp.Id=warp.id
        UIListItem_Warp.Data=warp.position      
        EventHelper.SetClick(UIListItem_Warp,function()
            PlayerRole:Instance().m_NavigateToWarp=true
            UIManager.hidedialog("map.dlgmap")
            PlayerRole:Instance():navigateTo({
                targetPos = Vector3(warp.position.x,warp.position.y,warp.position.z),
                callback = function ()
                end})
            end)
        local UILabel_Warp=UIListItem_Warp.Controls["UILabel_SubName"]
        UILabel_Warp.text=warp.name
    end
    local UISprite_AddInWarp=m_WarpItem.Controls["UISprite_Add"]
    local UISprite_MinusInWarp=m_WarpItem.Controls["UISprite_Minus"]
    if #allWarps==0 then
        UISprite_AddInWarp.gameObject:SetActive(false)
        UISprite_MinusInWarp.gameObject:SetActive(false)
    end
    EventHelper.SetClick(m_WarpItem,function()
        m_IsExpand.warps=not (m_IsExpand.warps)
        m_IsExpand.monsters=false
        m_IsExpand.npcs=false
        if m_IsExpand.warps==false then
            local UIToggle=m_WarpItem:GetComponent("UIToggle")
            UIToggle:Set(false)
        end
    end)
end

local function LoadTeamMembers()
    local TeamManager=require"ui.team.teammanager"
    local teamInfo=TeamManager.GetTeamInfo()
    if teamInfo then
        if teamInfo.members then
            for id ,member in pairs(teamInfo.members) do
                if id~=PlayerRole:Instance().m_Id then
                    TeamManager.SendGetPlayerLocation(id)
                end
            end
        end
    end
end

local function RefreshTeamMemberLocation(params)
    if (PlayerRole:Instance():GetMapId()==params.info.worldid) and (PlayerRole:Instance().m_MapInfo:GetLineId()==params.info.lineid) then
        local roleId=params.info.roleid
        if roleId then
            
            if IsNull(m_TeamMemberList.roleId) then   
                local Obj=m_Fields.UISprite_TeammateInAreaMap.gameObject
                local targetObj=NGUITools.AddChild(m_UITexture_AreaObj,Obj)
                m_TeamMemberList.roleId=targetObj
            end
            m_TeamMemberList.roleId:SetActive(true)
            m_TeamMemberList.roleId.transform.localPosition=MapManager.GetTransferCoordInArea(params.info.position,m_WRatio,m_HRatio)
        end
    end
end

local function RefreshOwnPos()
    local playerPos=PlayerRole:Instance():GetPos()
    local rotation=nil
    if PlayerRole:Instance():IsRiding() then
        rotation=PlayerRole:Instance().m_Mount.m_Object.transform.rotation
    else
        rotation=PlayerRole:Instance().m_Object.transform.rotation
    end
    local UILabel_Coordinate=m_Fields.UILabel_Coordinate
    UILabel_Coordinate.text=((LocalString.AreaMap_CurCoord)..string.format("%.0f",playerPos.x)..(LocalString.AreaMap_CoordSeparator)..string.format("%.0f",playerPos.z))
    m_Fields.UISprite_PlayerInAreaMap.transform.localPosition=MapManager.GetTransferCoordInArea(playerPos,m_WRatio,m_HRatio)
    m_Fields.UISprite_PlayerInAreaMap.transform.rotation = Quaternion.Euler(0, 0, - rotation.eulerAngles.y)
end

local function ClearSubObj()
    local UIList_NPC=m_NpcItem.Controls["UIList_Classification"]
    UIList_NPC:Clear()
    local UIList_Monsters=m_MonsterItem.Controls["UIList_Classification"]
    UIList_Monsters:Clear()
    local UIList_Warps=m_WarpItem.Controls["UIList_Classification"]
    UIList_Warps:Clear()
end

local function SelectFirst()
--    local UIToggle_NPC= m_NpcItem.gameObject.transform:GetComponent("UIToggle")
--    UIToggle_NPC.value=true
--    local UIPlayTween = m_NpcItem.gameObject.transform:GetComponent("UIPlayTween")
--    UIPlayTween:Play(true)
--    local allNpcs=CharacterManager.GetAllNpcsByCsv()
--    if #allNpcs>0 then
--        m_IsExpand.npcs=not (m_IsExpand.npcs)
--        local UISprite_AddInNPC=m_NpcItem.Controls["UISprite_Add"]
--        local UISprite_MinusInNPC=m_NpcItem.Controls["UISprite_Minus"]
--        UISprite_AddInNPC.gameObject:SetActive(not(m_IsExpand.npcs))
--        UISprite_MinusInNPC.gameObject:SetActive(m_IsExpand.npcs)
--    end
end
local function ClearObj()
    for _,targetObj in pairs(m_NPCObjList) do
        NGUITools.Destroy(targetObj)
    end
    for _,targetObj in pairs(m_MonsterObjList) do
        NGUITools.Destroy(targetObj)
    end
    m_MonsterObjList={}
    m_NPCObjList={}
end

local function LoadAreaMap()
    local width=m_Fields.UITexture_AreaInAreaMap.width
    local height=m_Fields.UITexture_AreaInAreaMap.height
    local sceneName=ConfigManager.getConfigData("worldmap",PlayerRole:Instance():GetMapId()).scenename
    local sceneData=ConfigManager.getConfigData("scene",sceneName)
    local sceneSize=sceneData.scenesize
    m_WRatio=width/sceneSize
    m_HRatio=height/sceneSize
    if m_MapId~=PlayerRole:Instance():GetMapId() then
        ClearObj()
        m_MapId=PlayerRole:Instance():GetMapId()
        m_IsExpand={npcs=false,monsters=false,warps=false}
        m_Fields.UIList_Parent:Clear()
        m_NpcItem=m_Fields.UIList_Parent:AddListItem()
        m_NpcItem.Controls["UILabel_Name"].text="NPC"
        m_MonsterItem=m_Fields.UIList_Parent:AddListItem()
        m_MonsterItem.Controls["UILabel_Name"].text=LocalString.AreaMap_Monster
        m_WarpItem=m_Fields.UIList_Parent:AddListItem()
        m_WarpItem.Controls["UILabel_Name"].text=LocalString.AreaMap_Warp
        LoadNPC()
        LoadMonsters()
        LoadWarps()
        LoadTeamMembers()
        --SelectFirst()
    end
    --显示当前坐标
    RefreshOwnPos()
    local UITexture_AreaInAreaMap=m_Fields.UITexture_AreaInAreaMap
    UITexture_AreaInAreaMap:SetIconTexture(ConfigManager.getConfigData("worldmap",PlayerRole:Instance():GetMapId()).scenename)
    EventHelper.SetClick(UITexture_AreaInAreaMap,function()
        --[[
--        printyellow("SetClick")
        local go=UITexture_AreaInAreaMap.gameObject
        local camera = NGUITools.FindCameraForLayer(go.layer)
        local bounds = NGUIMath.CalculateAbsoluteWidgetBounds(go.transform)
--        printt(bounds)
        local min = camera:WorldToScreenPoint(bounds.min)
        local max = camera:WorldToScreenPoint(bounds.max)
--        printt(min)
--        printt(max)
        local position=Vector3.zero
        if Input.GetMouseButtonDown(0) then
--            printyellow("1")
            position = Input.mousePosition
        elseif Input.touchCount > 0 and Input.GetTouch(0).phase == TouchPhase.Began then
--            printyellow("2")
            position = Input.GetTouch(0).position
        end
        local p0 =  UITexture_AreaInAreaMap.cachedTransform.worldToLocalMatrix:MultiplyPoint(UICamera.lastHit.point)
--        printt(p0)
        local realPos=Vector3(p0.x/m_WRatio,0,p0.y/m_HRatio)
--        printt(realPos)
        PlayerRole:Instance():navigateTo({targetPos = realPos})
        ]]
    end)
end

local function update()
    if PlayerRole:Instance():IsNavigating() or PlayerRole:Instance():IsFlyNavigating() then
        if m_RefreshTime and (os.time()-m_RefreshTime<1) then
            return
        end
        m_RefreshTime=os.time()
        RefreshOwnPos()
    end
end

local function show(params)
end

local function hide()
end

local function refresh(params)
    LoadAreaMap()
end

local function destroy()
end

local function init(params)
    m_Name, m_GameObject, m_Fields = Unpack(params)
    m_IsExpand={npcs=false,monsters=false,warps=false}
    m_UITexture_AreaObj=m_Fields.UITexture_AreaInAreaMap.gameObject
    local UISprite_LeftBackground=m_Fields.UISprite_LeftBackground
    local UISprite_LeftBackgroundObj=UISprite_LeftBackground.gameObject
end

local function uishowtype()
    return UIShowType.Refresh
end

return {
    init = init,
    show = show,
    hide = hide,
    update = update,
    destroy = destroy,
    refresh = refresh,
    uishowtype = uishowtype,
    RefreshTeamMemberLocation = RefreshTeamMemberLocation,
}
