if(async_load[? "id"] == server)
{
	if(async_load[? "type"] == network_type_connect)
	{
		var client_id = async_load[? "socket"];
		array_push(clients, client_id);
		if (array_length(clients) == 1)
		{
			host = client_id;
		}
		sendPacket(client_id, "init_handshake_server", [INTEGER], [client_id]);
	}
	if(async_load[? "type"] == network_type_disconnect)
	{
		var client_id = async_load[? "socket"];
		array_delete(clients, array_get_index(clients, client_id), 1);
		sendPacket(host, "manage_player_disconnect", [INTEGER], [client_id]);
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
					sendPacket(host, "new_player_connected", [INTEGER, STRING], [async_load[? "id"], name]);
				}
				break;
				
				#region Send Packet to all clients
				case "init_player":
				case "player_disconnect":
				case "input_primary" :
				case "input_secondary" :
				case "input_exit" :
				case "input_left_scroll" :
				case "input_right_scroll" :
				case "input_extra" :
				{
					relayPacketAll(clients, packet);	
				}
				break;
				case "player_sync" :
				case "prepare_new_player" :
				{
					relayPacketAll(clients, packet, [host]);
				}
				break;
				#endregion
				
				#region Send Packet to host
				case "player_piece_request":
				case "player_color_request":
				{
					relayPacket(host, packet);
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