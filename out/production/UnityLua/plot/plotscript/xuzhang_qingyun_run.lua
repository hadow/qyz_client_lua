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
	Duration = 13.3,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "paokushe",
		[2] = "qingyunfei",
		[3] = "qingyunshoufei",
		[4] = "machechengtu",
		[5] = "MainCharacter",
	},
	Title = "xuzhang_qingyun_run",
	EndTime = 13.3,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "qingyunfei",
			Active = false,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(121.36,178.13,324.99),
			Rotation = Vector3(0,322.95,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "qingfei",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 7,
		},
		[2] = {
			IndexName = "qingyunshoufei",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(118.367,177.783,329.598),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "shoufei1",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
		},
		[3] = {
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
			StartTime = 0,
			Duration = 3.154218,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 3.154218,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 12,
		},
		[4] = {
			IndexName = "paokushe",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(118.02,176.9,329.3),
			Rotation = Vector3(0,280,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "paokushe",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 5,
		},
		[5] = {
			IndexName = "MainCharacter",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(118.02,176.9,329.3),
			Rotation = Vector3(0,280,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zhujue",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_special",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectSpecialCreate",
			ParentId = 3,
		},
		[6] = {
			IndexName = "qingyunshoufei",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(117.906,177.79,329.064),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "shoufei2",
			StartTime = 0,
			Duration = 0.11,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 0.11,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[7] = {
			ObjectName = "paokushe/Camera001/empty",
			PositionFollow = true,
			RotationFollow = true,
			RelativePosition = Vector3(0,0,0),
			RelativeRotation = Vector3(0,0,0),
			PositionFollowFactor = -1,
			RotationFollowFactor = -1,
			StartTime = 0.09000001,
			Duration = 13.1,
			CurrentState = 5,
			Title = "follow",
			EndTime = 13.19,
			Type = "PlotDirector.PlotEventCameraFollow",
			ParentId = 2,
		},
		[8] = {
			ObjectName = "shoufei1",
			ParentName = "zhujue/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand",
			StartTime = 0.1,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_parent",
			EndTime = 0.3,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 8,
		},
		[9] = {
			ObjectName = "qingfei",
			ParentName = "zhujue/Bip001",
			StartTime = 0.1,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_parent",
			EndTime = 0.3,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 7,
		},
		[10] = {
			ObjectName = "shoufei2",
			ParentName = "zhujue/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 L Clavicle/Bip001 L UpperArm/Bip001 L Forearm/Bip001 L Hand",
			StartTime = 0.11,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_parent(clone)",
			EndTime = 0.31,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 9,
		},
		[11] = {
			ObjectName = "qingfei",
			Active = true,
			StartTime = 0.1600001,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 1.16,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 11,
		},
		[12] = {
			ObjectName = "zhujue",
			IsLoop = false,
			StateName = "run2",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.2,
			Duration = 12.33333,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 12.53333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 3,
		},
		[13] = {
			ObjectName = "paokushe",
			IsLoop = false,
			StateName = "qingyunrun2",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.2,
			Duration = 12.33333,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 12.53333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 5,
		},
		[14] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_swing_mid_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.5701814,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 1.43,
			Duration = 0.5701814,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 2.000181,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 13,
		},
		[15] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_swing_mid_01",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.5512472,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 2.219999,
			Duration = 0.5512472,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 2.771246,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[16] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_swing_mid_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.5701814,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Constant",
			VolumeValue = 0.2,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 2.4,
			Duration = 0.5701814,
			CurrentState = 5,
			Title = "back_sound(clone)",
			EndTime = 2.970181,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 15,
		},
		[17] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "skill_common_magic_shot_03",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.514399,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 2.61,
			Duration = 1.514399,
			CurrentState = 5,
			Title = "back_sound(Clone)",
			EndTime = 4.124399,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 16,
		},
		[18] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_swing_lag_03",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.8418821,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.31,
			Duration = 0.8418821,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 4.151882,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 13,
		},
		[19] = {
			ObjectName = "paokushe",
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
					Position = Vector3(118.02,176.9,329.3),
					Rotation = Vector3(0,280,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(118.02,176.9,329.3),
					OutTangent = Vector3(118.02,176.9,329.3),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(118.02,179.9,329.3),
					Rotation = Vector3(0,280,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(118.02,179.9,329.3),
					OutTangent = Vector3(118.02,179.9,329.3),
				},
			},
			StartTime = 3.5,
			Duration = 1,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 4.5,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 7,
		},
		[20] = {
			ObjectName = "zhujue",
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
					Position = Vector3(118.02,176.9,329.3),
					Rotation = Vector3(0,280,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(118.02,176.9,329.3),
					OutTangent = Vector3(118.02,176.9,329.3),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(118.02,179.9,329.3),
					Rotation = Vector3(0,280,0),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(118.02,179.9,329.3),
					OutTangent = Vector3(118.02,179.9,329.3),
				},
			},
			StartTime = 3.5,
			Duration = 1,
			CurrentState = 5,
			Title = "object_path",
			EndTime = 4.5,
			Type = "PlotDirector.PlotEventObjectPath",
			ParentId = 6,
		},
		[21] = {
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
			StartTime = 3.551246,
			Duration = 3.650181,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 7.201427,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[22] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "skill_common_magic_shot_03",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 1.514399,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 5.120007,
			Duration = 1.514399,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 6.634406,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 15,
		},
		[23] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "wpn_magic_shot_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 3.842698,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 5.889999,
			Duration = 3.842698,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 9.732697,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 13,
		},
		[24] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "footsteps_mount_02",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 0.4594331,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 8.52,
			Duration = 0.4594331,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 8.979434,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 14,
		},
		[25] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "cg_ling",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.393492,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 8.529999,
			Duration = 2.393492,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 10.92349,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 16,
		},
		[26] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "impact_stone_sml_02",
			Looping = false,
			StartPlayPos = 0.1054995,
			EndPlayPos = 1.125329,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0,0,0),
					[2] = UnityEngine.Keyframe(0.08444545,0.1977377,-0.1663563,-0.1663563),
					[3] = UnityEngine.Keyframe(1.010807,0.3106061,0,0),
				},
			},
			StartTime = 8.54,
			Duration = 1.019829,
			CurrentState = 5,
			Title = "back_sound",
			EndTime = 9.55983,
			Type = "PlotDirector.PlotEventBackSound",
			ParentId = 15,
		},
		[27] = {
			IndexName = "machechengtu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(110.78,180.5309,287.7379),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "mache",
			StartTime = 8.629997,
			Duration = 1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 9.629997,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene