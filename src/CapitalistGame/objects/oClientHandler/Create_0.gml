client = network_create_socket(network_socket_tcp);

is_connected = network_connect_async(client, global.server_ip, global.server_port)

client_id = -1;