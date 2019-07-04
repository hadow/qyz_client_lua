local require = require
local unpack = unpack
local print = print
local EventHelper = UIEventListenerHelper
local UIManager = require("uimanager")
local name
local gameObject
local fields
local dlgname = "dlgdialogbox_status"


local function destroy()

end

local function show(params)
    fields.UIList_Status:Clear()
    local head = fields.UIList_Status:AddListItem()
    head:SetText("UILabel_Name","Name")
    head:SetText("UILabel_CpuTime","Time")
    head:SetText("UILabel_MaxCpuTime","MaxTime")
    head:SetText("UILabel_TotalCpuTime","TotalTime")
    head:SetText("UILabel_CallTimes","Calls")
    local statuslisteners = status.GetAllStatusListeners()
    for i=1,#statuslisteners do 
        local item = fields.UIList_Status:AddListItem()
        item.Data = statuslisteners[i]
    end 
    UIManager.refresh(dlgname)
end

local function hide()

end

local function refresh(params)
    for i = 1,fields.UIList_Status.Count-1 do 
        local item = fields.UIList_Status:GetItemByIndex(i)
        item:SetText("UILabel_Name",item.Data.name)
        item:SetText("UILabel_CpuTime",string.format("%.2fms",item.Data.cputime*1000))
        item:SetText("UILabel_MaxCpuTime",string.format("%.2fms",item.Data.cpumaxtime*1000))
        item:SetText("UILabel_TotalCpuTime",string.format("%.2fms",item.Data.totalcputime*1000))
        item:SetText("UILabel_CallTimes",item.Data.calltimes)
    end 
end


local function init(params)
    name, gameObject, fields = unpack(params)
    EventHelper.SetClick(fields.UIButton_Close,function()
        UIManager.hide(dlgname)
    end)
    gameObject.transform.localPosition = Vector3(0,0,-1000)
end

local function second_update(now)
    UIManager.refresh(dlgname)
end 

return {
    init = init,
    show = show,
    hide = hide,
    update = update,
    destroy = destroy,
    refresh = refresh,
    second_update = second_update,
}
