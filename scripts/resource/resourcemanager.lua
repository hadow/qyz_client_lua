local Define        = require("define")
local ConfigManager = require("cfg.configmanager")

local function ChangeAvatar(char_obj, avatar_obj, callback)
    for i = 1, char_obj.transform.childCount do
        local trans = char_obj.transform:GetChild(i-1)
        Util.Destroy(trans.gameObject)
    end
    local childList = {}
    for i = 1, avatar_obj.transform.childCount do
        local trans = avatar_obj.transform:GetChild(i-1)
        table.insert(childList,trans)
    end
    for i, trans in pairs(childList) do
        trans.parent = char_obj.transform
    end
    Util.Destroy(avatar_obj)
    callback(char_obj)
end


local function InstantiateObject(modelCfg, asset_obj, modelPath)
    if asset_obj then
        return Util.Instantiate(asset_obj, modelPath)
    end
    logError("加载文件失败：" .. tostring(modelCfg.modelname))
    return nil
end

--=================================================================================================
--加载Object（通用）
local function LoadGameObject(modelCfg, params, callback)
    local modelPath = string.format( "character/c_%s.bundle",modelCfg.modelpath)
    return Util.Load(modelPath, params.mode, function(asset_obj)
        if not IsNull(asset_obj) then
            callback(InstantiateObject(modelCfg, asset_obj, modelPath))
        else
            callback(nil)
        end
    end )
end
--加载UI
local function LoadUI()

end
--加载特效
local function LoadEffect(modelCfg, params, callback)
    local modelPath = string.format( "sfx/s_%s.bundle",modelCfg.modelpath)
    return Util.Load(modelPath, params.mode, function(asset_obj)
        if not IsNull(asset_obj) then
            callback(InstantiateObject(modelCfg, asset_obj, modelPath))
        else
            callback(nil)
        end
    end)
end
--加载角色
local function LoadCharacter(modelCfg, params, callback)
    local modelPath = string.format("character/c_%s.bundle",modelCfg.modelpath)
    --printyellow("params.animSelectType",params.animSelectType)
    local result = Game.CharacterLoader.Instance:Load(
        modelCfg.modelname,
        modelPath, 
        params.mode,
        params.animSelectType or cfg.skill.AnimTypeSelectType.Default, 
        function(asset_obj)
            if params.notLoadAvatar ~= true and modelCfg.avatarid ~= nil and modelCfg.avatarid ~= "" then
                local avatarPath = string.format("avatar/armour_%s.bundle",modelCfg.avatarid)
                Util.LoadAvatar(avatarPath, function(avatar_obj)
                    if not IsNull(asset_obj) and not IsNull(avatar_obj) then                  
                        local avatarObj = InstantiateObject(modelCfg, avatar_obj, modelPath)
                        ChangeAvatar(asset_obj, avatarObj, callback)
                    else
                        callback(nil)
                    end
                end)
            else
                callback(asset_obj)
            end
        end)
    return result
end

local ModelTypeLoader = {
    [cfg.character.ModelType.Effect]        = LoadEffect,
    [cfg.character.ModelType.NoAnimation]   = LoadGameObject,
}

local function GetLoader(modelCfg)
    if modelCfg.modeltype and ModelTypeLoader[modelCfg.modeltype] then
        return ModelTypeLoader[modelCfg.modeltype]
    end
    return LoadCharacter
end

local function LoadObject(index, params, callback)
    local params_in = params or {}
    params_in.mode = params_in.mode or Define.ResourceLoadType.LoadBundleFromFile
    local modelCfg = ConfigManager.getConfigData("model", index)
    if modelCfg == nil then
        logError("config error, model表中找不到配置："..tostring(index))
    end
    local loader = GetLoader(modelCfg)
    local result = loader(modelCfg, params_in, function(asset_obj)
        if IsNull(asset_obj) then
            logError("Load model failed: " .. tostring(index))
            callback(nil)
        else
            callback(asset_obj)
        end
    end)
    return result
end

local function LoadAudio(path, params, callback)
    Util.Load(path, Define.ResourceLoadType.LoadBundleFromFile, function(obj)
        callback(obj)
    end)
end

local function Copy(go)
    return Util.Copy(go)
end

local function Destroy(go)
    Util.Destroy(go)
end

local function ReplaceAnimatorControl(modelname, charactergo, callback)
     return Game.CharacterLoader.Instance:ReplaceMecanimControl(modelname, charactergo, callback)
end

return {
    LoadObject    = LoadObject,
    LoadAudio     = LoadAudio,
    Copy    = Copy,
    Destroy = Destroy,
    ReplaceAnimatorControl = ReplaceAnimatorControl,
}