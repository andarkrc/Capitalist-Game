if (async_load[? "id"] == client)
{
	if (async_load[? "type"] == network_type_data)
	{
		if (buffer_exists(async_load[? "buffer"]))
		{
			var packet = buffer_duplicate(async_load[? "buffer"]);
			buffer_seek(packet, buffer_seek_start, 0);
			var packet_version = buffer_read(packet, STRING);
			if (packet_version == global.networking_version)
			{
				var packet_type = buffer_read(packet, STRING);
				if (string_starts_with(packet_type, "sv_info") || 
					string_starts_with(packet_type, "cl_info"))
				{
					if (!ds_map_exists(listeners, "host"))
					{
						ds_map_add(listeners, "host", oGameHandler.id);
					}
					array_push(listeners[? "host"].events, packet);
				}
				else if (string_starts_with(packet_type, "hst"))
				{
					array_push(listeners[? "game"].events, packet);
				}else{ switch(packet_type)
				{
					case "sv_req_info":
					server_id = buffer_read(packet, INT);
					packet_send(client, packet_create("cl_rsp_info", [], []));
					show_debug_message("[CLIENT] Recieved connection confirmation");
					break;
					
					case "sv_rsp_connection":
					is_connected = 1;
					break;
					
					default:
					break;
				}
				buffer_delete(packet);
				}
			}
		}
	}
}