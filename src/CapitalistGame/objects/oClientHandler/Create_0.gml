client = network_create_socket(network_socket_tcp);
show_debug_message($"Created client with id {client}");

is_connected = network_connect(client, global.server_ip, global.server_port)

server_id = -1;

timeout_time = 8;

listeners = ds_map_create();

///@function timeout_fn
timeout_fn = function()
{
	if (is_connected < 0)
	{
		network_destroy(client);
		// Client no longer connected to server.
	}
	is_connected = -1;
	packet_send(client, packet_create("cl_req_connection", [], []));
}
ts_keep_connection = time_source_create(time_source_game, timeout_time, time_source_units_seconds,
					 timeout_fn, [], -1);
time_source_start(ts_keep_connection);