port = 6550;
server = network_create_server(network_socket_tcp, port, 6);

while(server < 0)
{
	network_destroy(server);
	port++;
	server = network_create_server(network_socket_tcp, port, 6);
}

clients = [];

host = undefined;