local Plot = require("plot.plot")

PlotCutscene = {
	PlayRate = 1,
	config = {
		isLooping = false,
		isSkippable = true,
		independentMusic = false,
		hideUI = true,
		hideCharacter = true,
		showBorder = false,
		showCurtain = false,
		fadeInOutTime = 0.7,
		mainCameraControl = true,
		previewMode = false,
	},
	StartTime = 0,
	Duration = 4,
	CurrentState = 5,
	AssetIndexList = {},
	Title = "xuzhang_1",
	EndTime = 4,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			ProfessionDeviation = false,
			PathMode = "Bessel",
			TangentMode = false,
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			ConstSpeed = false,
			Speed = 7,
			PathList = {
				[1] = {
					NodeTime = 0.3,
					Position = Vector3(39.60023,179.3253,426.2651),
					Rotation = Vector3(345.5338,85.00001,8.817286E-07),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(39.60023,179.3253,426.2651),
					OutTangent = Vector3(39.60023,179.3253,426.2651),
				},
				[2] = {
					NodeTime = 4,
					Position = Vector3(39.60023,179.3253,426.2651),
					Rotation = Vector3(21,85.00002,-9.145155E-07),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(39.60023,179.3253,426.2651),
					OutTangent = Vector3(39.60023,179.3253,426.2651),
				},
			},
			StartTime = 0,
			Duration = 4,
			CurrentState = 5,
			Title = "path",
			EndTime = 4,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene