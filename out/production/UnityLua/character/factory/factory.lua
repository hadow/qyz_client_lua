local UIPlayerFactory = require("character.factory.factories.uiplayerfactory")


return {

    --[[CreatePlayerForUIByMsg(msgName, msg, callback)   callback(player, go)]]
    CreatePlayerForUIByMsg = UIPlayerFactory.CreatePlayerForUIByMsg,
    DestroyCharacterForUI = UIPlayerFactory.DestroyCharacter,
}


