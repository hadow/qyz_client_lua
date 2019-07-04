local Unpack = unpack
local EventHelper = UIEventListenerHelper
local UIManager = require("uimanager")
local ConfigManager=require("cfg.configmanager")
local MapManager=require("map.mapmanager")
local NetWork = require("network")
local PlayerRole=require("character.playerrole")

local m_GameObject
local m_Name
local m_Fields
local m_Lines

local function show(params)
end

local function hide()
end

local function refresh(params)
    MapManager.GetMapLines()
end

local function DisplayMapLines()
    m_Fields.UIList_LineButton:Clear()
    for i=1,#m_Lines do
        local UIListItem_Line=m_Fields.UIList_LineButton:AddListItem()
        local lineId=m_Lines[i].lineid
        UIListItem_Line.Id=lineId
        UIListItem_Line:SetText("UILabel_Line",lineId..LocalString.LineMap_Line)
        if lineId==PlayerRole:Instance().m_MapInfo:GetLineId() then
            m_Fields.UIList_LineButton:SetSelectedIndex(i-1)
            local UILabel_CurLine=m_Fields.UILabel_CurLine
            UILabel_CurLine.text=lineId..LocalString.LineMap_Line
        else
            EventHelper.SetClick(UIListItem_Line,function()
                local familymgr = require("family.familymanager")
                if familymgr.IsInStation() then
                    UIManager.ShowSingleAlertDlg({title=LocalString.LineMap_Warn,content=LocalString.Family.ChangeLineForbid})
                    return
                end

                MapManager.EnterMap(PlayerRole:Instance():GetMapId(),lineId)
            end)
        end
    end
    EventHelper.SetClick(m_Fields.UIButton_Sure,function()
        local familymgr = require("family.familymanager")
        if familymgr.IsInStation() then
            UIManager.ShowSingleAlertDlg({title=LocalString.LineMap_Warn,content=LocalString.Family.ChangeLineForbid})
            return
        end

        local UILabel_CurSelectedLine=m_Fields.UILabel_CurSelectedLine
        local inputContent=UILabel_CurSelectedLine.text
        local n=tonumber(inputContent)
        if n==nil then           
            UIManager.ShowSingleAlertDlg({title=LocalString.LineMap_Warn,content=LocalString.LineMap_InputNum})
        elseif n<=0 then
            UIManager.ShowSingleAlertDlg({title=LocalString.LineMap_Warn,content=LocalString.LineMap_LineNotExit})
        else
            for i=1,#m_Lines do
                local lineId=m_Lines[i].lineid
                if lineId==n then
                    if lineId~=PlayerRole:Instance().m_MapInfo:GetLineId() then
                        MapManager.EnterMap(PlayerRole:Instance():GetMapId(),lineId )
                    else
                        UIManager.ShowSystemFlyText(LocalString.LineMap_InTheLine)
                    end
                    return
                end
            end
            UIManager.ShowSingleAlertDlg({title=LocalString.LineMap_Warn,content=LocalString.LineMap_LineNotExit})
        end                   
    end)
end

local function update()
end

local function ShowMapLines(msg)
    m_Lines=msg.lines
    DisplayMapLines()
end

--判断一个点是否在多边形内（polySides:顶点个数,x:测试点x坐标,y:测试点y坐标,poly:顶点序列）
--local function PointInPolygon(polySides,x,y,poly) 
--    local  j=polySides
--    local  oddNodes=false
--    for i=1,polySides do
--        if(((poly[i].y< y and poly[j].y>=y) or (poly[j].y<y and poly[i].y>=y)) and (poly[i].x<=x or poly[j].x<=x)) then
--            if(poly[i].x+(y-poly[i].y)/(poly[j].y-poly[i].y)*(poly[j].x-poly[i].x)<x) then
--                oddNodes=(not oddNodes)                
--            end
--        end
--        j=i
--    end
--    return oddNodes
--end

local function destroy()
end

local function init(params)
    m_Name, m_GameObject, m_Fields = Unpack(params)          
end

local function uishowtype()
    return UIShowType.Refresh
end

return {
    init = init,
    show = show,
    hide = hide,
    update = update,
    destroy = destroy,
    refresh = refresh,
    uishowtype = uishowtype,
    ShowMapLines = ShowMapLines,
}