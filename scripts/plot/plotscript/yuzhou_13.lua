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
	Duration = 22.2,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "lixun",
		[2] = "zhayao",
		[3] = "zengshushu",
	},
	Title = "yuzhou_13",
	EndTime = 22.2,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "zhayao",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(315.4568,26.87,148.47),
			Rotation = Vector3(270,223.9,0),
			LocalScale = Vector3(5,5,5),
			ObjectName = "zhaoyao5",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[2] = {
			IndexName = "zhayao",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(315.4568,26.87,151.12),
			Rotation = Vector3(270,166.5,0),
			LocalScale = Vector3(5,5,5),
			ObjectName = "zhaoyao4",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 0.2,
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
					Position = Vector3(325.5742,33.7239,143.4223),
					Rotation = Vector3(20.66269,308.4373,-9.489679E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(325.5742,33.7239,143.4223),
					OutTangent = Vector3(325.5742,33.7239,143.4223),
				},
				[2] = {
					NodeTime = 3,
					Position = Vector3(325.5742,33.7239,143.4223),
					Rotation = Vector3(20.4908,316.516,-9.387853E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(325.5742,33.7239,143.4223),
					OutTangent = Vector3(325.5742,33.7239,143.4223),
				},
			},
			StartTime = 0,
			Duration = 4,
			CurrentState = 5,
			Title = "path",
			EndTime = 4,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 5,
		},
		[4] = {
			AudioMode = "BackMusic",
			LoadMode = "Delay",
			IndexName = "bgm_cg_03",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 22.29116,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0.06442642,0.844697,0,0),
					[2] = UnityEngine.Keyframe(19.0596,0.8145964,0.002682209,0.002682209),
					[3] = UnityEngine.Keyframe(22.29116,0,0,0),
				},
			},
			StartTime = 0,
			Duration = 22.29116,
			CurrentState = 5,
			Title = "back_music",
			EndTime = 22.29116,
			Type = "PlotDirector.PlotEventBackMusic",
			ParentId = 14,
		},
		[5] = {
			IndexName = "zengshushu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(329.38,27.094,158.3944),
			Rotation = Vector3(0,266.2,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "shushu",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 10,
		},
		[6] = {
			IndexName = "zhayao",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(315.4568,26.73,156.71),
			Rotation = Vector3(270,204.4,0),
			LocalScale = Vector3(5,5,5),
			ObjectName = "zhaoyao",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[7] = {
			IndexName = "lixun",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(320.86,27.04,158.53),
			Rotation = Vector3(0,273.55,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "lixun",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 2,
		},
		[8] = {
			IndexName = "zhayao",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(315.4568,26.66889,159.74),
			Rotation = Vector3(270.0198,170,0),
			LocalScale = Vector3(5,5,5),
			ObjectName = "zhaoyao1",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[9] = {
			IndexName = "zhayao",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(315.4568,26.87,154.1),
			Rotation = Vector3(270,203.3,0),
			LocalScale = Vector3(5,5,5),
			ObjectName = "zhaoyao3",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 7,
		},
		[10] = {
			IndexName = "zhayao",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(315.4568,26.66889,164.2),
			Rotation = Vector3(270,253.9,0),
			LocalScale = Vector3(5,5,5),
			ObjectName = "zhaoyao2",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 6,
		},
		[11] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_13_1",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.529637,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.999999,
			Duration = 1.529637,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 5.529636,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 15,
		},
		[12] = {
			ObjectName = "shushu",
			IsLoop = true,
			StateName = "run",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 4,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 5,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 11,
		},
		[13] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "曾书书：  李洵！你疯了？！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 4,
			Duration = 2,
			CurrentState = 5,
			Title = "talk",
			EndTime = 6,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 13,
		},
		[14] = {
			ObjectName = "shushu",
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
					Position = Vector3(329.38,27.094,158.3944),
					Rotation = Vector3(0,266.2,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(329.38,27.094,158.3944),
					OutTangent = Vector3(329.38,27.094,158.3944),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(322.03,27.094,158.3944),
					Rotation = Vector3(0,266.2,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(322.03,27.094,158.3944),
					OutTangent = Vector3(322.03,27.094,158.3944),
				},
			},
			StartTime = 4,
			Duration = 2,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 6,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 10,
		},
		[15] = {
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
					Position = Vector3(325.5742,33.7239,143.4223),
					Rotation = Vector3(20.4908,316.516,-9.387853E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(325.5742,33.7239,143.4223),
					OutTangent = Vector3(325.5742,33.7239,143.4223),
				},
				[2] = {
					NodeTime = 0.2,
					Position = Vector3(325.5742,33.7239,143.4223),
					Rotation = Vector3(20.31892,333.5329,-9.513946E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(325.5742,33.7239,143.4223),
					OutTangent = Vector3(325.5742,33.7239,143.4223),
				},
			},
			StartTime = 4,
			Duration = 2,
			CurrentState = 5,
			Title = "path",
			EndTime = 6,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 5,
		},
		[16] = {
			ObjectName = "lixun",
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
					Position = Vector3(320.86,27.04,158.53),
					Rotation = Vector3(0,273.55,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(320.86,27.04,158.53),
					OutTangent = Vector3(320.86,27.04,158.53),
				},
				[2] = {
					NodeTime = 0.5,
					Position = Vector3(320.86,27.04,158.53),
					Rotation = Vector3(0,80.38,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(320.86,27.04,158.53),
					OutTangent = Vector3(320.86,27.04,158.53),
				},
			},
			StartTime = 4.01,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 4.51,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 9,
		},
		[17] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_13_2",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 4.298312,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 5.999994,
			Duration = 4.298312,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 10.29831,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 15,
		},
		[18] = {
			ObjectName = "lixun",
			SpeedValue = 0.7,
			Curve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 6,
			Duration = 3,
			CurrentState = 2,
			Mode = "Event",
			Title = "animator_speed",
			EndTime = 9,
			Type = "PlotDirector.PlotEventAnimatorSpeed",
			ParentId = 8,
		},
		[19] = {
			ObjectName = "lixun",
			IsLoop = true,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 6,
			Duration = 3,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 9,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 9,
		},
		[20] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "李洵：  协助外公治理河道，你有的你主意，我也有我的方法，我们互不干涉，这话当初可是你说的。",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 6,
			Duration = 4.31,
			CurrentState = 5,
			Title = "talk",
			EndTime = 10.31,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 13,
		},
		[21] = {
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
					Position = Vector3(325.5742,33.7239,143.4223),
					Rotation = Vector3(20.31892,333.5329,-9.513946E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(325.5742,33.7239,143.4223),
					OutTangent = Vector3(325.5742,33.7239,143.4223),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(322.401,28.91048,153.8212),
					Rotation = Vector3(11.7246,342.6428,-8.741465E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(322.401,28.91048,153.8212),
					OutTangent = Vector3(322.401,28.91048,153.8212),
				},
			},
			StartTime = 6,
			Duration = 1,
			CurrentState = 5,
			Title = "path",
			EndTime = 7,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 5,
		},
		[22] = {
			ObjectName = "shushu",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0.6,
			StartTime = 6,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 7,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 11,
		},
		[23] = {
			ObjectName = "lixun",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 9.003335,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 10.00333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 9,
		},
		[24] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_13_3",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 4.939342,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 10.29831,
			Duration = 4.939342,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 15.23765,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 15,
		},
		[25] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "曾书书：  我不管你用什么方法，可你这样直接炸了河道，只会给渝都百姓带来灾难！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 10.31,
			Duration = 4.919999,
			CurrentState = 5,
			Title = "talk",
			EndTime = 15.23,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 13,
		},
		[26] = {
			ObjectName = "shushu",
			SpeedValue = 0.7,
			Curve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 10.33,
			Duration = 3,
			CurrentState = 2,
			Mode = "Event",
			Title = "animator_speed",
			EndTime = 13.33,
			Type = "PlotDirector.PlotEventAnimatorSpeed",
			ParentId = 10,
		},
		[27] = {
			ObjectName = "shushu",
			IsLoop = true,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 10.33,
			Duration = 3,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 13.33,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 11,
		},
		[28] = {
			ObjectName = "shushu",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 13.33,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 14.33,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 11,
		},
		[29] = {
			ObjectName = "lixun",
			IsLoop = true,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 15.21,
			Duration = 3,
			CurrentState = 5,
			Title = "animator_play(Clone)",
			EndTime = 18.21,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 11,
		},
		[30] = {
			ObjectName = "lixun",
			SpeedValue = 0.7,
			Curve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 15.22,
			Duration = 3,
			CurrentState = 2,
			Mode = "Event",
			Title = "animator_speed(Clone)",
			EndTime = 18.22,
			Type = "PlotDirector.PlotEventAnimatorSpeed",
			ParentId = 10,
		},
		[31] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "李洵：  你还是跟小时候一样，只会讲这些大道理，这一次，表哥不能听你的了！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 15.23,
			Duration = 6.82,
			CurrentState = 5,
			Title = "talk",
			EndTime = 22.05,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 13,
		},
		[32] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_13_4",
			Looping = false,
			StartPlayPos = 1.013291,
			EndPlayPos = 7.84483,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 15.23765,
			Duration = 6.83154,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 22.06919,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 15,
		},
		[33] = {
			ObjectName = "lixun",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 18.21,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play(Clone)",
			EndTime = 19.21,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 11,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene