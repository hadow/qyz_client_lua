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
	Duration = 8,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "nianlaoda",
		[2] = "diliebao",
		[3] = "lianxuetangshashou",
		[4] = "cg_dibo",
		[5] = "gwfeishou",
	},
	Title = "caomiao_boss_3",
	EndTime = 8,
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
					Position = Vector3(442.0415,18.20227,119.2501),
					Rotation = Vector3(8.114356,57.96582,1.703255E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(442.0415,18.20227,119.2501),
					OutTangent = Vector3(442.0415,18.20227,119.2501),
				},
				[2] = {
					NodeTime = 3.63,
					Position = Vector3(445.2767,17.42827,121.3288),
					Rotation = Vector3(11.38021,57.27832,1.611158E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(445.2767,17.42827,121.3288),
					OutTangent = Vector3(445.2767,17.42827,121.3288),
				},
			},
			StartTime = 0,
			Duration = 3.63,
			CurrentState = 5,
			Title = "path",
			EndTime = 3.63,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[2] = {
			IndexName = "gwfeishou",
			Active = false,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(448.463,16.577,123.469),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "shou",
			StartTime = 0,
			Duration = 0.2099998,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.2099998,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 6,
		},
		[3] = {
			IndexName = "nianlaoda",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(455.13,14.89,126.43),
			Rotation = Vector3(0,242.37,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "nianlaoda",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[4] = {
			IndexName = "lianxuetangshashou",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(447.9038,15.36555,124.879),
			Rotation = Vector3(0,159.33,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "dizi",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[5] = {
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
			StartTime = 0.06,
			Duration = 3.530249,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 3.590249,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 8,
		},
		[6] = {
			ObjectName = "nianlaoda",
			IsLoop = true,
			StateName = "walk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.1,
			Duration = 3.15,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 3.25,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[7] = {
			ObjectName = "nianlaoda",
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
					Position = Vector3(455.13,14.89,126.43),
					Rotation = Vector3(0,246.3,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(455.13,14.89,126.43),
					OutTangent = Vector3(455.13,14.89,126.43),
				},
				[2] = {
					NodeTime = 3.5,
					Position = Vector3(448.6558,15.611,123.13),
					Rotation = Vector3(0,242.37,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(448.6558,15.611,123.13),
					OutTangent = Vector3(448.6558,15.611,123.13),
				},
			},
			StartTime = 0.1,
			Duration = 3.5,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 3.6,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 3,
		},
		[8] = {
			ObjectName = "dizi",
			IsLoop = true,
			StateName = "stun",
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
			ParentId = 4,
		},
		[9] = {
			ObjectName = "nianlaoda",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 1,
			StartTime = 3.25,
			Duration = 0.3699999,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 3.62,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[10] = {
			ObjectName = "shou",
			ParentName = "nianlaoda/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand",
			StartTime = 3.36,
			Duration = 0.06999993,
			CurrentState = 5,
			Title = "object_parent",
			EndTime = 3.43,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 6,
		},
		[11] = {
			ObjectName = "shou",
			Active = true,
			StartTime = 3.57,
			Duration = 0.1900001,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 3.76,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 7,
		},
		[12] = {
			ObjectName = "nianlaoda",
			IsLoop = true,
			StateName = "skill02",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.2,
			StartTime = 3.62,
			Duration = 1.4,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 5.02,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[13] = {
			ObjectName = "nianlaoda",
			SpeedValue = 2.5,
			Curve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.63,
			Duration = 0.8,
			CurrentState = 4,
			Mode = "Event",
			Title = "animator_speed",
			EndTime = 4.43,
			Type = "PlotDirector.PlotEventAnimatorSpeed",
			ParentId = 6,
		},
		[14] = {
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
			StartTime = 3.772086,
			Duration = 4.107914,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 7.88,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 8,
		},
		[15] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_magic_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.9697732,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 4.779998,
			Duration = 0.9697732,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 5.749771,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 9,
		},
		[16] = {
			IndexName = "diliebao",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(447.9038,15.36555,124.879),
			Rotation = Vector3(0,159.33,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "baopo",
			StartTime = 4.989997,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 5.989997,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[17] = {
			IndexName = "cg_dibo",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(447.9038,15.842,124.879),
			Rotation = Vector3(0,159.33,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "dibo",
			StartTime = 4.999998,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 5.999998,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[18] = {
			ObjectName = "dizi",
			IsLoop = true,
			StateName = "dying",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 5.019993,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 6.019993,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 6,
		},
		[19] = {
			ObjectName = "nianlaoda",
			IsLoop = true,
			StateName = "standfight",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.5,
			StartTime = 5.02,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 6.02,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[20] = {
			ObjectName = "shou",
			Active = false,
			StartTime = 5.27,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 6.27,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 7,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene