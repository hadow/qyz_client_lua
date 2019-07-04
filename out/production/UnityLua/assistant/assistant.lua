local FriendManager 	= require("ui.friend.friendmanager")
local TitleManager 		= require("ui.title.titlemanager")
local TalismanManager 	= require("ui.playerrole.talisman.talismanmanager")
--local ArenaManager 		= require("ui.arena.single.arenamanager")
local RideManager 		= require("ui.ride.ridemanager")
local ModuleArena 		= require("ui.arena.modulearena")
local ActivityManager	= require("ui.activity.dlgactivitymanager")
local CharacterManager  = require("character.charactermanager")
local WorldBossManager =require("ui.activity.worldboss.worldbossmanager")
--PersonalBoss  = require("assistant.personalboss")
local function init()
	 FriendManager.Start()
     TitleManager.Start()
	 TalismanManager.Start()
	 RideManager.Start()
	 --ArenaManager.Start() 
	 ActivityManager.Start()
	 ModuleArena.Start()
	 CharacterManager.Start()
	 WorldBossManager.Start()
end


return {
	init = init,
}
