// General buffer types
#macro STRING buffer_string
#macro INT buffer_s32
#macro FLOAT buffer_f32
#macro DOUBLE buffer_f64
#macro LONG buffer_u64
// Specific buffer types
#macro BOOL buffer_bool // [0 -> 1]

#macro F16 buffer_f16
#macro F32 buffer_f32
#macro F64 buffer_f64

#macro S8  buffer_s8  // [-128 -> 127]
#macro S16 buffer_s16 // [-32768 -> 32767]
#macro S32 buffer_s32 // [-2147483648 -> 2147483647]

#macro U8  buffer_u8  // [0 -> 255]
#macro U16 buffer_u16 // [0 -> 65,535]
#macro U32 buffer_u32 // [0 -> 4,294,967,295]
#macro U64 buffer_u64 // [0 -> 18,446,744,073,709,551,615]

global.networking_version = "Capitalist Game v0.1";

///@function packet_create
///@param {String} packet_type_
///@param {Array<Constant.BufferDataType>} data_type_
///@param {Array<Any>} data_
///@param {Real} reroute_
function packet_create(packet_type_, data_type_, data_, reroute_ = 0)
{
	var packet = buffer_create(256, buffer_grow, 1);
	buffer_seek(packet, buffer_seek_start, 0);
	buffer_write(packet, STRING, global.networking_version);
	if (reroute_ == 1)
	{
		buffer_write(packet, STRING, "reroute");
	}
	else if (reroute_ == 2)
	{
		buffer_write(packet, STRING, "reroute_all");
	}
	buffer_write(packet, STRING, packet_type_);
	for (var i = 0; i < array_length(data_); i++)
	{
		buffer_write(packet, data_type_[i], data_[i]);
	}
	return packet;
}

///@function packet_unroute
///@description remove the "reroute" or "relay dst" from a packet
///@param {Id.Buffer} packet_
function packet_unroute(packet_)
{
	var rerouted_packed = buffer_create(256, buffer_grow, 1);
	buffer_seek(rerouted_packed, buffer_seek_start, 0);
	buffer_seek(packet_, buffer_seek_start, 0);
	buffer_write(rerouted_packed, STRING, global.networking_version);
	var dest_size = buffer_tell(rerouted_packed);
	var info = buffer_read(packet_, STRING);
	info = buffer_read(packet_, STRING);
	var src_skip = buffer_tell(packet_);
	buffer_seek(packet_, buffer_seek_end, 0);
	var src_size = buffer_tell(packet_);
	buffer_copy(packet_, src_skip, src_size - src_skip, rerouted_packed, dest_size);
	return rerouted_packed;
}


///@function packet_send
///@param {Id.Socket} socket_
///@param {Id.Buffer} packet_
function packet_send(socket_, packet_)
{
	buffer_seek(packet_, buffer_seek_end, 0);
	network_send_packet(socket_, packet_, buffer_tell(packet_));
	buffer_delete(packet_);
}

///@function packet_sendm
///@param {Array<Id.Socket>} sockets_
///@param {Id.Buffer} packet_
///@param {Array<Id.Socket>} except_
function packet_sendm(sockets_, packet_, except_ = [])
{
	buffer_seek(packet_, buffer_seek_end, 0);
	var packet_size = buffer_tell(packet_);
	for (var i = 0; i < array_length(sockets_); i++)
	{
		if (array_contains(except_, sockets_[i])) continue;
		network_send_packet(sockets_[i], packet_, packet_size);
	}
	buffer_delete(packet_);
}