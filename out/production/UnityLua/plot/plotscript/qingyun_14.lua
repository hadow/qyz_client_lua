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
	Duration = 14,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "fanhe",
		[2] = "xiaofanchengnian",
		[3] = "MainCharacter",
	},
	Title = "qingyun_14",
	EndTime = 14,
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
					Position = Vector3(251.1741,16.12701,370.0593),
					Rotation = Vector3(23.13597,21.04222,-6.499105E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(251.1741,16.12701,370.0593),
					OutTangent = Vector3(251.1741,16.12701,370.0593),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(251.215,16.096,370.138),
					Rotation = Vector3(23.13596,21.04222,-8.355993E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(251.215,16.096,370.138),
					OutTangent = Vector3(251.215,16.096,370.138),
				},
			},
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "Path",
			EndTime = 1,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 7,
		},
		[2] = {
			AudioMode = "BackMusic",
			LoadMode = "Delay",
			IndexName = "bgm_cg_03",
			Looping = false,
			StartPlayPos = 9.134519,
			EndPlayPos = 22.96679,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0,0,0),
					[2] = UnityEngine.Keyframe(1.087271,0.8978748,-0.0002980232,-0.0002980232),
					[3] = UnityEngine.Keyframe(12.82585,0.8467592,-0.035657,-0.035657),
					[4] = UnityEngine.Keyframe(13.83227,0,0,0),
				},
			},
			StartTime = 0,
			Duration = 13.83227,
			CurrentState = 5,
			Title = "back_music",
			EndTime = 13.83227,
			Type = "PlotDirector.PlotEventBackMusic",
			ParentId = 13,
		},
		[3] = {
			IndexName = "MainCharacter",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(249.79,13.25,371.13),
			Rotation = Vector3(0,17.15166,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhujue",
			StartTime = 0,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_special",
			EndTime = 0.5,
			Type = "PlotDirector.PlotEventObjectSpecialCreate",
			ParentId = 1,
		},
		[4] = {
			IndexName = "fanhe",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(253.05,13.15,374.85),
			Rotation = Vector3(271.2627,171.0229,170.3022),
			LocalScale = Vector3(1,1,1),
			ObjectName = "fanhe",
			StartTime = 0,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.5,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 2,
		},
		[5] = {
			IndexName = "xiaofanchengnian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(250.98,13.21,370.55),
			Rotation = Vector3(0,26.06451,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhangxiaofan",
			StartTime = 0,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.5,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[6] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "张小凡：  那是，是师姐给我送饭的食盒！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 1,
			Duration = 3,
			CurrentState = 5,
			Title = "talk",
			EndTime = 4,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 10,
		},
		[7] = {
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
					Position = Vector3(255.2823,14.20221,370.2652),
					Rotation = Vector3(357.6292,304.9277,2.125581E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(255.2823,14.20221,370.2652),
					OutTangent = Vector3(255.2823,14.20221,370.2652),
				},
				[2] = {
					NodeTime = 3,
					Position = Vector3(255.5281,14.1898,370.0936),
					Rotation = Vector3(357.6292,304.9277,2.243076E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(255.5281,14.1898,370.0936),
					OutTangent = Vector3(255.5281,14.1898,370.0936),
				},
			},
			StartTime = 1,
			Duration = 3,
			CurrentState = 5,
			Title = "Path",
			EndTime = 4,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 8,
		},
		[8] = {
			ObjectName = "zhangxiaofan",
			IsLoop = true,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 1,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 2,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 4,
		},
		[9] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_14_1",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.720635,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 1,
			Duration = 2.720635,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 3.720635,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 15,
		},
		[10] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "[00CC00]{PlayerRoleName}[-]:  糟了！恐怕出事了！上面有封信！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 4,
			Duration = 3.11,
			CurrentState = 5,
			Title = "talk",
			EndTime = 7.11,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 10,
		},
		[11] = {
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
					Position = Vector3(250.4663,14.95102,372.3304),
					Rotation = Vector3(359.4156,209.7746,1.200682E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(250.4663,14.95102,372.3304),
					OutTangent = Vector3(250.4663,14.95102,372.3304),
				},
				[2] = {
					NodeTime = 2.5,
					Position = Vector3(250.3173,14.95408,372.07),
					Rotation = Vector3(359.4155,209.7745,2.961682E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(250.3173,14.95408,372.07),
					OutTangent = Vector3(250.3173,14.95408,372.07),
				},
			},
			StartTime = 4,
			Duration = 2.5,
			CurrentState = 5,
			Title = "path",
			EndTime = 6.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 8,
		},
		[12] = {
			ObjectName = "zhujue",
			IsLoop = true,
			StateName = "CG_scratch",
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
			ParentId = 4,
		},
		[13] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_14_2zhujue",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.347506,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 4.019989,
			Duration = 3.347506,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 7.367495,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 15,
		},
		[14] = {
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
					Position = Vector3(250.98,13.21,370.55),
					Rotation = Vector3(0,26.06451,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(250.9122,13.21,370.4206),
					OutTangent = Vector3(251.0477,13.21,370.6794),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(251.307,13.2,371.214),
					Rotation = Vector3(0,26.06451,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(251.2534,13.2,371.0999),
					OutTangent = Vector3(251.3606,13.2,371.3281),
				},
			},
			StartTime = 6.5,
			Duration = 1,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 7.5,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 4,
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
					Position = Vector3(256.8824,16.766,371.224),
					Rotation = Vector3(27.26125,282.8945,-2.689271E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(256.8824,16.766,371.224),
					OutTangent = Vector3(256.8824,16.766,371.224),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(256.8824,16.766,371.224),
					Rotation = Vector3(26.91748,285.4728,-1.723519E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(256.8824,16.766,371.224),
					OutTangent = Vector3(256.8824,16.766,371.224),
				},
			},
			StartTime = 6.5,
			Duration = 1,
			CurrentState = 5,
			Title = "path",
			EndTime = 7.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 8,
		},
		[16] = {
			ObjectName = "zhangxiaofan",
			IsLoop = true,
			StateName = "walk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 6.5,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 7.5,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 3,
		},
		[17] = {
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
					Position = Vector3(251.853,14.89302,372.6919),
					Rotation = Vector3(26.33433,19.87055,3.143704E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(251.853,14.89302,372.6919),
					OutTangent = Vector3(251.853,14.89302,372.6919),
				},
				[2] = {
					NodeTime = 5,
					Position = Vector3(252.7543,14.32697,374.2657),
					Rotation = Vector3(43.69497,18.83924,4.014825E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(252.7543,14.32697,374.2657),
					OutTangent = Vector3(252.7543,14.32697,374.2657),
				},
			},
			StartTime = 7.5,
			Duration = 5,
			CurrentState = 5,
			Title = "path",
			EndTime = 12.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 8,
		},
		[18] = {
			ObjectName = "zhangxiaofan",
			Active = false,
			StartTime = 7.5,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Show Hide",
			EndTime = 8.5,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 2,
		},
		[19] = {
			ObjectName = "zhangxiaofan",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 8.730001,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 9.730001,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 3,
		},
		[20] = {
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
			StartTime = 10.46975,
			Duration = 3.530249,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 14,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene