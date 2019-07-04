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
	Duration = 3,
	CurrentState = 5,
	AssetIndexList = {},
	Title = "zhangjie_3",
	EndTime = 3,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "fushige",
			EffectType = "Words",
			Position = Vector2(0,-0.1),
			ObjectName = "zhangjiezi",
			StartTime = 0,
			Duration = 2.93,
			CurrentState = 5,
			Title = "screen_words",
			EndTime = 2.93,
			Type = "PlotDirector.PlotEventScreenWords",
			ParentId = 1,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene