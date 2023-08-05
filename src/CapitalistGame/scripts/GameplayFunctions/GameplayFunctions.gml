///@function initiatePlayer
///@param {Real} id_
function initiatePlayer(id_){
	with(oGameHandler)
	{
		var index = getPlayerIndexFromID(id_);
		if(index == -1)
		{
			players[array_length(players)] = new player(id_, , "", c_white);
		}
	}
}

///@function getPlayerIndexFromID
///@param {Real} id_
function getPlayerIndexFromID(id_){
	var index = -1;
	with(oGameHandler)
	{
		for(var i = 0; i < array_length(players); i++)
		{
			if(players[i].id == id_)
			{
				index = i;
				break;
			}
		}
	}
	return index;
}

///@function updatePlayerName
///@param {Real} id_
///@param {String} name_
function updatePlayerName(id_, name_){
	with(oGameHandler)
	{
		var index = getPlayerIndexFromID(id_);
		if(index < array_length(players) && index >= 0)
		{
			players[index].name = name_;
		}
	}
}

///@function updatePlayerMoney
///@param {Real} id_
///@param {Real} money_
function updatePlayerMoney(id_, money_){
	with(oGameHandler)
	{
		var index = getPlayerIndexFromID(id_);
		if(index < array_length(players) && index >= 0)
		{
			players[index].money = money_;
		}
	}
}

///@function updatePlayerJailCards
///@param {Real} id_
///@param {Real} jail_cards_
function updatePlayerJailCards(id_, jail_cards_){
	with(oGameHandler)
	{
		var index = getPlayerIndexFromID(id_);
		if(index < array_length(players) && index >= 0)
		{
			players[index].jail_cards = jail_cards_;
		}
	}
}

///@function updatePlayerIsInJail
///@param {Real} id_
///@param {Bool} is_in_jail_
function updatePlayerIsInJail(id_, is_in_jail_){
	with(oGameHandler)
	{
		var index = getPlayerIndexFromID(id_);
		if(index < array_length(players) && index >= 0)
		{
			players[index].is_in_jail = is_in_jail_;
		}
	}
}

///@function updatePlayerTurnsInJail
///@param {Real} id_
///@param {Real} turns_in_jail_
function updatePlayerTurnsInJail(id_, turns_in_jail_){
	with(oGameHandler)
	{
		var index = getPlayerIndexFromID(id_);
		if(index < array_length(players) && index >= 0)
		{
			players[index].turns_in_jail = turns_in_jail_;
		}
	}
}

///@function updatePlayerPosition
///@param {Real} id_
///@param {Real} position_
function updatePlayerPosition(id_, position_){
	with(oGameHandler)
	{
		var index = getPlayerIndexFromID(id_);
		if(index < array_length(players) && index >= 0)
		{
			players[index].position = position_;
		}
	}
}

///@function updatePlayerPiece
///@param {Real} id_
///@param {String} piece_
function updatePlayerPiece(id_, piece_){
	with(oGameHandler)
	{
		var index = getPlayerIndexFromID(id_);
		if(index < array_length(players) && index >= 0)
		{
			players[index].piece = piece_;
		}
	}
}

///@function updatePlayerColor
///@param {Real} id_
///@param {Constant.Color} color_
function updatePlayerColor(id_, color_){
	with(oGameHandler)
	{
		var index = getPlayerIndexFromID(id_);
		if(index < array_length(players) && index >= 0)
		{
			players[index].color = color_;
		}
	}
}

///@function updatePlayerReady
///@param {Real} id_
///@param {Bool} ready_
function updatePlayerReady(id_, ready_){
	with(oGameHandler)
	{
		var index = getPlayerIndexFromID(id_);
		if(index < array_length(players) && index >= 0)
		{
			players[index].ready = ready_;
		}
	}
}

///@function syncAllPlayers
function syncAllPlayers(){
	var players = oGameHandler.players;
	with(oServerHandler)
	{
		for(var i = 0; i < array_length(clients); i++)
		{
			for(var j = 0; j < array_length(players); j++)
			{
				sendPacket(clients[i], "player_sync_name", [INTEGER, STRING], [players[j].id, players[j].name]);
				sendPacket(clients[i], "player_sync_money", [INTEGER, INTEGER], [players[j].id, players[j].money]);
				sendPacket(clients[i], "player_sync_jail_cards", [INTEGER, INTEGER], [players[j].id, players[j].jail_cards]);
				sendPacket(clients[i], "player_sync_is_in_jail", [INTEGER, BOOL], [players[j].id, players[j].is_in_jail]);
				sendPacket(clients[i], "player_sync_turns_in_jail", [INTEGER, INTEGER], [players[j].id, players[j].turns_in_jail]);
				sendPacket(clients[i], "player_sync_position", [INTEGER, INTEGER], [players[j].id, players[j].position]);
				sendPacket(clients[i], "player_sync_piece", [INTEGER, STRING], [players[j].id, players[j].piece]);
				var red = color_get_red(players[j].color);
				var green = color_get_green(players[j].color);
				var blue = color_get_blue(players[j].color);
				sendPacket(clients[i], "player_sync_color", [INTEGER, INTEGER, INTEGER, INTEGER], [players[j].id, red, green, blue]);
				sendPacket(clients[i], "player_sync_ready", [INTEGER, BOOL], [players[j].id, players[j].ready]);
			}
		}
	}
}