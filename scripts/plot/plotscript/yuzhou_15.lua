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
	Duration = 25.5,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "xiaofanchengnian",
		[2] = "zhanlongjian",
		[3] = "dushen",
		[4] = "shihunchong",
		[5] = "heiyigongji",
		[6] = "cg_jiafang",
		[7] = "xueqigong",
		[8] = "luxueqi",
		[9] = "xuewu",
		[10] = "linjingyu",
		[11] = "cangsongshenjian",
	},
	Title = "yuzhou_15",
	EndTime = 25.5,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "linjingyu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0,0,0),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "lin",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[2] = {
			IndexName = "luxueqi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0,0,0),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xueqi",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
		},
		[3] = {
			AudioMode = "BackMusic",
			LoadMode = "Delay",
			IndexName = "bgm_cg_06",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 25.43674,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0.8352273,0,0),
					[2] = UnityEngine.Keyframe(6.147008,0.7811294,-0.0007450581,-0.0007450581),
					[3] = UnityEngine.Keyframe(21.87388,0.7689394,0,0),
					[4] = UnityEngine.Keyframe(25.43674,0,0,0),
				},
			},
			StartTime = 0,
			Duration = 25.43674,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 25.43674,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 12,
		},
		[4] = {
			IndexName = "xiaofanchengnian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(443.1042,53.807,365.16),
			Rotation = Vector3(0,20.11,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xiaofan",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[5] = {
			IndexName = "dushen",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(444.0384,53.81,375.3262),
			Rotation = Vector3(0,186.8,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "dushen",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[6] = {
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
					Position = Vector3(443.3787,55.99777,363.7666),
					Rotation = Vector3(345.6,1.791494,0.0001219178),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(443.3787,55.99777,363.7666),
					OutTangent = Vector3(443.3787,55.99777,363.7666),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(442.6511,55.42912,364.4735),
					Rotation = Vector3(1.75566,26.54326,0.0001207323),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(442.6511,55.42912,364.4735),
					OutTangent = Vector3(442.6511,55.42912,364.4735),
				},
			},
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "path",
			EndTime = 1,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[7] = {
			ObjectName = "xiaofan",
			IsLoop = false,
			StateName = "standfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.2,
			Duration = 1.333333,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 1.533333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 3,
		},
		[8] = {
			ObjectName = "dushen",
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
					Position = Vector3(444.0384,53.81,375.3262),
					Rotation = Vector3(0,186.8,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(444.0352,47.44,375.8906),
					OutTangent = Vector3(444.0416,60.18,374.7619),
				},
				[2] = {
					NodeTime = 0.8,
					Position = Vector3(443.35,53.74,366.96),
					Rotation = Vector3(0,192.1,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(443.2655,53.56,367.377),
					OutTangent = Vector3(443.4345,53.92,366.543),
				},
			},
			StartTime = 0.2,
			Duration = 0.8,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 6,
		},
		[9] = {
			ObjectName = "dushen",
			IsLoop = false,
			StateName = "jump",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.2,
			Duration = 2.133333,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 2.333333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 4,
		},
		[10] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_swing_mid_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.5701814,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0.7900001,
			Duration = 0.5701814,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 1.360182,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 13,
		},
		[11] = {
			ObjectName = "dushen",
			IsLoop = false,
			StateName = "attack01",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 1,
			Duration = 1.1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 2.1,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 6,
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
					Position = Vector3(442.6511,55.42912,364.4735),
					Rotation = Vector3(1.75566,26.54326,0.0001207323),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(442.6511,55.42912,364.4735),
					OutTangent = Vector3(442.6511,55.42912,364.4735),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(436.4576,57.46779,366.2477),
					Rotation = Vector3(24.61793,105.2361,0.0002282099),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(436.4576,57.46779,366.2477),
					OutTangent = Vector3(436.4576,57.46779,366.2477),
				},
			},
			StartTime = 1,
			Duration = 1.72,
			CurrentState = 5,
			Title = "path",
			EndTime = 2.72,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[13] = {
			IndexName = "heiyigongji",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0,0,0),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "gongji",
			StartTime = 1.31,
			Duration = 0.22,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1.53,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 5,
		},
		[14] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_15_1",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.639388,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 1.319998,
			Duration = 1.639388,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 2.959385,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[15] = {
			ObjectName = "xiaofan",
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
					Position = Vector3(443.1042,53.807,365.16),
					Rotation = Vector3(0,20.11,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(443.1042,53.807,365.16),
					OutTangent = Vector3(443.1042,53.807,365.16),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(442.581,53.807,361.686),
					Rotation = Vector3(0,20.11,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(442.581,53.807,361.686),
					OutTangent = Vector3(442.581,53.807,361.686),
				},
			},
			StartTime = 1.400001,
			Duration = 1,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 2.400001,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 7,
		},
		[16] = {
			ObjectName = "xiaofan",
			IsLoop = false,
			StateName = "dying",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 1.400001,
			Duration = 2.266667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 3.666668,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[17] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_magic_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.12678,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 1.49,
			Duration = 1.12678,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 2.61678,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[18] = {
			IndexName = "xuewu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(443.1042,54.87,365.16),
			Rotation = Vector3(0,20.11,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xuewu",
			StartTime = 1.53,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1.73,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[19] = {
			IndexName = "shihunchong",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(443.35,53.74,365.6),
			Rotation = Vector3(20.5089,207.6,9.79566),
			LocalScale = Vector3(1,1,1),
			ObjectName = "shan",
			StartTime = 1.53,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 2.53,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 5,
		},
		[20] = {
			ObjectName = "gongji",
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
					Position = Vector3(443.35,53.94,366.96),
					Rotation = Vector3(20.50868,205.477,9.795606),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(443.35,53.94,366.96),
					OutTangent = Vector3(443.35,53.94,366.96),
				},
				[2] = {
					NodeTime = 0.2,
					Position = Vector3(443.35,53.99,359.56),
					Rotation = Vector3(20.50868,205.477,9.795606),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(443.35,53.99,359.56),
					OutTangent = Vector3(443.35,53.99,359.56),
				},
			},
			StartTime = 1.533333,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 1.733333,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 3,
		},
		[21] = {
			IndexName = "xuewu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(442.85,54.87,364.47),
			Rotation = Vector3(0,20.11,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xuewu1",
			StartTime = 1.73,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 1.93,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[22] = {
			IndexName = "xuewu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(442.04,54.87,363.54),
			Rotation = Vector3(0,20.11,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xuewu2",
			StartTime = 1.93,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 2.13,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[23] = {
			ObjectName = "dushen",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 2.1,
			Duration = 0.4100001,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 2.51,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 6,
		},
		[24] = {
			ObjectName = "lin",
			IsLoop = false,
			StateName = "skill02",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 2.333333,
			Duration = 3.233334,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 5.566667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 4,
		},
		[25] = {
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
					Position = Vector3(436.4576,57.46779,366.2477),
					Rotation = Vector3(24.61793,105.2361,0.0002282099),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(436.4576,57.46779,366.2477),
					OutTangent = Vector3(436.4576,57.46779,366.2477),
				},
				[2] = {
					NodeTime = 0.5,
					Position = Vector3(434.6095,56.66263,361.4485),
					Rotation = Vector3(350.4124,115.3773,0.0002008814),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(434.6095,56.66263,361.4485),
					OutTangent = Vector3(434.6095,56.66263,361.4485),
				},
			},
			StartTime = 2.72,
			Duration = 0.5,
			CurrentState = 5,
			Title = "path",
			EndTime = 3.22,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[26] = {
			IndexName = "zhanlongjian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0,0,0),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhanlong",
			StartTime = 2.73,
			Duration = 0.07999992,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 2.81,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[27] = {
			ObjectName = "zhanlong",
			ParentName = "lin",
			StartTime = 2.81,
			Duration = 0.1100001,
			CurrentState = 5,
			Title = "object_parent",
			EndTime = 2.92,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 3,
		},
		[28] = {
			ObjectName = "dushen",
			IsLoop = false,
			StateName = "standfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 2.83,
			Duration = 2,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 4.83,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[29] = {
			ObjectName = "lin",
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
					Position = Vector3(444.404,61.10431,347.87),
					Rotation = Vector3(19.63318,358.6659,0.0002082905),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(444.404,61.10431,347.87),
					OutTangent = Vector3(444.404,61.10431,347.87),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(443.4622,53.955,361.8),
					Rotation = Vector3(354.47,3.100029,0.0002310607),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(443.4622,53.955,361.8),
					OutTangent = Vector3(443.4622,53.955,361.8),
				},
			},
			StartTime = 2.92,
			Duration = 1,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 3.92,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 3,
		},
		[30] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "bodyfall_lag",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.9054195,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Constant",
			VolumeValue = 0.4,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.06,
			Duration = 0.9054195,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 3.96542,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 13,
		},
		[31] = {
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
					Position = Vector3(434.6095,56.66263,361.4485),
					Rotation = Vector3(350.4124,115.3773,0.0002008814),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(435.5908,56.65769,365.2663),
					OutTangent = Vector3(433.6282,56.66757,357.6306),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(442.4918,59.70932,354.2372),
					Rotation = Vector3(21.00833,1.931796,0.0002123795),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(439.3587,59.70459,352.1224),
					OutTangent = Vector3(445.6248,59.71405,356.3521),
				},
			},
			StartTime = 3.22,
			Duration = 1,
			CurrentState = 5,
			Title = "path",
			EndTime = 4.22,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[32] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_magic_shot_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.650181,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.22,
			Duration = 3.650181,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 6.870182,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[33] = {
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
					Position = Vector3(442.4918,59.70932,354.2372),
					Rotation = Vector3(21.00833,1.931796,0.0002123795),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(442.492,59.70961,355.5203),
					OutTangent = Vector3(442.4915,59.70903,352.9542),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(450.0016,58.32871,356.6293),
					Rotation = Vector3(8.460553,315.3503,0.0002021969),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(450.1277,58.32958,353.7839),
					OutTangent = Vector3(449.8755,58.32785,359.4748),
				},
			},
			StartTime = 4.22,
			Duration = 1.99,
			CurrentState = 5,
			Title = "path",
			EndTime = 6.21,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[34] = {
			ObjectName = "lin",
			IsLoop = false,
			StateName = "attack02",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 4.670006,
			Duration = 2.166667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 6.836673,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[35] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "skill_common_magic_shot_03",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.514399,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 5.369996,
			Duration = 1.514399,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 6.884395,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 15,
		},
		[36] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "skill_qingyunmen_skl01_90006",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 5.261708,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,1,0,0),
					[2] = UnityEngine.Keyframe(4.082002,1,0,0),
					[3] = UnityEngine.Keyframe(5.261708,0,0,0),
				},
			},
			StartTime = 5.489998,
			Duration = 5.261708,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 10.75171,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 13,
		},
		[37] = {
			ObjectName = "lin",
			IsLoop = false,
			StateName = "standfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 5.499996,
			Duration = 1.666667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 7.166662,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 7,
		},
		[38] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_stone_mid_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.834286,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 5.559999,
			Duration = 1.834286,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 7.394285,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 16,
		},
		[39] = {
			IndexName = "xueqigong",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(443.35,53.74,368.56),
			Rotation = Vector3(0,181.45,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xuqigongji",
			StartTime = 5.619998,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 6.619998,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 6,
		},
		[40] = {
			ObjectName = "dushen",
			IsLoop = false,
			StateName = "hit",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 5.679993,
			Duration = 0.5666667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 6.246659,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 3,
		},
		[41] = {
			ObjectName = "dushen",
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
					Position = Vector3(443.35,53.74,366.96),
					Rotation = Vector3(20.50868,205.477,9.795606),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(443.35,53.74,366.96),
					OutTangent = Vector3(443.35,53.74,366.96),
				},
				[2] = {
					NodeTime = 0.5,
					Position = Vector3(443.35,53.74,368.56),
					Rotation = Vector3(0,181.45,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(443.35,53.74,368.56),
					OutTangent = Vector3(443.35,53.74,368.56),
				},
			},
			StartTime = 5.719991,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 6.219991,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 4,
		},
		[42] = {
			IndexName = "cangsongshenjian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(450.51,54.06,368.56),
			Rotation = Vector3(0,275.5,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "shenjian",
			StartTime = 6.030001,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 7.030001,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[43] = {
			ObjectName = "xueqi",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(450.51,54.19,368.56),
			Rotation = Vector3(0,275.5,0),
			LocalScale = Vector3(1,1,1),
			StartTime = 6.2,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_transform",
			EndTime = 6.3,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 8,
		},
		[44] = {
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
					Position = Vector3(450.0016,58.32871,356.6293),
					Rotation = Vector3(8.460553,315.3503,0.0002021969),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(450.0016,58.32871,356.6293),
					OutTangent = Vector3(450.0016,58.32871,356.6293),
				},
				[2] = {
					NodeTime = 0.5,
					Position = Vector3(453.4551,56.15329,365.6202),
					Rotation = Vector3(15.16421,301.9429,0.0001963755),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(453.4551,56.15329,365.6202),
					OutTangent = Vector3(453.4551,56.15329,365.6202),
				},
			},
			StartTime = 6.21,
			Duration = 5.68,
			CurrentState = 5,
			Title = "path",
			EndTime = 11.89,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[45] = {
			ObjectName = "dushen",
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
					Position = Vector3(443.35,53.74,368.56),
					Rotation = Vector3(0,181.45,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(443.35,53.74,368.56),
					OutTangent = Vector3(443.35,53.74,368.56),
				},
				[2] = {
					NodeTime = 0.2,
					Position = Vector3(443.35,53.74,368.56),
					Rotation = Vector3(0,89.80002,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(443.35,53.74,368.56),
					OutTangent = Vector3(443.35,53.74,368.56),
				},
			},
			StartTime = 6.219991,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 6.419991,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 4,
		},
		[46] = {
			ObjectName = "dushen",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 6.246659,
			Duration = 0.1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 6.346659,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 3,
		},
		[47] = {
			ObjectName = "xueqi",
			IsLoop = false,
			StateName = "skill04",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 6.3,
			Duration = 5.666667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 11.96667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[48] = {
			ObjectName = "dushen",
			IsLoop = false,
			StateName = "hit",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 7.166662,
			Duration = 0.5666667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 7.733329,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 7,
		},
		[49] = {
			ObjectName = "dushen",
			SpeedValue = 0.1,
			Curve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 7.179997,
			Duration = 4.800002,
			CurrentState = 4,
			Mode = "Event",
			Title = "animator_speed",
			EndTime = 11.98,
			Type = "PlotDirector.PlotEventAnimatorSpeed",
			ParentId = 6,
		},
		[50] = {
			IndexName = "cg_jiafang",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(443.35,53.74,368.56),
			Rotation = Vector3(0,89.80002,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "qi",
			StartTime = 7.189998,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 8.189999,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 5,
		},
		[51] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "skill_qingyunmen_skl01_90006",
			Looping = false,
			StartPlayPos = 6.620364,
			EndPlayPos = 11.85737,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 10.02999,
			Duration = 5.237005,
			CurrentState = 5,
			Title = "back_sound(clone)",
			EndTime = 15.267,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[52] = {
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
					Position = Vector3(453.4551,56.15329,365.6202),
					Rotation = Vector3(15.16421,301.9429,0.0001963755),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(451.792,56.14896,366.1621),
					OutTangent = Vector3(455.1182,56.15761,365.0782),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(451.7498,57.04565,359.5522),
					Rotation = Vector3(20.66462,316.0376,0.0001998333),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(452.9191,57.04252,359.5499),
					OutTangent = Vector3(450.5805,57.04879,359.5546),
				},
			},
			StartTime = 11.89,
			Duration = 1,
			CurrentState = 5,
			Title = "path",
			EndTime = 12.89,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[53] = {
			ObjectName = "dushen",
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
					Position = Vector3(443.35,53.74,368.56),
					Rotation = Vector3(0,89.80002,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(443.35,53.74,368.56),
					OutTangent = Vector3(443.35,53.74,368.56),
				},
				[2] = {
					NodeTime = 0.2,
					Position = Vector3(443.35,53.74,368.56),
					Rotation = Vector3(0,147,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(443.35,53.74,368.56),
					OutTangent = Vector3(443.35,53.74,368.56),
				},
			},
			StartTime = 11.93,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 12.13,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 3,
		},
		[54] = {
			ObjectName = "shenjian",
			Active = false,
			StartTime = 11.96,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 12.96,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 9,
		},
		[55] = {
			ObjectName = "xueqi",
			IsLoop = false,
			StateName = "standfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 11.96667,
			Duration = 1.066667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 13.03333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[56] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_15_3",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.608073,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 12.21,
			Duration = 3.608073,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 15.81807,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[57] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "毒神：  想不到，几个小辈竟有如此修为。",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 12.25,
			Duration = 3.439996,
			CurrentState = 5,
			Title = "talk",
			EndTime = 15.69,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 11,
		},
		[58] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_15_4",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.591519,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 15.87807,
			Duration = 3.591519,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 19.46959,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[59] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "陆雪琪：  惊羽，你冷静点，小凡不一定有事。",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 15.89,
			Duration = 3.570004,
			CurrentState = 5,
			Title = "talk",
			EndTime = 19.46,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 11,
		},
		[60] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_15_5",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.208821,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 19.7296,
			Duration = 2.208821,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 21.93842,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[61] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "林惊羽：  我拖住他们，你们尽快离开这里。",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 19.74,
			Duration = 2.24,
			CurrentState = 5,
			Title = "talk",
			EndTime = 21.98,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 11,
		},
		[62] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_15_6",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.050884,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 22.15999,
			Duration = 1.050884,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 23.21088,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[63] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "陆雪琪：  我不能丢下你！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 22.16,
			Duration = 3,
			CurrentState = 5,
			Title = "talk",
			EndTime = 25.16,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 11,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene