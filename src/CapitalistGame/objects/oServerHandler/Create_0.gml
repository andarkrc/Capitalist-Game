port = 6550;
server = network_create_server(network_socket_tcp, port, 6);

while(server < 0)
{
	network_destroy(server);
	port++;
	server = network_create_server(network_socket_tcp, port, 6);
}
show_debug_message($"[Server] Created on port {port} with id {server}");
clients = [];
show_debug_message($"Server is {server}");
//instance_create_layer(0, 0, "Handlers", oClientHandler);

repeat(5)
{
	//with(instance_create_layer(0, 0, "Handlers", oClientHandler))
	{
		//ds_map_add(listeners, "game", oGameHandler.id);
	}
}