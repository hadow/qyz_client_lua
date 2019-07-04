local SceneManager=require"scenemanager"
local RideManager=require"ui.ride.ridemanager"
local PlayerRole=(require"character.playerrole"):Instance()

local m_IsFlyNaving=false
local m_NavParams=nil
local m_ReadyFlyNav=true
local m_ReFlyTime
local m_ReFlyTimes=0

local function SetNavInfo(params)
    m_IsFlyNaving=true
    m_NavParams=params
end

local function CheckIsNeedNav()
    if m_IsFlyNaving==true then
        if (SceneManager.HasSkyHeight()==true) then
            RideManager.Ride(RideManager.GetActivedRide(),cfg.equip.RideType.FLY)
            m_ReadyFlyNav=true
        elseif PlayerRole:CanRide() then
            RideManager.Ride(RideManager.GetActivedRide(),cfg.equip.RideType.WALK) 
            m_ReadyFlyNav=true 
        else
            PlayerRole:NavigateTo(m_NavParams)  
            m_NavParams=nil        
        end
        m_IsFlyNaving=false
    end
end

local function CheckIsNeedLineNav()
    if m_IsFlyNaving==true and m_NavParams.changeLine==true then
        if (SceneManager.HasSkyHeight()==true) then
            RideManager.Ride(RideManager.GetActivedRide(),cfg.equip.RideType.FLY)
            m_ReadyFlyNav=true
        elseif PlayerRole:CanRide() then
            RideManager.Ride(RideManager.GetActivedRide(),cfg.equip.RideType.WALK) 
            m_ReadyFlyNav=true 
        else
            PlayerRole:NavigateTo(m_NavParams)  
            m_NavParams=nil        
        end
        m_IsFlyNaving=false
    end
end

local function ClearData()
    m_IsFlyNaving=false
    m_NavParams=nil
    m_ReadyFlyNav=false
    m_ReFlyTime=os.time()
    m_ReFlyTimes=0
end

local function update()
    if m_ReadyFlyNav==true then
        if (SceneManager.HasSkyHeight()==true) then
            if PlayerRole:IsFlying() then
                PlayerRole:navigateTo(m_NavParams)
                ClearData()
            elseif (os.time()-m_ReFlyTime)>0.2 then
               RideManager.Ride(RideManager.GetActivedRide(),cfg.equip.RideType.FLY) 
               m_ReFlyTime=os.time()
               m_ReFlyTimes=m_ReFlyTimes+1
               if m_ReFlyTimes>1000 then
                  ClearData()
               end
            end
        else
            if PlayerRole:IsRiding() then
                PlayerRole:navigateTo(m_NavParams)
                ClearData()
            end        
        end
    end
end

local function IsFlyNav()
    local result=false
    result=((m_ReadyFlyNav==true) and (m_NavParams~=nil))
    return result
end

local function init()
    ClearData()
    gameevent.evt_update:add(update)
    gameevent.evt_system_message:add("logout", ClearData)
end

return{
    init = init,
    update = update,
    SetNavInfo = SetNavInfo,
    CheckIsNeedNav = CheckIsNeedNav,
    IsFlyNav = IsFlyNav,
    ClearData = ClearData,
    CheckIsNeedLineNav = CheckIsNeedLineNav,
}