local require = require
local unpack = unpack
local print = print
local EventHelper = UIEventListenerHelper
local UIManager = require("uimanager")
local name
local gameObject
local fields


local function destroy()

end

local function show(params)

end

local function hide()

end

local function refresh(params)
    local skill =params.skillConfig
    local skillLevel = params.skillLevel
    --printyellow("====================")
    --printyellow("GetSkillName", skill:GetSkillName())
    --printyellow("GetSkillDescription", skill:GetSkillDescription())
    --printyellow("GetSkillDetailDesc", skill:GetSkillDetailDesc())
    --printyellow(skill:GetSkillIcon())

    fields.UITexture_Skill01:SetIconTexture(skill:GetSkillIcon())
    fields.UILabel_SkillName01.text = skill:GetSkillName()
    fields.UILabel_Discription.text = skill:GetSkillDescription()
    fields.UILabel_Discription01.text = skill:GetSkillDetailDesc()
    fields.UILabel_Level.text = skillLevel
end

local function update()

end

local function init(params)
    name, gameObject, fields = unpack(params)
    EventHelper.SetClick(fields.UIButton_Close,function()
        UIManager.hide("dlgalert_skill")
    end)
    gameObject.transform.localPosition = Vector3(0,0,-1000)
end

return {
    init = init,
    show = show,
    hide = hide,
    update = update,
    destroy = destroy,
    refresh = refresh,
}
