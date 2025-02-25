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
	Duration = 10,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "xiaoqi",
		[2] = "zhaoshi",
		[3] = "zhihetexiao",
	},
	Title = "caomiao_4",
	EndTime = 10,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "zhihetexiao",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(429.666,15.66,88.452),
			Rotation = Vector3(0,317.04,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "texiaozhihe",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 6,
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
					Position = Vector3(428.3046,18.09325,93.19118),
					Rotation = Vector3(1.239113,160.4742,-8.190137E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(428.3046,18.09325,93.19118),
					OutTangent = Vector3(428.3046,18.09325,93.19118),
				},
				[2] = {
					NodeTime = 6,
					Position = Vector3(428.8204,18.05986,91.7365),
					Rotation = Vector3(1.239113,180.9,-8.180965E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(428.8204,18.05986,91.7365),
					OutTangent = Vector3(428.8204,18.05986,91.7365),
				},
			},
			StartTime = 0,
			Duration = 6,
			CurrentState = 5,
			Title = "Path",
			EndTime = 6,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[3] = {
			IndexName = "xiaoqi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(428.86,16.937,88.48),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xiaoqi",
			StartTime = 0,
			Duration = 0.53,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 0.53,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[4] = {
			IndexName = "zhaoshi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(429.666,18.049,88.452),
			Rotation = Vector3(0,317.04,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhihe",
			StartTime = 1.467764E-08,
			Duration = 0.49,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 0.49,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 5,
		},
		[5] = {
			ObjectName = "texiaozhihe",
			ParentName = "zhihe",
			StartTime = 0.2,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_parent(Clone)(Clone)",
			EndTime = 0.7,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 6,
		},
		[6] = {
			AudioMode = "BackMusic",
			LoadMode = "Delay",
			IndexName = "bgm_cg_01",
			Looping = false,
			StartPlayPos = 8.361552,
			EndPlayPos = 13.18007,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0,0,0),
					[2] = UnityEngine.Keyframe(1.087395,1,0,0),
					[3] = UnityEngine.Keyframe(3.835133,0.5820179,-0.3818747,-0.3818747),
					[4] = UnityEngine.Keyframe(4.818521,0,0.008067226,0.008067226),
				},
			},
			StartTime = 0.56,
			Duration = 4.818521,
			CurrentState = 5,
			Title = "back_music",
			EndTime = 5.378521,
			Type = "PlotDirector.PlotEventBackMusic",
			ParentId = 14,
		},
		[7] = {
			ObjectName = "zhihe",
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
					Position = Vector3(429.666,18.049,88.452),
					Rotation = Vector3(0,317.04,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(428.4468,18.049,89.76124),
					OutTangent = Vector3(430.8852,18.049,87.14275),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(427.234,18.808,89.1),
					Rotation = Vector3(0,317.3,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(424.9395,18.835,87.49302),
					OutTangent = Vector3(429.5284,18.781,90.70698),
				},
				[3] = {
					NodeTime = 2,
					Position = Vector3(429.082,17.603,90.079),
					Rotation = Vector3(22.36014,355.6,2.307968E-07),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(429.1614,17.61539,90.37653),
					OutTangent = Vector3(429.0026,17.59061,89.78147),
				},
			},
			StartTime = 1.01,
			Duration = 2,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 3.01,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 6,
		},
		[8] = {
			ObjectName = "xiaoqi",
			IsLoop = false,
			StateName = "idle",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 1.02,
			Duration = 2.666667,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 3.686667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 3,
		},
		[9] = {
			AudioMode = "Sound3D",
			LoadMode = "Delay",
			IndexName = "wpn_swing_sml_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.4334467,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 1.19,
			Duration = 0.4334467,
			CurrentState = 5,
			Title = "Back Sound",
			EndTime = 1.623446,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 13,
		},
		[10] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_ling",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.393492,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Constant",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 2.300002,
			Duration = 2.393492,
			CurrentState = 5,
			Title = "Back Sound",
			EndTime = 4.693494,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 12,
		},
		[11] = {
			IndexName = "xiaoqitexie",
			EffectType = "Words",
			Position = Vector2(0.6,0.5),
			ObjectName = "texie",
			StartTime = 2.3299,
			Duration = 1.98,
			CurrentState = 5,
			Title = "Screen Words",
			EndTime = 4.3099,
			Type = "PlotDirector.PlotEventScreenWords",
			ParentId = 8,
		},
		[12] = {
			AudioMode = "Sound3D",
			LoadMode = "Delay",
			IndexName = "wpn_swing_sml_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.4334467,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 2.47,
			Duration = 0.4334467,
			CurrentState = 5,
			Title = "Back Sound(Clone)",
			EndTime = 2.903446,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 13,
		},
		[13] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_whoose_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.154218,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 2.67,
			Duration = 3.154218,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 5.824217,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 15,
		},
		[14] = {
			ObjectName = "xiaoqi",
			SpeedValue = 0,
			Curve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3,
			Duration = 1.18,
			CurrentState = 4,
			Mode = "Event",
			Title = "Animator Speed",
			EndTime = 4.18,
			Type = "PlotDirector.PlotEventAnimatorSpeed",
			ParentId = 5,
		},
		[15] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_gunzou",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 4.107914,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Constant",
			VolumeValue = 0.6,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.21,
			Duration = 4.107914,
			CurrentState = 5,
			Title = "Back Sound",
			EndTime = 7.317914,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 13,
		},
		[16] = {
			ObjectName = "zhihe",
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
					Position = Vector3(429.1002,17.603,90.0972),
					Rotation = Vector3(22.36014,355.6,2.307968E-07),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(428.7243,17.603,90.06828),
					OutTangent = Vector3(429.4761,17.603,90.12612),
				},
				[2] = {
					NodeTime = 0.3,
					Position = Vector3(429.338,17.592,90.605),
					Rotation = Vector3(355.7,334.25,-4.280919E-07),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(429.4586,17.56801,90.3089),
					OutTangent = Vector3(429.2174,17.61599,90.90111),
				},
				[3] = {
					NodeTime = 1,
					Position = Vector3(426.29,19.88,92.52),
					Rotation = Vector3(333.6,279.4001,1.906358E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(426.29,19.88,92.52),
					OutTangent = Vector3(426.29,19.88,92.52),
				},
			},
			StartTime = 4.139997,
			Duration = 1,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 5.139997,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 17,
		},
		[17] = {
			ObjectName = "xiaoqi",
			IsLoop = false,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 4.78,
			Duration = 2,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 6.78,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 6,
		},
		[18] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "caomiao_4_1",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.438004,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 5.989999,
			Duration = 3.438004,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 9.428003,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 16,
		},
		[19] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "小七：  嘿！急急忙忙的，你在找谁？",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 6,
			Duration = 3.5,
			CurrentState = 5,
			Title = "talk",
			EndTime = 9.5,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 8,
		},
		[20] = {
			ObjectName = "xiaoqi",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 6,
			Duration = 2.666667,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 8.666667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 6,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene