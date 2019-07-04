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
	Duration = 12,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "yingwu",
		[2] = "xiaofanchengnian",
		[3] = "zengshushu",
		[4] = "MainCharacter",
	},
	Title = "yuzhou_12",
	EndTime = 12,
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
					Position = Vector3(23.45194,3.751171,8.966307),
					Rotation = Vector3(8.809343,324.5446,0.01970619),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(23.45194,3.751171,8.966307),
					OutTangent = Vector3(23.45194,3.751171,8.966307),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(23.45194,3.751171,8.966307),
					Rotation = Vector3(8.809343,324.5446,0.01970619),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(23.45194,3.751171,8.966307),
					OutTangent = Vector3(23.45194,3.751171,8.966307),
				},
			},
			StartTime = 0,
			Duration = 2,
			CurrentState = 5,
			Title = "path",
			EndTime = 2,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[2] = {
			IndexName = "zengshushu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(22.0977,1.464403,13.68113),
			Rotation = Vector3(0,326.3,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "shushu",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
		},
		[3] = {
			IndexName = "MainCharacter",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(19.70985,1.464404,11.94583),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhujue",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_special",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectSpecialCreate",
			ParentId = 5,
		},
		[4] = {
			IndexName = "yingwu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(20.51985,4.016,13.11475),
			Rotation = Vector3(0,146.32,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "yingwu",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[5] = {
			IndexName = "xiaofanchengnian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(21.23685,1.464404,12.10628),
			Rotation = Vector3(0,339.3,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xiaofan",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[6] = {
			AudioMode = "BackMusic",
			LoadMode = "Delay",
			IndexName = "bgm_cg_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 11.38286,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0.5075758,-0.004280257,-0.004280257),
					[2] = UnityEngine.Keyframe(9.417488,0.4981061,0.00447948,0.00447948),
					[3] = UnityEngine.Keyframe(11.21915,0,0,0),
				},
			},
			StartTime = 0.43,
			Duration = 11.38286,
			CurrentState = 5,
			Title = "back_music",
			EndTime = 11.81286,
			Type = "PlotDirector.PlotEventBackMusic",
			ParentId = 9,
		},
		[7] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "机关鹦鹉：  图纸！图纸！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 0.7,
			Duration = 1.3,
			CurrentState = 5,
			Title = "talk",
			EndTime = 2,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 7,
		},
		[8] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_12_1",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.277143,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0.7000002,
			Duration = 1.277143,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 1.977143,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 10,
		},
		[9] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_12_2",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 4.291882,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 1.977143,
			Duration = 4.291882,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 6.269025,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 10,
		},
		[10] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "曾书书：  啊？！这不是我的声音，这又是跟谁学的？！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 2,
			Duration = 4.29,
			CurrentState = 5,
			Title = "talk",
			EndTime = 6.29,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 7,
		},
		[11] = {
			ObjectName = "shushu",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 2.02,
			Duration = 2,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 4.02,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[12] = {
			ObjectName = "shushu",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.5,
			StartTime = 4.02,
			Duration = 0.9799995,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 5,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[13] = {
			ObjectName = "zhujue",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 5,
			Duration = 2.666667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 7.666667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[14] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "[00CC00]{PlayerRoleName}[-]：  那人一定还在里面！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 6.400001,
			Duration = 1.45,
			CurrentState = 5,
			Title = "talk",
			EndTime = 7.850001,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 7,
		},
		[15] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_12_3zhujue",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.428549,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 6.429999,
			Duration = 1.428549,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 7.858548,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 10,
		},
		[16] = {
			ObjectName = "zhujue",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.5,
			StartTime = 6.899999,
			Duration = 0.7300014,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 7.63,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[17] = {
			ObjectName = "xiaofan",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 7.07,
			Duration = 2.666667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 9.736667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 4,
		},
		[18] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "张小凡：  书书，你这只机关鹦鹉关键时刻还真顶用啊！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 7.960001,
			Duration = 3.869999,
			CurrentState = 5,
			Title = "talk",
			EndTime = 11.83,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 7,
		},
		[19] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "yuzhou_12_4",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.85093,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 7.969997,
			Duration = 3.85093,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 11.82093,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 10,
		},
		[20] = {
			ObjectName = "xiaofan",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.5,
			StartTime = 9.736667,
			Duration = 0.5,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 10.23667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 4,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene