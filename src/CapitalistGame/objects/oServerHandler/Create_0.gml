port = 6550;
server = network_create_server(network_socket_tcp, port, 6);

while(server < 0)
{
	port++;
	server = network_create_server(network_socket_tcp, port, 6);
}

clients = [];

var fn = function(){
	instance_create_layer(0, 0, "Instances", oClientHandler);
}

ts_new_client = time_source_create(time_source_game, 0.5, time_source_units_seconds, fn, [], 6);

instance_create_layer(0, 0, "Instances", oClientHandler);
