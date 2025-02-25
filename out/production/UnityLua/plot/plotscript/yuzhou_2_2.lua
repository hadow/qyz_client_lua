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
	Duration = 2.5,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "yegoudaoren",
		[2] = "lianxuetangshashou",
	},
	Title = "yuzhou_2_2",
	EndTime = 2.5,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "lianxuetangshashou",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(111.8778,26.42711,278.7115),
			Rotation = Vector3(0,271.1,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "lianxuetang3",
			StartTime = 0,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.5,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 5,
		},
		[2] = {
			IndexName = "lianxuetangshashou",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(110.7414,26.42711,281.0674),
			Rotation = Vector3(0,271.1004,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "lianxuetang4",
			StartTime = 0,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.5,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 6,
		},
		[3] = {
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
					Position = Vector3(107.2652,28.35826,276.8964),
					Rotation = Vector3(9.661336,92.33897,-3.680742E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(107.2652,28.35826,276.8964),
					OutTangent = Vector3(107.2652,28.35826,276.8964),
				},
				[2] = {
					NodeTime = 1.5,
					Position = Vector3(106.633,28.466,276.922),
					Rotation = Vector3(9.661336,92.33897,-3.680742E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(106.633,28.466,276.922),
					OutTangent = Vector3(106.633,28.466,276.922),
				},
			},
			StartTime = 0,
			Duration = 1.5,
			CurrentState = 5,
			Title = "path",
			EndTime = 1.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 7,
		},
		[4] = {
			IndexName = "yegoudaoren",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(109.09,26.42711,276.62),
			Rotation = Vector3(0,271.1005,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yegou",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 2,
		},
		[5] = {
			IndexName = "lianxuetangshashou",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(112.1151,26.42711,274.7069),
			Rotation = Vector3(0,271.0997,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "lianxuetang1",
			StartTime = 0,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.5,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[6] = {
			IndexName = "lianxuetangshashou",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(111.4831,26.42711,272.9534),
			Rotation = Vector3(0,271.1005,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "lianxuetang2",
			StartTime = 0,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.5,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[7] = {
			ObjectName = "yegou",
			IsLoop = false,
			StateName = "runfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.1,
			Duration = 0.8000001,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 0.9000001,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[8] = {
			ObjectName = "yegou",
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
					Position = Vector3(109.09,26.42711,276.62),
					Rotation = Vector3(0,271.1005,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(109.09,26.42711,276.62),
					OutTangent = Vector3(109.09,26.42711,276.62),
				},
				[2] = {
					NodeTime = 0.3,
					Position = Vector3(109.09,26.42711,276.62),
					Rotation = Vector3(0,89.71571,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(109.09,26.42711,276.62),
					OutTangent = Vector3(109.09,26.42711,276.62),
				},
				[3] = {
					NodeTime = 3,
					Position = Vector3(121.04,26.42711,276.67),
					Rotation = Vector3(0,89.71571,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(121.04,26.42711,276.67),
					OutTangent = Vector3(121.04,26.42711,276.67),
				},
			},
			StartTime = 0.1,
			Duration = 3,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 3.1,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 2,
		},
		[9] = {
			ObjectName = "lianxuetang1",
			IsLoop = false,
			StateName = "runfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.5,
			Duration = 0.6666667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 1.166667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 9,
		},
		[10] = {
			ObjectName = "lianxuetang1",
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
					Position = Vector3(112.1151,26.42711,274.7069),
					Rotation = Vector3(0,271.0997,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(112.1151,26.42711,274.7069),
					OutTangent = Vector3(112.1151,26.42711,274.7069),
				},
				[2] = {
					NodeTime = 0.3,
					Position = Vector3(112.1151,26.42711,274.7069),
					Rotation = Vector3(0,89.54552,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(112.1151,26.42711,274.7069),
					OutTangent = Vector3(112.1151,26.42711,274.7069),
				},
				[3] = {
					NodeTime = 3,
					Position = Vector3(119.72,26.42711,274.77),
					Rotation = Vector3(0,89.54552,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(119.72,26.42711,274.77),
					OutTangent = Vector3(119.72,26.42711,274.77),
				},
			},
			StartTime = 0.5,
			Duration = 3,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 3.5,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 3,
		},
		[11] = {
			ObjectName = "lianxuetang2",
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
					Position = Vector3(111.4831,26.42711,272.9534),
					Rotation = Vector3(0,271.1005,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(111.4831,26.42711,272.9534),
					OutTangent = Vector3(111.4831,26.42711,272.9534),
				},
				[2] = {
					NodeTime = 0.3,
					Position = Vector3(111.4831,26.42711,272.9534),
					Rotation = Vector3(0,91.22807,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(111.4831,26.42711,272.9534),
					OutTangent = Vector3(111.4831,26.42711,272.9534),
				},
				[3] = {
					NodeTime = 3,
					Position = Vector3(120.42,26.42711,272.75),
					Rotation = Vector3(0,91.22807,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(120.42,26.42711,272.75),
					OutTangent = Vector3(120.42,26.42711,272.75),
				},
			},
			StartTime = 0.5,
			Duration = 3,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 3.5,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 4,
		},
		[12] = {
			ObjectName = "lianxuetang2",
			IsLoop = false,
			StateName = "runfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.5,
			Duration = 0.6666667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 1.166667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[13] = {
			ObjectName = "lianxuetang4",
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
					Position = Vector3(111.1414,26.42711,281.0674),
					Rotation = Vector3(0,271.1004,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(111.1414,26.42711,281.0674),
					OutTangent = Vector3(111.1414,26.42711,281.0674),
				},
				[2] = {
					NodeTime = 0.3,
					Position = Vector3(111.1414,26.42711,281.0674),
					Rotation = Vector3(0,92.29691,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(111.1414,26.42711,281.0674),
					OutTangent = Vector3(111.1414,26.42711,281.0674),
				},
				[3] = {
					NodeTime = 3,
					Position = Vector3(119.45,26.42711,280.73),
					Rotation = Vector3(0,92.29691,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(119.45,26.42711,280.73),
					OutTangent = Vector3(119.45,26.42711,280.73),
				},
			},
			StartTime = 0.5,
			Duration = 3,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 3.5,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 6,
		},
		[14] = {
			ObjectName = "lianxuetang4",
			IsLoop = false,
			StateName = "runfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.5,
			Duration = 0.6666667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 1.166667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 14,
		},
		[15] = {
			ObjectName = "lianxuetang3",
			IsLoop = false,
			StateName = "runfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.5,
			Duration = 0.6666667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 1.166667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 13,
		},
		[16] = {
			ObjectName = "lianxuetang3",
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
					Position = Vector3(111.8778,26.42711,278.7114),
					Rotation = Vector3(0,271.1,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(111.8778,26.42711,278.7114),
					OutTangent = Vector3(111.8778,26.42711,278.7114),
				},
				[2] = {
					NodeTime = 0.3,
					Position = Vector3(111.8764,26.42711,278.7074),
					Rotation = Vector3(0,93.5716,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(111.8764,26.42711,278.7074),
					OutTangent = Vector3(111.8764,26.42711,278.7074),
				},
				[3] = {
					NodeTime = 3,
					Position = Vector3(119.0622,26.42711,278.2516),
					Rotation = Vector3(0,93.5716,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(119.0622,26.42711,278.2516),
					OutTangent = Vector3(119.0622,26.42711,278.2516),
				},
			},
			StartTime = 0.5,
			Duration = 3,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 3.5,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 5,
		},
		[17] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "野狗道人：小的们，快跑！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 0.5300001,
			Duration = 1.5,
			CurrentState = 5,
			Title = "Talk",
			EndTime = 2.03,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 11,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene