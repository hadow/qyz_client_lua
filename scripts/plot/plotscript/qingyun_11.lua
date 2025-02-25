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
		[1] = "shihun",
		[2] = "xiaofanchengnian",
		[3] = "heiwu",
		[4] = "qilinbeng2",
		[5] = "pao",
		[6] = "bingshigui",
	},
	Title = "qingyun_11",
	EndTime = 11,
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
					Position = Vector3(46.48604,3.015527,164.1467),
					Rotation = Vector3(359.1761,348.6231,1.554296E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(46.48604,3.015527,164.1467),
					OutTangent = Vector3(46.48604,3.015527,164.1467),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(46.48604,3.015527,164.1467),
					Rotation = Vector3(359.1761,348.6231,1.554296E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(46.48604,3.015527,164.1467),
					OutTangent = Vector3(46.48604,3.015527,164.1467),
				},
			},
			StartTime = 0,
			Duration = 0.86,
			CurrentState = 5,
			Title = "Path",
			EndTime = 0.86,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[2] = {
			AudioMode = "BackMusic",
			LoadMode = "Delay",
			IndexName = "bgm_cg_03",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 11.04913,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0.07451271,0.8534091,0,0),
					[2] = UnityEngine.Keyframe(9.074561,0.7192066,-0.07638165,-0.07638165),
					[3] = UnityEngine.Keyframe(10.43945,0,0,0),
				},
			},
			StartTime = 0,
			Duration = 11.04913,
			CurrentState = 5,
			Title = "back_music",
			EndTime = 11.04913,
			Type = "PlotDirector.PlotEventBackMusic",
			ParentId = 11,
		},
		[3] = {
			IndexName = "bingshigui",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0,0,0),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1.5,1.5,1.5),
			ObjectName = "guaiwu",
			StartTime = 0,
			Duration = 0.2900004,
			CurrentState = 5,
			Title = "Object Create(Clone)",
			EndTime = 0.2900004,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[4] = {
			IndexName = "shihun",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(45.92,1.95,168.53),
			Rotation = Vector3(0,179.33,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "shihun",
			StartTime = 0,
			Duration = 0.15,
			CurrentState = 5,
			Title = "shihunweizhi(Clone)",
			EndTime = 0.15,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[5] = {
			IndexName = "xiaofanchengnian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(45.156,2.046,167.401),
			Rotation = Vector3(8.300002,294.5927,179.9999),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhangxiaofan",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "zhangxiaofanweizhi(clone)",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 5,
		},
		[6] = {
			IndexName = "heiwu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(45.95,3.707,170.927),
			Rotation = Vector3(270.0198,9.19806E-05,0),
			LocalScale = Vector3(0.02,0.05535215,0.05535215),
			ObjectName = "heiwu",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "heiwuchushengweizhi(Clone)",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 7,
		},
		[7] = {
			ObjectName = "zhangxiaofan/fabao_shihun",
			Active = false,
			StartTime = 0.1,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 6,
		},
		[8] = {
			ObjectName = "zhangxiaofan/Object001",
			Active = false,
			StartTime = 0.1,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 17,
		},
		[9] = {
			ObjectName = "zhangxiaofan",
			IsLoop = false,
			StateName = "dead",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.15,
			Duration = 0.1333334,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 0.2833335,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[10] = {
			ObjectName = "shihun",
			IsLoop = false,
			StateName = "CG_stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.15,
			Duration = 2.666667,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 2.816667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 4,
		},
		[11] = {
			ObjectName = "heiwu",
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
					Position = Vector3(45.98,3.707,170.927),
					Rotation = Vector3(270.0198,9.19806E-05,0),
					LocalScale = Vector3(0.02,0.05535215,0.05535215),
					InTangent = Vector3(45.98,3.707,170.927),
					OutTangent = Vector3(45.98,3.707,170.927),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(46.22998,2.286903,169.08),
					Rotation = Vector3(0,0,0),
					LocalScale = Vector3(0.05505006,0.05505006,0.05505006),
					InTangent = Vector3(46.22998,2.286903,169.08),
					OutTangent = Vector3(46.22998,2.286903,169.08),
				},
				[3] = {
					NodeTime = 5,
					Position = Vector3(45.95,-9.1,183.4),
					Rotation = Vector3(0,0,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(45.95,-9.1,183.4),
					OutTangent = Vector3(45.95,-9.1,183.4),
				},
			},
			StartTime = 0.63,
			Duration = 5,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 5.63,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 7,
		},
		[12] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_magic_shot_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.650181,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0.69,
			Duration = 3.650181,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 4.340181,
			Type = "PlotDirector.PlotEventBackSound",
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
					Position = Vector3(45.57945,3.421252,162.7015),
					Rotation = Vector3(353.6757,1.858308,2.024693E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(45.57945,3.421252,162.7015),
					OutTangent = Vector3(45.57945,3.421252,162.7015),
				},
				[2] = {
					NodeTime = 2,
					Position = Vector3(45.57945,3.421253,162.7015),
					Rotation = Vector3(329.2677,2.889682,1.986528E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(45.57945,3.421253,162.7015),
					OutTangent = Vector3(45.57945,3.421253,162.7015),
				},
			},
			StartTime = 0.86,
			Duration = 2,
			CurrentState = 5,
			Title = "Path",
			EndTime = 2.86,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
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
					Position = Vector3(83.68248,39.88789,102.6154),
					Rotation = Vector3(10,314.2457,1.452132E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(83.68248,39.88789,102.6154),
					OutTangent = Vector3(83.68248,39.88789,102.6154),
				},
				[2] = {
					NodeTime = 3.05,
					Position = Vector3(83.9588,39.88796,102.8991),
					Rotation = Vector3(10,315.6207,1.517153E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(83.9588,39.88796,102.8991),
					OutTangent = Vector3(83.9588,39.88796,102.8991),
				},
			},
			StartTime = 2.86,
			Duration = 3.05,
			CurrentState = 5,
			Title = "Path",
			EndTime = 5.91,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
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
					Position = Vector3(45.37674,6.034742,164.6188),
					Rotation = Vector3(289.2178,326.7933,-1.556274E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(45.37674,6.034742,164.6188),
					OutTangent = Vector3(45.37674,6.034742,164.6188),
				},
				[2] = {
					NodeTime = 0.8700004,
					Position = Vector3(45.37674,6.034746,164.6188),
					Rotation = Vector3(289.7334,328.6842,-2.022896E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(45.37674,6.034746,164.6188),
					OutTangent = Vector3(45.37674,6.034746,164.6188),
				},
			},
			StartTime = 5.91,
			Duration = 0.8700004,
			CurrentState = 5,
			Title = "Path",
			EndTime = 6.78,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[16] = {
			IndexName = "pao",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(45.92,48.65,168.53),
			Rotation = Vector3(90,179.33,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "baosi",
			StartTime = 6.19,
			Duration = 0.1700006,
			CurrentState = 5,
			Title = "Object Create(Clone)",
			EndTime = 6.360001,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 7,
		},
		[17] = {
			ObjectName = "baosi",
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
					Position = Vector3(45.92,48.65,168.53),
					Rotation = Vector3(90,179.33,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(45.92,48.65,168.53),
					OutTangent = Vector3(45.92,48.65,168.53),
				},
				[2] = {
					NodeTime = 0.5,
					Position = Vector3(45.91,2.4,169.54),
					Rotation = Vector3(90,179.33,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(45.91,2.4,169.54),
					OutTangent = Vector3(45.91,2.4,169.54),
				},
			},
			StartTime = 6.360001,
			Duration = 0.5,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 6.860001,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 7,
		},
		[18] = {
			TimeScaleValue = 0.6,
			StartTime = 6.360001,
			Duration = 0.5,
			CurrentState = 5,
			Mode = "Event",
			Title = "time_scale_set",
			EndTime = 6.860001,
			Type = "PlotDirector.PlotEventTimeScaleSet",
			ParentId = 10,
		},
		[19] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "skill_common_magic_shot_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.413515,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 6.440002,
			Duration = 1.413515,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 7.853517,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 13,
		},
		[20] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_explo_sml_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.828798,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 6.690001,
			Duration = 1.828798,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 8.518799,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
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
					Position = Vector3(46.37188,3.810205,163.7778),
					Rotation = Vector3(10.69248,346.2166,9.666061E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(46.37188,3.810205,163.7778),
					OutTangent = Vector3(46.37188,3.810205,163.7778),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(46.37188,3.810205,163.7778),
					Rotation = Vector3(10.69248,347.4198,1.053492E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(46.37188,3.810205,163.7778),
					OutTangent = Vector3(46.37188,3.810205,163.7778),
				},
			},
			StartTime = 6.78,
			Duration = 1,
			CurrentState = 5,
			Title = "Path",
			EndTime = 7.78,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[22] = {
			ObjectName = "guaiwu",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(45.81,1.95,169.23),
			Rotation = Vector3(0,164.6,0),
			LocalScale = Vector3(1.5,1.5,1.5),
			StartTime = 6.849999,
			Duration = 0.2900004,
			CurrentState = 5,
			Title = "Object Transform",
			EndTime = 7.139999,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 5,
		},
		[23] = {
			ObjectName = "baosi",
			Active = false,
			StartTime = 6.859998,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Show Hide",
			EndTime = 7.859998,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 6,
		},
		[24] = {
			IndexName = "qilinbeng2",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(45.91,1.98,169.54),
			Rotation = Vector3(90,179.33,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "baozha",
			StartTime = 6.860001,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 7.860001,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 7,
		},
		[25] = {
			ObjectName = "guaiwu",
			IsLoop = false,
			StateName = "skill01",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 7.14,
			Duration = 1.133333,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 8.273334,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 4,
		},
		[26] = {
			ObjectName = "shihun",
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
					Position = Vector3(45.92,1.95,168.53),
					Rotation = Vector3(0,179.33,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(45.92,1.95,168.53),
					OutTangent = Vector3(45.92,1.95,168.53),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(45.955,4.761,168.53),
					Rotation = Vector3(0,179.33,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(45.955,4.761,168.53),
					OutTangent = Vector3(45.955,4.761,168.53),
				},
			},
			StartTime = 7.159999,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Path",
			EndTime = 8.159999,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 9,
		},
		[27] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "vox_monster_xuhuan_attack_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.175465,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 7.21,
			Duration = 1.175465,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 8.385465,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 15,
		},
		[28] = {
			ObjectName = "guaiwu",
			SpeedValue = 0.6,
			Curve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 7.89,
			Duration = 2.72,
			CurrentState = 4,
			Mode = "Event",
			Title = "Animator Speed",
			EndTime = 10.61,
			Type = "PlotDirector.PlotEventAnimatorSpeed",
			ParentId = 5,
		},
		[29] = {
			ObjectName = "guaiwu",
			IsLoop = false,
			StateName = "attack01",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 8.889997,
			Duration = 1.066667,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 9.956663,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 4,
		},
		[30] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_blade_lag_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.6349887,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 9.379999,
			Duration = 0.6349887,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 10.01499,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 15,
		},
		[31] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "vox_monster_xuhuan_attack_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.208798,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 9.420002,
			Duration = 1.208798,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 10.6288,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene