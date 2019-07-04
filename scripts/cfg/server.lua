--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

--endregion

local serverlist = {
	{
		name="officialServer1",
		test=1,
		isNew=true,
		addresses=
		{
		  	{host="120.92.19.28",port=10011},
		  	{host="120.92.19.28",port=10013},
		  	{host="120.92.19.28",port=10014},
		},
	},
}

local yhlm_serverlist = {
	{
		name="allianceServer1",
		test=1,
		isNew=true,
		addresses=
		{
		  	{host="120.92.19.28",port=10011},
		  	{host="120.92.19.28",port=10013},
		  	{host="120.92.19.28",port=10014},
		},
	},
}

local yingyongbao_serverlist = {
	{
		name="tentcentServer1",
		test=1,
		isNew=true,
		addresses=
		{
		  	{host="120.92.19.28",port=10011},
		  	{host="120.92.19.28",port=10013},
		  	{host="120.92.19.28",port=10014},
		},
	},
}

local dhf_serverlist = {
	{
		name="策划服",
		test=1,
		isNew = true,
		addresses=
		{
			{host="10.241.69.16", port=10063},
		}
	},
}

local recommendserver = 2

local logserver = {host="10.12.3.122", port=10031}

return
{
	logserver = logserver,
	serverlist = serverlist,
	yhlm_serverlist = yhlm_serverlist,
	yingyongbao_serverlist = yingyongbao_serverlist,
	dhf_serverlist = dhf_serverlist,
}
