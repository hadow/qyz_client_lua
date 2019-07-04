local Unpack = unpack
local EventHelper = UIEventListenerHelper
local UIManager = require("uimanager")

local name
local gameObject
local fields

Dlg_Complex_Type={
    UIGROUP_WASH=0,
    UIGROUP_UPDATE=1,
    UIGROUP_BILLIONOFWORDS=2,
    UIGroup_log=3,
}
----------------------------
--显示功能所需的Group，关闭无关的Group
-----------------------------
local function DisplayGroupByType(type)
    fields.UIGroup_Wash.gameObject:SetActive(type==Dlg_Complex_Type.UIGROUP_WASH)
    fields.UIGroup_Update.gameObject:SetActive(type==Dlg_Complex_Type.UIGROUP_UPDATE)
    fields.UIGroup_BillionOfWords.gameObject:SetActive(type==Dlg_Complex_Type.UIGROUP_BILLIONOFWORDS)
    fields.UIGroup_log.gameObject:SetActive(type==Dlg_Complex_Type.UIGroup_log)
end

local function refresh(params)
	if params.callBackFunc then
        params.callBackFunc(params,fields,gameObject)
    end
end

local function update()

end

local function hide()

end

local function uishowtype()
	-- 公用弹窗hide直接销毁，防止其他界面使用出现
	-- 公用部分显隐错误
	return UIShowType.DestroyWhenHide
end

---------------------------------------
--调用接口 
--参数释义({type:功能类型，见Dlg_Complex_Type;callBackFunc:回调函数，实现个人所需功能})
---------------------------------------
local function show(params)
    if params then
        if params.type then
            DisplayGroupByType(params.type)
        end
--        if params.callBackFunc then
--            params.callBackFunc(params,fields)
--        end
    end   
end

local function init(params)
    name,gameObject,fields=Unpack(params)
    EventHelper.SetClick(fields.UIButton_Close,function()
        UIManager.hide(name)
    end)
end

return{
    show = show,
    init = init,
	hide = hide,
    update = update,
    refresh = refresh,
	uishowtype = uishowtype,
}