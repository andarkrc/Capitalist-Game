#macro STRING buffer_string
#macro INTEGER buffer_s32
#macro FLOAT buffer_f64
#macro BOOL buffer_bool
#macro LONG buffer_u64



///@function sendPacket
///@param {Id.Socket} socket_
///@param {String} packet_type_
///@param {Array<Constant.BufferDataType>} data_type_
///@param {Array<Any>} data_
function sendPacket(socket_, packet_type_, data_type_ = [], data_ = []){
	var packet = buffer_create(1, buffer_grow, 1);
	buffer_seek(packet, buffer_seek_start, 0);
	buffer_write(packet, STRING, global.game_name);
	buffer_write(packet, STRING, packet_type_);
	for(var i = 0; i < array_length(data_); i++)
	{
		buffer_write(packet, data_type_[i], data_[i]);
	}
	network_send_packet(socket_, packet, buffer_tell(packet));
	buffer_delete(packet);
}

///@function relayPacket
///@param {Id.Socket} socket_
///@param {Id.Buffer} packet_
function relayPacket(socket_, packet_){
	buffer_seek(packet_, buffer_seek_end, 0);
	network_send_packet(socket_, packet_, buffer_tell(packet_));
}

//ONLY USE ON SERVER!!!

///@function sendPacketAll
///@param {Array<Id.Socket>} clients_
///@param {String} packet_type_
///@param {Array<Constant.BufferDataType>} data_type_
///@param {Array<Any>} data_
///@param {Array<Id.Socket>} black_list_
function sendPacketAll(clients_, packet_type_, data_type_ = [], data_ = [], black_list_ = []){
	var packet = buffer_create(1, buffer_grow, 1);
	buffer_seek(packet, buffer_seek_start, 0);
	buffer_write(packet, STRING, global.game_name);
	buffer_write(packet, STRING, packet_type_);
	for(var i = 0; i < array_length(data_); i++)
	{
		buffer_write(packet, data_type_[i], data_[i]);
	}
	for(var i = 0; i < array_length(clients_); i++)
	{
		if (array_contains(black_list_, clients_[i])) continue;
		network_send_packet(clients_[i], packet, buffer_tell(packet));
	}
	buffer_delete(packet);
}

///@function relayPacketAll
///@param {Array<Id.Socket>} clients_
///@param {Id.Buffer} packet_
///@param {Array<Id.Socket>} black_list_
function relayPacketAll(clients_, packet_, black_list_ = []){
	buffer_seek(packet_, buffer_seek_end, 0);
	for (var i = 0; i < array_length(clients_); i++)
	{
		if (array_contains(black_list_, clients_[i])) continue;
		network_send_packet(clients_[i], packet_, buffer_tell(packet_));
	}
}