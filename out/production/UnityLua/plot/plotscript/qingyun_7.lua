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
	Duration = 30,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "nianlaoda",
		[2] = "luxueqi",
		[3] = "zengshushu",
		[4] = "xiaofanchengnian",
		[5] = "linjingyu",
		[6] = "MainCharacter",
	},
	Title = "qingyun_7",
	EndTime = 30,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "xiaofanchengnian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(111.7189,-0.05077362,26.18322),
			Rotation = Vector3(0,223.44,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zxf",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[2] = {
			IndexName = "MainCharacter",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(110.03,-0.05077362,25.63),
			Rotation = Vector3(0,153.53,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhujue",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_special",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectSpecialCreate",
			ParentId = 10,
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
					Position = Vector3(115.9147,1.736555,26.54231),
					Rotation = Vector3(6.567326,268.4598,-9.453542E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(115.9147,1.736555,26.54231),
					OutTangent = Vector3(115.9147,1.736555,26.54231),
				},
				[2] = {
					NodeTime = 5,
					Position = Vector3(115.9283,1.714303,25.85105),
					Rotation = Vector3(8.45819,269.1485,-9.926362E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(115.9283,1.714303,25.85105),
					OutTangent = Vector3(115.9283,1.714303,25.85105),
				},
			},
			StartTime = 0,
			Duration = 5.61,
			CurrentState = 5,
			Title = "Path",
			EndTime = 5.61,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 11,
		},
		[4] = {
			IndexName = "nianlaoda",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(110.4884,-0.05076981,24.30804),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "nld",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 6,
		},
		[5] = {
			IndexName = "luxueqi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(106.3905,2.670288E-05,30.79604),
			Rotation = Vector3(0,269.3,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "lxq",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 7,
		},
		[6] = {
			IndexName = "zengshushu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(104.2594,0.01741409,30.49604),
			Rotation = Vector3(0,88.60001,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zss",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
		},
		[7] = {
			ObjectName = "zxf/fabao_shihun",
			Active = false,
			StartTime = 0.1,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 0.3,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 10,
		},
		[8] = {
			ObjectName = "zxf/Object001",
			Active = false,
			StartTime = 0.1,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 9,
		},
		[9] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_7_1",
			Looping = false,
			StartPlayPos = 5.330168,
			EndPlayPos = 8.416055,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0.4899999,
			Duration = 3.085886,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 3.575886,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 18,
		},
		[10] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "年老大:  这里是颜如玉书屋。",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 0.5,
			Duration = 5.399998,
			CurrentState = 5,
			Title = "talk",
			EndTime = 5.899998,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 13,
		},
		[11] = {
			ObjectName = "zss",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 5,
			Duration = 2,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 7,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
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
					Position = Vector3(105.5444,1.754679,26.97842),
					Rotation = Vector3(6.051597,4.128715,-0.0001552783),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(105.5444,1.754679,26.97842),
					OutTangent = Vector3(105.5444,1.754679,26.97842),
				},
				[2] = {
					NodeTime = 3,
					Position = Vector3(105.5326,1.741287,27.13583),
					Rotation = Vector3(4.848288,357.4253,-0.0001536688),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(105.5326,1.741287,27.13583),
					OutTangent = Vector3(105.5326,1.741287,27.13583),
				},
			},
			StartTime = 5.61,
			Duration = 2.38,
			CurrentState = 5,
			Title = "path",
			EndTime = 7.99,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 11,
		},
		[13] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_7_2",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.043379,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 5.889488,
			Duration = 3.043379,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 8.932867,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 18,
		},
		[14] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "曾书书：  姑娘空灵绝尘犹如天仙下凡......",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 5.899998,
			Duration = 3,
			CurrentState = 5,
			Title = "talk",
			EndTime = 8.899998,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 13,
		},
		[15] = {
			ObjectName = "zss",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0,
			StartTime = 7,
			Duration = 0.5,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 7.5,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[16] = {
			ObjectName = "zss",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 8,
			Duration = 2,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 10,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[17] = {
			IndexName = "linjingyu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(97.7384,0.1496079,52.87804),
			Rotation = Vector3(-6.755209E-10,173.6,-2.764043E-08),
			LocalScale = Vector3(1,1,1),
			ObjectName = "ljy",
			StartTime = 8.579997,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 9.579997,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 15,
		},
		[18] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "曾书书：  看姑娘的装扮，莫非也是青云门弟子？",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 8.909998,
			Duration = 4,
			CurrentState = 5,
			Title = "talk",
			EndTime = 12.91,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 13,
		},
		[19] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_7_3",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.704739,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 8.932867,
			Duration = 3.704739,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 12.63761,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 18,
		},
		[20] = {
			ObjectName = "zss",
			IsLoop = false,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0,
			StartTime = 10,
			Duration = 2,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 12,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[21] = {
			ObjectName = "ljy",
			IsLoop = false,
			StateName = "walk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 11.62,
			Duration = 1,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 12.62,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 16,
		},
		[22] = {
			ObjectName = "ljy",
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
					Position = Vector3(97.7384,0.1496079,52.87804),
					Rotation = Vector3(-6.755211E-10,173.6,-2.764043E-08),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(97.7384,0.1496079,52.87804),
					OutTangent = Vector3(97.7384,0.1496079,52.87804),
				},
				[2] = {
					NodeTime = 8,
					Position = Vector3(97.6184,0.1496079,40.59804),
					Rotation = Vector3(-6.755218E-10,181.6,-2.764044E-08),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(97.6184,0.1496079,40.59804),
					OutTangent = Vector3(97.6184,0.1496079,40.59804),
				},
			},
			StartTime = 11.62,
			Duration = 8,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 19.62,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 15,
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
					Position = Vector3(105.5326,1.741287,27.13583),
					Rotation = Vector3(4.848288,357.4253,-0.0001536688),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(105.5326,1.741287,27.13583),
					OutTangent = Vector3(105.5326,1.741287,27.13583),
				},
				[2] = {
					NodeTime = 3,
					Position = Vector3(100.0194,2.081185,40.93941),
					Rotation = Vector3(3.129523,339.8249,-0.0001574359),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(100.0194,2.081185,40.93941),
					OutTangent = Vector3(100.0194,2.081185,40.93941),
				},
			},
			StartTime = 12.14,
			Duration = 3,
			CurrentState = 5,
			Title = "path",
			EndTime = 15.14,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 11,
		},
		[24] = {
			ObjectName = "zss",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(105.406,0.073,30.978),
			Rotation = Vector3(-2.448534E-10,326.7,-1.001877E-08),
			LocalScale = Vector3(1,1,1),
			StartTime = 14.09,
			Duration = 1,
			CurrentState = 5,
			Title = "object_transform",
			EndTime = 15.09,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 7,
		},
		[25] = {
			ObjectName = "lxq",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(106.3905,2.670288E-05,30.79604),
			Rotation = Vector3(0,333.6,0),
			LocalScale = Vector3(1,1,1),
			StartTime = 14.1,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Transform",
			EndTime = 15.1,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 8,
		},
		[26] = {
			ObjectName = "zxf",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(111.7189,-0.05077362,26.18322),
			Rotation = Vector3(0,316.2,0),
			LocalScale = Vector3(1,1,1),
			StartTime = 14.13,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Transform",
			EndTime = 15.13,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 9,
		},
		[27] = {
			ObjectName = "zhujue",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(110.5884,-0.05077362,26.00804),
			Rotation = Vector3(0,305.2,0),
			LocalScale = Vector3(1,1,1),
			StartTime = 14.16,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Transform",
			EndTime = 15.16,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 10,
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
					Position = Vector3(104.2559,1.607335,34.18444),
					Rotation = Vector3(8.114415,155.5299,-7.222665E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(104.2559,1.607335,34.18444),
					OutTangent = Vector3(104.2559,1.607335,34.18444),
				},
				[2] = {
					NodeTime = 2.5,
					Position = Vector3(104.2559,1.607335,34.18444),
					Rotation = Vector3(8.114414,155.5299,-8.516277E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(104.2559,1.607335,34.18444),
					OutTangent = Vector3(104.2559,1.607335,34.18444),
				},
			},
			StartTime = 16,
			Duration = 2.5,
			CurrentState = 5,
			Title = "Path",
			EndTime = 18.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 11,
		},
		[29] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "曾书书：  不好！戒律堂的人来了！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 16,
			Duration = 3,
			CurrentState = 5,
			Title = "talk",
			EndTime = 19,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 13,
		},
		[30] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_gu",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.255238,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 16,
			Duration = 2.255238,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 18.25524,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 17,
		},
		[31] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_7_4",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.452857,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 16.01,
			Duration = 2.452857,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 18.46286,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 18,
		},
		[32] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_7_6",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.099184,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 18.99254,
			Duration = 3.099184,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 22.09172,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 18,
		},
		[33] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "曾书书：  他们进来了！姑娘你先走我掩护！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 19,
			Duration = 5,
			CurrentState = 5,
			Title = "talk",
			EndTime = 24,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 13,
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
					Position = Vector3(109.84,1.73369,28.82312),
					Rotation = Vector3(13.44292,155.0143,-8.558787E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(109.84,1.73369,28.82312),
					OutTangent = Vector3(109.84,1.73369,28.82312),
				},
				[2] = {
					NodeTime = 5,
					Position = Vector3(109.84,1.73369,28.82312),
					Rotation = Vector3(13.44292,155.0143,-8.339331E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(109.84,1.73369,28.82312),
					OutTangent = Vector3(109.84,1.73369,28.82312),
				},
			},
			StartTime = 23.98,
			Duration = 5,
			CurrentState = 5,
			Title = "Path",
			EndTime = 28.98,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 11,
		},
		[35] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "张小凡：  糟了！师门严禁弟子来这里看书，每天都有戒律堂的弟子巡查！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 24,
			Duration = 5,
			CurrentState = 5,
			Title = "talk",
			EndTime = 29,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 13,
		},
		[36] = {
			ObjectName = "zxf",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 24,
			Duration = 2.666667,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 26.66667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 10,
		},
		[37] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_7_5",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 4.633605,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 24.00302,
			Duration = 4.633605,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 28.63663,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 18,
		},
		[38] = {
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
			StartTime = 25.89209,
			Duration = 4.107914,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 30,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 17,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene