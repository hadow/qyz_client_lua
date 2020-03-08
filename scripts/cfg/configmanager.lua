-- local ConfigManager = require "cfg.configmanager"


local os = require "cfg.structs"
local AllCsvCfgs
local AllCsvLoadPath
function create_datastream(file)
    return os.new(LuaHelper.GetPath("config/csv/" .. file))
end

local function loadCsv()
--    printyellow("load csv")
--    AllCsvCfgs = require "cfg.configs"
    AllCsvLoadPath = require "cfg.csvloadpath"
end

local function init()
    AllCsvCfgs = {}
    loadCsv()
 --   printt(AllCsvCfgs["skill"])
end

local function loadConfig(configname)

    local s = AllCsvLoadPath[configname]
    if not s then
        return nil
    end
    local fs = create_datastream(s.output)
    local method = 'get_' .. s.type:gsub('%.', '_')
    if not s.single then
        local c = {}
        for i = 1, fs:get_int() do
            local v = fs[method](fs)
            c[v[s.index]] = v
        end
        AllCsvCfgs[s.name] = c
    else
        if fs:get_int() ~= 1 then error('single config size != 1') end
        AllCsvCfgs[s.name] = fs[method](fs)
    end
    fs:close()
end

local index = 0
local function getConfig(configname)
    --printyellow(configname)
    --printt(AllCsvCfgs[configname])

    if not AllCsvCfgs or not AllCsvCfgs[configname] then
        loadConfig(configname)
        index = index+1
        print("load config index :"..index..configname)
    end
    if AllCsvCfgs then
        return AllCsvCfgs[configname]
    end
    return nil
end

local function getConfigData(configname,index)
    local config = getConfig(configname)
    if config then
        return config[index]
    end
    return nil
end



local function getProfessionData(faction,gender)
    local professions = getConfig("profession")
    for _,data in pairs(professions) do
        if data.faction == faction and data.gender == gender then
            return data
        end
    end
    return nil
end

local function GetHeadIcon(profession, gender)
    local dataprofession = ConfigManager.getConfigData("profession", profession)
    if not dataprofession then return "" end
    local datamodel = ConfigManager.getConfigData("model",
                                                  gender == cfg.role.GenderType.MALE and dataprofession.modelname or dataprofession.modelname2)
    if not datamodel then return "" end
    return datamodel.headicon
end

return
{
    init              = init,
    getConfig         = getConfig,
    getConfigData     = getConfigData,
    getProfessionData = getProfessionData,
    GetHeadIcon       = GetHeadIcon,
}
