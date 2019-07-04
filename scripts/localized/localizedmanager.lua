local m_LocalizedData

function get_localization_value(key)
    local result    
    for id,value in pairs(m_LocalizedData) do
        if id == key then
            result = value.taiwan
            break
        end 
    end
    if result == nil then
        printyellow("Not Localized Key:",key)
        result = key
    end
    return result
end

local function init()
    local ConfigManager = require"cfg.configmanager"
    m_LocalizedData = ConfigManager.getConfig("localized")
end

return
{
    init = init,
}