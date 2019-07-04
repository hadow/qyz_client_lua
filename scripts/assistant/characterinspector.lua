local CharacterManager  = require("character.charactermanager")
local defineenum        = require "defineenum"
local CharacterType     = defineenum.CharacterType

local function GetCharactersInfo()
    local charactersInfo = {
        charactercount = 0,
        numinfo = {
            ["1"] = 0,
            ["2"] = 0,
            ["4"] = 0,
            ["8"] = 0,
            ["16"] = 0,
        },
        characters = {},
    }
    local characters = CharacterManager.GetCharacters()
    for id,char in pairs(characters) do
        if charactersInfo.numinfo[tostring(char.m_Type)] == nil then
            charactersInfo.numinfo[tostring(char.m_Type)] = 1
        else
            charactersInfo.numinfo[tostring(char.m_Type)] = charactersInfo.numinfo[tostring(char.m_Type)] + 1
        end
        charactersInfo.charactercount = charactersInfo.charactercount + 1
        charactersInfo.characters[tostring(char.m_Id)] = char
    end
    return charactersInfo
end
local function GetCharacterInfoById(id)
    local char = CharacterManager.GetCharacter(id)
    return char
end
local function SetPosition(id, x,y,z)

end
return {
    GetCharactersInfo = GetCharactersInfo,
    GetCharacterInfoById = GetCharacterInfoById,
    SetPosition = SetPosition,
}
