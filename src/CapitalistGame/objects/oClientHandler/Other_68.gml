if(async_load[? "id"] == client)
{
	if(async_load[? "type"] == network_type_data)
	{
		var packet = async_load[? "buffer"];
		if(buffer_exists(packet))
		{
			buffer_seek(packet, buffer_seek_start, 0);
			var game_name = buffer_read(packet, STRING);
			var packet_type = buffer_read(packet, STRING);
			var events = oGameHandler.events;
			if(game_name == "Capitalist Game")
			{	
				switch(packet_type)
				{
					case "init_handshake_server" :
					{
						client_id = buffer_read(packet, INTEGER);
						sendPacket(client, "init_handshake_client", [STRING], [global.player_name]);
					}
					break;
					
					case "player_disconnect" :
					{
						var id_ = buffer_read(packet, INTEGER);
						array_push(events, {type : "player_disconnect", id : id_});
					}
					break;
					
					case "game_starting" :
					{
						array_push(events, {type : "game_starting"});
					}
					break;
					
					case "init_player" : 
					{
						var id_ = buffer_read(packet, INTEGER);
						var name = buffer_read(packet, STRING);
						var piece = buffer_read(packet, STRING);
						var r = buffer_read(packet, INTEGER);
						var g = buffer_read(packet, INTEGER);
						var b = buffer_read(packet, INTEGER);
						var event = { 
							type : "init_player", 
							id : id_,
							name : name, 
							color : make_color_rgb(r, g, b), 
							piece : piece
						};
						array_push(events, event);
					}
					break;
					
					case "player_sync":
					{
						var id_ = buffer_read(packet, INTEGER);
						var name = buffer_read(packet, STRING);
						var money = buffer_read(packet, INTEGER);
						var jail_cards = buffer_read(packet, INTEGER);
						var is_in_jail = buffer_read(packet, BOOL);
						var turns_in_jail = buffer_read(packet, INTEGER);
						var position = buffer_read(packet, INTEGER);
						var piece = buffer_read(packet, STRING);
						var r = buffer_read(packet, INTEGER);
						var g = buffer_read(packet, INTEGER);
						var b = buffer_read(packet, INTEGER);
						var ready = buffer_read(packet, BOOL);
						var event = {
							type : "player_sync",
							id : id_,
							name : name,
							money : money,
							jail_cards : jail_cards,
							is_in_jail : is_in_jail,
							turns_in_jail : turns_in_jail,
							position : position,
							piece : piece,
							color : make_color_rgb(r, g, b),
							ready : ready
						};
						array_push(events, event);
					}
					break;
					
					#region Input
					case "input_primary" :
					case "input_secondary" : 
					case "input_exit" : 
					case "input_left_scroll" : 
					case "input_right_scroll" :
					case "input_extra" :
					{
						var sender_id = buffer_read(packet, INTEGER)
						array_push(events, {type : packet_type, id : sender_id});
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
}