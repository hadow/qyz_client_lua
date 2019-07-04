local unpack 		= unpack
local print 		= print
local UIManager 	= require "uimanager"
local ArenaManager   = require "ui.arena.single.arenamanager"
local EventHelper 	= UIEventListenerHelper
local ArenaData = ArenaManager.ArenaData

local name
local fields
local gameObject


local function RefreshItem(uiItem,wrapIndex,realIndex)
        local reportInfo = ArenaData.FightReportList[realIndex]
        
     --   printyellow("reportInfo",reportInfo)
        local str = reportInfo:ToString()
        uiItem:SetText("UILabel_ReportInfo",str)
        uiItem:SetText("UILabel_Name",""--[[reportInfo.m_OpponentName]])
        uiItem:SetText("UILabel_RiseNum",""--[[reportInfo.m_ResultRank]])
        uiItem:SetText("UILabel_Win",""--[[reportInfo.m_ResultRank]])

end


local function refresh(params)
    local reportListCount = #ArenaData.FightReportList

  --  printyellow("[][][][][][][][][][][]")
 --   printyellow(reportListCount)

    local wrapList = fields.UIList_BattlefieldReport.gameObject:GetComponent("UIWrapContentList")
    EventHelper.SetWrapListRefresh(wrapList,RefreshItem)
    wrapList:SetDataCount(reportListCount)
    if reportListCount > 0 then 
        fields.UIGroup_Empty.gameObject:SetActive(false)
    else
        fields.UIGroup_Empty.gameObject:SetActive(true)
    end
end

local function destroy()

end

local function show(params)

end

local function hide()

end

local function update()

end

local function init(params)
    name, gameObject, fields = unpack(params)
    EventHelper.SetClick(fields.UIButton_CloseReport, function ()
        UIManager.hide(name)
	end)
    gameObject.transform.position = Vector3(0,0,-1000)
end
return {
    init = init,
    show = show,
    hide = hide,
    update = update,
    destroy = destroy,
    refresh = refresh,
}
