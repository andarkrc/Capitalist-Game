if(async_load[? "id"] == server)
{
	if(async_load[? "type"] == network_type_connect)
	{
		var client_id = async_load[? "socket"];
		if (oGameHandler.get_game_state() == "lobby")
		{
			array_push(clients, client_id);
			sendPacket(client_id, "init_handshake_server", [INTEGER], [client_id]);
		}
		else
		{
			sendPacket(async_load[? "socket"], "connection_rejected");
			network_destroy(async_load[? "socket"]);
		}
	}
	if(async_load[? "type"] == network_type_disconnect)
	{
		var client_id = async_load[? "socket"];
		var index = getPlayerIndexFromID(client_id);
		array_push(oGameHandler.player_pieces, oGameHandler.players[index].piece);
		array_push(oGameHandler.player_colors, oGameHandler.players[index].color);
		array_delete(clients, array_get_index(clients, client_id), 1);
		sendPacketAll(clients, "player_disconnect", [INTEGER], [client_id]);
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
		
		var events = oGameHandler.events;
		var players = oGameHandler.players;
		if(game_name == "Capitalist Game")
		{
			switch(packet_type)
			{
				case "init_handshake_client" : 
				{
				var name = buffer_read(packet, STRING);
				var color = irandom(array_length(oGameHandler.player_colors) - 1);
				var piece = irandom(array_length(oGameHandler.player_pieces) - 1);
				
				for (var i = 0; i < array_length(players); i++)
				{
					var r = color_get_red(players[i].color);
					var g = color_get_green(players[i].color);
					var b = color_get_blue(players[i].color);
					sendPacket(async_load[? "id"], "init_player", [INTEGER, STRING, STRING, INTEGER, INTEGER, INTEGER],
							   [players[i].id, players[i].name, players[i].piece, r, g, b]);
				}
				var r = color_get_red(oGameHandler.player_colors[color]);
				var g = color_get_green(oGameHandler.player_colors[color]);
				var b = color_get_blue(oGameHandler.player_colors[color]);
				sendPacketAll(clients, "init_player", [INTEGER, STRING, STRING, INTEGER, INTEGER, INTEGER], 
							  [async_load[? "id"], name, oGameHandler.player_pieces[piece], r, g, b]);
				array_delete(oGameHandler.player_pieces, piece, 1);
				array_delete(oGameHandler.player_colors, color, 1);
				syncPlayers();
				}
				break;
				
				#region Cosmetic Requests
				case "player_piece_request" :
				{
					if (array_length(oGameHandler.player_pieces) <= 0) break;
					var index = getPlayerIndexFromID(async_load[? "id"]);
					var new_piece_index = irandom(array_length(oGameHandler.player_pieces) - 1);
					var new_piece = oGameHandler.player_pieces[new_piece_index];
					array_push(oGameHandler.player_pieces, players[index].piece);
					players[index].piece = new_piece;
					array_delete(oGameHandler.player_pieces, new_piece_index, 1);
					syncPlayers();
				}
				break;
				
				case "player_color_request" :
				{
					if (array_length(oGameHandler.player_colors) <= 0) break;
					var index = getPlayerIndexFromID(async_load[? "id"]);
					var new_color_index = irandom(array_length(oGameHandler.player_colors) - 1);
					var new_color = oGameHandler.player_colors[new_color_index];
					array_push(oGameHandler.player_colors, players[index].color);
					players[index].color = new_color;
					array_delete(oGameHandler.player_colors, new_color_index, 1);
					syncPlayers();
				}
				break;
				#endregion
				
				#region Input
				case "input_primary" :
				case "input_secondary" :
				case "input_exit" :
				case "input_left_scroll" :
				case "input_right_scroll" :
				case "input_extra" :
				{
					var client_id = buffer_read(packet, INTEGER);
					sendPacketAll(clients, packet_type, [INTEGER], [client_id]);
				}
				break;
				#endregion
				
				default :
				break;
			}
		}
		buffer_seek(packet, buffer_seek_end, 0);
		buffer_delete(packet);
	}
}