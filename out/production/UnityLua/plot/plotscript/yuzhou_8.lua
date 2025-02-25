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
	Duration = 72,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "weiqiong",
		[2] = "lixun",
		[3] = "qinwuyan",
		[4] = "xiaofanchengnian",
		[5] = "zengshushu",
		[6] = "MainCharacter",
	},
	Title = "yuzhou_8",
	EndTime = 72,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "MainCharacter",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(154.63,28.38,397.43),
			Rotation = Vector3(0,358.8002,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhujiao",
			StartTime = 0,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_special",
			EndTime = 0.5,
			Type = "PlotDirector.PlotEventObjectSpecialCreate",
			ParentId = 6,
		},
		[2] = {
			IndexName = "zengshushu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(153.38,28.43,397.75),
			Rotation = Vector3(0,358.8002,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zengshushu",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
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
					Position = Vector3(142.572,31.6745,400.8017),
					Rotation = Vector3(9.041034,92.40747,5.187087E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(142.572,31.6745,400.8017),
					OutTangent = Vector3(142.572,31.6745,400.8017),
				},
				[2] = {
					NodeTime = 4,
					Position = Vector3(143.9968,31.44759,400.7418),
					Rotation = Vector3(9.041034,92.40747,5.187087E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(143.9968,31.44759,400.7418),
					OutTangent = Vector3(143.9968,31.44759,400.7418),
				},
			},
			StartTime = 0,
			Duration = 4,
			CurrentState = 5,
			Title = "path",
			EndTime = 4,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 3,
		},
		[4] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "曾书书：  外公，你不是生病了吗？送信上青云那会儿，把我娘给吓得不轻，现在又好了？",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 0,
			Duration = 7.5,
			CurrentState = 5,
			Title = "talk",
			EndTime = 7.5,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 14,
		},
		[5] = {
			IndexName = "lixun",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(156.6431,28.45715,403.2582),
			Rotation = Vector3(0,194.0418,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "lixun",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[6] = {
			IndexName = "weiqiong",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(154.89,28.45715,402.2651),
			Rotation = Vector3(0,177.6607,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "weiqiong",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 2,
		},
		[7] = {
			IndexName = "xiaofanchengnian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(155.67,28.49,397.63),
			Rotation = Vector3(0,358.8002,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhangxiaofan",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 7,
		},
		[8] = {
			IndexName = "qinwuyan",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(153.1155,28.45715,402.986),
			Rotation = Vector3(0,169.1537,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "qinwuyan",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 5,
		},
		[9] = {
			ObjectName = "zengshushu",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.44,
			Duration = 2,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 2.44,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[10] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_8_1",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 6.241088,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0.7099998,
			Duration = 6.241088,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 6.951088,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[11] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_ling",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.393492,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.359991,
			Duration = 2.393492,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 5.753483,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 16,
		},
		[12] = {
			ObjectName = "zengshushu",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 4.890003,
			Duration = 2,
			CurrentState = 5,
			Title = "animator_play(Clone)",
			EndTime = 6.890003,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[13] = {
			ObjectName = "weiqiong",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 7.499996,
			Duration = 2.5,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 9.999996,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[14] = {
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
					Position = Vector3(154.9694,30.54073,399.165),
					Rotation = Vector3(11.03669,0.410856,-7.490326E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(154.9694,30.54073,399.165),
					OutTangent = Vector3(154.9694,30.54073,399.165),
				},
				[2] = {
					NodeTime = 3,
					Position = Vector3(154.9749,30.39189,399.9281),
					Rotation = Vector3(11.03669,0.410856,-7.490326E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(154.9749,30.39189,399.9281),
					OutTangent = Vector3(154.9749,30.39189,399.9281),
				},
			},
			StartTime = 7.5,
			Duration = 3,
			CurrentState = 5,
			Title = "Path",
			EndTime = 10.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 3,
		},
		[15] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "卫琼：  你看外公像生病了吗？",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 7.5,
			Duration = 2.549999,
			CurrentState = 5,
			Title = "talk",
			EndTime = 10.05,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 14,
		},
		[16] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_8_2",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.562131,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 7.501068,
			Duration = 2.562131,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 10.0632,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[17] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_8_3",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.923401,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 10.49999,
			Duration = 1.923401,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 12.4234,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
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
					Position = Vector3(153.1839,30.2824,399.5813),
					Rotation = Vector3(7.770874,173.6733,-7.467053E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(153.1839,30.2824,399.5813),
					OutTangent = Vector3(153.1839,30.2824,399.5813),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(153.2582,30.19032,398.9107),
					Rotation = Vector3(7.770874,173.6733,-7.467053E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(153.2582,30.19032,398.9107),
					OutTangent = Vector3(153.2582,30.19032,398.9107),
				},
			},
			StartTime = 10.5,
			Duration = 2,
			CurrentState = 5,
			Title = "Path",
			EndTime = 12.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 3,
		},
		[19] = {
			ObjectName = "zengshushu",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 10.5,
			Duration = 2,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 12.5,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[20] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "曾书书：  原来是逗我们玩啊！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 10.5,
			Duration = 2,
			CurrentState = 5,
			Title = "talk",
			EndTime = 12.5,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 14,
		},
		[21] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_8_4",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 8.574409,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 12.49999,
			Duration = 8.574409,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 21.0744,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[22] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "卫琼：  我不装病，你们能回来看我？你大姨嫁到焚香谷，你娘嫁到青云门，多少年没回来了！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 12.5,
			Duration = 8.469999,
			CurrentState = 5,
			Title = "talk",
			EndTime = 20.97,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 14,
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
					Position = Vector3(150.1879,30.511,400.752),
					Rotation = Vector3(15.84958,91.51118,-7.63263E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(150.1879,30.511,400.752),
					OutTangent = Vector3(150.1879,30.511,400.752),
				},
				[2] = {
					NodeTime = 6,
					Position = Vector3(149.3022,30.76255,400.7754),
					Rotation = Vector3(15.84958,91.51118,-7.63263E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(149.3022,30.76255,400.7754),
					OutTangent = Vector3(149.3022,30.76255,400.7754),
				},
			},
			StartTime = 12.5,
			Duration = 6,
			CurrentState = 5,
			Title = "Path",
			EndTime = 18.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 3,
		},
		[24] = {
			ObjectName = "weiqiong",
			IsLoop = true,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 12.54,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 13.54,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[25] = {
			ObjectName = "weiqiong",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 15.04,
			Duration = 2.5,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 17.54,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[26] = {
			ObjectName = "weiqiong",
			SpeedValue = 0.5,
			Curve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 15.07,
			Duration = 3,
			CurrentState = 2,
			Mode = "Event",
			Title = "animator_speed",
			EndTime = 18.07,
			Type = "PlotDirector.PlotEventAnimatorSpeed",
			ParentId = 11,
		},
		[27] = {
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
					Position = Vector3(154.435,30.29278,400.6665),
					Rotation = Vector3(8.458421,175.736,-7.145366E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(154.435,30.29278,400.6665),
					OutTangent = Vector3(154.435,30.29278,400.6665),
				},
				[2] = {
					NodeTime = 3,
					Position = Vector3(154.4895,30.18373,399.9352),
					Rotation = Vector3(8.458421,175.736,-7.145366E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(154.4895,30.18373,399.9352),
					OutTangent = Vector3(154.4895,30.18373,399.9352),
				},
			},
			StartTime = 18.5,
			Duration = 3,
			CurrentState = 5,
			Title = "Path",
			EndTime = 21.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 3,
		},
		[28] = {
			ObjectName = "zhujiao",
			IsLoop = false,
			StateName = "CG_scratch",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 18.62,
			Duration = 2.533334,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 21.15333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[29] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "卫琼：  罢了罢了，还不快见过你表哥。",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 21.5,
			Duration = 3,
			CurrentState = 5,
			Title = "talk",
			EndTime = 24.5,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 14,
		},
		[30] = {
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
					Position = Vector3(153.8457,30.38623,396.9026),
					Rotation = Vector3(8.286545,11.82334,-7.317465E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(153.8457,30.38623,396.9026),
					OutTangent = Vector3(153.8457,30.38623,396.9026),
				},
				[2] = {
					NodeTime = 3,
					Position = Vector3(154.0139,30.26671,397.7058),
					Rotation = Vector3(8.286545,11.82334,-7.317465E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(154.0139,30.26671,397.7058),
					OutTangent = Vector3(154.0139,30.26671,397.7058),
				},
			},
			StartTime = 21.5,
			Duration = 3,
			CurrentState = 5,
			Title = "Path",
			EndTime = 24.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 3,
		},
		[31] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_8_5",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.997149,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 21.50003,
			Duration = 2.997149,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 24.49718,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[32] = {
			ObjectName = "weiqiong",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 21.52,
			Duration = 2.5,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 24.02,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[33] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_8_6",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 6.149116,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 24.49718,
			Duration = 6.149116,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 30.6463,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[34] = {
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
					Position = Vector3(153.5154,30.19628,398.5244),
					Rotation = Vector3(5.192601,190.6541,-7.485229E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(153.5154,30.19628,398.5244),
					OutTangent = Vector3(153.5154,30.19628,398.5244),
				},
				[2] = {
					NodeTime = 6,
					Position = Vector3(153.5706,30.22343,398.818),
					Rotation = Vector3(5.192601,190.6541,-7.485229E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(153.5706,30.22343,398.818),
					OutTangent = Vector3(153.5706,30.22343,398.818),
				},
			},
			StartTime = 24.5,
			Duration = 6,
			CurrentState = 5,
			Title = "path",
			EndTime = 30.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 3,
		},
		[35] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "曾书书：  表哥啊，十年前焚香谷被你不小心烧了的房子，现在补起来了吗？",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 24.5,
			Duration = 6.15,
			CurrentState = 5,
			Title = "talk",
			EndTime = 30.65,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 14,
		},
		[36] = {
			ObjectName = "zengshushu",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 25.78001,
			Duration = 2,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 27.78001,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[37] = {
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
					Position = Vector3(156.3044,30.30482,401.8832),
					Rotation = Vector3(6.052021,13.61007,-7.743127E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(156.3044,30.30482,401.8832),
					OutTangent = Vector3(156.3044,30.30482,401.8832),
				},
				[2] = {
					NodeTime = 6.5,
					Position = Vector3(156.3746,30.27319,402.1732),
					Rotation = Vector3(6.052021,13.61007,-7.743127E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(156.3746,30.27319,402.1732),
					OutTangent = Vector3(156.3746,30.27319,402.1732),
				},
			},
			StartTime = 30.5,
			Duration = 6.5,
			CurrentState = 5,
			Title = "path",
			EndTime = 37,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 3,
		},
		[38] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_8_7",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 6.299252,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 30.6463,
			Duration = 6.299252,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 36.94555,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[39] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "李洵：  你表哥我可是唯一会八荒火龙阵的弟子，倒是你，仙术有没有长进啊？",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 30.65,
			Duration = 6.320002,
			CurrentState = 5,
			Title = "talk",
			EndTime = 36.97,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 14,
		},
		[40] = {
			ObjectName = "lixun",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 30.69001,
			Duration = 2.033334,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 32.72334,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[41] = {
			ObjectName = "lixun",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 32.72334,
			Duration = 2.033334,
			CurrentState = 5,
			Title = "animator_play(Clone)",
			EndTime = 34.75668,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[42] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_8_8",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 5.228887,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 36.94555,
			Duration = 5.228887,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 42.17443,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[43] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "卫琼：  小时候来渝都，做的机关可是把外公房子给炸了半间。",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 36.97,
			Duration = 5.189999,
			CurrentState = 5,
			Title = "talk",
			EndTime = 42.16,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 14,
		},
		[44] = {
			ObjectName = "weiqiong",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 36.97001,
			Duration = 2.5,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 39.47001,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[45] = {
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
					Position = Vector3(149.5234,31.29341,400.5718),
					Rotation = Vector3(19.80303,92.33451,-7.985444E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(149.5234,31.29341,400.5718),
					OutTangent = Vector3(149.5234,31.29341,400.5718),
				},
				[2] = {
					NodeTime = 12,
					Position = Vector3(149.8227,31.18557,400.5596),
					Rotation = Vector3(19.80303,92.33451,-7.985444E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(149.8227,31.18557,400.5596),
					OutTangent = Vector3(149.8227,31.18557,400.5596),
				},
			},
			StartTime = 37,
			Duration = 12,
			CurrentState = 5,
			Title = "path",
			EndTime = 49,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 3,
		},
		[46] = {
			ObjectName = "weiqiong",
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
					Position = Vector3(154.89,28.45715,402.2651),
					Rotation = Vector3(0,177.6607,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(154.89,28.45715,402.2651),
					OutTangent = Vector3(154.89,28.45715,402.2651),
				},
				[2] = {
					NodeTime = 0.4,
					Position = Vector3(154.89,28.45715,402.2651),
					Rotation = Vector3(0,75.98093,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(154.89,28.45715,402.2651),
					OutTangent = Vector3(154.89,28.45715,402.2651),
				},
			},
			StartTime = 42,
			Duration = 0.4,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 42.40001,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 11,
		},
		[47] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "卫琼：  你也好不到哪去，拿着你们云谷主的玄火鉴，被里面的火龙吓得尿裤子，忘了？",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 42.16,
			Duration = 6.869999,
			CurrentState = 5,
			Title = "talk",
			EndTime = 49.03,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 14,
		},
		[48] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_8_9",
			Looping = false,
			StartPlayPos = 0.669876,
			EndPlayPos = 7.540398,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 42.17443,
			Duration = 6.870522,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 49.04496,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[49] = {
			ObjectName = "weiqiong",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 42.42998,
			Duration = 2.5,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 44.92998,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[50] = {
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
					Position = Vector3(154.9469,30.48364,401.183),
					Rotation = Vector3(25.54232,1.239087,-1.102977E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(154.9469,30.48364,401.183),
					OutTangent = Vector3(154.9469,30.48364,401.183),
				},
				[2] = {
					NodeTime = 5,
					Position = Vector3(154.9294,30.8717,400.3711),
					Rotation = Vector3(25.54232,1.239087,-1.102977E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(154.9294,30.8717,400.3711),
					OutTangent = Vector3(154.9294,30.8717,400.3711),
				},
			},
			StartTime = 49,
			Duration = 8,
			CurrentState = 5,
			Title = "path",
			EndTime = 57,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 3,
		},
		[51] = {
			ObjectName = "weiqiong",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 49.00001,
			Duration = 2.5,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 51.50001,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[52] = {
			ObjectName = "weiqiong",
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
					Position = Vector3(154.89,28.45715,402.2651),
					Rotation = Vector3(0,75.98093,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(154.89,28.45715,402.2651),
					OutTangent = Vector3(154.89,28.45715,402.2651),
				},
				[2] = {
					NodeTime = 0.5,
					Position = Vector3(154.89,28.45715,402.2651),
					Rotation = Vector3(0,177.6607,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(154.89,28.45715,402.2651),
					OutTangent = Vector3(154.89,28.45715,402.2651),
				},
			},
			StartTime = 49.01998,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 49.51998,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 11,
		},
		[53] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "卫琼：  如今一眨眼，你们都长大了，外公也老了，再过个几年，也就……",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 49.03,
			Duration = 8.27,
			CurrentState = 5,
			Title = "talk",
			EndTime = 57.3,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 14,
		},
		[54] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_8_10",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 8.276485,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 49.04496,
			Duration = 8.276485,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 57.32145,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[55] = {
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
					Position = Vector3(153.5474,30.17419,399.7596),
					Rotation = Vector3(4.67695,188.0758,-7.238489E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(153.5474,30.17419,399.7596),
					OutTangent = Vector3(153.5474,30.17419,399.7596),
				},
				[2] = {
					NodeTime = 3,
					Position = Vector3(153.5054,30.14973,399.4636),
					Rotation = Vector3(4.67695,188.0758,-7.238489E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(153.5054,30.14973,399.4636),
					OutTangent = Vector3(153.5054,30.14973,399.4636),
				},
			},
			StartTime = 57,
			Duration = 3,
			CurrentState = 5,
			Title = "Path",
			EndTime = 60,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 3,
		},
		[56] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "曾书书：没有没有，外公您还是很健壮的。",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 57.37007,
			Duration = 2.929928,
			CurrentState = 5,
			Title = "Talk",
			EndTime = 60.3,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 14,
		},
		[57] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_8_11",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.912222,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 57.38997,
			Duration = 2.912222,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 60.3022,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[58] = {
			ObjectName = "zengshushu",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 57.39335,
			Duration = 2,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 59.39335,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[59] = {
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
					Position = Vector3(150.1626,31.33235,400.7741),
					Rotation = Vector3(22.72513,91.47504,-8.700936E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(150.1626,31.33235,400.7741),
					OutTangent = Vector3(150.1626,31.33235,400.7741),
				},
				[2] = {
					NodeTime = 7,
					Position = Vector3(149.0561,31.79592,400.8026),
					Rotation = Vector3(22.72513,91.47504,-8.700936E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(149.0561,31.79592,400.8026),
					OutTangent = Vector3(149.0561,31.79592,400.8026),
				},
			},
			StartTime = 60,
			Duration = 7,
			CurrentState = 5,
			Title = "Path",
			EndTime = 67,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 3,
		},
		[60] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "卫琼：这次召你们回来，就是因为咱渝都城也得有人接手了，你们俩，谁愿意做城主啊？",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 60.3,
			Duration = 8.990002,
			CurrentState = 5,
			Title = "talk",
			EndTime = 69.29,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 14,
		},
		[61] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_8_12",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 9.01746,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 60.3022,
			Duration = 9.01746,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 69.31966,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
		[62] = {
			ObjectName = "weiqiong",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 60.42,
			Duration = 2.5,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 62.92,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[63] = {
			ObjectName = "weiqiong",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 63.81,
			Duration = 2.5,
			CurrentState = 5,
			Title = "animator_play(Clone)",
			EndTime = 66.31001,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 12,
		},
		[64] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_jinshuguabian",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.530249,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 68.18,
			Duration = 3.530249,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 71.71025,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 16,
		},
		[65] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "曾书书：啊？！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 69.38007,
			Duration = 1.5,
			CurrentState = 5,
			Title = "Talk",
			EndTime = 70.88007,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 14,
		},
		[66] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_8_13",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.19381,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 69.40965,
			Duration = 1.19381,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 70.60346,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 17,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene