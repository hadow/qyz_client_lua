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
	Duration = 4.5,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "cg_dibo",
		[2] = "shirenhua",
		[3] = "shehun",
	},
	Title = "yuzhou_boss_1",
	EndTime = 4.5,
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
					Position = Vector3(23.39065,25.20452,30.18869),
					Rotation = Vector3(23.9324,5.042864,0.0001420971),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(23.39065,25.20452,30.18869),
					OutTangent = Vector3(23.39065,25.20452,30.18869),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(23.39065,25.20452,30.18869),
					Rotation = Vector3(23.9324,5.042864,0.0001420971),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(23.39065,25.20452,30.18869),
					OutTangent = Vector3(23.39065,25.20452,30.18869),
				},
			},
			StartTime = 0,
			Duration = 1.05,
			CurrentState = 5,
			Title = "Path",
			EndTime = 1.05,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[2] = {
			IndexName = "shirenhua",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(44.05983,0,-24.02347),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(2,2,2),
			ObjectName = "shirenhua",
			StartTime = 0,
			Duration = 0.16,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 0.16,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[3] = {
			ObjectName = "shirenhua",
			IsLoop = true,
			StateName = "born",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.3899998,
			Duration = 0.4300002,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 0.82,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[4] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_stone_sml_03",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.829932,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0.39,
			Duration = 0.829932,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 1.219932,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 7,
		},
		[5] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_gunzou",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 4.107914,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0.392086,
			Duration = 4.107914,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 4.5,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 6,
		},
		[6] = {
			IndexName = "cg_dibo",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(24.91771,20.34775,37.34026),
			Rotation = Vector3(0,194.95,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "dibo",
			StartTime = 0.5,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1.5,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[7] = {
			ObjectName = "shirenhua",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(24.91771,20.34775,37.34026),
			Rotation = Vector3(0,194.95,0),
			LocalScale = Vector3(2,2,2),
			StartTime = 0.6300003,
			Duration = 1,
			CurrentState = 5,
			Title = "object_transform",
			EndTime = 1.63,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 4,
		},
		[8] = {
			ObjectName = "shirenhua",
			IsLoop = true,
			StateName = "skill01",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.5,
			StartTime = 0.82,
			Duration = 2.153334,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 2.973334,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[9] = {
			IndexName = "shehun",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(24.91771,21.383,37.34026),
			Rotation = Vector3(342.8322,195.6647,355.2683),
			LocalScale = Vector3(1,1,1),
			ObjectName = "jineng",
			StartTime = 2.18,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 3.18,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[10] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_ex_wind_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.413878,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 2.39,
			Duration = 1.413878,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 3.803878,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 7,
		},
		[11] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "vox_monster_xuhuan_attack_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.208798,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 2.4,
			Duration = 1.208798,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 3.608798,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 8,
		},
		[12] = {
			ObjectName = "shirenhua",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.5,
			StartTime = 2.973334,
			Duration = 1.333333,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 4.306667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene