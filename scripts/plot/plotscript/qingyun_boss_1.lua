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
	Duration = 4,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "jianchi",
	},
	Title = "qingyun_boss_1",
	EndTime = 4,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
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
			StartTime = 0,
			Duration = 4.107914,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 4.107914,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 7,
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
					Position = Vector3(101.02,-0.75,428.88),
					Rotation = Vector3(5.540275,269.5729,0.0001117259),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(101.02,-0.75,428.88),
					OutTangent = Vector3(101.02,-0.75,428.88),
				},
				[2] = {
					NodeTime = 2.32,
					Position = Vector3(95.627,-1.202,428.897),
					Rotation = Vector3(8.4,267.7322,-5.221343E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(95.627,-1.202,428.897),
					OutTangent = Vector3(95.627,-1.202,428.897),
				},
			},
			StartTime = 0,
			Duration = 2.32,
			CurrentState = 5,
			Title = "path",
			EndTime = 2.32,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[3] = {
			IndexName = "jianchi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(72.15,-6.88,428.1),
			Rotation = Vector3(0,89.96001,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "jianchi",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[4] = {
			ObjectName = "jianchi",
			IsLoop = true,
			StateName = "skill01",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.2,
			Duration = 1.13,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 1.33,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 4,
		},
		[5] = {
			ObjectName = "jianchi",
			OnGround = true,
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
					Position = Vector3(74.16,-5.08,428.1),
					Rotation = Vector3(0,89.96001,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(74.16,-5.08,428.1),
					OutTangent = Vector3(74.16,-5.08,428.1),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(90.219,-2.61,428.7349),
					Rotation = Vector3(0,89.96001,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(90.219,-1.72,428.7349),
					OutTangent = Vector3(90.219,-3.5,428.7349),
				},
			},
			StartTime = 0.2,
			Duration = 1,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 1.2,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 3,
		},
		[6] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_daqigu",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.385588,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,1,0,0),
					[2] = UnityEngine.Keyframe(2.385588,0,0,0),
				},
			},
			StartTime = 0.4044143,
			Duration = 2.385588,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 2.790002,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 6,
		},
		[7] = {
			ObjectName = "jianchi",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.7,
			StartTime = 1.33,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 2.33,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 4,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene