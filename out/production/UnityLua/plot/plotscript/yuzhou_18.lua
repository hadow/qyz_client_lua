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
		[1] = "guanxing",
	},
	Title = "yuzhou_18",
	EndTime = 10,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			AudioMode = "BackMusic",
			LoadMode = "Delay",
			IndexName = "bgm_cg_04",
			Looping = false,
			StartPlayPos = 55.05066,
			EndPlayPos = 65.312,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0,
			Duration = 10.26133,
			CurrentState = 5,
			Title = "back_music",
			EndTime = 10.26133,
			Type = "PlotDirector.PlotEventBackMusic",
			ParentId = 4,
		},
		[2] = {
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
					Position = Vector3(119.9446,24.50376,47.04717),
					Rotation = Vector3(343.0193,49.47105,-0.0001053377),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(119.9446,24.50376,47.04717),
					OutTangent = Vector3(119.9446,24.50376,47.04717),
				},
				[2] = {
					NodeTime = 3,
					Position = Vector3(119.9446,24.50375,47.04718),
					Rotation = Vector3(343.0193,56.69032,-0.0001017669),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(119.9446,24.50375,47.04718),
					OutTangent = Vector3(119.9446,24.50375,47.04718),
				},
			},
			StartTime = 0,
			Duration = 3,
			CurrentState = 5,
			Title = "path",
			EndTime = 3,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 3,
		},
		[3] = {
			IndexName = "guanxing",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(161.7479,4.420126,47.75),
			Rotation = Vector3(0,274.89,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yazhu",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 2,
		},
		[4] = {
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
					Position = Vector3(123.5947,9.998177,47.90535),
					Rotation = Vector3(5.536475,89.52076,-0.0001035764),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(123.5947,9.998177,47.90535),
					OutTangent = Vector3(123.5947,9.998177,47.90535),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(155.0683,6.235359,48.01314),
					Rotation = Vector3(4.333262,90.0364,-0.0001031747),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(155.0683,6.235359,48.01314),
					OutTangent = Vector3(155.0683,6.235359,48.01314),
				},
			},
			StartTime = 4,
			Duration = 2,
			CurrentState = 5,
			Title = "path",
			EndTime = 6,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 3,
		},
		[5] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_whoose_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 4.048707,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 4.26,
			Duration = 4.048707,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 8.308708,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 5,
		},
		[6] = {
			ObjectName = "yazhu",
			IsLoop = false,
			StateName = "idle",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 5.779999,
			Duration = 3.766667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 9.546666,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 2,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene