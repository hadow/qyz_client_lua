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
	Duration = 10.5,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "xiaofanchengnian",
		[2] = "biyao",
		[3] = "cg_dibo",
		[4] = "puzhijinengtx",
		[5] = "dushen",
		[6] = "MainCharacter",
	},
	Title = "yuzhou_17",
	EndTime = 10.5,
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
					Position = Vector3(475.4231,56.92686,417.0441),
					Rotation = Vector3(12.76284,252.5974,0.01997537),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(475.4231,56.92686,417.0441),
					OutTangent = Vector3(475.4231,56.92686,417.0441),
				},
				[2] = {
					NodeTime = 0.7,
					Position = Vector3(475.4231,56.92686,417.0441),
					Rotation = Vector3(12.76284,252.5974,0.01997537),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(475.4231,56.92686,417.0441),
					OutTangent = Vector3(475.4231,56.92686,417.0441),
				},
				[3] = {
					NodeTime = 2.37,
					Position = Vector3(459.7361,55.45493,414.2294),
					Rotation = Vector3(11.9034,258.2694,0.01991651),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(459.7361,55.45493,414.2294),
					OutTangent = Vector3(459.7361,55.45493,414.2294),
				},
			},
			StartTime = 0,
			Duration = 2.37,
			CurrentState = 5,
			Title = "path",
			EndTime = 2.37,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 6,
		},
		[2] = {
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
			StartTime = 0,
			Duration = 3.154218,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 3.154218,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 11,
		},
		[3] = {
			AudioMode = "BackMusic",
			LoadMode = "Delay",
			IndexName = "bgm_cg_06",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 10.51385,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0.8484849,0,0),
					[2] = UnityEngine.Keyframe(7.492167,0.8453339,-0.0002980232,-0.0002980232),
					[3] = UnityEngine.Keyframe(10.51385,0,0,0),
				},
			},
			StartTime = 0,
			Duration = 10.51385,
			CurrentState = 5,
			Title = "back_music",
			EndTime = 10.51385,
			Type = "PlotDirector.PlotEventBackMusic",
			ParentId = 10,
		},
		[4] = {
			IndexName = "dushen",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(456.46,53.847,413.57),
			Rotation = Vector3(0,84.90001,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "dushen",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 5,
		},
		[5] = {
			IndexName = "xiaofanchengnian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(473.06,55.01,414.7344),
			Rotation = Vector3(0,265.1,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xiaofan",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 2,
		},
		[6] = {
			IndexName = "biyao",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(472.9075,55.27071,417.3663),
			Rotation = Vector3(0,261.1,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "biyao",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[7] = {
			IndexName = "MainCharacter",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(472.6,55.18,415.89),
			Rotation = Vector3(0,270.3,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhujue",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_special",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectSpecialCreate",
			ParentId = 4,
		},
		[8] = {
			ObjectName = "biyao",
			ParentName = "zhujue",
			StartTime = 0.33,
			Duration = 1,
			CurrentState = 5,
			Title = "object_parent",
			EndTime = 1.33,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 4,
		},
		[9] = {
			ObjectName = "xiaofan",
			ParentName = "zhujue",
			StartTime = 0.3300001,
			Duration = 1,
			CurrentState = 5,
			Title = "object_parent",
			EndTime = 1.33,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 3,
		},
		[10] = {
			ObjectName = "biyao",
			IsLoop = true,
			StateName = "standfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 1,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 2,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 7,
		},
		[11] = {
			ObjectName = "zhujue",
			IsLoop = true,
			StateName = "standfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 1.05,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 2.05,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[12] = {
			ObjectName = "dushen",
			IsLoop = false,
			StateName = "skill02",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 1.6,
			Duration = 4.8,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 6.4,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 2,
		},
		[13] = {
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
					Position = Vector3(459.7361,55.45493,414.2294),
					Rotation = Vector3(11.9034,258.2694,0.01991651),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(459.7361,55.45493,414.2294),
					OutTangent = Vector3(459.7361,55.45493,414.2294),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(475.8078,57.03678,416.9394),
					Rotation = Vector3(10.18452,251.9093,0.01981931),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(475.8078,57.03678,416.9394),
					OutTangent = Vector3(475.8078,57.03678,416.9394),
				},
			},
			StartTime = 2.37,
			Duration = 2,
			CurrentState = 5,
			Title = "path",
			EndTime = 4.37,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 6,
		},
		[14] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_ex_black_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.9032199,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 2.79,
			Duration = 0.9032199,
			CurrentState = 5,
			Title = "back_sound(Clone)",
			EndTime = 3.69322,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 12,
		},
		[15] = {
			IndexName = "cg_dibo",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(460.21,54.19,411.46),
			Rotation = Vector3(0,84.90001,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "bo1",
			StartTime = 2.88,
			Duration = 0.3,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 3.18,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[16] = {
			ObjectName = "dushen",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(460.21,54.19,411.46),
			Rotation = Vector3(0,84.90001,0),
			LocalScale = Vector3(1,1,1),
			StartTime = 2.88,
			Duration = 0.3100014,
			CurrentState = 5,
			Title = "object_transform",
			EndTime = 3.190001,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 5,
		},
		[17] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_ex_black_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.9032199,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.154218,
			Duration = 0.9032199,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 4.057438,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 11,
		},
		[18] = {
			IndexName = "cg_dibo",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(462.22,54.19,416.34),
			Rotation = Vector3(0,84.90001,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "bo2",
			StartTime = 3.18,
			Duration = 0.3,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 3.48,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[19] = {
			ObjectName = "dushen",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(462.22,54.19,416.34),
			Rotation = Vector3(0,84.90001,0),
			LocalScale = Vector3(1,1,1),
			StartTime = 3.190001,
			Duration = 0.3,
			CurrentState = 5,
			Title = "object_transform",
			EndTime = 3.490001,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 5,
		},
		[20] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_ex_black_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.9032199,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.47,
			Duration = 0.9032199,
			CurrentState = 5,
			Title = "back_sound(Clone)(Clone)",
			EndTime = 4.37322,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 13,
		},
		[21] = {
			IndexName = "cg_dibo",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(464.87,54.19,410.9),
			Rotation = Vector3(0,84.90001,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "bo3",
			StartTime = 3.48,
			Duration = 0.3,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 3.779999,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[22] = {
			ObjectName = "dushen",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(464.87,54.19,410.9),
			Rotation = Vector3(0,84.90001,0),
			LocalScale = Vector3(1,1,1),
			StartTime = 3.490001,
			Duration = 0.3,
			CurrentState = 5,
			Title = "object_transform",
			EndTime = 3.790001,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 5,
		},
		[23] = {
			IndexName = "cg_dibo",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(466.27,54.19,417.55),
			Rotation = Vector3(0,84.90001,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "bo4",
			StartTime = 3.779999,
			Duration = 0.3200021,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 4.100001,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[24] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_ex_black_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.9032199,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.789999,
			Duration = 0.9032199,
			CurrentState = 5,
			Title = "back_sound(Clone)(Clone)",
			EndTime = 4.693219,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 12,
		},
		[25] = {
			ObjectName = "dushen",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(466.27,54.19,417.55),
			Rotation = Vector3(0,84.90001,0),
			LocalScale = Vector3(1,1,1),
			StartTime = 3.790001,
			Duration = 0.3,
			CurrentState = 5,
			Title = "object_transform",
			EndTime = 4.090002,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 5,
		},
		[26] = {
			ObjectName = "dushen",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(470,54.88,415.647),
			Rotation = Vector3(0,88.10001,0),
			LocalScale = Vector3(1,1,1),
			StartTime = 4.090002,
			Duration = 0.3,
			CurrentState = 5,
			Title = "object_transform",
			EndTime = 4.390002,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 5,
		},
		[27] = {
			IndexName = "cg_dibo",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(470,54.88,415.647),
			Rotation = Vector3(0,88.10001,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "bo5",
			StartTime = 4.100001,
			Duration = 0.3,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 4.400002,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[28] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_ex_black_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.9032199,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 4.119999,
			Duration = 0.9032199,
			CurrentState = 5,
			Title = "back_sound(Clone)",
			EndTime = 5.023219,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 11,
		},
		[29] = {
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
					Position = Vector3(475.8078,57.03678,416.9394),
					Rotation = Vector3(10.18452,251.9093,0.01981931),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(475.8078,57.03678,416.9394),
					OutTangent = Vector3(475.8078,57.03678,416.9394),
				},
				[2] = {
					NodeTime = 0.5,
					Position = Vector3(474.8951,56.96782,417.6221),
					Rotation = Vector3(16.71619,247.2707,0.02037041),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(474.8951,56.96782,417.6221),
					OutTangent = Vector3(474.8951,56.96782,417.6221),
				},
			},
			StartTime = 4.37,
			Duration = 0.5,
			CurrentState = 5,
			Title = "path",
			EndTime = 4.87,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 6,
		},
		[30] = {
			ObjectName = "dushen",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.5,
			StartTime = 4.390002,
			Duration = 0.5,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 4.890002,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[31] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "skill_common_magic_hold_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.327914,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0.5397727,0,0),
					[2] = UnityEngine.Keyframe(1.362963,0.5511364,0,0),
					[3] = UnityEngine.Keyframe(2.327914,0,0,0),
				},
			},
			StartTime = 4.519999,
			Duration = 2.327914,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 6.847913,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 13,
		},
		[32] = {
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
					Position = Vector3(474.8951,56.96782,417.6221),
					Rotation = Vector3(16.71619,247.2707,0.02037041),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(474.3517,56.96771,416.8685),
					OutTangent = Vector3(475.4386,56.96793,418.3757),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(472.2128,56.95861,419.9134),
					Rotation = Vector3(13.62228,191.2342,0.02007077),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(472.2106,56.95948,420.8263),
					OutTangent = Vector3(472.2151,56.95774,419.0005),
				},
			},
			StartTime = 4.87,
			Duration = 1,
			CurrentState = 5,
			Title = "path",
			EndTime = 5.87,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 6,
		},
		[33] = {
			ObjectName = "dushen",
			IsLoop = false,
			StateName = "skill01",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 4.890002,
			Duration = 1.6,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 6.490002,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[34] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_ex_boom_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.469887,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 5.570001,
			Duration = 2.469887,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 8.039887,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[35] = {
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
			StartTime = 5.579998,
			Duration = 1.828798,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 7.408797,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 12,
		},
		[36] = {
			ObjectName = "zhujue",
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
					Position = Vector3(472.6,55.18,415.89),
					Rotation = Vector3(0,270.3,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(472.6,55.18,415.89),
					OutTangent = Vector3(472.6,55.18,415.89),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(473.82,55.679,415.89),
					Rotation = Vector3(0,270.3,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(473.82,55.679,415.89),
					OutTangent = Vector3(473.82,55.679,415.89),
				},
			},
			StartTime = 5.8,
			Duration = 1,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 6.8,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 3,
		},
		[37] = {
			IndexName = "puzhijinengtx",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(470,54.88,415.647),
			Rotation = Vector3(0,88.10001,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "pao",
			StartTime = 5.800001,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 6.800001,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[38] = {
			ObjectName = "xiaofan",
			IsLoop = false,
			StateName = "dying",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 5.839997,
			Duration = 2.266667,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 8.106665,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 9,
		},
		[39] = {
			ObjectName = "zhujue",
			IsLoop = false,
			StateName = "dying",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 5.84,
			Duration = 4.333333,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 10.17333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 7,
		},
		[40] = {
			ObjectName = "biyao",
			IsLoop = false,
			StateName = "dying",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 5.84,
			Duration = 2.233333,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 8.073334,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[41] = {
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
					Position = Vector3(472.2128,56.95861,419.9134),
					Rotation = Vector3(13.62228,191.2342,0.02007077),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(472.2128,56.95861,419.9134),
					OutTangent = Vector3(472.2128,56.95861,419.9134),
				},
				[2] = {
					NodeTime = 0.5,
					Position = Vector3(469.4378,57.12262,419.6429),
					Rotation = Vector3(16.2006,145.1693,0.02031277),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(469.4378,57.12262,419.6429),
					OutTangent = Vector3(469.4378,57.12262,419.6429),
				},
			},
			StartTime = 5.87,
			Duration = 0.5,
			CurrentState = 5,
			Title = "path",
			EndTime = 6.37,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 6,
		},
		[42] = {
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
					Position = Vector3(469.4378,57.12262,419.6429),
					Rotation = Vector3(16.2006,145.1693,0.02031277),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(469.4378,57.12262,419.6429),
					OutTangent = Vector3(469.4378,57.12262,419.6429),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(466.3939,56.7415,415.1316),
					Rotation = Vector3(8.637586,81.39645,0.01974635),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(466.3939,56.7415,415.1316),
					OutTangent = Vector3(466.3939,56.7415,415.1316),
				},
			},
			StartTime = 6.37,
			Duration = 2,
			CurrentState = 5,
			Title = "path",
			EndTime = 8.37,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 6,
		},
		[43] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "bodyfall_lag",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.9054195,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Constant",
			VolumeValue = 0.6,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 7.27,
			Duration = 0.9054195,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 8.175419,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 11,
		},
		[44] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "bodyfall_mid",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.5161905,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 9.099997,
			Duration = 0.5161905,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 9.616187,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 11,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene