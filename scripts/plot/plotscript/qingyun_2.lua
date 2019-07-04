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
	Duration = 6.7,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "shenmiren",
		[2] = "xiaofanshaonian",
		[3] = "zhuangji",
		[4] = "heiyigongji",
		[5] = "MainCharacter",
	},
	Title = "qingyun_2",
	EndTime = 6.7,
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
					Position = Vector3(175.88,31.54,187.21),
					Rotation = Vector3(19.17731,104.7619,358.3201),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(176.6021,32.1918,187.0247),
					OutTangent = Vector3(175.1579,30.8882,187.3953),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(174.7843,27.49128,187.4059),
					Rotation = Vector3(3.475299,103.5033,0.0006161703),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(175.0141,29.04053,187.4021),
					OutTangent = Vector3(174.5545,25.94203,187.4096),
				},
			},
			StartTime = 0,
			Duration = 2,
			CurrentState = 5,
			Title = "Path",
			EndTime = 2,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 4,
		},
		[2] = {
			IndexName = "xiaofanshaonian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0,0,0),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhangxiaofan",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[3] = {
			IndexName = "shenmiren",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(167.1329,25.94715,188.2251),
			Rotation = Vector3(0,21.79985,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "cangsong",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 1,
		},
		[4] = {
			IndexName = "MainCharacter",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(177.3994,25.76,188.0842),
			Rotation = Vector3(0,170.3603,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhujiao",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "Object Special",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectSpecialCreate",
			ParentId = 5,
		},
		[5] = {
			ObjectName = "cangsong",
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
					Position = Vector3(151.79,26.58,165.47),
					Rotation = Vector3(0,21.79985,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(151.79,26.58,165.47),
					OutTangent = Vector3(151.79,26.58,165.47),
				},
				[2] = {
					NodeTime = 3.8,
					Position = Vector3(174.7,26.32,185.62),
					Rotation = Vector3(0,21.79985,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(174.7,26.32,185.62),
					OutTangent = Vector3(174.7,26.32,185.62),
				},
				[3] = {
					NodeTime = 4.3,
					Position = Vector3(174.5,26.62,183.7),
					Rotation = Vector3(0,0,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(174.5,26.62,183.7),
					OutTangent = Vector3(174.5,26.62,183.7),
				},
			},
			StartTime = 0.2,
			Duration = 4.1,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 4.3,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 2,
		},
		[6] = {
			ObjectName = "zhujiao",
			IsLoop = true,
			StateName = "walk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.2,
			Duration = 1,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 1.2,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 14,
		},
		[7] = {
			ObjectName = "zhujiao",
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
					Position = Vector3(181.49,26.332,186.36),
					Rotation = Vector3(0,270.6519,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(181.49,26.332,186.36),
					OutTangent = Vector3(181.49,26.332,186.36),
				},
				[2] = {
					NodeTime = 2.5,
					Position = Vector3(176.196,26.332,187.0035),
					Rotation = Vector3(0,265.5282,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(176.196,26.332,187.0035),
					OutTangent = Vector3(176.196,26.332,187.0035),
				},
			},
			StartTime = 0.2,
			Duration = 2.7,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 2.9,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 16,
		},
		[8] = {
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
					Position = Vector3(183.63,26.26,184.71),
					Rotation = Vector3(0,291.6944,0),
					LocalScale = Vector3(0.9999996,1,0.9999996),
					InTangent = Vector3(183.63,26.26,184.71),
					OutTangent = Vector3(183.63,26.26,184.71),
				},
				[2] = {
					NodeTime = 4,
					Position = Vector3(177.95,26.32,186.99),
					Rotation = Vector3(0,288.58,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(177.95,26.32,186.99),
					OutTangent = Vector3(177.95,26.32,186.99),
				},
			},
			StartTime = 0.2,
			Duration = 4,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 4.2,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 6,
		},
		[9] = {
			ObjectName = "zhangxiaofan",
			IsLoop = false,
			StateName = "walk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.2499999,
			Duration = 1.066667,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 1.316667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 9,
		},
		[10] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_shanbai",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 6.133333,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0.5,
			Duration = 6.133333,
			CurrentState = 5,
			Title = "Back Sound",
			EndTime = 6.633333,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 15,
		},
		[11] = {
			ObjectName = "cangsong",
			IsLoop = false,
			StateName = "runfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.8100004,
			Duration = 1.8,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 2.610001,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[12] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_daqigu",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 5.134898,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 1.54,
			Duration = 5.134898,
			CurrentState = 5,
			Title = "Back Sound",
			EndTime = 6.674898,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 19,
		},
		[13] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "vox_boss_heiyicangsong_attack_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.370159,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0.3679246,0,0),
					[2] = UnityEngine.Keyframe(0.3772702,0.7037736,0,0),
					[3] = UnityEngine.Keyframe(1,1,0,0),
				},
			},
			StartTime = 1.98,
			Duration = 1.370159,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 3.350159,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 20,
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
					Position = Vector3(181.9816,27.526,189.0157),
					Rotation = Vector3(358.8344,237.0598,0.0006286142),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(181.9816,27.526,189.0157),
					OutTangent = Vector3(181.9816,27.526,189.0157),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(173.96,27.75,184.92),
					Rotation = Vector3(358.8344,237.0598,0.0006286142),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(173.96,27.75,184.92),
					OutTangent = Vector3(173.96,27.75,184.92),
				},
			},
			StartTime = 2,
			Duration = 1,
			CurrentState = 5,
			Title = "Path",
			EndTime = 3,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 4,
		},
		[15] = {
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
			StartTime = 2.25,
			Duration = 3.154218,
			CurrentState = 5,
			Title = "back_sound(Clone)",
			EndTime = 5.404218,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 22,
		},
		[16] = {
			ObjectName = "zhujiao",
			IsLoop = true,
			StateName = "jump",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 2.68,
			Duration = 0.5333334,
			CurrentState = 2,
			Title = "animator_play",
			EndTime = 3.213333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
		},
		[17] = {
			ObjectName = "zhujiao",
			SpeedValue = 1.2,
			Curve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 2.7,
			Duration = 1,
			CurrentState = 4,
			Mode = "Event",
			Title = "animator_speed",
			EndTime = 3.7,
			Type = "PlotDirector.PlotEventAnimatorSpeed",
			ParentId = 9,
		},
		[18] = {
			ObjectName = "zhujiao",
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
					Position = Vector3(177.3602,26.14,188.0402),
					Rotation = Vector3(0,219.6607,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(177.3602,26.14,188.0402),
					OutTangent = Vector3(177.3602,26.14,188.0402),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(176.194,26.332,187.0009),
					Rotation = Vector3(0,234.624,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(176.194,26.332,187.0009),
					OutTangent = Vector3(176.194,26.332,187.0009),
				},
			},
			StartTime = 2.9,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 3.9,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 5,
		},
		[19] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "[00CC00]{PlayerRoleName}[-]:  小心！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 3,
			Duration = 0.5,
			CurrentState = 5,
			Title = "talk",
			EndTime = 3.5,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 12,
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
					Position = Vector3(174.1581,29.0627,182.7309),
					Rotation = Vector3(21.86747,11.71572,0.0006913554),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(174.1581,29.0627,182.7309),
					OutTangent = Vector3(174.1581,29.0627,182.7309),
				},
				[2] = {
					NodeTime = 0.5,
					Position = Vector3(174.214,28.817,182.959),
					Rotation = Vector3(21.86747,11.71572,0.0006913554),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(174.214,28.817,182.959),
					OutTangent = Vector3(174.214,28.817,182.959),
				},
			},
			StartTime = 3,
			Duration = 0.5,
			CurrentState = 5,
			Title = "Path",
			EndTime = 3.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 4,
		},
		[21] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_2_1zhujue",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.8149433,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.01,
			Duration = 0.8149433,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 3.824944,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 13,
		},
		[22] = {
			ObjectName = "zhujiao",
			IsLoop = true,
			StateName = "jumploop",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 3.213333,
			Duration = 1,
			CurrentState = 2,
			Title = "animator_play",
			EndTime = 4.213333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 8,
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
					Position = Vector3(177.02,28.37,185.33),
					Rotation = Vector3(19.11733,311.5552,0.0006849347),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(176.2451,28.9011,184.0792),
					OutTangent = Vector3(177.7949,27.8389,186.5808),
				},
				[2] = {
					NodeTime = 1.2,
					Position = Vector3(177.688,27.26,189.203),
					Rotation = Vector3(353.678,214.6104,0.0006444628),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(177.7358,27.38552,187.7933),
					OutTangent = Vector3(177.6402,27.13448,190.6127),
				},
			},
			StartTime = 3.5,
			Duration = 1.2,
			CurrentState = 5,
			Title = "Path",
			EndTime = 4.7,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 4,
		},
		[24] = {
			ObjectName = "zhangxiaofan",
			IsLoop = false,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 3.51,
			Duration = 1.4,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 4.91,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 14,
		},
		[25] = {
			ObjectName = "cangsong",
			IsLoop = false,
			StateName = "attack02",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 3.51,
			Duration = 0.9666668,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 4.476667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 1,
		},
		[26] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "vox_boss_heiyicangsong_attack_03",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.189229,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.66,
			Duration = 1.189229,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 4.849229,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 20,
		},
		[27] = {
			ObjectName = "zhujiao",
			IsLoop = false,
			StateName = "attack01",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 3.7,
			Duration = 0.4333334,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 4.133333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 9,
		},
		[28] = {
			IndexName = "heiyigongji",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(175.01,26.54,185.78),
			Rotation = Vector3(0,55.39636,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "heiyigongji",
			StartTime = 3.8,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 4.8,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 18,
		},
		[29] = {
			IndexName = "zhuangji",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(175.493,27.483,186.33),
			Rotation = Vector3(0,265.5282,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhuangji",
			StartTime = 3.85,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 4.849999,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 17,
		},
		[30] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_magic_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.12678,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.859998,
			Duration = 1.12678,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 4.986777,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 21,
		},
		[31] = {
			ObjectName = "zhujiao",
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
					Position = Vector3(176.2006,26.332,187.0087),
					Rotation = Vector3(0,234.624,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(176.2006,26.332,187.0087),
					OutTangent = Vector3(176.2006,26.332,187.0087),
				},
				[2] = {
					NodeTime = 0.8,
					Position = Vector3(175.99,26.33,188.41),
					Rotation = Vector3(0,234.624,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(175.99,26.33,188.41),
					OutTangent = Vector3(175.99,26.33,188.41),
				},
			},
			StartTime = 3.9,
			Duration = 0.8,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 4.7,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 5,
		},
		[32] = {
			ObjectName = "zhujiao",
			IsLoop = false,
			StateName = "attack01end",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 4.2,
			Duration = 0.4333334,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 4.633333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 6,
		},
		[33] = {
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
					Position = Vector3(177.9895,26.31958,186.9741),
					Rotation = Vector3(0,272.2145,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(177.9895,26.31958,186.9741),
					OutTangent = Vector3(177.9895,26.31958,186.9741),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(177.9895,26.31958,186.9741),
					Rotation = Vector3(0,272.2145,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(177.9895,26.31958,186.9741),
					OutTangent = Vector3(177.9895,26.31958,186.9741),
				},
			},
			StartTime = 4.34,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 5.34,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 8,
		},
		[34] = {
			ObjectName = "cangsong",
			IsLoop = false,
			StateName = "idle",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 4.44,
			Duration = 2.5,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 6.94,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 1,
		},
		[35] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "[00CC00]{PlayerRoleName}[-]:  什么人！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 4.7,
			Duration = 2,
			CurrentState = 5,
			Title = "talk",
			EndTime = 6.7,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 12,
		},
		[36] = {
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
					Position = Vector3(173.52,28.2,185.85),
					Rotation = Vector3(11.55432,45.98911,0.000647039),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(173.52,28.2,185.85),
					OutTangent = Vector3(173.52,28.2,185.85),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(174.07,28.2,186.24),
					Rotation = Vector3(11.55432,45.98911,0.000647039),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(174.07,28.2,186.24),
					OutTangent = Vector3(174.07,28.2,186.24),
				},
			},
			StartTime = 4.7,
			Duration = 2,
			CurrentState = 5,
			Title = "Path",
			EndTime = 6.7,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 4,
		},
		[37] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_2_2zhujue",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.45214,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 4.719997,
			Duration = 1.45214,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 6.172137,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 13,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene