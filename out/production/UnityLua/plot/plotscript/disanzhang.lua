local Plot = require("plot.plot")

PlotCutscene = {
	PlayRate = 1,
	config = {
		isLooping = false,
		isSkippable = true,
		independentMusic = true,
		hideUI = true,
		hideCharacter = true,
		showBorder = true,
		showCurtain = true,
		fadeInOutTime = 0.7,
		mainCameraControl = true,
		previewMode = false,
	},
	StartTime = 0,
	Duration = 3.8,
	CurrentState = 0,
	AssetIndexList = {},
	Title = "disanzhang",
	EndTime = 3.8,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			FieldList = {
				[1] = {
					fieldType = "UILabel",
					fieldName = "UILabel_Title",
					fieldValue = "第三章",
				},
				[2] = {
					fieldType = "UILabel",
					fieldName = "UILabel_Content",
					fieldValue = "冷暖人情渝都行  断破阴谋是非清",
				},
			},
			StartTime = 0,
			Duration = 3.85,
			CurrentState = 0,
			Title = "chapter_ui",
			EndTime = 3.85,
			Type = "PlotDirector.PlotEventChapterUI",
			ParentId = 2,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene