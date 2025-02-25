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
	Duration = 9,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "baofu",
		[2] = "MainCharacter",
	},
	Title = "caomiao_3",
	EndTime = 9,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			AudioMode = "BackMusic",
			LoadMode = "Delay",
			IndexName = "bgm_cg_03",
			Looping = false,
			StartPlayPos = 10.10069,
			EndPlayPos = 18.98231,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0,0,0),
					[2] = UnityEngine.Keyframe(0.5859576,0.7231621,-0.0005960464,-0.0005960464),
					[3] = UnityEngine.Keyframe(8.229294,0.5985363,-0.03344757,-0.03344757),
					[4] = UnityEngine.Keyframe(8.881626,0,0,0),
				},
			},
			StartTime = 0,
			Duration = 8.881626,
			CurrentState = 5,
			Title = "back_music",
			EndTime = 8.881626,
			Type = "PlotDirector.PlotEventBackMusic",
			ParentId = 17,
		},
		[2] = {
			MaskName = "Back",
			Mode = "Keep",
			MaskValue = 1,
			MaskColor = Color(0,0,0,1),
			StartTime = 0,
			Duration = 0.5,
			CurrentState = 0,
			Title = "mask",
			EndTime = 0.5,
			Type = "PlotDirector.PlotEventCameraMask",
			ParentId = 11,
		},
		[3] = {
			IndexName = "baofu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(353.814,17.492,67.422),
			Rotation = Vector3(3.642746,88.07733,1.41387),
			LocalScale = Vector3(1.8,1.8,1.8),
			ObjectName = "xueji2",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 13,
		},
		[4] = {
			IndexName = "MainCharacter",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(351.1586,17.86709,69.71879),
			Rotation = Vector3(0,240.1,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhujiao",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "Object Special",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectSpecialCreate",
			ParentId = 1,
		},
		[5] = {
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
					Position = Vector3(330.6736,21.50086,82.32797),
					Rotation = Vector3(5.431956,111.6679,0.0001387208),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(330.4654,17.47097,82.32462),
					OutTangent = Vector3(330.8819,25.53075,82.33133),
				},
				[2] = {
					NodeTime = 5,
					Position = Vector3(333.0209,27.12317,81.02898),
					Rotation = Vector3(14.36991,112.6993,0.0001370496),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(333.0209,27.12317,81.02898),
					OutTangent = Vector3(333.0209,27.12318,81.02898),
				},
			},
			StartTime = 0,
			Duration = 5,
			CurrentState = 5,
			Title = "Path",
			EndTime = 5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 7,
		},
		[6] = {
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
					Position = Vector3(335.7,19.35,81.41),
					Rotation = Vector3(0,122.4353,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(335.7,19.35,81.41),
					OutTangent = Vector3(335.7,19.35,81.41),
				},
				[2] = {
					NodeTime = 4.5,
					Position = Vector3(351.1587,17.86709,69.7188),
					Rotation = Vector3(0,124.5932,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(351.1587,17.86709,69.7188),
					OutTangent = Vector3(351.1587,17.86709,69.7188),
				},
			},
			StartTime = 0.1,
			Duration = 4.5,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 4.6,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 3,
		},
		[7] = {
			ObjectName = "zhujiao",
			IsLoop = true,
			StateName = "run",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.5,
			Duration = 3.869998,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 4.369998,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 6,
		},
		[8] = {
			MaskName = "Back",
			Mode = "FadeOut",
			MaskValue = 1,
			MaskColor = Color(0,0,0,1),
			StartTime = 0.5,
			Duration = 0.5,
			CurrentState = 0,
			Title = "mask",
			EndTime = 1,
			Type = "PlotDirector.PlotEventCameraMask",
			ParentId = 11,
		},
		[9] = {
			ObjectName = "zhujiao",
			IsLoop = false,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.5,
			StartTime = 4.369998,
			Duration = 2.666667,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 7.036665,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 6,
		},
		[10] = {
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
					Position = Vector3(351.5619,20.17086,69.3821),
					Rotation = Vector3(35.68407,130.3717,0.0001093172),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(351.5619,20.17086,69.3821),
					OutTangent = Vector3(351.5619,20.17086,69.3821),
				},
				[2] = {
					NodeTime = 0.5,
					Position = Vector3(352.9767,18.72297,68.18221),
					Rotation = Vector3(45.65343,130.0279,0.0001148141),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(352.9767,18.72297,68.18221),
					OutTangent = Vector3(352.9767,18.72297,68.18221),
				},
				[3] = {
					NodeTime = 1.5,
					Position = Vector3(352.9767,18.72297,68.18221),
					Rotation = Vector3(45.65343,130.0279,0.0001148141),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(352.9767,18.72297,68.18221),
					OutTangent = Vector3(352.9767,18.72297,68.18221),
				},
			},
			StartTime = 5,
			Duration = 1.5,
			CurrentState = 5,
			Title = "Path",
			EndTime = 6.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 7,
		},
		[11] = {
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
			StartTime = 5.260003,
			Duration = 5.134898,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 10.3949,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 16,
		},
		[12] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "caomiao_3_1zhujue",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.320544,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 6.499998,
			Duration = 2.320544,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 8.820541,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 18,
		},
		[13] = {
			ObjectName = "zhujiao",
			IsLoop = false,
			StateName = "pullsword",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 6.5,
			Duration = 0.7666667,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 7.266666,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 15,
		},
		[14] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "[00CC00]{PlayerRoleName}[-]：  不好，她们可能遇到危险了！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 6.5,
			Duration = 2.5,
			CurrentState = 5,
			Title = "talk",
			EndTime = 9,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 9,
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
					Position = Vector3(354.6815,18.65747,67.79657),
					Rotation = Vector3(354.4309,298.2337,8.857018E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(354.6815,18.65747,67.79657),
					OutTangent = Vector3(354.6815,18.65747,67.79657),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(354.6815,18.65747,67.79657),
					Rotation = Vector3(354.4309,298.2337,8.857018E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(354.6815,18.65747,67.79657),
					OutTangent = Vector3(354.6815,18.65747,67.79657),
				},
			},
			StartTime = 6.5,
			Duration = 2,
			CurrentState = 5,
			Title = "Path",
			EndTime = 8.5,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 7,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene