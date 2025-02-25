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
		[1] = "zhuxianjian",
		[2] = "puzhi",
	},
	Title = "xuzhang_3",
	EndTime = 10,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "zhuxianjian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(79.44,179.48,430.33),
			Rotation = Vector3(1.829856,266.1942,10.43727),
			LocalScale = Vector3(1,1,1),
			ObjectName = "jianluo",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
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
					Position = Vector3(86.0538,189.2134,430.4841),
					Rotation = Vector3(315.9289,87.49354,-8.793488E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(86.0538,189.2134,430.4841),
					OutTangent = Vector3(86.0538,189.2134,430.4841),
				},
				[2] = {
					NodeTime = 0.4,
					Position = Vector3(80.19366,183.5348,430.2276),
					Rotation = Vector3(315.9289,87.49354,-9.03116E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(80.19366,183.5348,430.2276),
					OutTangent = Vector3(80.19366,183.5348,430.2276),
				},
				[3] = {
					NodeTime = 0.7,
					Position = Vector3(80.19363,183.5348,430.2274),
					Rotation = Vector3(11.79232,84.91517,-6.803013E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(80.19363,183.5348,430.2274),
					OutTangent = Vector3(80.19363,183.5348,430.2274),
				},
				[4] = {
					NodeTime = 0.9,
					Position = Vector3(79.462,183.684,430.158),
					Rotation = Vector3(11.79232,84.91517,-6.803013E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(79.462,183.684,430.158),
					OutTangent = Vector3(79.462,183.684,430.158),
				},
				[5] = {
					NodeTime = 1.6,
					Position = Vector3(86.13026,181.1165,431.4082),
					Rotation = Vector3(355.1192,87.70136,-9.961239E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(86.18345,181.116,431.4103),
					OutTangent = Vector3(86.07706,181.1169,431.406),
				},
				[6] = {
					NodeTime = 2,
					Position = Vector3(81.00137,180.095,431.2342),
					Rotation = Vector3(341.0245,86.49822,-9.389491E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(81.00137,180.095,431.2342),
					OutTangent = Vector3(81.00137,180.095,431.2342),
				},
			},
			StartTime = 0.01,
			Duration = 2,
			CurrentState = 5,
			Title = "path",
			EndTime = 2.01,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[3] = {
			Xallow = true,
			Yallow = true,
			Zallow = false,
			Amplify = Vector3(1,1,1),
			Omega = Vector3(3,3,3),
			Delay = Vector3(0,0,0),
			Beta = Vector3(1,1,1),
			Mode = "Line",
			StartTime = 0.8000008,
			Duration = 0.2,
			CurrentState = 5,
			Title = "shock",
			EndTime = 1.000001,
			Type = "PlotDirector.PlotEventCameraShock",
			ParentId = 11,
		},
		[4] = {
			IndexName = "puzhi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(90.3,179.859,431.03),
			Rotation = Vector3(0,265.8571,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "lm1",
			StartTime = 0.83,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1.83,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[5] = {
			IndexName = "puzhi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(91.731,179.997,427.136),
			Rotation = Vector3(0,265.8571,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "lm3",
			StartTime = 0.84,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 1.84,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 6,
		},
		[6] = {
			IndexName = "puzhi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(90.67,179.997,435.41),
			Rotation = Vector3(0,265.8571,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "lm2",
			StartTime = 0.84,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 1.84,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 5,
		},
		[7] = {
			ObjectName = "lm1",
			IsLoop = false,
			StateName = "attack01",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 1.08,
			Duration = 0,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 1.08,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 7,
		},
		[8] = {
			ObjectName = "lm2",
			IsLoop = false,
			StateName = "attack01",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 1.1,
			Duration = 0,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 1.1,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[9] = {
			ObjectName = "lm3",
			IsLoop = false,
			StateName = "attack01",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 1.13,
			Duration = 0,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 1.13,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 9,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene