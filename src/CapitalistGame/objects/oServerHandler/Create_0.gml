port = 6550;
server = network_create_server(network_socket_tcp, port, 6);

while(server < 0)
{
	network_destroy(server);
	port++;
	server = network_create_server(network_socket_tcp, port, 6);
}

clients = [];

repeat (5)
{
	instance_create_layer(0, 0, "Instances", oClientHandler);
}


host = undefined;