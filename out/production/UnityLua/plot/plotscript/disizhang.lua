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
	CurrentState = 5,
	AssetIndexList = {},
	Title = "disizhang",
	EndTime = 3.8,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			FieldList = {
				[1] = {
					fieldType = "UILabel",
					fieldName = "UILabel_Title",
					fieldValue = "第四章",
				},
				[2] = {
					fieldType = "UILabel",
					fieldName = "UILabel_Content",
					fieldValue = "古窟幻境动魂惊  梦呓缘定三生情",
				},
			},
			StartTime = 0,
			Duration = 3.8,
			CurrentState = 5,
			Title = "chapter_ui",
			EndTime = 3.8,
			Type = "PlotDirector.PlotEventChapterUI",
			ParentId = 1,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene