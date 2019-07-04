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
	Duration = 33,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "xiaofanchengnian",
		[2] = "biyao",
	},
	Title = "xiaochi_7",
	EndTime = 33,
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
					Position = Vector3(98.43849,39.66609,380.5424),
					Rotation = Vector3(344.5657,6.87949,5.823582E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(98.43849,39.66609,380.5424),
					OutTangent = Vector3(98.43849,39.66609,380.5424),
				},
				[2] = {
					NodeTime = 7.03,
					Position = Vector3(102.2042,38.72165,401.374),
					Rotation = Vector3(346.6284,5.504394,5.786438E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(102.2042,38.72165,401.374),
					OutTangent = Vector3(102.2042,38.72165,401.374),
				},
			},
			StartTime = 0,
			Duration = 7.03,
			CurrentState = 5,
			Title = "path",
			EndTime = 7.03,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[2] = {
			IndexName = "biyao",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(102.993,38.198,409.197),
			Rotation = Vector3(0,97.50002,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "biyao",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[3] = {
			IndexName = "xiaofanchengnian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(103.67,38.203,409.02),
			Rotation = Vector3(0,285,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhangxiaofan",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[4] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "碧瑶:  这满月井已有三千年了，一说满月时分，人若望下，就会看到心爱的人或事物。",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 0.1,
			Duration = 5,
			CurrentState = 0,
			Title = "talk",
			EndTime = 5.1,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 8,
		},
		[5] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "张小凡:  这种玄而又玄的东西你也相信？",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 5.16,
			Duration = 3,
			CurrentState = 0,
			Title = "talk",
			EndTime = 8.16,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 8,
		},
		[6] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "碧瑶:  哼！我想要的东西我都会自己争取的，不过要离开了，心血来潮，想看看它到底会告诉我什么。",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 8.33,
			Duration = 5,
			CurrentState = 0,
			Title = "talk",
			EndTime = 13.33,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 8,
		},
		[7] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "碧瑶:  不要回青云门去了，我们一起走吧。",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 13.55,
			Duration = 3,
			CurrentState = 0,
			Title = "talk",
			EndTime = 16.55,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 8,
		},
		[8] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "张小凡:  碧瑶，你……",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 16.79,
			Duration = 2,
			CurrentState = 0,
			Title = "talk",
			EndTime = 18.79,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 8,
		},
		[9] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "张小凡:  有时候我在想，如果有一天，你真的这么问我了，我该怎么回答？",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 19,
			Duration = 5,
			CurrentState = 0,
			Title = "talk",
			EndTime = 24,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 8,
		},
		[10] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "张小凡:  这一次，兽神复活关系到天下苍生的安危，第一卷天书选中了我，这是我不能逃脱的责任。",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 24.29,
			Duration = 5,
			CurrentState = 0,
			Title = "talk",
			EndTime = 29.29,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 8,
		},
		[11] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "碧瑶:  果满月古井告诉你，咱们最后还能在一起。一切结束后，你来找我吧......",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 29.58,
			Duration = 3.4,
			CurrentState = 0,
			Title = "talk",
			EndTime = 32.98,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 8,
		},
		[12] = {
			ObjectName = "zhangxiaofan",
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
					Position = Vector3(103.67,38.203,409.02),
					Rotation = Vector3(0,285,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(103.67,38.203,409.02),
					OutTangent = Vector3(103.67,38.203,409.02),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(103.67,38.203,409.02),
					Rotation = Vector3(0,30.8,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(103.67,38.203,409.02),
					OutTangent = Vector3(103.67,38.203,409.02),
				},
			},
			StartTime = 29.8,
			Duration = 1,
			CurrentState = 0,
			Title = "object_path",
			EndTime = 30.8,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 4,
		},
		[13] = {
			ObjectName = "biyao",
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
					Position = Vector3(102.993,38.198,409.197),
					Rotation = Vector3(0,97.50002,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(102.993,38.198,409.197),
					OutTangent = Vector3(102.993,38.198,409.197),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(102.993,38.198,409.197),
					Rotation = Vector3(0,41.3,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(102.993,38.198,409.197),
					OutTangent = Vector3(102.993,38.198,409.197),
				},
			},
			StartTime = 29.8,
			Duration = 1,
			CurrentState = 0,
			Title = "object_path",
			EndTime = 30.8,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 5,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene