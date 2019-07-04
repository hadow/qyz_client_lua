local unpack 		= unpack
local print 		= print
local UIManager 	= require("uimanager")
local FriendManager = require("ui.friend.friendmanager")
local ConfigManager = require("cfg.configmanager")
local EventHelper 	= UIEventListenerHelper
local ItemManager   = require("item.itemmanager")

local name, gameObject, fields
local m_RedPacketInfos

local function destroy()
end

local function refresh(params)
end

--[[
<protocol name="SGetRoleList">
	<variable name="packageid" type="long"/>
	<variable name="moneytype" type="int"/>
	<variable name="roles" type="map" key="string" value="int"/>
</protocol>
--]]
local function GetInfoContent(info)
    local labelstring = ""
    if info then
        local currencydata = ItemManager.CreateItemBaseById(info.moneytype, nil, info.number)
        if currencydata then
            labelstring = string.format(LocalString.Red_Packet_Fetch_Info, info.name, info.number, currencydata:GetName())
        end    
    end
    return labelstring
end

local function InitInfos(params)
    m_RedPacketInfos = {}
    if params then
        for name, number in pairs(params.roles) do
            table.insert(m_RedPacketInfos, {name=name, number=number, moneytype=params.moneytype})
        end
    end
end

local function show(params)
    if params then
        --info
        InitInfos(params)

        --title
        fields.UILabel_Title.text = LocalString.Red_Packet_Fetch_Title

        --is empty
        local infoNum = table.getn(m_RedPacketInfos)
        local wrapList = fields.UIList_BattlefieldReport.gameObject:GetComponent("UIWrapContentList")
        if infoNum >0 then
            fields.UIGroup_Empty.gameObject:SetActive(false)
            wrapList.gameObject:SetActive(true)
        else
            fields.UIGroup_Empty.gameObject:SetActive(true)
            wrapList.gameObject:SetActive(false)
            fields.UILabel_Empty.text = LocalString.Red_Packet_Fetch_None
            return
        end

        --list
        if wrapList then
            EventHelper.SetWrapListRefresh(wrapList,function(uiItem,index,realIndex)
                local uiLabel = uiItem.Controls["UILabel_ReportInfo"]
                if uiLabel then
                    uiLabel.text = GetInfoContent(m_RedPacketInfos[realIndex])
                end
            end)
            wrapList:SetDataCount(infoNum)
        end
    end
end

local function hide()
end

local function update()
end


local function init(params)
	name, gameObject, fields = unpack(params)
    EventHelper.SetClick(fields.UIButton_CloseReport, function()
        UIManager.hide(name)
    end)
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
}
