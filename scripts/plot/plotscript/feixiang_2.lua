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
	Duration = 3.5,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "xiaohui",
		[2] = "xiaohuibianshen",
		[3] = "baozha",
	},
	Title = "feixiang_2",
	EndTime = 3.5,
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
					Position = Vector3(197.8728,30.5102,400.5911),
					Rotation = Vector3(5.812674,86.46749,-4.226567E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(197.8728,30.5102,400.5911),
					OutTangent = Vector3(197.8728,30.5102,400.5911),
				},
				[2] = {
					NodeTime = 1.63,
					Position = Vector3(197.8728,30.5102,400.5911),
					Rotation = Vector3(5.46891,90.42075,-4.41704E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(197.8728,30.5102,400.5911),
					OutTangent = Vector3(197.8728,30.5102,400.5911),
				},
			},
			StartTime = 0,
			Duration = 1.63,
			CurrentState = 5,
			Title = "path",
			EndTime = 1.63,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[2] = {
			IndexName = "xiaohui",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(203.95,29.19,400.27),
			Rotation = Vector3(0,276.2,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xiaohui",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[3] = {
			ObjectName = "xiaohui",
			IsLoop = false,
			StateName = "joy",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.1,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 1.1,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 3,
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
					Position = Vector3(197.8728,30.5102,400.5911),
					Rotation = Vector3(5.46891,90.42075,-4.41704E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(197.8728,30.5102,400.5911),
					OutTangent = Vector3(197.8728,30.5102,400.5911),
				},
				[2] = {
					NodeTime = 1.2,
					Position = Vector3(195.2953,31.64804,400.748),
					Rotation = Vector3(3.062549,91.10834,-4.03985E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(195.2953,31.64804,400.748),
					OutTangent = Vector3(195.2953,31.64804,400.748),
				},
			},
			StartTime = 1.63,
			Duration = 1.2,
			CurrentState = 5,
			Title = "path",
			EndTime = 2.83,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[5] = {
			ObjectName = "xiaohui",
			Active = false,
			StartTime = 1.69,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 2.69,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 5,
		},
		[6] = {
			IndexName = "baozha",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(203.95,29.19,400.27),
			Rotation = Vector3(0,276.2,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zha",
			StartTime = 1.7,
			Duration = 0.95,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 2.65,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[7] = {
			IndexName = "xiaohuibianshen",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(203.95,29.19,400.27),
			Rotation = Vector3(0,276.2,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xiaohuibian",
			StartTime = 1.92,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 2.92,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene