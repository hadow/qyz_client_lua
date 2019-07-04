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
	Duration = 7,
	CurrentState = 5,
	AssetIndexList = {
		[1] = "xiaofanchengnian",
		[2] = "heiwu",
		[3] = "luxueqi",
	},
	Title = "qingyun_23",
	EndTime = 7,
	Type = "PlotDirector.PlotCutscene",
	ParentId = -1,
	PlotElements = {
		[1] = {
			IndexName = "luxueqi",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(433.945,12.98276,362.099),
			Rotation = Vector3(0,228.2,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "luxueqi",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 5,
		},
		[2] = {
			AudioMode = "BackMusic",
			LoadMode = "Delay",
			IndexName = "bgm_cg_03",
			Looping = false,
			StartPlayPos = 1.304931,
			EndPlayPos = 8.264564,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Curve",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {
					[1] = UnityEngine.Keyframe(0,0.8513258,0,0),
					[2] = UnityEngine.Keyframe(5.05723,0.7658637,-0.04024041,-0.04024041),
					[3] = UnityEngine.Keyframe(6.959632,0,0,0),
				},
			},
			StartTime = 0,
			Duration = 6.959632,
			CurrentState = 5,
			Title = "back_music",
			EndTime = 6.959632,
			Type = "PlotDirector.PlotEventBackMusic",
			ParentId = 9,
		},
		[3] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_23_1",
			Looping = false,
			StartPlayPos = 0,
			EndPlayPos = 2.623016,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 0,
			Duration = 2.623016,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 2.623016,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 11,
		},
		[4] = {
			IndexName = "xiaofanchengnian",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(432.2774,12.98276,360.7205),
			Rotation = Vector3(0,70.18124,0),
			LocalScale = Vector3(1,1,1),
			ObjectName = "dazhang",
			StartTime = 0,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_create",
			EndTime = 0.1,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 4,
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
					Position = Vector3(434.9653,15.0074,358.3708),
					Rotation = Vector3(14.81795,323.1156,-7.72751E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(434.7987,14.934,358.5927),
					OutTangent = Vector3(435.1318,15.0808,358.1489),
				},
				[2] = {
					NodeTime = 3,
					Position = Vector3(435.6536,14.7613,360.3725),
					Rotation = Vector3(16.36487,278.285,-9.966019E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(435.8682,14.82497,360.3413),
					OutTangent = Vector3(435.439,14.69762,360.4038),
				},
			},
			StartTime = 0,
			Duration = 3,
			CurrentState = 5,
			Title = "Path",
			EndTime = 3,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[6] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "陆雪琪：  小凡，守住本心！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 0,
			Duration = 3.299998,
			CurrentState = 5,
			Title = "talk",
			EndTime = 3.299998,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 8,
		},
		[7] = {
			ObjectName = "dazhang/fabao_shihun",
			Active = false,
			StartTime = 0.1,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 5,
		},
		[8] = {
			ObjectName = "dazhang",
			IsLoop = false,
			StateName = "CG_helfkneel",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.1,
			Duration = 1.833333,
			CurrentState = 5,
			Title = "Animator Play",
			EndTime = 1.933333,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 4,
		},
		[9] = {
			ObjectName = "dazhang/Object001",
			Active = false,
			StartTime = 0.1,
			Duration = 0.1,
			CurrentState = 5,
			Title = "object_show_hide",
			EndTime = 0.2,
			Type = "PlotDirector.PlotEventObjectShowHide",
			ParentId = 10,
		},
		[10] = {
			ObjectName = "luxueqi",
			IsLoop = false,
			StateName = "talk",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = false,
			TransitionDuration = 0,
			StartTime = 0.1900003,
			Duration = 2.9,
			CurrentState = 5,
			Title = "Animator Play(Clone)",
			EndTime = 3.09,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 6,
		},
		[11] = {
			IndexName = "heiwu",
			Active = true,
			SetParent = false,
			ParentName = "",
			SetTrans = true,
			Position = Vector3(432.6,1.42,362.5),
			Rotation = Vector3(0,320.1,0),
			LocalScale = Vector3(0.2,0.3,0.2),
			ObjectName = "heiwu",
			StartTime = 2.25,
			Duration = 1,
			CurrentState = 5,
			Title = "Object Create",
			EndTime = 3.25,
			Type = "PlotDirector.PlotEventObjectCreate",
			ParentId = 5,
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
					Position = Vector3(435.6536,14.7613,360.3725),
					Rotation = Vector3(16.36487,278.285,-9.966019E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(435.6536,14.7613,360.3725),
					OutTangent = Vector3(435.6536,14.7613,360.3725),
				},
				[2] = {
					NodeTime = 3.49,
					Position = Vector3(436.7756,15.08706,363.6987),
					Rotation = Vector3(16.36495,227.5465,-6.940623E-05),
					LocalScale = Vector3(1,1,1),
					InTangent = Vector3(437.884,15.08706,362.4872),
					OutTangent = Vector3(435.6673,15.08706,364.9102),
				},
			},
			StartTime = 2.79,
			Duration = 3.49,
			CurrentState = 5,
			Title = "Path",
			EndTime = 6.28,
			Type = "PlotDirector.PlotEventCameraPath",
			ParentId = 2,
		},
		[13] = {
			ObjectName = "dazhang",
			IsLoop = true,
			StateName = "stand",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.5,
			StartTime = 2.85,
			Duration = 1,
			CurrentState = 5,
			Title = "animator_play",
			EndTime = 3.85,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 4,
		},
		[14] = {
			ObjectName = "dazhang",
			IsLoop = false,
			StateName = "CG_coverhead",
			Layer = -1,
			NormalizedTime = 0,
			IsCrossFade = true,
			TransitionDuration = 0.5,
			StartTime = 3.09,
			Duration = 4.066667,
			CurrentState = 5,
			Title = "animator_play(clone)",
			EndTime = 7.156667,
			Type = "PlotDirector.PlotEventAnimatorPlay",
			ParentId = 6,
		},
		[15] = {
			AudioMode = "Sound2D",
			LoadMode = "Delay",
			IndexName = "qingyun_23_2",
			Looping = false,
			StartPlayPos = 7.47082,
			EndPlayPos = 10.48936,
			Is3DSound = false,
			Position = Vector3(0,0,0),
			VolumeControl = "Default",
			VolumeValue = 1,
			VolumeCurve = {
				Name = "",
				KeyList = {},
			},
			StartTime = 3.287192,
			Duration = 3.018544,
			CurrentState = 5,
			Title = "talk_sound",
			EndTime = 6.305736,
			Type = "PlotDirector.PlotEventTalkSound",
			ParentId = 11,
		},
		[16] = {
			DialogMode = "MovieStyle",
			DialogSystem = false,
			TalkId = 1,
			PersonPicture = "",
			TalkPerson = "",
			TalkContent = "张小凡：  啊！啊！啊！不！",
			UseSound = false,
			SoundPath = "",
			Position = Vector2(0,0),
			FontSize = -1,
			StartTime = 3.299998,
			Duration = 3,
			CurrentState = 5,
			Title = "talk",
			EndTime = 6.299998,
			Type = "PlotDirector.PlotEventTalk",
			ParentId = 8,
		},
	},
}
setmetatable(PlotCutscene, {__index = Plot.PlotCutscene})
return PlotCutscene