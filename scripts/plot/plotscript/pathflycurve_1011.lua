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
	Duration = 10,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "zuoqibaihe",
	},
	Title = "pathflycurve_1011",
	EndTime = 10,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "zuoqibaihe",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(28.42703,209.4055,180.0468),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "bh",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 2,
		},
		[2] = {
			ObjectName = "bh",
			OnGround = false,
			OffSetY = 0,
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
					Position = Vector3(25.4,216.9,195.1),
					Rotation = Vector3(8.77995,16.4928,0.05296953),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(27.69203,215.5504,192.6211),
					OutTangent = Vector3(23.10797,218.2496,197.5789),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(16.9,220.5,276.7),
					Rotation = Vector3(46.76707,11.38384,0.07642279),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(13.73218,222.6863,258.8609),
					OutTangent = Vector3(20.06782,218.3137,294.5392),
				},
				[3] = {
					NodeTime = 4,
					Position = Vector3(37.2,211.3,332.5),
					Rotation = Vector3(15.99926,54.65878,0.05446479),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(31.19857,213.4468,319.9066),
					OutTangent = Vector3(43.20143,209.1532,345.0934),
				},
				[4] = {
					NodeTime = 6.69,
					Position = Vector3(63.5,205.9,358.6),
					Rotation = Vector3(21.84344,57.75874,0.05640751),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(59.21066,207.7373,356.8049),
					OutTangent = Vector3(67.78934,204.0627,360.3951),
				},
			},
			StartTime = 1,
			Duration = 6.69,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 7.69,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 2,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene