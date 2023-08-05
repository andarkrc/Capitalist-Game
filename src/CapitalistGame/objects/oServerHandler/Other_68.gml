if(async_load[? "id"] == server)
{
	if(async_load[? "type"] == network_type_connect)
	{
		initiatePlayer(async_load[? "socket"]);
		array_push(clients, async_load[? "socket"]);
		sendPacket(async_load[? "socket"], "client_id", [INTEGER], [async_load[? "socket"]]);
		
		for(var i = 0; i < array_length(clients) - 1; i++)
		{
			sendPacket(clients[i], "player_connected", [INTEGER], [async_load[? "socket"]]);
		}
		for(var i = 0; i < array_length(clients); i++)
		{
			sendPacket(async_load[? "socket"], "player_connected", [INTEGER], [clients[i]]);
		}
	}
	if(async_load[? "type"] == network_type_disconnect)
	{
		array_delete(clients, array_get_index(clients, async_load[? "socket"]), 1);
	}
}
else if(async_load[? "type"] == network_type_data)
{
	var packet = async_load[? "buffer"];
	if(buffer_exists(packet))
	{
		buffer_seek(packet, buffer_seek_start, 0);
		var game_name = buffer_read(packet, STRING);
		var packet_type = buffer_read(packet, STRING);
		if(game_name == "Capitalist Game")
		{
			#region Local Variables
			var new_name, new_color, new_piece, new_id, index;
			var players = oGameHandler.players;
			var events = oGameHandler.events;
			#endregion
			switch(packet_type)
			{
				case "player_key_press_enter" :
				array_push(events, {type : "player_key_press_enter"});
				break;
				
				case "player_ready" :
				array_push(events, {type : "player_ready", id : async_load[? "id"]});
				break;
				
				case "player_request_new_piece" :
				array_push(events, {type : "player_request_new_piece", id : async_load[? "id"]});
				break;
				
				case "player_request_new_color" :
				array_push(events, {type : "player_request_new_color", id : async_load[? "id"]});
				break;
				
				case "player_info_request" :
				new_name = buffer_read(packet, STRING);
				new_piece = irandom(array_length(oGameHandler.player_pieces)-1);
				new_color = irandom(array_length(oGameHandler.player_colors)-1);
				updatePlayerName(async_load[? "id"], new_name);
				updatePlayerColor(async_load[? "id"], oGameHandler.player_colors[new_color]);
				updatePlayerPiece(async_load[? "id"], oGameHandler.player_pieces[new_piece]);
				array_delete(oGameHandler.player_pieces, new_piece, 1);
				array_delete(oGameHandler.player_colors, new_color, 1);
				syncAllPlayers();
				break;
				
				default :
				break;
			}
		}
		buffer_seek(packet, buffer_seek_end, 0);
		buffer_delete(packet);
	}
}