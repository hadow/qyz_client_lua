-- CD数据
local CDData = Class:new()

--------------------------
---1.update算剩余时间版本--
--------------------------
function CDData:__new(cdGroupId, totalCDTime)
	self.m_CDGroupId = cdGroupId
	self.m_LeftCDTime = 0
	--self.m_CDExpireTime = 0
	self.m_TotalCDTime = totalCDTime
end

function CDData:IsReady()
	return (self.m_LeftCDTime == 0)
	--return  ((self.m_LeftCDTime == 0) and (self.m_CDExpireTime < timeutils.GetServerTime()))
end

function CDData:GetLeftTime()
	return self.m_LeftCDTime
end

function CDData:GetCDRatio()
	if self.m_TotalCDTime > 0 then
		return self.m_LeftCDTime / self.m_TotalCDTime
	end
	return 0
end
-- 以秒为单位
function CDData:BeginCD(expireTime)
	--self.m_CDExpireTime = expireTime
	if expireTime > timeutils.GetServerTime() then
		if (expireTime - timeutils.GetServerTime()) > self.m_TotalCDTime then
			-- 防止客户端和服务器时间不一致导致的实际CD时间比配置CD时间长
			self.m_LeftCDTime = self.m_TotalCDTime
		else
			self.m_LeftCDTime = expireTime - timeutils.GetServerTime()
		end
	else
		self.m_LeftCDTime = 0
	end
end

function CDData:ResetData()
	self.m_LeftCDTime = 0
	--self.m_CDExpireTime = 0
end

function CDData:Update()
	if self.m_LeftCDTime > 0 then
		self.m_LeftCDTime = self.m_LeftCDTime - Time.deltaTime
		if self.m_LeftCDTime < 0 then
			self.m_LeftCDTime = 0
		end
	end
end
--------------------------
---2.以服务器算时间版本----
--------------------------
-- 此版本由于lua没有毫秒
-- 导致CD旋转效果不平滑
--function CDData:__new(cdGroupId,totalCDTime)
--	self.m_CDGroupId = cdGroupId
--	self.m_CDExpireTime = 0
--	self.m_TotalCDTime = totalCDTime
--end

--function CDData:GetLeftTime()
--	local leftTime = self.m_CDExpireTime - timeutils.GetServerTime()
--	if leftTime > 0 then
--		return leftTime
--	else
--		return 0
--	end 
--end

--function CDData:IsReady()
--	return (self:GetLeftTime() == 0)
--end

--function CDData:GetCDRatio()
--	local leftTime = self:GetLeftTime()
--	if self.m_TotalCDTime > 0 then
--		return leftTime / self.m_TotalCDTime
--	end
--	return 0
--end
---- 以秒为单位
--function CDData:BeginCD(expireTime)
--	if expireTime > 0 then
--		self.m_CDExpireTime = expireTime
--	else
--		self.m_CDExpireTime = 0
--	end
--end
return CDData