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
	Duration = 5.9,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "heiyigongji",
		[2] = "nianlaoda",
		[3] = "tianlinger",
		[4] = "linjingyu",
		[5] = "xiaofanchengnian",
		[6] = "MainCharacter",
	},
	Title = "qingyun_17",
	EndTime = 5.9,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "linjingyu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(200.23,-3.964172,127.71),
			Rotation = Vector3(0,269.79,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "jingyu",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 11,
		},
		[2] = {
			IndexName = "MainCharacter",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(201.38,-3.964172,128.49),
			Rotation = Vector3(0,269.79,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhujue",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "object_special",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectSpecialCreate",
			ParentId = 12,
		},
		[3] = {
			IndexName = "nianlaoda",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(142.0872,-4.004289,127.0229),
			Rotation = Vector3(0,264.57,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "nld",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[4] = {
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
					Position = Vector3(152.9546,-0.2380687,127.6853),
					Rotation = Vector3(358.3168,270.8623,-8.066306E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(152.9546,-0.2380687,127.6853),
					OutTangent = Vector3(152.9546,-0.2380687,127.6853),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(141.8867,-0.1912134,127.3196),
					Rotation = Vector3(5.364126,266.5652,-7.224681E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(141.8867,-0.1912134,127.3196),
					OutTangent = Vector3(141.8867,-0.1912134,127.3196),
				},
			},
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "Path",
			EndTime = 1,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[5] = {
			IndexName = "tianlinger",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(141.9212,-2.619,127.6539),
			Rotation = Vector3(-1.866934E-05,77.80013,180),
			LocalScale = Vector3(1,1,1),
			ObjectName = "tianlinger",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 7,
		},
		[6] = {
			IndexName = "xiaofanchengnian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(201.15,-3.964172,129.89),
			Rotation = Vector3(0,269.79,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xiaofan",
			StartTime = 0,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 13,
		},
		[7] = {
			ObjectName = "tianlinger",
			ParentName = "nld",
			StartTime = 0.1,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_parent(clone)",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 7,
		},
		[8] = {
			ObjectName = "nld",
			IsLoop = true,
			StateName = "runfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.2,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 1.2,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 6,
		},
		[9] = {
			ObjectName = "nld",
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
					Position = Vector3(142.0872,-2.669,127.0229),
					Rotation = Vector3(0,264.57,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(142.0872,-2.669,127.0229),
					OutTangent = Vector3(142.0872,-2.669,127.0229),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(120.9183,1.3,128.0269),
					Rotation = Vector3(0,270.9,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(120.9183,1.3,128.0269),
					OutTangent = Vector3(120.9183,1.3,128.0269),
				},
			},
			StartTime = 0.2,
			Duration = 2,
			CurrentState = 5,
			Title = "object_path(clone)",
			EndTime = 2.2,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 16,
		},
		[10] = {
			ObjectName = "tianlinger",
			SpeedValue = 10,
			Curve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0.2,
			Duration = 1,
			CurrentState = 4,
			Mode = "Event",
			Title = "Animator Speed",
			EndTime = 1.2,
			Type = "PlotDirector.PlotEventAnimatorSpeed",
			ParentId = 8,
		},
		[11] = {
			ObjectName = "tianlinger",
			IsLoop = true,
			StateName = "float",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.2300003,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 1.23,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 17,
		},
		[12] = {
			ObjectName = "xiaofan",
			IsLoop = true,
			StateName = "CG_helfkneel",
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
			ParentId = 13,
		},
		[13] = {
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
					Position = Vector3(130.2599,0.9396186,131.192),
					Rotation = Vector3(12.23968,164.6359,-7.436791E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(130.2599,0.9396186,131.192),
					OutTangent = Vector3(130.2599,0.9396186,131.192),
				},
				[2] = {
					NodeTime = 1.14,
					Position = Vector3(130.2599,0.93962,131.192),
					Rotation = Vector3(9.833254,223.9371,-7.278629E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(130.2599,0.93962,131.192),
					OutTangent = Vector3(130.2599,0.93962,131.192),
				},
			},
			StartTime = 1,
			Duration = 1.14,
			CurrentState = 5,
			Title = "Path",
			EndTime = 2.14,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[14] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_ex_wind_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.480658,
			Is3DSound = false,
			Position = Vector3(40,0,84.2),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 1.48,
			Duration = 1.480658,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 2.960658,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 18,
		},
		[15] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_explo_mid_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.595737,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 1.88,
			Duration = 2.595737,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 4.475738,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 20,
		},
		[16] = {
			IndexName = "heiyigongji",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(125.7883,1.91,126.6869),
			Rotation = Vector3(89.58979,180,180),
			LocalScale = Vector3(1,1,1),
			ObjectName = "hycs",
			StartTime = 2,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 3,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 6,
		},
		[17] = {
			IndexName = "heiyigongji",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(125.7883,1.91,127.5969),
			Rotation = Vector3(89.58979,180,180),
			LocalScale = Vector3(1,1,1),
			ObjectName = "hycs2",
			StartTime = 2.1,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create(Clone)",
			EndTime = 3.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
		},
		[18] = {
			IndexName = "heiyigongji",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(125.7883,1.92,125.9369),
			Rotation = Vector3(89.58979,180,180),
			LocalScale = Vector3(1,1,1),
			ObjectName = "hycs1",
			StartTime = 2.1,
			Duration = 1.04,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 3.14,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 7,
		},
		[19] = {
			IndexName = "heiyigongji",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(125.7883,1.92,124.9769),
			Rotation = Vector3(89.58979,180,180),
			LocalScale = Vector3(1,1,1),
			ObjectName = "hycs4",
			StartTime = 2.2,
			Duration = 0.8099999,
			CurrentState = 5,
			Title = "Object Create(Clone)",
			EndTime = 3.01,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 11,
		},
		[20] = {
			IndexName = "heiyigongji",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(125.7883,1.9,128.4469),
			Rotation = Vector3(89.58979,180,180),
			LocalScale = Vector3(1,1,1),
			ObjectName = "hycs3",
			StartTime = 2.2,
			Duration = 0.8099999,
			CurrentState = 5,
			Title = "Object Create(Clone)",
			EndTime = 3.01,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 10,
		},
		[21] = {
			ObjectName = "nld",
			Active = false,
			StartTime = 2.2,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Show Hide",
			EndTime = 3.2,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 9,
		},
		[22] = {
			IndexName = "heiyigongji",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(125.7883,1.89,129.1269),
			Rotation = Vector3(89.58979,180,180),
			LocalScale = Vector3(1,1,1),
			ObjectName = "hycs6",
			StartTime = 2.3,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create(Clone)",
			EndTime = 3.3,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 13,
		},
		[23] = {
			IndexName = "heiyigongji",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(125.7883,1.93,124.1069),
			Rotation = Vector3(89.58979,180,180),
			LocalScale = Vector3(1,1,1),
			ObjectName = "hycs5",
			StartTime = 2.3,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create(Clone)",
			EndTime = 3.3,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 12,
		},
		[24] = {
			ObjectName = "jingyu",
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
					Position = Vector3(200.23,-3.964172,127.71),
					Rotation = Vector3(0,269.79,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(200.23,-3.964172,127.71),
					OutTangent = Vector3(200.23,-3.964172,127.71),
				},
				[2] = {
					NodeTime = 3.57,
					Position = Vector3(181.17,-3.964172,127.64),
					Rotation = Vector3(0,269.79,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(181.17,-3.964172,127.64),
					OutTangent = Vector3(181.17,-3.964172,127.64),
				},
			},
			StartTime = 3.01,
			Duration = 2.779999,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 5.789999,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 10,
		},
		[25] = {
			ObjectName = "jingyu",
			IsLoop = true,
			StateName = "runfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 3.01,
			Duration = 2.81,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 5.82,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 11,
		},
		[26] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "林惊羽：  看好小凡，我去救人！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 3.19,
			Duration = 1.46,
			CurrentState = 5,
			Title = "talk",
			EndTime = 4.65,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 15,
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
					Position = Vector3(205.6089,-2.692696,127.6979),
					Rotation = Vector3(3.746768,267.7809,0.005436069),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(205.6089,-2.692696,127.6979),
					OutTangent = Vector3(205.6089,-2.692696,127.6979),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(205.6089,-2.692696,127.6979),
					Rotation = Vector3(3.746768,267.7809,0.005435642),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(205.6089,-2.692696,127.6979),
					OutTangent = Vector3(205.6089,-2.692696,127.6979),
				},
			},
			StartTime = 3.19,
			Duration = 1,
			CurrentState = 5,
			Title = "path",
			EndTime = 4.19,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[28] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_17_1",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.401202,
			Is3DSound = false,
			Position = Vector3(40,0,84.2),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.190001,
			Duration = 1.401202,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 4.591202,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 19,
		},
		[29] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "skill_qingyunmen_skl03_90008",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.333243,
			Is3DSound = false,
			Position = Vector3(40,0,84.2),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.7,
			Duration = 1.333243,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 5.033243,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 18,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene