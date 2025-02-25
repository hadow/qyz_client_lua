local Plot = require("plot.plot")

PlotCutscene = {
	PlayRate = 1,
	config = {
		isLooping = false,
		isSkippable = true,
		independentMusic = true,
		hideUI = true,
		hideCharacter = true,
		showBorder = false,
		showCurtain = true,
		fadeInOutTime = 0.7,
		mainCameraControl = true,
		previewMode = false,
	},
	StartTime = 0,
	Duration = 17.8,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "luxueqi",
		[2] = "xh2",
		[3] = "xh1",
		[4] = "tianyajianguang",
		[5] = "xueqituowei",
	},
	Title = "xueqiqi",
	EndTime = 17.8,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "xueqituowei",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(-0.485,1.114,-0.005),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "zuowei",
			StartTime = 0,
			Duration = 0.58,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 0.58,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 11,
		},
		[2] = {
			IndexName = "xh2",
			Active = false,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0,0,0),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "cg_npc_luxueqi_02_hydf_3",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 6,
		},
		[3] = {
			IndexName = "tianyajianguang",
			Active = false,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0.047,1.334,-0.118),
			Rotation = Vector3(329.0524,269.9091,283.9654),
			LocalScale = Vector3(1,1,1),
			ObjectName = "tianyajian",
			StartTime = 0,
			Duration = 0.17,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.17,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 9,
		},
		[4] = {
			IndexName = "xueqituowei",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0.474,1.114,-0.005),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "youwei",
			StartTime = 0,
			Duration = 0.58,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.58,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 10,
		},
		[5] = {
			IndexName = "xh2",
			Active = false,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0,0,0),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "cg_npc_luxueqi_01_hydf_1",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
		},
		[6] = {
			IndexName = "xh2",
			Active = false,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0,0,0),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "cg_npc_luxueqi_02_hydf_4",
			StartTime = 0,
			Duration = 0.18,
			CurrentState = 5,
			Title = "object_create(clone)(clone)",
			EndTime = 0.18,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 7,
		},
		[7] = {
			IndexName = "xh1",
			Active = false,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0,0,0),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "cg_npc_luxueqi_02_hydf_5",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create(clone)(clone)",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 8,
		},
		[8] = {
			IndexName = "luxueqi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0,0,0),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "xueqi",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 3,
		},
		[9] = {
			IndexName = "xh1",
			Active = false,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(0,0,0),
			Rotation = Vector3(0,0,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "cg_npc_luxueqi_01_hydf_2",
			StartTime = 0,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_create(clone)",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 5,
		},
		[10] = {
			ObjectName = "tianyajian",
			ParentName = "xueqi/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand/Jian",
			StartTime = 0.17,
			Duration = 1,
			CurrentState = 5,
			Title = "object_parent",
			EndTime = 1.17,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 9,
		},
		[11] = {
			ObjectName = "cg_npc_luxueqi_02_hydf_4",
			ParentName = "xueqi",
			StartTime = 0.18,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_parent(clone)",
			EndTime = 0.38,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 7,
		},
		[12] = {
			ObjectName = "cg_npc_luxueqi_02_hydf_3",
			ParentName = "xueqi",
			StartTime = 0.2,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_parent(clone)",
			EndTime = 0.4,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 6,
		},
		[13] = {
			ObjectName = "cg_npc_luxueqi_02_hydf_5",
			ParentName = "xueqi",
			StartTime = 0.2,
			Duration = 0.24,
			CurrentState = 5,
			Title = "object_parent(clone)",
			EndTime = 0.44,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 8,
		},
		[14] = {
			ObjectName = "cg_npc_luxueqi_01_hydf_2",
			ParentName = "xueqi",
			StartTime = 0.2,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_parent(clone)",
			EndTime = 0.4,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 5,
		},
		[15] = {
			ObjectName = "cg_npc_luxueqi_01_hydf_1",
			ParentName = "xueqi",
			StartTime = 0.2,
			Duration = 0.2,
			CurrentState = 5,
			Title = "object_parent",
			EndTime = 0.4,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 4,
		},
		[16] = {
			ObjectName = "cg_npc_luxueqi_02_hydf_4",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(2.14,3.007,-7.204),
			Rotation = Vector3(-10.00851,-21.90826,156.6285),
			LocalScale = Vector3(0.8,0.8,0.8),
			StartTime = 0.38,
			Duration = 1,
			CurrentState = 5,
			Title = "object_transform(clone)",
			EndTime = 1.38,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 7,
		},
		[17] = {
			ObjectName = "cg_npc_luxueqi_01_hydf_1",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(-1.51,2.8,-7.78),
			Rotation = Vector3(10.69946,106.2752,-27.71677),
			LocalScale = Vector3(0.8,0.8,0.8),
			StartTime = 0.4,
			Duration = 1,
			CurrentState = 5,
			Title = "object_transform(clone)(clone)",
			EndTime = 1.4,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 4,
		},
		[18] = {
			ObjectName = "cg_npc_luxueqi_02_hydf_3",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(0.83,2.34,-8.01),
			Rotation = Vector3(0,0,139.3188),
			LocalScale = Vector3(0.8,0.8,0.8),
			StartTime = 0.4,
			Duration = 1,
			CurrentState = 5,
			Title = "object_transform(clone)",
			EndTime = 1.4,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 6,
		},
		[19] = {
			ObjectName = "cg_npc_luxueqi_01_hydf_2",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(-0.74,2.5,-7.98),
			Rotation = Vector3(329.0758,259.4077,356.8262),
			LocalScale = Vector3(1,1,1),
			StartTime = 0.4,
			Duration = 1,
			CurrentState = 5,
			Title = "object_transform(clone)",
			EndTime = 1.4,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 5,
		},
		[20] = {
			ObjectName = "cg_npc_luxueqi_02_hydf_5",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(1.91,3.24,-5.900001),
			Rotation = Vector3(316.9359,125.1366,30.02355),
			LocalScale = Vector3(0.8,0.8,0.8),
			StartTime = 0.44,
			Duration = 1,
			CurrentState = 5,
			Title = "object_transform(clone)",
			EndTime = 1.44,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 8,
		},
		[21] = {
			ObjectName = "youwei",
			ParentName = "xueqi/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand",
			StartTime = 0.58,
			Duration = 1,
			CurrentState = 5,
			Title = "object_parent(clone)",
			EndTime = 1.58,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 10,
		},
		[22] = {
			ObjectName = "zuowei",
			ParentName = "xueqi/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 L Clavicle/Bip001 L UpperArm/Bip001 L Forearm/Bip001 L Hand",
			StartTime = 0.58,
			Duration = 1,
			CurrentState = 5,
			Title = "object_parent(clone)(clone)",
			EndTime = 1.58,
			Type = "PlotDirector.PlotEventObjectParent",
			ParentId = 11,
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
					Position = Vector3(41.10365,2.817832,66.56635),
					Rotation = Vector3(344.4908,355.962,-0.002116132),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(41.10365,2.817832,66.56635),
					OutTangent = Vector3(41.10365,2.817832,66.56635),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(41.10365,2.817832,66.56635),
					Rotation = Vector3(344.4908,355.962,-0.002116132),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(41.10365,2.817832,66.56635),
					OutTangent = Vector3(41.10365,2.817832,66.56635),
				},
			},
			StartTime = 2.8,
			Duration = 1.96,
			CurrentState = 5,
			Title = "Path",
			EndTime = 4.76,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[24] = {
			ObjectName = "tianyajian",
			Active = true,
			StartTime = 4.190001,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 5.190001,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 11,
		},
		[25] = {
			ObjectName = "xueqi",
			IsLoop = false,
			StateName = "CG_illusion2",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 4.459999,
			Duration = 7.1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 11.56,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 3,
		},
		[26] = {
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
					Position = Vector3(41.10365,2.817832,66.56635),
					Rotation = Vector3(344.4908,355.962,-0.002116132),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(41.10365,2.817832,66.56635),
					OutTangent = Vector3(41.10365,2.817832,66.56635),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(40.44794,1.627457,67.80612),
					Rotation = Vector3(352.3977,356.4773,-0.002056622),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(40.44794,1.627457,67.80612),
					OutTangent = Vector3(40.44794,1.627457,67.80612),
				},
			},
			StartTime = 6.709994,
			Duration = 1,
			CurrentState = 5,
			Title = "path",
			EndTime = 7.709994,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[27] = {
			ObjectName = "cg_npc_luxueqi_01_hydf_1",
			Active = true,
			StartTime = 7.436505,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 8.436504,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 4,
		},
		[28] = {
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
					Position = Vector3(40.44794,1.627457,67.80612),
					Rotation = Vector3(352.3977,356.4773,-0.002056622),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(40.11844,1.64943,67.95068),
					OutTangent = Vector3(40.77745,1.605485,67.66156),
				},
				[2] = {
					NodeTime = 0.7799883,
					Position = Vector3(41.4384,1.120021,69.11618),
					Rotation = Vector3(342.2564,348.0552,-0.002144228),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(41.35149,1.044142,68.85538),
					OutTangent = Vector3(41.52531,1.195901,69.37698),
				},
			},
			StartTime = 8.530012,
			Duration = 0.7799883,
			CurrentState = 5,
			Title = "path",
			EndTime = 9.31,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[29] = {
			ObjectName = "cg_npc_luxueqi_01_hydf_2",
			Active = true,
			StartTime = 8.899609,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide(clone)",
			EndTime = 9.899609,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 5,
		},
		[30] = {
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
					Position = Vector3(41.4384,1.120021,69.11618),
					Rotation = Vector3(342.2564,348.0552,-0.002144228),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(41.37867,1.2532,69.52897),
					OutTangent = Vector3(41.49813,0.986843,68.70339),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(42.56912,1.275343,70.23582),
					Rotation = Vector3(355.6635,358.4358,-0.002047126),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(42.0223,1.244891,69.81889),
					OutTangent = Vector3(43.11594,1.305796,70.65276),
				},
			},
			StartTime = 9.31,
			Duration = 1,
			CurrentState = 5,
			Title = "path",
			EndTime = 10.31,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[31] = {
			ObjectName = "cg_npc_luxueqi_02_hydf_3",
			Active = true,
			StartTime = 10.18966,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide(clone)",
			EndTime = 11.18966,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 6,
		},
		[32] = {
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
					Position = Vector3(42.56912,1.275343,70.23582),
					Rotation = Vector3(355.6635,358.4358,-0.002047126),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(42.55674,1.309747,70.68935),
					OutTangent = Vector3(42.58151,1.240939,69.7823),
				},
				[2] = {
					NodeTime = 1,
					Position = Vector3(43.45177,1.011456,70.08211),
					Rotation = Vector3(349.8195,354.8265,-0.002072834),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(43.01912,0.9706427,69.81464),
					OutTangent = Vector3(43.88441,1.052269,70.34957),
				},
			},
			StartTime = 10.31,
			Duration = 1,
			CurrentState = 5,
			Title = "path",
			EndTime = 11.31,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[33] = {
			ObjectName = "cg_npc_luxueqi_02_hydf_5",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(43.19744,2.86,74.11147),
			Rotation = Vector3(316.9359,110.79,30.02351),
			LocalScale = Vector3(0.8,0.8,0.8),
			StartTime = 10.56,
			Duration = 1,
			CurrentState = 5,
			Title = "object_transform",
			EndTime = 11.56,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 8,
		},
		[34] = {
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
					Position = Vector3(43.45177,1.011456,70.08211),
					Rotation = Vector3(349.8195,354.8265,-0.002072834),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(43.45177,1.011456,70.08211),
					OutTangent = Vector3(43.45177,1.011456,70.08211),
				},
				[2] = {
					NodeTime = 2.849999,
					Position = Vector3(43.39957,1.593235,69.93495),
					Rotation = Vector3(341.78,2.131605,-1.011194E-06),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(43.39957,1.593235,69.93495),
					OutTangent = Vector3(43.39957,1.593235,69.93495),
				},
			},
			StartTime = 11.31,
			Duration = 2.849999,
			CurrentState = 5,
			Title = "path",
			EndTime = 14.16,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 1,
		},
		[35] = {
			ObjectName = "cg_npc_luxueqi_02_hydf_4",
			Active = true,
			StartTime = 11.69996,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide(clone)(clone)(clone)",
			EndTime = 12.69996,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 7,
		},
		[36] = {
			ObjectName = "cg_npc_luxueqi_02_hydf_5",
			Active = true,
			StartTime = 12.109,
			Duration = 1,
			CurrentState = 5,
			Title = "object_show_hide(clone)(clone)",
			EndTime = 13.109,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 8,
		},
		[37] = {
			ObjectName = "xueqi",
			SpeedValue = 0,
			Curve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 13.51,
			Duration = 4.22,
			CurrentState = 4,
			Mode = "Event",
			Title = "animator_speed",
			EndTime = 17.73,
			Type = "PlotDirector.PlotEventAnimatorSpeed",
			ParentId = 3,
		},
		[38] = {
			ObjectName = "xueqi",
			PositionVary = true,
			RotationVary = true,
			ScaleVary = true,
			Position = Vector3(41.86,-0.27,80.89),
			Rotation = Vector3(0,0.36,0),
			LocalScale = Vector3(1,1,1),
			StartTime = 16.97,
			Duration = 1,
			CurrentState = 5,
			Title = "object_transform(Clone)",
			EndTime = 17.97,
			Type = "PlotDirector.PlotEventObjectTransform",
			ParentId = 5,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene