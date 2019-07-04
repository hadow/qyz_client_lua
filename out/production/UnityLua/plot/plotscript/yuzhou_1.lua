local Plot = require("plot.plot")

PlotCutscene = {
	PlayRate = 1,
	config = {
		isLooping = false,
		isSkippable = true,
		independentMusic = false,
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
	Title = "yuzhou_1",
	EndTime = 3,
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
					NodeTime = 0,
					Position = Vector3(118.8943,29.2188,282.4315),
					Rotation = Vector3(359.3494,232.7173,-7.785849E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(118.8943,29.2188,282.4315),
					OutTangent = Vector3(118.8943,29.2188,282.4315),
				},
				[2] = {
					NodeTime = 3,
					Position = Vector3(118.8942,29.2188,282.4313),
					Rotation = Vector3(358.1462,259.3599,-7.869508E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(118.8942,29.2188,282.4313),
					OutTangent = Vector3(118.8942,29.2188,282.4313),
				},
			},
			StartTime = 0,
			Duration = 3,
			CurrentState = 5,
			Title = "path",
			EndTime = 3,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene