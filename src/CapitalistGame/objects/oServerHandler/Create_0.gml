port = 6550;
server = network_create_server(network_socket_tcp, port, 6);

while(server < 0)
{
	port++;
	server = network_create_server(network_socket_tcp, port, 6);
}

clients = [];

instance_create_layer(0, 0, "Instances", oClientHandler);