for (var i = 0; i < array_length(clients); i++)
{
	network_destroy(clients[i]);
}
network_destroy(server);