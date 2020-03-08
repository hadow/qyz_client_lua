local unpack = unpack
local print = print
local uimanager = require("uimanager")
local ObjPoolsManager = require"objectpoolsmanager"
local gameObject
local name
local fields
local uiFadeIn,uiFadeOut
local ElapsedTime

local function destroy()
end

local function update()
    if ElapsedTime then
        if ElapsedTime > 0 then
            ElapsedTime = ElapsedTime - Time.deltaTime
        else
            uimanager.hide(name)
            uimanager.show("dlglogin")
            ElapsedTime = nil
        end
    end
end

local function show(params)
    ElapsedTime = 3
    -- uiFadeIn:Play()

    if not ObjPoolsManager.IsInited() then
        ObjPoolsManager.init()
    end
end

local function hide()

end

local function refresh(params)

end

local function init(params)
    name, gameObject, fields = unpack(params)

    uimanager.SetAnchor(fields.UISprite_Background)

    -- uiFadeIn.onFinished = {function()
    --     uiFadeOut:Play()
    -- end}
    --
    -- uiFadeOut.onFinished = {function()
    --     uimanager.show("dlglogin")
    -- end}

end


return {
    init = init,
    show = show,
    hide = hide,
    update = update,
    destroy = destroy,
    refresh = refresh,
}
