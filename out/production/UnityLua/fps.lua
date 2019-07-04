local UIManager = require("uimanager")

local m_UpdateInterval = 1
local m_Accum = 0
local m_Frames = 0
local m_TimeLeft = 0

local function update()
    if Local.HideFPS == false then
        m_TimeLeft = m_TimeLeft - Time.deltaTime 
        m_Accum = m_Accum + (Time.timeScale / Time.deltaTime) 
        m_Frames = m_Frames + 1
        if (m_TimeLeft <= 0) then        
            if UIManager.isshow("dlguimain") then
                local fps = m_Accum / m_Frames 
                local str = string.format("FPS:%.2f",fps)
                UIManager.call("dlguimain","RefreshFPS",str)   
            end
            m_TimeLeft = m_UpdateInterval 
            m_Accum =0 
            m_Frames = 0  
        end
    end  
end

local function init()
    m_TimeLeft = m_UpdateInterval 
    gameevent.evt_update:add(update)
end

return{
    init = init,
    update = update,
}
