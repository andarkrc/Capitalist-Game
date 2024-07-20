if (async_load[? "id"] == server)
{
	if (async_load[? "type"] == network_type_connect)
	{
		var cl_id = async_load[? "socket"];

		array_push(clients, cl_id);
		packet_send(cl_id, packet_create("sv_req_info",
		[INT], [cl_id]));
		show_debug_message($"[SERVER] New connection {cl_id}")
	}
	if (async_load[? "type"] == network_type_disconnect)
	{
		var cl_id = async_load[? "socket"];
		var cl_idx = array_get_index(clients, cl_id);
		array_delete(clients, cl_idx, 1);
		show_debug_message("[SERVER] New disconnection");
		if (array_length(clients) > 0)
		{
			packet_send(clients[0], packet_create("sv_info_new_disconnect",
			[INT], [cl_id]));
			show_debug_message("[SERVER] Sent disconnection info to HOST");
		}
	}
} else if (async_load[? "type"] == network_type_data && array_contains(clients, async_load[? "id"]))
{
	if buffer_exists(async_load[? "buffer"])
	{
		var packet = buffer_duplicate(async_load[? "buffer"]);
		buffer_seek(packet, buffer_seek_start, 0);
		var packet_version = buffer_read(packet, STRING);
		if (packet_version == global.networking_version)
		{
			var cl_id = async_load[? "id"];
			
			var cl_idx = array_get_index(clients, cl_id);
			
			var packet_type = buffer_read(packet, STRING);
			if (string_starts_with(packet_type, "relay"))
			{
				var tokens = string_split(packet_type, " ");
				var dst = real(tokens[1]);
				packet_send(dst, packet_unroute(packet));
				show_debug_message($"[SERVER] Relayed packet to {dst}")
			} else switch(packet_type)
			{
				case "cl_rsp_info":
				packet_send(clients[0], packet_create("sv_info_new_connection",
				[INT], [cl_id]));
				show_debug_message("[SERVER] Sent new connection info to HOST");
				break;
				
				case "cl_req_connection":
				packet_send(cl_id, packet_create("sv_rsp_connection", [], []));
				break;
				
				case "reroute":
				packet_sendm(clients, packet_unroute(packet), [cl_id]);
				show_debug_message($"[SERVER] Rerouted packet except to {cl_id}")
				break;
				
				case "reroute_all":
				packet_sendm(clients, packet_unroute(packet));
				show_debug_message($"[SERVER] Rerouted packet to all");
				break;
				
				default:
				packet_send(clients[0], packet);
				show_debug_message($"[SERVER] Sent packet '{packet_type}' to HOST (sent by {async_load[? "id"]})")
				break;
			}
		}
	}
}