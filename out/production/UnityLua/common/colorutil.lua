
-- 颜色配置是根据\luxianres\Design\10_美术资源需求与管理\UI需求\字体类效果需求\字体颜色汇总.png配置的
local ColorType = 
{
    White          = 0,
    Green          = 1,
    Blue           = 2,
    Purple         = 3,
    Orange         = 4,
    Red_Item       = 5,
    Red_Character  = 6,
    Gray           = 7,
    Black          = 8,
    Yellow         = 9,
    Orange2        = 10,
    Gray2          = 11,
	Green_Tip	   = 12,
	Yellow_Title   = 13,
	Red	           = 14,
	Orange_Chat    = 15,
	Pink_Chat      = 16,
	Pink_Task	   = 17,
	Blue_Chat      = 18,
	Blue_Task      = 19,
	Green_Chat     = 20,
	Green_Task     = 21,

	Green_Remind   = 22,
	Red_Remind     = 23,
}

local ColorStringTable = 
{
    [ColorType.White]          = "[FEFFF0]%s[-]",
    [ColorType.Green]          = "[C4EE1B]%s[-]",
	[ColorType.Green_Tip]      = "[9AFE19]%s[-]",
	[ColorType.Green_Chat]     = "[A5DF7F]%s[-]",
	[ColorType.Green_Task]     = "[B7F244]%s[-]",
	[ColorType.Blue]           = "[26BEFE]%s[-]",
    [ColorType.Blue_Chat]      = "[4EDDF7]%s[-]",
	[ColorType.Blue_Task]      = "[4EDDF7]%s[-]",
    [ColorType.Purple]         = "[F43E87]%s[-]",
    [ColorType.Orange]         = "[F48E21]%s[-]",
	[ColorType.Orange_Chat]    = "[FFBA25]%s[-]",
	[ColorType.Pink_Chat]      = "[FD73C1]%s[-]",
	[ColorType.Pink_Task]      = "[FF5FF9]%s[-]",
	[ColorType.Red]            = "[FA4926]%s[-]",
    [ColorType.Red_Item]       = "[E9392C]%s[-]",
    [ColorType.Red_Character]  = "[FF4A4AFF]%s[-]",
    [ColorType.Gray]           = "[A8B1B5]%s[-]",
    [ColorType.Black]          = "[0D151C]%s[-]",
    [ColorType.Yellow]         = "[FFD74C]%s[-]",
	[ColorType.Yellow_Title]   = "[FFF354]%s[-]",
    [ColorType.Orange2]        = "[6BF520]%s[-]",
    [ColorType.Gray2]          = "[979FA2]%s[-]",
}

local ColorValueTable = {
	[ColorType.Green_Remind] 	    = Color(154/255, 254/255, 25/255, 1),
	[ColorType.Red_Remind] 		    = Color(250/255, 73/255, 38/255, 1),
	[ColorType.White] 		        = Color(254/255, 255/255, 240/255, 1),
	[ColorType.Gray] 		        = Color(168/255, 177/255, 181/255, 1),
	[ColorType.Yellow_Title] 		= Color(255/255, 243/255, 84/255, 1),
}
local ShadowColorValueTable = {
	[ColorType.Green_Remind] 	    = Color(17/255, 44/255, 62/255, 1),
	[ColorType.Red_Remind] 		    = Color(75/255, 13/255, 9/255, 1), 
	[ColorType.White] 		        = Color(12/255, 32/255, 46/255, 1),
	[ColorType.Gray] 		        = Color(37/255, 44/255, 51/255, 1),
	[ColorType.Yellow_Title] 		= Color(20/255, 21/255, 39/255, 1),
}


-- 仅适用于品质框
local QualityBoxColor = 
{
	[cfg.item.EItemColor.WHITE]  = Color(186 / 255, 183 / 255, 175 / 255, 1),
	[cfg.item.EItemColor.GREEN]  = Color(159 / 255, 203 / 255, 54 / 255, 1),
	[cfg.item.EItemColor.BLUE]   = Color(57 / 255, 153 / 255, 235 / 255, 1),
	[cfg.item.EItemColor.PURPLE] = Color(236 / 255, 80 / 255, 190 / 255, 1),
	[cfg.item.EItemColor.ORANGE] = Color(244 / 255, 119 / 255, 44 / 255, 1),
	[cfg.item.EItemColor.RED]    = Color(227 / 255, 50 / 255, 36 / 255, 1),
}

-- 仅适用于品质相关字体描边
local OutlineColor = 
{
	[cfg.item.EItemColor.WHITE]  = Color(12 / 255, 32 / 255, 46 / 255, 1),
	[cfg.item.EItemColor.GREEN]  = Color(12 / 255, 32 / 255, 46 / 255, 1),
	[cfg.item.EItemColor.BLUE]   = Color(12 / 255, 32 / 255, 46 / 255, 1),
	[cfg.item.EItemColor.PURPLE] = Color(12 / 255, 32 / 255, 46 / 255, 1),
	[cfg.item.EItemColor.ORANGE] = Color(12 / 255, 32 / 255, 46 / 255, 1),
	[cfg.item.EItemColor.RED]    = Color(12 / 255, 32 / 255, 46 / 255, 1),
}
-- 仅适用于品质属性文字
local QualityColorText = 
{
	[cfg.item.EItemColor.WHITE]  = "[E6EEF1]%s[-]",
	[cfg.item.EItemColor.GREEN]  = "[C4EE1B]%s[-]",
	[cfg.item.EItemColor.BLUE]   = "[26BEFE]%s[-]",
	[cfg.item.EItemColor.PURPLE] = "[F23C9A]%s[-]",
	[cfg.item.EItemColor.ORANGE] = "[FFA127]%s[-]",
	[cfg.item.EItemColor.RED]    = "[FF2B1B]%s[-]",
}

-- 根据品质类型返回品质颜色
local function GetQualityColor(quality)
	if quality then
		if QualityBoxColor[quality] then 
			return QualityBoxColor[quality]
		else
			logError("Item quality error")
			return Color(255 / 255, 255 / 255, 255 / 255, 1)
		end
	else
		return Color(255 / 255, 255 / 255, 255 / 255, 1)
	end
end

-- 根据品质类型返回相应颜色文本
local function GetQualityColorText(quality,originalText)
	if QualityColorText[quality] then 
		return string.format(QualityColorText[quality],originalText)
	else
		logError("Item quality error")
		return originalText
	end
end
-- 此函数将描边和字体颜色一起设置
local function SetQualityColorText(uiLabel,quality,originalText)
	if QualityColorText[quality] then 
		uiLabel.text = string.format(QualityColorText[quality],originalText)
		uiLabel.effectColor = OutlineColor[quality]
	else
		uiLabel.text = originalText
		logError("Item quality error")
	end
end
-- 文字颜色和描边置成灰色
local function SetTextColor2Gray(uiLabel,originalText)
	uiLabel.text = string.format(ColorStringTable[ColorType.Gray],originalText)
	uiLabel.effectColor = ShadowColorValueTable[ColorType.Gray]
end

local function SetLabelColorText(uiLabel, colorType, content)
	uiLabel.text = tostring(content)
	if ColorValueTable[colorType] and ShadowColorValueTable[colorType] then
		uiLabel.color = ColorValueTable[colorType]
		uiLabel.effectColor = ShadowColorValueTable[colorType]
	else
		logError("Can't find value of color type.'")
	end
end

local function GetColorStr(colorType, str)
    return string.format(ColorStringTable[colorType], str)
end

local function GetQualityStr(quality)
    local color = GetQualityColor(quality)
    local colorstr = string.format("%x",math.round(color.r*255*256*256+color.g*255*256+color.b*255))
    return colorstr
end



local inactiveShader = UnityEngine.Shader.Find("Unlit/Transparent Colored Gray")
local activeShader = UnityEngine.Shader.Find("Unlit/Transparent Colored")

local function SetTextureColorGray(uiTexture, isGray)
    if isGray then
        uiTexture.shader = inactiveShader
    else
        uiTexture.shader = activeShader
    end
end


return {
    ColorType           = ColorType,
    GetColorStr         = GetColorStr,
	GetQualityStr		= GetQualityStr,
	GetQualityColorText = GetQualityColorText,
	GetQualityColor     = GetQualityColor,
	SetQualityColorText = SetQualityColorText,
	SetTextColor2Gray	= SetTextColor2Gray,
	SetTextureColorGray = SetTextureColorGray,
	SetLabelColorText   = SetLabelColorText,
}