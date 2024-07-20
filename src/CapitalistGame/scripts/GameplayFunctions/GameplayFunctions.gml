randomize();

///@function get_player_index_from_id
///@param {Real} id_
function get_player_index_from_id(id_)
{
	var index = -1;
	with(oGameHandler)
	{
		for(var i = 0; i < array_length(players); i++)
		{
			if(players[i].id == id_)
			{
				index = i;
				break;
			}
		}
	}
	return index;
}