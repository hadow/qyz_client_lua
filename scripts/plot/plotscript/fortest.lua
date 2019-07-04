local Plot = require("plot.plot")

PlotCutscene = {
	PlayRate = 1,
	config = {
		isLooping = false,
		isSkippable = true,
		independentMusic = false,
		hideUI = false,
		hideCharacter = false,
		showBorder = true,
		showCurtain = true,
		fadeInOutTime = 0.7,
		mainCameraControl = false,
		previewMode = false,
	},
	StartTime = 0,
	Duration = 10,
	CurrentState = 0,
	AssetIndexList = {},
	Title = "fortest",
	EndTime = 10,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene