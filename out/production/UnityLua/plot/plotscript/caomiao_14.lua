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
	Duration = 11,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "tianbuyi",
		[2] = "dimianbaodian",
		[3] = "suru",
		[4] = "chuansongmen",
		[5] = "xiaofanshaonian",
		[6] = "jingyushaonian",
		[7] = "MainCharacter",
	},
	Title = "caomiao_14",
	EndTime = 11,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "MainCharacter",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(412.2808,26.97915,454.0789),
			Rotation = Vector3(0,316.9505,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhujue",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "Object Special",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectSpecialCreate",
			ParentId = 11,
		},
		[2] = {
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
					Position = Vector3(414.9114,29.57552,458.3138),
					Rotation = Vector3(20.66211,247.0376,-7.390971E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(414.9114,29.57552,458.3138),
					OutTangent = Vector3(414.9114,29.57552,458.3138),
				},
				[2] = {
					NodeTime = 3.5,
					Position = Vector3(414.9114,29.57552,458.3137),
					Rotation = Vector3(20.49022,246.522,-7.473797E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(414.9114,29.57552,458.3137),
					OutTangent = Vector3(414.9114,29.57552,458.3137),
				},
			},
			StartTime = 0,
			Duration = 3.5,
			CurrentState = 5,
			Title = "Path",
			EndTime = 3.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[3] = {
			AudioMode = "BackMusic",
			LoadMode = "Delay",
			IndexName = "bgm_cg_04",
			Looping = false,
			StartPlayPos = 55.32798,
			EndPlayPos = 66.56,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0,0,0),
					[2] = UnityEngine.Keyframe(0.7760803,0.7422715,-0.0008940697,-0.0008940697),
					[3] = UnityEngine.Keyframe(9.26534,0.7165663,0.003278255,0.003278255),
					[4] = UnityEngine.Keyframe(11.23201,0,0,0),
				},
			},
			StartTime = 0,
			Duration = 11.23201,
			CurrentState = 5,
			Title = "back_music",
			EndTime = 11.23201,
			Type = "PlotDirector.PlotEventBackMusic",
			ParentId = 19,
		},
		[4] = {
			IndexName = "jingyushaonian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(411.328,27.0476,458.376),
			Rotation = Vector3(0,321.8,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xiaolin",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 10,
		},
		[5] = {
			IndexName = "tianbuyi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(409.266,27.01404,458.863),
			Rotation = Vector3(0,152.3,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "tby",
			StartTime = 0,
			Duration = 0.27,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.27,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 7,
		},
		[6] = {
			IndexName = "suru",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(410.25,27.02442,456.93),
			Rotation = Vector3(0,332.3,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "suru",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
		},
		[7] = {
			IndexName = "xiaofanshaonian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(408.732,27.04133,456.24),
			Rotation = Vector3(0,326.7,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xiaozhang",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[8] = {
			ObjectName = "tby",
			IsLoop = true,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.27,
			Duration = 1.54,
			CurrentState = 5,
			Title = "animator_play(Clone)(Clone)",
			EndTime = 1.81,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 7,
		},
		[9] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "田不易：  此事还需尽快告知掌门师兄......",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 0.3,
			Duration = 3.2,
			CurrentState = 5,
			Title = "talk",
			EndTime = 3.5,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 13,
		},
		[10] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "caomiao_14_1",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.396463,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0.3000001,
			Duration = 3.396463,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 3.696463,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 20,
		},
		[11] = {
			ObjectName = "tby",
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
					Position = Vector3(409.266,27.01404,458.863),
					Rotation = Vector3(0,152.3,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(409.266,27.01404,458.863),
					OutTangent = Vector3(409.266,27.01404,458.863),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(409.266,27.01404,458.863),
					Rotation = Vector3(0,304.5,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(409.266,27.01404,458.863),
					OutTangent = Vector3(409.266,27.01404,458.863),
				},
			},
			StartTime = 2.93,
			Duration = 0.7,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 3.63,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 7,
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
					Position = Vector3(411.895,30.42099,462.8762),
					Rotation = Vector3(25.81862,199.2168,-9.531927E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(411.895,30.42099,462.8762),
					OutTangent = Vector3(411.895,30.42099,462.8762),
				},
				[2] = {
					NodeTime = 3,
					Position = Vector3(412.1191,30.79138,463.2558),
					Rotation = Vector3(21.00578,258.3461,-8.688231E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(412.1191,30.79138,463.2558),
					OutTangent = Vector3(412.1191,30.79138,463.2558),
				},
			},
			StartTime = 3.5,
			Duration = 3,
			CurrentState = 5,
			Title = "Path",
			EndTime = 6.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[13] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "田不易：  你们都随我来吧！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 3.7,
			Duration = 1.38,
			CurrentState = 5,
			Title = "talk",
			EndTime = 5.08,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 13,
		},
		[14] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "caomiao_14_2",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.244263,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.76,
			Duration = 1.244263,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 5.004263,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 20,
		},
		[15] = {
			ObjectName = "tby",
			IsLoop = true,
			StateName = "walk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.3,
			StartTime = 3.81,
			Duration = 2.24,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 6.05,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[16] = {
			ObjectName = "tby",
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
					Position = Vector3(409.266,27.01404,458.863),
					Rotation = Vector3(0,304.5,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(409.266,27.01404,458.863),
					OutTangent = Vector3(409.266,27.01404,458.863),
				},
				[2] = {
					NodeTime = 7,
					Position = Vector3(397.7246,28.18,469.8235),
					Rotation = Vector3(0,313.3,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(397.7246,28.18,469.8235),
					OutTangent = Vector3(397.7246,28.18,469.8235),
				},
			},
			StartTime = 3.81,
			Duration = 5.63,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 9.440001,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 7,
		},
		[17] = {
			ObjectName = "suru",
			IsLoop = true,
			StateName = "walk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.5,
			StartTime = 3.94,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 4.94,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 9,
		},
		[18] = {
			ObjectName = "suru",
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
					Position = Vector3(410.25,27.02442,456.93),
					Rotation = Vector3(0,332.3,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(410.25,27.02442,456.93),
					OutTangent = Vector3(410.25,27.02442,456.93),
				},
				[2] = {
					NodeTime = 5.63,
					Position = Vector3(403.47,27.02442,463.74),
					Rotation = Vector3(0,316.54,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(403.47,27.02442,463.74),
					OutTangent = Vector3(403.47,27.02442,463.74),
				},
			},
			StartTime = 3.97,
			Duration = 5.63,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 9.6,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 15,
		},
		[19] = {
			ObjectName = "xiaozhang",
			IsLoop = true,
			StateName = "walk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.5,
			StartTime = 4,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 5,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 10,
		},
		[20] = {
			ObjectName = "xiaolin",
			IsLoop = true,
			StateName = "walk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.5,
			StartTime = 4,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 5,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 11,
		},
		[21] = {
			ObjectName = "xiaozhang",
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
					Position = Vector3(408.732,27.04133,456.24),
					Rotation = Vector3(0,326.7,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(408.732,27.04133,456.24),
					OutTangent = Vector3(408.732,27.04133,456.24),
				},
				[2] = {
					NodeTime = 5.63,
					Position = Vector3(399,28.03,464.82),
					Rotation = Vector3(0,317.5,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(399,28.03,464.82),
					OutTangent = Vector3(399,28.03,464.82),
				},
			},
			StartTime = 4,
			Duration = 5.63,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 9.63,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 16,
		},
		[22] = {
			ObjectName = "xiaolin",
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
					Position = Vector3(411.328,27.0476,458.376),
					Rotation = Vector3(0,321.8,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(411.328,27.0476,458.376),
					OutTangent = Vector3(411.328,27.0476,458.376),
				},
				[2] = {
					NodeTime = 5.63,
					Position = Vector3(403.202,27.903,468.702),
					Rotation = Vector3(0,321.8,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(403.202,27.903,468.702),
					OutTangent = Vector3(403.202,27.903,468.702),
				},
			},
			StartTime = 4,
			Duration = 5.63,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 9.63,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 17,
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
					Position = Vector3(413.8159,28.77472,451.4146),
					Rotation = Vector3(7.770488,325.0382,-7.884426E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(413.8159,28.77472,451.4146),
					OutTangent = Vector3(413.8159,28.77472,451.4146),
				},
				[2] = {
					NodeTime = 4,
					Position = Vector3(413.8159,28.77472,451.4146),
					Rotation = Vector3(7.942363,323.6633,-7.887691E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(413.8159,28.77472,451.4146),
					OutTangent = Vector3(413.8159,28.77472,451.4146),
				},
			},
			StartTime = 6.5,
			Duration = 4,
			CurrentState = 5,
			Title = "Path",
			EndTime = 10.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[24] = {
			IndexName = "chuansongmen",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(400.08,28.62,467.29),
			Rotation = Vector3(0,299.04,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "chuansong",
			StartTime = 8.340001,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 9.340001,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
		},
		[25] = {
			IndexName = "dimianbaodian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(399.2291,28.02801,468.3947),
			Rotation = Vector3(0,311.3102,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "chsole",
			StartTime = 9.36,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 10.36,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 14,
		},
		[26] = {
			ObjectName = "tby",
			Active = false,
			StartTime = 9.440001,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Show Hide(Clone)(Clone)",
			EndTime = 10.44,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 7,
		},
		[27] = {
			IndexName = "dimianbaodian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(403.47,27.02442,463.74),
			Rotation = Vector3(0,316.54,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "chsole1",
			StartTime = 9.539999,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)(clone)",
			EndTime = 10.54,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[28] = {
			IndexName = "dimianbaodian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(399,28.03,464.82),
			Rotation = Vector3(0,317.5,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "chsole2",
			StartTime = 9.58,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)(clone)",
			EndTime = 10.58,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 10,
		},
		[29] = {
			IndexName = "dimianbaodian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(403.202,27.903,468.702),
			Rotation = Vector3(0,321.8,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "chsole3",
			StartTime = 9.589998,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create(clone)(clone)",
			EndTime = 10.59,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 11,
		},
		[30] = {
			ObjectName = "suru",
			Active = false,
			StartTime = 9.6,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Show Hide(Clone)(Clone)",
			EndTime = 10.6,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 15,
		},
		[31] = {
			ObjectName = "xiaozhang",
			Active = false,
			StartTime = 9.63,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Show Hide(Clone)(Clone)(Clone)",
			EndTime = 10.63,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 16,
		},
		[32] = {
			ObjectName = "xiaolin",
			Active = false,
			StartTime = 9.63,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Show Hide(Clone)(Clone)(Clone)",
			EndTime = 10.63,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 17,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene