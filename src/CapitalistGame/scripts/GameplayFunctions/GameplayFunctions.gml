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


//ONLY FOR SERVER!!
///@function syncPlayers
function syncPlayers(){
	var players = oGameHandler.players;
	for (var i = 0; i < array_length(players); i++)
	{
		var p = players[i];
		var r = color_get_red(p.color);
		var g = color_get_green(p.color);
		var b = color_get_blue(p.color);
		sendPacketAll(clients, "player_sync",
		[INTEGER, STRING, INTEGER, INTEGER, BOOL, INTEGER, INTEGER, STRING, INTEGER, INTEGER, INTEGER, BOOL],
		[p.id, p.name, p.money, p.jail_cards, p.is_in_jail, p.turns_in_jail, p.position, p.piece, r, g, b, p.ready]);
	}
}