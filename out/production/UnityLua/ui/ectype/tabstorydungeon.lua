local unpack = unpack
local print  = print
local type   = type
local EventHelper = UIEventListenerHelper
local uimanager = require("uimanager")
local ConfigManager = require "cfg.configmanager"
local storyectypemanager = require "ui.ectype.storyectype.storyectypemanager"
local network = require "network"

local gameObject
local name

local UIWidget_Chapter 
local fields


local function hide()
  --print(name, "hide")
end


local function GetTotalStarsByChapterId(chapterid)
	local num = 0
	local starMatrix = storyectypemanager.GetStarMatrix()
--	printyellow("GetTotalStarsByChapterId")
--	printt(starMatrix)
--	printyellow("chapterid",chapterid)
	if starMatrix and #starMatrix ~= 0 and starMatrix[chapterid] then
		for k,v in pairs(starMatrix[chapterid]) do
			num = num + v 
		end
	end
	return num
end

local function SetLockLabel(listItem,chapterdata,islocked)
	local chapter = chapterdata[1].chapter

		if not islocked then  --判断当前章节是否能开启
			listItem.Controls["UISprite_Lock"].gameObject:SetActive(false)
			EventHelper.SetClick(listItem,function()
				uimanager.showdialog("ectype.dlgstorydungeonsub",{chapterdata = chapterdata})
				hide(name)
			end) 
		end  

end 

local function DisplayOneItem(listItem,chapterdata,chapterdata2,islocked)
	local totalstar    = #chapterdata * 3              -- 每关三颗星
	local curstar      = GetTotalStarsByChapterId(chapterdata[1].chapter) 
	local totalsection = #chapterdata

	local chapter      = chapterdata[1].chapter
	local starmatrix   = storyectypemanager.GetStarMatrix()
	if starmatrix[chapter] then 
		cursection   =  #starmatrix[chapter]
	else
		cursection   =  0
	end
	SetLockLabel(listItem,chapterdata,islocked)
--	printyellow("DisplayOneItem")
--	printt(chapterdata[1])
	                        -- 当前章开启的关数
	listItem.Controls["UITexture_Chapter"]:SetIconTexture(chapterdata2.chapterbgmpic)
	listItem.Controls["UILabel_Chapter01"].text = chapterdata2.chaptername
	listItem.Controls["UILabel_Number"].text = cursection .."/"..totalsection .."节"
	listItem.Controls["UILabel_StarAmount"].text = curstar .. "/" .. totalstar 
		

end





local function DisPlayAllChapter()
    local ectypeData  = ConfigManager.getConfig("storyectype")
--	printyellow("DisPlayAllChapter")
	--printt(ectypeData)
	local chapterData = ConfigManager.getConfig("chapter")
--	printt(chapterData)
	local index 
	local ChaptersInfo = storyectypemanager.GetChapterInfo(ectypeData)
	--printt(ChaptersInfo)
--	printyellow("num_chapter",num_chapter)
	fields.UIList_Chapter:Clear()
    for index = 1 ,#ChaptersInfo  do
        --local listItem=m_Fields.UIList_ChallengeDungeon:AddListItem()

		local chapterdata = ChaptersInfo[index]
		if storyectypemanager.IsUnLocked(chapterdata,#ChaptersInfo) then
			local listItem=fields.UIList_Chapter:AddListItem()
			DisplayOneItem(listItem,chapterdata,chapterData[index],false)
	    else
			--置灰
			local listItem=fields.UIList_Chapter:AddListItem()
			DisplayOneItem(listItem,chapterdata,chapterData[index],true)
			local inactiveShader = UnityEngine.Shader.Find("Unlit/Transparent Colored Gray")
			listItem.Controls["UITexture_Chapter"].shader= inactiveShader
			listItem.Controls["UITexture_Background"].shader= inactiveShader
--			break
		end 
    end
end

local function destroy()
  --print(name, "destroy")
end

local function show(params)
--	printyellow("gameObject = ",gameObject)
--	printyellow(gameObject.transform.localPosition)
	gameObject.transform.localPosition = Vector3(0,-50,0)
end



local function refresh(params)
	DisPlayAllChapter()
	
end

local function update()
   
  --print(name, "update")
end



local function init(params)
    name, gameObject, fields = unpack(params)
end

local function uishowtype()
    return UIShowType.DestroyWhenHide
end


return {
	uishowtype = uishowtype,
  init = init,
  show = show,
  hide = hide,
  update = update,
  destroy = destroy,
  refresh = refresh,
	DisPlayAllChapter = DisPlayAllChapter,
}