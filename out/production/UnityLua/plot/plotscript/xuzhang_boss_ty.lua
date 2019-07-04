local Plot = require("plot.plot")

PlotCutscene = {
	PlayRate = 1,
	config = {
		isLooping = false,
		isSkippable = false,
		independentMusic = false,
		hideUI = true,
		hideCharacter = true,
		showBorder = false,
		showCurtain = true,
		fadeInOutTime = 0.7,
		mainCameraControl = true,
		previewMode = true,
	},
	StartTime = 0,
	Duration = 24.5,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "shuiqilin",
		[2] = "qilinshe",
		[3] = "tydg",
		[4] = "dimianbaodian",
		[5] = "machechengtu",
		[6] = "tyxl",
		[7] = "shuihua",
		[8] = "tycc",
		[9] = "xuanwo",
		[10] = "MainCharacter",
	},
	Title = "xuzhang_boss_ty",
	EndTime = 24.5,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "tyxl",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(8.84,209.4,122.83),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "gwxuli",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
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
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0,
			Duration = 3.322109,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 3.322109,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 22,
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
			IsLoop = true,
			StateName = "CG_QTE",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.1966645,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 1.196664,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 2,
		},
		[8] = {
			ObjectName = "zhujue",
			IsLoop = true,
			StateName = "CG_QTE",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.2,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 1.2,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 3,
		},
		[9] = {
			ObjectName = "qilinshe",
			IsLoop = true,
			StateName = "QTE",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.2,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 1.2,
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
			StartTime = 1.67,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 2.67,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 15,
		},
		[11] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_swing_lag_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.7898866,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 2.23,
			Duration = 0.7898866,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 3.019887,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 19,
		},
		[12] = {
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
			StartTime = 2.33,
			Duration = 1.670635,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 4.000635,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 20,
		},
		[13] = {
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
			StartTime = 2.66,
			Duration = 2.595737,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 5.255737,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 21,
		},
		[14] = {
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
		[15] = {
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
		[16] = {
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
		[17] = {
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
		[18] = {
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
		[19] = {
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
		[22] = {
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
		[23] = {
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
		[24] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_swing_water_lag_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.9,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 2.77,
			Duration = 1,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 3.77,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 23,
		},
		[25] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_swing_lag_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.7898866,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 4.230001,
			Duration = 0.7898866,
			CurrentState = 5,
			Title = "back_sound(Clone)",
			EndTime = 5.019888,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 19,
		},
		[26] = {
			ObjectName = "zhujue",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(9.5,210.35,127.83),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			StartTime = 4.669995,
			Duration = 0.7000046,
			CurrentState = 5,
			Title = "object_transform",
			EndTime = 5.37,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 6,
		},
		[27] = {
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
					Position = Vector3(9.5,210.35,127.83),
					Rotation = Vector3(0,0,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(9.5,210.35,127.83),
					OutTangent = Vector3(9.5,210.35,127.83),
				},
				[2] = {
					NodeTime = 0.6100011,
					Position = Vector3(10.31,210.7,127.3),
					Rotation = Vector3(0,0,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(10.31,210.7,127.3),
					OutTangent = Vector3(10.31,210.7,127.3),
				},
			},
			StartTime = 5.439999,
			Duration = 0.6100011,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 6.05,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 6,
		},
		[28] = {
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
					Position = Vector3(10.31,210.7,127.3),
					Rotation = Vector3(0,0,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(10.31,210.7,127.3),
					OutTangent = Vector3(10.31,210.7,127.3),
				},
				[2] = {
					NodeTime = 0.9399996,
					Position = Vector3(12.3,213.9,125.07),
					Rotation = Vector3(0,0,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(12.3,213.9,125.07),
					OutTangent = Vector3(12.3,213.9,125.07),
				},
			},
			StartTime = 6.05,
			Duration = 0.9199996,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 6.97,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 6,
		},
		[29] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_swing_lag_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.7898866,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 6.090002,
			Duration = 0.7898866,
			CurrentState = 5,
			Title = "back_sound(Clone)",
			EndTime = 6.879888,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 19,
		},
		[30] = {
			IndexName = "qte_qilin",
			EffectType = "QTE",
			Position = Vector2(0,0),
			ObjectName = "qilin",
			StartTime = 7,
			Duration = 0.1,
			CurrentState = 5,
			Title = "qte(clone)",
			EndTime = 7.1,
			Type = "PlotDirector.PlotEventScreenWords",
			ParentId = 8,
		},
		[31] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "skill_guiwangzong_skl03_91008",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.660771,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 7.080003,
			Duration = 2.660771,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 9.740774,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 20,
		},
		[32] = {
			IndexName = "tycc",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(16.84,226.95,109.52),
			Rotation = Vector3(345.7853,199.4482,180.0001),
			LocalScale = Vector3(1,1,1),
			ObjectName = "qingyunfei",
			StartTime = 7.100002,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 8.100002,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 12,
		},
		[33] = {
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
		[34] = {
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
		[35] = {
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
					Position = Vector3(12.29734,213.8957,125.073),
					Rotation = Vector3(0,0,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(12.29734,213.8957,125.073),
					OutTangent = Vector3(12.29734,213.8957,125.073),
				},
				[2] = {
					NodeTime = 2.350002,
					Position = Vector3(12.29734,209,125.073),
					Rotation = Vector3(0,0,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(12.29734,209,125.073),
					OutTangent = Vector3(12.29734,209,125.073),
				},
			},
			StartTime = 7.739998,
			Duration = 2.350002,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 10.09,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 6,
		},
		[36] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "vox_boss_shuiqilin_bellow_01",
			Looping = false,
			StartPlayPos = 3.165935,
			EndPlayPos = 6.412018,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 8.070003,
			Duration = 3.246084,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 11.31609,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 21,
		},
		[37] = {
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
			StartTime = 9.52,
			Duration = 5.737732,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 15.25773,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 19,
		},
		[38] = {
			IndexName = "machechengtu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(28.559,208.882,118.7685),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yancheng",
			StartTime = 10.06,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 11.06,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[39] = {
			IndexName = "qte_qilin",
			EffectType = "QTE",
			Position = Vector2(0,0),
			ObjectName = "qilin22",
			StartTime = 12.9,
			Duration = 0.1,
			CurrentState = 5,
			Title = "screen_words",
			EndTime = 13,
			Type = "PlotDirector.PlotEventScreenWords",
			ParentId = 8,
		},
		[40] = {
			IndexName = "tydg",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(27.47,209.801,117.668),
			Rotation = Vector3(22.01,0,0),
			LocalScale = Vector3(0.3,0.3,0.3),
			ObjectName = "daoguang",
			StartTime = 13.13,
			Duration = 0.1500006,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 13.28,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 6,
		},
		[41] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "skill_guiwangzong_skl05_91010",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.432653,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 13.25,
			Duration = 2.432653,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 15.68265,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 20,
		},
		[42] = {
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
					Rotation = Vector3(340.2482,280.5061,358.5983),
					LocalScale = Vector3(0.3,0.3,0.3),
					InTangent = Vector3(34.05103,207.5329,115.8412),
					OutTangent = Vector3(20.88897,212.0691,119.4948),
				},
				[2] = {
					NodeTime = 0.4,
					Position = Vector3(8.037725,219.3212,110.2433),
					Rotation = Vector3(339.2962,207.2226,13.10269),
					LocalScale = Vector3(4,4,4),
					InTangent = Vector3(11.3676,216.711,115.8844),
					OutTangent = Vector3(4.707854,221.9313,104.6021),
				},
			},
			StartTime = 13.28,
			Duration = 0.4,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 13.68,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 6,
		},
		[43] = {
			IndexName = "dimianbaodian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(8.12,219,110.41),
			Rotation = Vector3(76.86769,105.9471,103.6816),
			LocalScale = Vector3(2,2,2),
			ObjectName = "dilie",
			StartTime = 13.67,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 14.67,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[44] = {
			IndexName = "dimianbaodian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(9.26,219.22,110.01),
			Rotation = Vector3(77.24575,91.2075,89.31252),
			LocalScale = Vector3(2,2,2),
			ObjectName = "dilie1",
			StartTime = 13.67999,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 14.67999,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 10,
		},
		[45] = {
			IndexName = "dimianbaodian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(12.57,221.73,105.79),
			Rotation = Vector3(77.1877,86.32234,84.54829),
			LocalScale = Vector3(2,2,2),
			ObjectName = "dilie3",
			StartTime = 13.68,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)(clone)",
			EndTime = 14.68,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 11,
		},
		[46] = {
			ObjectName = "daoguang",
			Active = false,
			StartTime = 13.68,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 14.68,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 6,
		},
		[47] = {
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
			StartTime = 14.14001,
			Duration = 2.328186,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 16.46819,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 21,
		},
		[48] = {
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
					[2] = UnityEngine.Keyframe(0.1427152,1,0,0),
					[3] = UnityEngine.Keyframe(1,1,0,0),
				},
			},
			StartTime = 15.14,
			Duration = 1.10551,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 16.24551,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 23,
		},
		[49] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "footsteps_mount_04",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.4867574,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 15.35,
			Duration = 0.4867574,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 15.83676,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 22,
		},
		[50] = {
			IndexName = "machechengtu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(7.77,208.882,114.72),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yancheng2",
			StartTime = 15.39,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)(clone)(clone)",
			EndTime = 16.39,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 11,
		},
		[51] = {
			IndexName = "machechengtu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(7,208.8987,119.3),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yancheng1",
			StartTime = 15.39,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)(clone)",
			EndTime = 16.39,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 10,
		},
		[52] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "vox_boss_shuiqilin_bellow_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.246083,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,1,0,0),
					[2] = UnityEngine.Keyframe(3.246083,0.09469706,0,0),
				},
			},
			StartTime = 16.24,
			Duration = 3.246083,
			CurrentState = 5,
			Title = "back_sound(clone)",
			EndTime = 19.48608,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 20,
		},
		[53] = {
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
			StartTime = 20.51,
			Duration = 3.842698,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 24.3527,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 21,
		},
		[54] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_stone_sml_02",
			Looping = false,
			StartPlayPos = 0.03047764,
			EndPlayPos = 1.125329,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0,0,0),
					[2] = UnityEngine.Keyframe(0.1895678,0.4431819,0,0),
					[3] = UnityEngine.Keyframe(0.9915618,0.4431819,0,0),
				},
			},
			StartTime = 20.95,
			Duration = 1.094851,
			CurrentState = 5,
			Title = "back_sound(clone)",
			EndTime = 22.04485,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 23,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene