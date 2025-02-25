local Plot = require("plot.plot")

PlotCutscene = {
	PlayRate = 1,
	config = {
		isLooping = false,
		isSkippable = false,
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
	Duration = 24.5,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "shuiqilin",
		[2] = "qilinshe",
		[3] = "qingyun_dao",
		[4] = "liedi",
		[5] = "machechengtu",
		[6] = "shuihua",
		[7] = "xuanwo",
		[8] = "MainCharacter",
	},
	Title = "xuzhang_qilin",
	EndTime = 24.5,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "qingyun_dao",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0,0,0),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "daoguang",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 6,
		},
		[2] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "skill_common_magic_hold_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.322109,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Constant",
			VolumeValue = 0.7,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0,
			Duration = 3.322109,
			CurrentState = 5,
			Title = "a2(Clone)",
			EndTime = 3.322109,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 19,
		},
		[3] = {
			IndexName = "qilinshe",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(10.4917,208.331,147.359),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(5,5,5),
			ObjectName = "qilinshe",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[4] = {
			IndexName = "shuiqilin",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(10.4917,208.331,147.359),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(5,5,5),
			ObjectName = "qilin",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 2,
		},
		[5] = {
			IndexName = "MainCharacter",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(9.5,209.4,127.83),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhujue",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_special",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectSpecialCreate",
			ParentId = 3,
		},
		[6] = {
			ObjectName = "qilinshe/Camera002/empty",
			PositionFollow = true,
			RotationFollow = true,
			RelativePosition = Vector3(0,0,0),
			RelativeRotation = Vector3(0,0,0),
			PositionFollowFactor = -1,
			RotationFollowFactor = -1,
			StartTime = 0.1,
			Duration = 24.32,
			CurrentState = 5,
			Title = "follow",
			EndTime = 24.42,
			Type = "PlotDirector.PlotEventCameraFollow",
			ParentId = 5,
		},
		[7] = {
			ObjectName = "qilin",
			IsLoop = false,
			StateName = "CG_QTE",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.2,
			Duration = 24.23334,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 24.43334,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 2,
		},
		[8] = {
			ObjectName = "zhujue",
			IsLoop = false,
			StateName = "CG_QTE",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.2,
			Duration = 24.23334,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 24.43334,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 3,
		},
		[9] = {
			ObjectName = "qilinshe",
			IsLoop = false,
			StateName = "QTE",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.2,
			Duration = 24.23334,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 24.43334,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 4,
		},
		[10] = {
			IndexName = "xuanwo",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(9.66,208.99,121.46),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(2,2,2),
			ObjectName = "xuanwo",
			StartTime = 1.21,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 2.21,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 15,
		},
		[11] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "vox_boss_shuiqilin_attack_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.670635,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 2.27,
			Duration = 1.670635,
			CurrentState = 5,
			Title = "a3(Clone)",
			EndTime = 3.940635,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 20,
		},
		[12] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_explo_mid_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.595737,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 2.64,
			Duration = 2.595737,
			CurrentState = 5,
			Title = "a4(Clone)",
			EndTime = 5.235737,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 21,
		},
		[13] = {
			IndexName = "shuihua",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(9.66,208.99,121.46),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(2,2,2),
			ObjectName = "shuihua1",
			StartTime = 2.67,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 3.67,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 15,
		},
		[14] = {
			IndexName = "machechengtu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(4.46,208.8987,121.46),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yanchen5",
			StartTime = 2.67,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 3.67,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 13,
		},
		[15] = {
			IndexName = "shuihua",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(6.64,208.99,123.09),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "shuihua1",
			StartTime = 2.68,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 3.68,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 16,
		},
		[16] = {
			IndexName = "machechengtu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(12.39,208.8987,124.9232),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yanchen1",
			StartTime = 2.68,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 3.68,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[17] = {
			IndexName = "shuihua",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(5.63,208.99,118.65),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "shuihua3",
			StartTime = 2.68,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 3.68,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 17,
		},
		[18] = {
			IndexName = "machechengtu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(5.39,208.8987,126.17),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yanchen4",
			StartTime = 2.68,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 3.68,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 12,
		},
		[19] = {
			IndexName = "machechengtu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(9.15,208.8987,127.41),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yanchen3",
			StartTime = 2.68,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 3.68,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 11,
		},
		[20] = {
			IndexName = "machechengtu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(5.72,208.8987,118.49),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yanchen6",
			StartTime = 2.68,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 3.68,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 14,
		},
		[21] = {
			IndexName = "machechengtu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(14.46,208.882,118.7685),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yanchen2",
			StartTime = 2.69,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 3.69,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 10,
		},
		[22] = {
			IndexName = "shuihua",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(13.47,208.99,120.8),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "shuihua4",
			StartTime = 2.7,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 3.7,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 18,
		},
		[23] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_swing_lag_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.8904989,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 4.3,
			Duration = 0.8904989,
			CurrentState = 5,
			Title = "a5(Clone)",
			EndTime = 5.190498,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 22,
		},
		[24] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_swing_lag_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.8904989,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 5.96,
			Duration = 0.8904989,
			CurrentState = 5,
			Title = "a6(Clone)",
			EndTime = 6.850499,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 20,
		},
		[25] = {
			IndexName = "qte_qilin",
			EffectType = "QTE",
			Position = Vector2(0,0),
			ObjectName = "qilin",
			StartTime = 6.999997,
			Duration = 0.1,
			CurrentState = 5,
			Title = "screen_words",
			EndTime = 7.099997,
			Type = "PlotDirector.PlotEventScreenWords",
			ParentId = 8,
		},
		[26] = {
			ObjectName = "xuanwo",
			Active = false,
			StartTime = 7.270001,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 8.27,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 11,
		},
		[27] = {
			IndexName = "shuihua",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(15.07,227.65,104.53),
			Rotation = Vector3(90,19.44808,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "shuihua5",
			StartTime = 7.270003,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)(clone)",
			EndTime = 8.270002,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 10,
		},
		[28] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "skill_qingyunmen_ack03_90005",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.475533,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 7.320002,
			Duration = 1.475533,
			CurrentState = 5,
			Title = "a7(Clone)",
			EndTime = 8.795534,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 21,
		},
		[29] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "vox_boss_shuiqilin_bellow_01",
			Looping = false,
			StartPlayPos = 3.018992,
			EndPlayPos = 6.412018,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 7.559999,
			Duration = 3.393026,
			CurrentState = 5,
			Title = "a8(Clone)",
			EndTime = 10.95302,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 22,
		},
		[30] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "vox_boss_shuiqilin_bellow_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 5.737732,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 8.870002,
			Duration = 5.737732,
			CurrentState = 5,
			Title = "a9(Clone)",
			EndTime = 14.60773,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 20,
		},
		[31] = {
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
					Position = Vector3(9.5,209.6,127.83),
					Rotation = Vector3(0,0,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(9.5,209.6,127.83),
					OutTangent = Vector3(9.5,209.6,127.83),
				},
				[2] = {
					NodeTime = 0.5,
					Position = Vector3(9.5,208.6,127.83),
					Rotation = Vector3(0,0,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(9.5,208.6,127.83),
					OutTangent = Vector3(9.5,208.6,127.83),
				},
			},
			StartTime = 9.369998,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 9.869998,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 6,
		},
		[32] = {
			IndexName = "machechengtu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(28.559,208.882,118.7685),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yanchen",
			StartTime = 10.06,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 11.06,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[33] = {
			ObjectName = "daoguang",
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
					Position = Vector3(27.47,209.801,117.668),
					Rotation = Vector3(22.01,0,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(27.47,209.801,117.668),
					OutTangent = Vector3(27.47,209.801,117.668),
				},
				[2] = {
					NodeTime = 0.5,
					Position = Vector3(8.037725,219.3212,110.2433),
					Rotation = Vector3(22.47202,7.284524,13.82134),
					LocalScale = Vector3(2,2,2),
					InTangent = Vector3(8.037725,219.3212,110.2433),
					OutTangent = Vector3(8.037725,219.3212,110.2433),
				},
			},
			StartTime = 13.1,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 13.6,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 6,
		},
		[34] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "skill_qingyunmen_ack02_90004",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.062971,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 13.4,
			Duration = 1.062971,
			CurrentState = 5,
			Title = "a10(Clone)",
			EndTime = 14.46297,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 21,
		},
		[35] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "skill_common_magic_shot_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.413515,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 13.49,
			Duration = 1.413515,
			CurrentState = 5,
			Title = "a11(Clone)",
			EndTime = 14.90351,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 22,
		},
		[36] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_common_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.5164853,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 13.52,
			Duration = 0.5164853,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 14.03648,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 23,
		},
		[37] = {
			IndexName = "liedi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(8.148,218.961,111.107),
			Rotation = Vector3(22.47202,7.284524,13.82134),
			LocalScale = Vector3(2,2,2),
			ObjectName = "dilie",
			StartTime = 13.59,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 14.59,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[38] = {
			IndexName = "liedi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(9.296,219.221,111.069),
			Rotation = Vector3(22.47202,7.284524,13.82134),
			LocalScale = Vector3(2,2,2),
			ObjectName = "dilie1",
			StartTime = 13.6,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 14.6,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 10,
		},
		[39] = {
			IndexName = "liedi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(12.63,221.7,107.08),
			Rotation = Vector3(22.47203,7.284525,13.82134),
			LocalScale = Vector3(2,2,2),
			ObjectName = "dilie3",
			StartTime = 13.6,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)(clone)",
			EndTime = 14.6,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 11,
		},
		[40] = {
			ObjectName = "daoguang",
			Active = false,
			StartTime = 13.6,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 14.6,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 6,
		},
		[41] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "vox_boss_shuiqilin_dead_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.328186,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 13.64,
			Duration = 2.328186,
			CurrentState = 5,
			Title = "a12(Clone)",
			EndTime = 15.96818,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 19,
		},
		[42] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_stone_sml_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.10551,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0,0,0),
					[2] = UnityEngine.Keyframe(0.08626813,0.4829546,0,0),
					[3] = UnityEngine.Keyframe(1,0.4829546,0,0),
				},
			},
			StartTime = 14.98,
			Duration = 1.10551,
			CurrentState = 5,
			Title = "a13(clone)",
			EndTime = 16.08551,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 20,
		},
		[43] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "vox_boss_shuiqilin_bellow_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.393026,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,1,0,0),
					[2] = UnityEngine.Keyframe(3.393026,0,0,0),
				},
			},
			StartTime = 17.79,
			Duration = 3.393026,
			CurrentState = 5,
			Title = "a14(Clone)",
			EndTime = 21.18303,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 21,
		},
		[44] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_magic_shot_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.842698,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 20.2273,
			Duration = 3.842698,
			CurrentState = 5,
			Title = "水麒麟飞行(Clone)",
			EndTime = 24.07,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 20,
		},
		[45] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_stone_sml_01",
			Looping = false,
			StartPlayPos = 0.094429,
			EndPlayPos = 1.10551,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0,0,0),
					[2] = UnityEngine.Keyframe(0.09211253,0.501894,0,0),
					[3] = UnityEngine.Keyframe(1.005844,0.501894,0,0),
				},
			},
			StartTime = 20.91999,
			Duration = 1.011081,
			CurrentState = 5,
			Title = "a15(clone)",
			EndTime = 21.93107,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 22,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene