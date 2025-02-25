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
		[3] = "gwjly",
		[4] = "gwjle",
		[5] = "machechengtu",
		[6] = "gwxuli",
		[7] = "shuihua",
		[8] = "gwfei",
		[9] = "xuanwo",
		[10] = "MainCharacter",
	},
	Title = "xuzhang_boss_gw",
	EndTime = 24.5,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "gwxuli",
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
			IsLoop = false,
			StateName = "CG_QTE",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.1966645,
			Duration = 24.23334,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 24.43,
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
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0.3900001,
			Duration = 1,
			CurrentState = 5,
			Title = "Back Sound",
			EndTime = 1.39,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 19,
		},
		[11] = {
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
		[12] = {
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
		[13] = {
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
		[14] = {
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
		[15] = {
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
		[16] = {
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
		[17] = {
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
		[18] = {
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
		[19] = {
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
		[20] = {
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
		[21] = {
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
		[22] = {
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
		[23] = {
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
		[24] = {
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
		[25] = {
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
		[26] = {
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
		[27] = {
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
		[28] = {
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
			StartTime = 6.440001,
			Duration = 2.660771,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 9.100772,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 20,
		},
		[29] = {
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
		[30] = {
			IndexName = "gwfei",
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
		[31] = {
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
			StartTime = 7.22,
			Duration = 3.246084,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 10.46608,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 21,
		},
		[32] = {
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
		[33] = {
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
		[34] = {
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
		[35] = {
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
		[36] = {
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
		[37] = {
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
		[38] = {
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
			StartTime = 13.09,
			Duration = 2.432653,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 15.52265,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 20,
		},
		[39] = {
			IndexName = "gwjly",
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
		[40] = {
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
					Rotation = Vector3(22.01,9.208895E-07,337.8007),
					LocalScale = Vector3(0.3,0.3,0.3),
					InTangent = Vector3(35.48314,206.5938,117.8277),
					OutTangent = Vector3(19.45686,213.0082,117.5083),
				},
				[2] = {
					NodeTime = 0.4,
					Position = Vector3(8.037725,219.3212,110.2433),
					Rotation = Vector3(336.2685,226.8816,5.603416),
					LocalScale = Vector3(4,4,4),
					InTangent = Vector3(11.86387,216.8388,115.8118),
					OutTangent = Vector3(4.211578,221.8035,104.6747),
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
		[41] = {
			IndexName = "gwjle",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(8.148,218.961,111.107),
			Rotation = Vector3(22.47202,7.284524,13.82134),
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
		[42] = {
			IndexName = "gwjle",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(9.296,219.221,111.069),
			Rotation = Vector3(22.47202,7.284524,13.82134),
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
		[43] = {
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
		[44] = {
			IndexName = "gwjle",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(12.63,221.7,107.08),
			Rotation = Vector3(22.47203,7.284525,13.82134),
			LocalScale = Vector3(2,2,2),
			ObjectName = "dilie3",
			StartTime = 13.69,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)(clone)",
			EndTime = 14.69,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 11,
		},
		[45] = {
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
			StartTime = 13.82,
			Duration = 2.328186,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 16.14819,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 21,
		},
		[46] = {
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
		[47] = {
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
		[48] = {
			IndexName = "machechengtu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(7,208.8987,119.3),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yanchen1",
			StartTime = 15.39,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)(clone)",
			EndTime = 16.39,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 10,
		},
		[49] = {
			IndexName = "machechengtu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(7.77,208.882,114.72),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yanchen2",
			StartTime = 15.39,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)(clone)(clone)",
			EndTime = 16.39,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 11,
		},
		[50] = {
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
		[51] = {
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
		[52] = {
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