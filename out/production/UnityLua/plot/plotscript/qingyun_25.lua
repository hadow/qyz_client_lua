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
	Duration = 15.1,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "xiaofanchengnian",
		[2] = "linjingyu",
		[3] = "luxueqi",
		[4] = "zengshushu",
		[5] = "jiuyiding",
		[6] = "jiagong",
		[7] = "diliebao",
		[8] = "sun",
		[9] = "liedi",
	},
	Title = "qingyun_25",
	EndTime = 15.1,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "sun",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(208.2422,14.9,193.0111),
			Rotation = Vector3(0,0,35.40001),
			LocalScale = Vector3(3,3,3),
			ObjectName = "yangguang",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 10,
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
					Position = Vector3(205.538,54.41431,190.421),
					Rotation = Vector3(86.83887,311.2537,-0.001888817),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(205.538,54.41431,190.421),
					OutTangent = Vector3(205.538,54.41431,190.421),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(205.4202,54.4467,190.6928),
					Rotation = Vector3(83.05726,1.27398,-0.0008294732),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(205.4202,54.4467,190.6928),
					OutTangent = Vector3(205.4202,54.4467,190.6928),
				},
			},
			StartTime = 0,
			Duration = 2,
			CurrentState = 5,
			Title = "Path",
			EndTime = 2,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[3] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_gunzou",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.209308,
			Is3DSound = false,
			Position = Vector3(251.1422,0,277.8111),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0,
			Duration = 3.209308,
			CurrentState = 5,
			Title = "back_sound(clone)",
			EndTime = 3.209308,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[4] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_gunzou",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.695818,
			Is3DSound = false,
			Position = Vector3(251.1422,0,277.8111),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,1,0,0),
					[2] = UnityEngine.Keyframe(1.836169,1,0,0),
					[3] = UnityEngine.Keyframe(2.695818,0,0,0),
				},
			},
			StartTime = 0,
			Duration = 2.695818,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 2.695818,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 12,
		},
		[5] = {
			IndexName = "jiuyiding",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(206.7522,38.93,192.6911),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(3,3,3),
			ObjectName = "jiuyiqiankunding",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
		},
		[6] = {
			IndexName = "xiaofanchengnian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(203.7968,37.42,195.2667),
			Rotation = Vector3(0,311.5229,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhangxiaofan",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[7] = {
			IndexName = "zengshushu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(203.8254,37.42,189.7765),
			Rotation = Vector3(0,228.1,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "cengshushu",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 7,
		},
		[8] = {
			IndexName = "luxueqi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(209.9006,37.42,189.4291),
			Rotation = Vector3(0,112.5501,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "luxueqi",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 6,
		},
		[9] = {
			IndexName = "linjingyu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(209.8076,37.42,195.2471),
			Rotation = Vector3(0,30.70009,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "lingjingyu",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 5,
		},
		[10] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_whoose_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.154218,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 1.74,
			Duration = 3.154218,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 4.894217,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 13,
		},
		[11] = {
			AudioMode = "BackMusic",
			LoadMode = "Delay",
			IndexName = "bgm_boss_01",
			Looping = false,
			StartPlayPos = 53.85917,
			EndPlayPos = 67.41551,
			Is3DSound = false,
			Position = Vector3(251.1422,0,277.8111),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0,0,0),
					[2] = UnityEngine.Keyframe(1.052138,0.8981061,0,0),
					[3] = UnityEngine.Keyframe(11.20268,0.8708333,-0.01545821,-0.01545821),
					[4] = UnityEngine.Keyframe(13.55634,0,0,0),
				},
			},
			StartTime = 1.83,
			Duration = 13.55634,
			CurrentState = 5,
			Title = "back_music",
			EndTime = 15.38634,
			Type = "PlotDirector.PlotEventBackMusic",
			ParentId = 11,
		},
		[12] = {
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
					Position = Vector3(206.4921,55.76337,158.4883),
					Rotation = Vector3(21.00588,359.5559,-0.0001035515),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(206.4921,55.76337,158.4883),
					OutTangent = Vector3(206.4921,55.76337,158.4883),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(206.3939,40.94987,183.3474),
					Rotation = Vector3(10.34887,356.462,-9.763789E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(206.3939,40.94987,183.3474),
					OutTangent = Vector3(206.3939,40.94987,183.3474),
				},
			},
			StartTime = 2,
			Duration = 2,
			CurrentState = 5,
			Title = "Path",
			EndTime = 4,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[13] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_ex_black_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.073605,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.849996,
			Duration = 1.073605,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 4.923602,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[14] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_magic_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.9697732,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.859996,
			Duration = 0.9697732,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 4.829769,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 15,
		},
		[15] = {
			ObjectName = "cengshushu",
			IsLoop = false,
			StateName = "idle",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 4,
			Duration = 3.333333,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 7.333333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 7,
		},
		[16] = {
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
					Position = Vector3(200.9203,39.18511,187.4105),
					Rotation = Vector3(12.4121,49.03154,-7.299626E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(200.9203,39.18511,187.4105),
					OutTangent = Vector3(200.9203,39.18511,187.4105),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(200.9203,39.18511,187.4105),
					Rotation = Vector3(12.4121,49.03154,-7.299626E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(200.9203,39.18511,187.4105),
					OutTangent = Vector3(200.9203,39.18511,187.4105),
				},
			},
			StartTime = 4,
			Duration = 1,
			CurrentState = 5,
			Title = "Path",
			EndTime = 5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[17] = {
			IndexName = "jiagong",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(203.8254,37.42,189.7765),
			Rotation = Vector3(0,228.1,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "jia1",
			StartTime = 4,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 5,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
		},
		[18] = {
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
					Position = Vector3(200.9203,39.18511,187.4105),
					Rotation = Vector3(12.4121,49.03154,-7.299626E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(200.9203,39.18511,187.4105),
					OutTangent = Vector3(200.9203,39.18511,187.4105),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(211.7092,38.43221,188.0334),
					Rotation = Vector3(356.47,301.774,-7.046328E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(211.7092,38.43221,188.0334),
					OutTangent = Vector3(211.7092,38.43221,188.0334),
				},
			},
			StartTime = 5.979993,
			Duration = 1,
			CurrentState = 5,
			Title = "Path",
			EndTime = 6.979993,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[19] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_ex_black_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.073605,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 6.789999,
			Duration = 1.073605,
			CurrentState = 5,
			Title = "back_sound(Clone)",
			EndTime = 7.863604,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[20] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_magic_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.9697732,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 6.79,
			Duration = 0.9697732,
			CurrentState = 5,
			Title = "back_sound(Clone)",
			EndTime = 7.759773,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 15,
		},
		[21] = {
			IndexName = "jiagong",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(209.9006,37.42,189.4291),
			Rotation = Vector3(0,112.5501,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "jia2",
			StartTime = 6.969998,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create(Clone)",
			EndTime = 7.969998,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
		},
		[22] = {
			ObjectName = "luxueqi",
			IsLoop = false,
			StateName = "idle",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 6.969998,
			Duration = 3.666667,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 10.63667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 7,
		},
		[23] = {
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
					Position = Vector3(211.7092,38.43221,188.0334),
					Rotation = Vector3(356.47,301.774,-7.046328E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(211.7092,38.43221,188.0334),
					OutTangent = Vector3(211.7092,38.43221,188.0334),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(211.2556,38.9076,196.824),
					Rotation = Vector3(1.24,226.936,-6.8478E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(211.2556,38.9076,196.824),
					OutTangent = Vector3(211.2556,38.9076,196.824),
				},
			},
			StartTime = 8.699999,
			Duration = 1,
			CurrentState = 5,
			Title = "Path",
			EndTime = 9.699999,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[24] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_magic_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.9697732,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 9.619997,
			Duration = 0.9697732,
			CurrentState = 5,
			Title = "back_sound(Clone)",
			EndTime = 10.58977,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 15,
		},
		[25] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_ex_black_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.073605,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 9.639999,
			Duration = 1.073605,
			CurrentState = 5,
			Title = "back_sound(Clone)",
			EndTime = 10.7136,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[26] = {
			IndexName = "jiagong",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(209.8076,37.42,195.2471),
			Rotation = Vector3(0,30.70009,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "jia3",
			StartTime = 9.73,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create(Clone)",
			EndTime = 10.73,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
		},
		[27] = {
			ObjectName = "lingjingyu",
			IsLoop = false,
			StateName = "idle",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 9.73,
			Duration = 3.533334,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 13.26333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 7,
		},
		[28] = {
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
					Position = Vector3(211.2556,38.9076,196.824),
					Rotation = Vector3(1.24,226.936,-6.8478E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(211.2556,38.9076,196.824),
					OutTangent = Vector3(211.2556,38.9076,196.824),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(201.953,39.04039,197.126),
					Rotation = Vector3(1.060007,134.9,-7.026159E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(201.953,39.04039,197.126),
					OutTangent = Vector3(201.953,39.04039,197.126),
				},
			},
			StartTime = 11.41,
			Duration = 1,
			CurrentState = 5,
			Title = "Path",
			EndTime = 12.41,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[29] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_ex_black_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.073605,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 12.09,
			Duration = 1.073605,
			CurrentState = 5,
			Title = "back_sound(Clone)",
			EndTime = 13.1636,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[30] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_magic_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.9697732,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 12.1,
			Duration = 0.9697732,
			CurrentState = 5,
			Title = "back_sound(Clone)",
			EndTime = 13.06977,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 15,
		},
		[31] = {
			IndexName = "diliebao",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(203.7968,37.42,195.2667),
			Rotation = Vector3(0,311.5229,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "jia4",
			StartTime = 12.39,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 13.39,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
		},
		[32] = {
			ObjectName = "zhangxiaofan",
			IsLoop = false,
			StateName = "skill04",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 12.39,
			Duration = 6.666667,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 19.05667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 7,
		},
		[33] = {
			IndexName = "jiagong",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(203.7968,37.42,195.2667),
			Rotation = Vector3(0,311.5229,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "jia3",
			StartTime = 12.39,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create(Clone)(Clone)",
			EndTime = 13.39,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 10,
		},
		[34] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_magic_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.9697732,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 13.65,
			Duration = 0.9697732,
			CurrentState = 5,
			Title = "back_sound(Clone)",
			EndTime = 14.61977,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 15,
		},
		[35] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_ex_black_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.073605,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 13.68,
			Duration = 1.073605,
			CurrentState = 5,
			Title = "back_sound(Clone)",
			EndTime = 14.7536,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[36] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_explo_sml_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.828798,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 13.69,
			Duration = 1.828798,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 15.5188,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 13,
		},
		[37] = {
			IndexName = "liedi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(203.7968,37.42,195.2667),
			Rotation = Vector3(0,311.5229,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "jia5",
			StartTime = 13.7,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 14.7,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 10,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene