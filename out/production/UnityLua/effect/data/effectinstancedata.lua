--Generated at 2015/8/18 16:45:56
--This file is auto-generated,please do not modify it!


local EffectInstanceData = Class:new()

local Version = 2
EffectInstanceData.Type                      = nil	--特效类型(0:Stand,1:Follow,2:Trace,3:TracePos,4:BindToCamera,5:UIStand)
EffectInstanceData.Life                      = nil	--生存时间
EffectInstanceData.Path                      = nil	--特效资源路径
EffectInstanceData.Scale                     = nil	--缩放系数
EffectInstanceData.StartDelay                = nil	--延迟播放时间
EffectInstanceData.FadeOutTime               = nil	--淡出时间
EffectInstanceData.FollowDirection           = nil	--是否跟随释放者方向
EffectInstanceData.FollowBeAttackedDirection = nil	--若攻击方为A，受击方为B，这个功能激活后（1=激活，0=不激活），B的受击特效的朝向始终指向A的方向
EffectInstanceData.TraceTime                 = nil	--用于trace类型，飞行时间
EffectInstanceData.InstanceTraceType         = nil	--跟踪类型(0:Line)
EffectInstanceData.WorldOffsetX              = nil	--世界偏移X
EffectInstanceData.WorldOffsetY              = nil	--世界偏移Y
EffectInstanceData.WorldOffsetZ              = nil	--世界偏移Z
EffectInstanceData.AlignType                 = nil	--屏幕对齐类型(0:None,1:LeftTop,2:Left,3:LeftBottom,4:Top,5:Center,6:Bottom,7:RightTop,8:Right,9:RightBottom)
EffectInstanceData.IsPoolDestroyed           = nil	--是否特效池管理
EffectInstanceData.CasterBindType            = nil	--释放者绑定类型(0:Body,1:Head,2:Foot,3:LeftHand,4:RightHand)
EffectInstanceData.TargetBindType            = nil	--目标者绑定类型(0:Body,1:Head,2:Foot,3:LeftHand,4:RightHand)
EffectInstanceData.BoneName                  = nil	--绑定骨骼名称
EffectInstanceData.BonePosX                  = nil	--骨骼偏移X
EffectInstanceData.BonePosY                  = nil	--骨骼偏移Y
EffectInstanceData.BonePosZ                  = nil	--骨骼偏移Z
EffectInstanceData.BoneRotX                  = nil	--骨骼旋转X
EffectInstanceData.BoneRotY                  = nil	--骨骼旋转Y
EffectInstanceData.BoneRotZ                  = nil	--骨骼旋转Z
EffectInstanceData.BoneScaleX                = nil	--骨骼缩放X
EffectInstanceData.BoneScaleY                = nil	--骨骼缩放Y
EffectInstanceData.BoneScaleZ                = nil	--骨骼缩放Z
EffectInstanceData.FollowBoneDirection       = nil	--是否跟随绑定骨骼方向


function EffectInstanceData:__new()
	self.Path = ""
	self.BoneName = ""
end


function EffectInstanceData:LoadConfig(file)
	local strLine = file:read()
	Version = tonumber(strLine)
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.Type = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.Life = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.Path = strLine
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.Scale = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.StartDelay = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.FadeOutTime = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.FollowDirection = strLine
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.FollowBeAttackedDirection = strLine
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.TraceTime = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.InstanceTraceType = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.WorldOffsetX = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.WorldOffsetY = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.WorldOffsetZ = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.AlignType = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.IsPoolDestroyed = strLine
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.CasterBindType = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.TargetBindType = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.BoneName = strLine
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.BonePosX = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.BonePosY = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.BonePosZ = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.BoneRotX = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.BoneRotY = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.BoneRotZ = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.BoneScaleX = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.BoneScaleY = tonumber(strLine)
	end
	if Version >= 0 and Version <= 99999 then
		strLine = file:read()
		self.BoneScaleZ = tonumber(strLine)
	end
	if Version >= 1 and Version <= 99999 then
		strLine = file:read()
		self.FollowBoneDirection = strLine
	end
end
return EffectInstanceData
