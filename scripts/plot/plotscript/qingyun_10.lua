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
	Duration = 31,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "xiaohui",
		[2] = "xiaofanchengnian",
		[3] = "tianlinger",
		[4] = "shihun",
		[5] = "shehunchong",
		[6] = "zhuling",
	},
	Title = "qingyun_10",
	EndTime = 31,
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
					Position = Vector3(66.98949,19.87415,89.56599),
					Rotation = Vector3(15.33338,308.6412,-8.233167E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(66.98949,19.87415,89.56599),
					OutTangent = Vector3(66.98949,19.87415,89.56599),
				},
				[2] = {
					NodeTime = 0.5,
					Position = Vector3(66.98946,19.87414,89.56597),
					Rotation = Vector3(10.69242,287.671,-7.819734E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(66.98946,19.87414,89.56597),
					OutTangent = Vector3(66.98946,19.87414,89.56597),
				},
			},
			StartTime = 0,
			Duration = 0.5,
			CurrentState = 5,
			Title = "Path",
			EndTime = 0.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[2] = {
			AudioMode = "BackMusic",
			LoadMode = "Delay",
			IndexName = "bgm_activity_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 21.04,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0.7420455,0,0),
					[2] = UnityEngine.Keyframe(18.1461,0.7217783,0.0002980232,0.0002980232),
					[3] = UnityEngine.Keyframe(21.04,0,0,0),
				},
			},
			StartTime = 0,
			Duration = 21.04,
			CurrentState = 5,
			Title = "back_music",
			EndTime = 21.04,
			Type = "PlotDirector.PlotEventBackMusic",
			ParentId = 13,
		},
		[3] = {
			IndexName = "xiaofanchengnian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(67.59,15.3,82.9),
			Rotation = Vector3(0,301.5,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhangxiaofan",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 6,
		},
		[4] = {
			IndexName = "tianlinger",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(67.59,15.3,82.9),
			Rotation = Vector3(0,301.5,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "tianlinger",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 7,
		},
		[5] = {
			IndexName = "xiaohui",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(64.86467,16.03209,92.68247),
			Rotation = Vector3(0,293.25,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xiaohui",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[6] = {
			ObjectName = "zhangxiaofan/Object001",
			Active = false,
			StartTime = 0.1,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 8,
		},
		[7] = {
			ObjectName = "zhangxiaofan/fabao_shihun",
			Active = false,
			StartTime = 0.1,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 6,
		},
		[8] = {
			ObjectName = "xiaohui",
			IsLoop = true,
			StateName = "standfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.18,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 1.18,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[9] = {
			ObjectName = "xiaohui",
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
					Position = Vector3(64.58267,16.03209,93.23347),
					Rotation = Vector3(0,293.25,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(64.58267,16.03209,93.23347),
					OutTangent = Vector3(64.58267,16.03209,93.23347),
				},
				[2] = {
					NodeTime = 0.2,
					Position = Vector3(63.748,17.58,94.951),
					Rotation = Vector3(284.6,333.9914,3.725767E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(63.748,17.58,94.951),
					OutTangent = Vector3(63.748,17.58,94.951),
				},
			},
			StartTime = 0.2,
			Duration = 0.2,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 0.4,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 4,
		},
		[10] = {
			ObjectName = "xiaohui",
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
					Position = Vector3(63.748,17.58,94.951),
					Rotation = Vector3(284.6,333.9914,3.725767E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(63.748,17.58,94.951),
					OutTangent = Vector3(63.748,17.58,94.951),
				},
				[2] = {
					NodeTime = 0.3,
					Position = Vector3(57.0269,20.60375,89.43121),
					Rotation = Vector3(353.3001,170.3,19.90003),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(57.0269,20.60375,89.43121),
					OutTangent = Vector3(57.0269,20.60375,89.43121),
				},
			},
			StartTime = 0.55,
			Duration = 0.3,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 0.85,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 4,
		},
		[11] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "vox_monster_monkey_hit_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.1589569,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0.8799999,
			Duration = 0.1589569,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 1.038957,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[12] = {
			ObjectName = "xiaohui",
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
					Position = Vector3(57.0269,20.60375,89.43121),
					Rotation = Vector3(353.3001,170.3,19.90003),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(56.9449,20.54658,89.91091),
					OutTangent = Vector3(57.1089,20.66091,88.95152),
				},
				[2] = {
					NodeTime = 0.4,
					Position = Vector3(47.016,14.051,90.977),
					Rotation = Vector3(3.300009,0.6000001,0.0001417814),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(47.01739,16.35717,91.10996),
					OutTangent = Vector3(47.01461,11.74483,90.84403),
				},
			},
			StartTime = 1.02,
			Duration = 0.4,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 1.42,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 4,
		},
		[13] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "vox_monster_monkey_hit_03",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.1450794,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 1.21,
			Duration = 0.1450794,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 1.355079,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[14] = {
			ObjectName = "xiaohui",
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
					Position = Vector3(47.016,14.051,90.977),
					Rotation = Vector3(3.300009,0.6000001,0.0001417814),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(47.016,14.051,90.977),
					OutTangent = Vector3(47.016,14.051,90.977),
				},
				[2] = {
					NodeTime = 1.5,
					Position = Vector3(47.13,10.33,101.79),
					Rotation = Vector3(3.300009,0.6000001,0.0001417814),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(47.13,10.33,101.79),
					OutTangent = Vector3(47.13,10.33,101.79),
				},
			},
			StartTime = 1.42,
			Duration = 1.5,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 2.92,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 4,
		},
		[15] = {
			ObjectName = "xiaohui",
			IsLoop = true,
			StateName = "runfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 1.44,
			Duration = 2,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 3.44,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[16] = {
			IndexName = "zhuling",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(67.59,15.3,82.9),
			Rotation = Vector3(0,301.5,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhuling",
			StartTime = 1.67,
			Duration = 0.09000003,
			CurrentState = 5,
			Title = "object_create(Clone)",
			EndTime = 1.76,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 18,
		},
		[17] = {
			ObjectName = "tianlinger",
			IsLoop = false,
			StateName = "CG_summon",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 1.76,
			Duration = 7.033334,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 8.793334,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 17,
		},
		[18] = {
			ObjectName = "zhuling",
			IsLoop = false,
			StateName = "CG_summon",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 1.76,
			Duration = 6.633334,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 8.393333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 18,
		},
		[19] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "田灵儿：  在那！追！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 1.76,
			Duration = 2,
			CurrentState = 5,
			Title = "talk",
			EndTime = 3.76,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 10,
		},
		[20] = {
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
					Position = Vector3(64.59029,17.02242,83.59364),
					Rotation = Vector3(8.629772,101.1052,-7.599244E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(64.59029,17.02242,83.59364),
					OutTangent = Vector3(64.59029,17.02242,83.59364),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(64.5903,17.02242,83.5936),
					Rotation = Vector3(8.801661,107.1213,-7.429948E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(64.5903,17.02242,83.5936),
					OutTangent = Vector3(64.5903,17.02242,83.5936),
				},
			},
			StartTime = 1.76,
			Duration = 1,
			CurrentState = 5,
			Title = "Path",
			EndTime = 2.76,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[21] = {
			ObjectName = "zhangxiaofan",
			IsLoop = false,
			StateName = "CG_summon",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 1.76,
			Duration = 7.033334,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 8.793334,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 16,
		},
		[22] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_10_1",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.672222,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 1.76,
			Duration = 1.672222,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 3.432223,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 19,
		},
		[23] = {
			ObjectName = "tianlinger/shadow",
			Active = false,
			StartTime = 2.76,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 3.76,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 8,
		},
		[24] = {
			ObjectName = "zhangxiaofan/npc_zhangxiaofan_shadow",
			Active = false,
			StartTime = 2.78,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 3.78,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 11,
		},
		[25] = {
			ObjectName = "zhangxiaofan",
			ParentName = "zhuling",
			StartTime = 3.69,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Parent",
			EndTime = 4.69,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 6,
		},
		[26] = {
			ObjectName = "tianlinger",
			ParentName = "zhuling",
			StartTime = 3.7,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Parent",
			EndTime = 4.7,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 7,
		},
		[27] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_10_2",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.119493,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 4.719994,
			Duration = 1.119493,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 5.839487,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 19,
		},
		[28] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "田灵儿:  上来！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 4.719998,
			Duration = 1,
			CurrentState = 5,
			Title = "talk",
			EndTime = 5.719998,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 10,
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
					Position = Vector3(67.4308,17.10063,80.89122),
					Rotation = Vector3(23.06831,18.9432,-0.0001053253),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(67.4308,17.10063,80.89122),
					OutTangent = Vector3(67.4308,17.10063,80.89122),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(67.4308,17.10063,80.89122),
					Rotation = Vector3(8.973513,13.7867,-9.443055E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(67.4308,17.10063,80.89122),
					OutTangent = Vector3(67.4308,17.10063,80.89122),
				},
			},
			StartTime = 4.779998,
			Duration = 2,
			CurrentState = 5,
			Title = "Path",
			EndTime = 6.779998,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[30] = {
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
			StartTime = 5.859999,
			Duration = 3.650181,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 9.51018,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[31] = {
			ObjectName = "zhangxiaofan",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(67.59,15.903,82.9),
			Rotation = Vector3(0,301.5001,0),
			LocalScale = Vector3(1,1,1),
			StartTime = 6.95,
			Duration = 0.08999586,
			CurrentState = 5,
			Title = "object_transform(Clone)",
			EndTime = 7.039996,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 7,
		},
		[32] = {
			ObjectName = "tianlinger",
			IsLoop = false,
			StateName = "CG_fly",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 6.979997,
			Duration = 2.666667,
			CurrentState = 5,
			Title = "Animator Play(Clone)(Clone)",
			EndTime = 9.646664,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 11,
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
					Position = Vector3(67.4308,17.10063,80.89122),
					Rotation = Vector3(8.973513,13.7867,-9.443055E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(67.4308,17.10063,80.89122),
					OutTangent = Vector3(67.4308,17.10063,80.89122),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(67.55635,17.0884,81.00707),
					Rotation = Vector3(358.1447,312.079,-9.957018E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(67.55635,17.0884,81.00707),
					OutTangent = Vector3(67.55635,17.0884,81.00707),
				},
			},
			StartTime = 6.979997,
			Duration = 1,
			CurrentState = 5,
			Title = "Path",
			EndTime = 7.979997,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[34] = {
			ObjectName = "zhangxiaofan",
			IsLoop = false,
			StateName = "CG_fly",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 6.979997,
			Duration = 2.666667,
			CurrentState = 5,
			Title = "Animator Play(Clone)",
			EndTime = 9.646664,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[35] = {
			ObjectName = "zhuling",
			IsLoop = false,
			StateName = "fly",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 6.989999,
			Duration = 2.666667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 9.656666,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[36] = {
			ObjectName = "zhuling",
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
					Position = Vector3(67.59,15.3,82.9),
					Rotation = Vector3(0,301.5,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(67.59,15.3,82.9),
					OutTangent = Vector3(67.59,15.3,82.9),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(50.1557,23.707,93.58811),
					Rotation = Vector3(0,301.5,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(50.1557,23.707,93.58811),
					OutTangent = Vector3(50.1557,23.707,93.58811),
				},
			},
			StartTime = 7.039996,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Path(Clone)(Clone)",
			EndTime = 8.039995,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 7,
		},
		[37] = {
			ObjectName = "xiaohui",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(47.19,9.94,107.3),
			Rotation = Vector3(3.300037,75.57001,0.0001452757),
			LocalScale = Vector3(1,1,1),
			StartTime = 7.039998,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Transform(Clone)(Clone)",
			EndTime = 8.039997,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 6,
		},
		[38] = {
			ObjectName = "zhuling",
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
					Position = Vector3(40.81,23.70677,99.32),
					Rotation = Vector3(0,56.40001,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(39.40992,23.70677,101.4273),
					OutTangent = Vector3(42.21008,23.70677,97.21271),
				},
				[2] = {
					NodeTime = 7,
					Position = Vector3(73.39,23.70677,125.34),
					Rotation = Vector3(0,358.5,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(73.43482,23.70677,109.8759),
					OutTangent = Vector3(73.34518,23.70677,140.8041),
				},
			},
			StartTime = 8.079995,
			Duration = 7,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 15.08,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 7,
		},
		[39] = {
			ObjectName = "xiaohui",
			OnGround = true,
			OffSetY = 0.5,
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
					Position = Vector3(47.19,9.94,107.3),
					Rotation = Vector3(3.300037,75.57001,0.0001452757),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(44.23963,10.6458,98.22861),
					OutTangent = Vector3(50.14037,9.234201,116.3714),
				},
				[2] = {
					NodeTime = 6,
					Position = Vector3(71.43,7.82,129.48),
					Rotation = Vector3(3.300067,9.800002,0.0001490439),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(59.29574,8.125067,126.2064),
					OutTangent = Vector3(83.56426,7.514934,132.7536),
				},
			},
			StartTime = 8.079997,
			Duration = 6,
			CurrentState = 5,
			Title = "Object Path(Clone)",
			EndTime = 14.08,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 6,
		},
		[40] = {
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
					Position = Vector3(47.25406,9.794916,121.2629),
					Rotation = Vector3(335.6278,193.4087,-0.0001729323),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(47.25406,9.794916,121.2629),
					OutTangent = Vector3(47.25406,9.794916,121.2629),
				},
				[2] = {
					NodeTime = 6,
					Position = Vector3(46.61471,11.67396,144.7245),
					Rotation = Vector3(356.0824,119.8408,-0.0001484767),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(46.61471,11.67396,144.7245),
					OutTangent = Vector3(46.61471,11.67396,144.7245),
				},
			},
			StartTime = 8.079997,
			Duration = 6,
			CurrentState = 5,
			Title = "Path",
			EndTime = 14.08,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
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
					Position = Vector3(73.50539,27.67203,115.5146),
					Rotation = Vector3(20.49046,357.6288,-0.0001818608),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(73.50539,27.67203,115.5146),
					OutTangent = Vector3(73.50539,27.67203,115.5146),
				},
				[2] = {
					NodeTime = 3.5,
					Position = Vector3(69.57829,29.30671,131.6091),
					Rotation = Vector3(8.97397,342.5028,-0.000168657),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(69.57829,29.30671,131.6091),
					OutTangent = Vector3(69.57829,29.30671,131.6091),
				},
			},
			StartTime = 14.08,
			Duration = 3.5,
			CurrentState = 5,
			Title = "Path",
			EndTime = 17.58,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[42] = {
			ObjectName = "xiaohui",
			OnGround = true,
			OffSetY = 0.5,
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
					Position = Vector3(71.43,7.82,129.48),
					Rotation = Vector3(3.300067,9.800002,0.0001490439),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(69.67295,8.415224,119.3078),
					OutTangent = Vector3(73.18705,7.224776,139.6522),
				},
				[2] = {
					NodeTime = 5,
					Position = Vector3(65.82,6.31,156.56),
					Rotation = Vector3(3.300066,348.1,0.0001481887),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(68.94144,6.310008,157.2178),
					OutTangent = Vector3(62.69855,6.309992,155.9022),
				},
			},
			StartTime = 14.08,
			Duration = 5,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 19.08,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 6,
		},
		[43] = {
			ObjectName = "zhuling",
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
					Position = Vector3(73.39,23.70677,125.34),
					Rotation = Vector3(0,358.5,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(68.52167,23.70677,125.2125),
					OutTangent = Vector3(78.25833,23.70677,125.4675),
				},
				[2] = {
					NodeTime = 3.990005,
					Position = Vector3(56.68,23.70677,166.37),
					Rotation = Vector3(0,323.75,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(60.63158,23.70677,169.2674),
					OutTangent = Vector3(52.72842,23.70677,163.4726),
				},
			},
			StartTime = 15.08,
			Duration = 3.990005,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 19.07,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 7,
		},
		[44] = {
			IndexName = "shihun",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(45.92,1.95,168.53),
			Rotation = Vector3(0,179.33,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "shihun",
			StartTime = 15.27,
			Duration = 0.9199982,
			CurrentState = 5,
			Title = "shihunweizhi(Clone)",
			EndTime = 16.18999,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 12,
		},
		[45] = {
			ObjectName = "shihun",
			IsLoop = false,
			StateName = "CG_stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 16.18999,
			Duration = 2.666667,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 18.85666,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[46] = {
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
					Position = Vector3(18.81106,5.906553,155.3727),
					Rotation = Vector3(350.4101,55.89873,-0.0001701442),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(18.81106,5.906553,155.3727),
					OutTangent = Vector3(18.81106,5.906553,155.3727),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(18.81106,5.906553,155.3727),
					Rotation = Vector3(350.4101,55.89874,-0.0001701442),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(18.81106,5.906553,155.3727),
					OutTangent = Vector3(18.81106,5.906553,155.3727),
				},
			},
			StartTime = 17.58,
			Duration = 1.530003,
			CurrentState = 5,
			Title = "Path",
			EndTime = 19.11,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[47] = {
			IndexName = "shehunchong",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(46.05,1.98,159.57),
			Rotation = Vector3(270.1066,179.3303,0),
			LocalScale = Vector3(10,10,10),
			ObjectName = "shihunchong",
			StartTime = 17.58,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 18.58,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 12,
		},
		[48] = {
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
			StartTime = 17.8,
			Duration = 4.107914,
			CurrentState = 5,
			Title = "Back Sound",
			EndTime = 21.90791,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 15,
		},
		[49] = {
			ObjectName = "xiaohui",
			Active = false,
			StartTime = 18.83997,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Show Hide",
			EndTime = 19.83997,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 4,
		},
		[50] = {
			ObjectName = "zhangxiaofan",
			IsLoop = false,
			StateName = "CG_fall",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 19.07,
			Duration = 3.866667,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 22.93667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 7,
		},
		[51] = {
			ObjectName = "tianlinger",
			IsLoop = false,
			StateName = "CG_fall",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 19.07999,
			Duration = 6.2,
			CurrentState = 5,
			Title = "Animator Play(Clone)",
			EndTime = 25.27999,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
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
					Position = Vector3(52.72229,24.75115,165.0651),
					Rotation = Vector3(353.676,66.72765,-0.0001726591),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(52.72229,24.75115,165.0651),
					OutTangent = Vector3(52.72229,24.75115,165.0651),
				},
				[2] = {
					NodeTime = 1.5,
					Position = Vector3(52.72228,24.75115,165.0651),
					Rotation = Vector3(353.676,68.7903,-0.0001698674),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(52.72228,24.75115,165.0651),
					OutTangent = Vector3(52.72228,24.75115,165.0651),
				},
			},
			StartTime = 19.11,
			Duration = 1.5,
			CurrentState = 5,
			Title = "Path",
			EndTime = 20.61,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[53] = {
			AudioMode = "BackMusic",
			LoadMode = "Delay",
			IndexName = "bgm_cg_03",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 10.00447,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0.8339015,0,0),
					[2] = UnityEngine.Keyframe(7.118205,0.8299056,-0.01937151,-0.01937151),
					[3] = UnityEngine.Keyframe(10.00447,0,0,0),
				},
			},
			StartTime = 19.52,
			Duration = 10.00447,
			CurrentState = 5,
			Title = "back_music",
			EndTime = 29.52447,
			Type = "PlotDirector.PlotEventBackMusic",
			ParentId = 14,
		},
		[54] = {
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
					Position = Vector3(52.72228,24.75115,165.0651),
					Rotation = Vector3(353.676,68.7903,-0.0001698674),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(52.72228,24.75115,165.0651),
					OutTangent = Vector3(52.72228,24.75115,165.0651),
				},
				[2] = {
					NodeTime = 1.540003,
					Position = Vector3(52.81051,24.76163,165.0994),
					Rotation = Vector3(50.9146,71.02461,-0.000241042),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(52.81051,24.76163,165.0994),
					OutTangent = Vector3(52.81051,24.76163,165.0994),
				},
			},
			StartTime = 21.26,
			Duration = 1.540003,
			CurrentState = 5,
			Title = "Path",
			EndTime = 22.8,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[55] = {
			MaskName = "Back",
			Mode = "FadeIn",
			MaskValue = 1,
			MaskColor = Color(0,0,0,1),
			StartTime = 22.79,
			Duration = 1,
			CurrentState = 5,
			Title = "Mask",
			EndTime = 23.79,
			Type = "PlotDirector.PlotEventCameraMask",
			ParentId = 1,
		},
		[56] = {
			ObjectName = "zhangxiaofan",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(45.34,2.16,166.03),
			Rotation = Vector3(8.300004,294.5928,179.9999),
			LocalScale = Vector3(1,1,1),
			StartTime = 23.17,
			Duration = 0.429987,
			CurrentState = 5,
			Title = "object_transform",
			EndTime = 23.59999,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 11,
		},
		[57] = {
			ObjectName = "zhangxiaofan",
			IsLoop = true,
			StateName = "dead",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 23.59999,
			Duration = 0.1333334,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 23.73332,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 11,
		},
		[58] = {
			MaskName = "Back",
			Mode = "Keep",
			MaskValue = 1,
			MaskColor = Color(0,0,0,1),
			StartTime = 23.79,
			Duration = 1,
			CurrentState = 5,
			Title = "Mask",
			EndTime = 24.79,
			Type = "PlotDirector.PlotEventCameraMask",
			ParentId = 1,
		},
		[59] = {
			MaskName = "Back",
			Mode = "FadeOut",
			MaskValue = 1,
			MaskColor = Color(0,0,0,1),
			StartTime = 24.79,
			Duration = 1,
			CurrentState = 5,
			Title = "Mask",
			EndTime = 25.79,
			Type = "PlotDirector.PlotEventCameraMask",
			ParentId = 1,
		},
		[60] = {
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
					Position = Vector3(44.17498,3.730756,162.9481),
					Rotation = Vector3(14.30202,18.94284,-9.295403E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(44.17498,3.730756,162.9481),
					OutTangent = Vector3(44.17498,3.730756,162.9481),
				},
				[2] = {
					NodeTime = 2.160002,
					Position = Vector3(44.17499,3.730757,162.9481),
					Rotation = Vector3(13.95827,20.8339,-9.171406E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(44.17499,3.730757,162.9481),
					OutTangent = Vector3(44.17499,3.730757,162.9481),
				},
			},
			StartTime = 24.81,
			Duration = 2.160002,
			CurrentState = 5,
			Title = "Path",
			EndTime = 26.97,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[61] = {
			ObjectName = "shihun",
			Xallow = true,
			Yallow = true,
			Zallow = true,
			Amplify = Vector3(0.05,0.05,0.05),
			Omega = Vector3(100,100,100),
			Delay = Vector3(0,0,0),
			Beta = Vector3(0,0,0),
			Mode = "Line",
			StartTime = 24.84999,
			Duration = 2.049992,
			CurrentState = 5,
			Title = "Object Shock",
			EndTime = 26.89998,
			Type = "PlotDirector.PlotEventObjectShock",
			ParentId = 4,
		},
		[62] = {
			ObjectName = "shihunchong",
			Active = false,
			StartTime = 25.09,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Show Hide",
			EndTime = 26.09,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 11,
		},
		[63] = {
			ObjectName = "xiaohui",
			OnGround = true,
			OffSetY = 0.5,
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
					Position = Vector3(65.84058,1.916726,156.5642),
					Rotation = Vector3(3.300066,348.177,0.0001481887),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(62.31448,2.246562,149.9816),
					OutTangent = Vector3(69.36669,1.58689,163.1468),
				},
				[2] = {
					NodeTime = 4,
					Position = Vector3(60.5,1.01,170.98),
					Rotation = Vector3(3.300072,317.1,0.0001488034),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(65.10877,1.247751,169.6342),
					OutTangent = Vector3(55.89123,0.772249,172.3258),
				},
			},
			StartTime = 25.18,
			Duration = 4,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 29.18,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 6,
		},
		[64] = {
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
					Position = Vector3(44.17499,3.730757,162.9481),
					Rotation = Vector3(13.95827,20.8339,-9.171406E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(44.17499,3.730757,162.9481),
					OutTangent = Vector3(44.17499,3.730757,162.9481),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(45.42455,5.065695,159.3092),
					Rotation = Vector3(20.14621,358.3167,-9.554536E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(45.42455,5.065695,159.3092),
					OutTangent = Vector3(45.42455,5.065695,159.3092),
				},
			},
			StartTime = 26.97,
			Duration = 2,
			CurrentState = 5,
			Title = "Path",
			EndTime = 28.97,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene