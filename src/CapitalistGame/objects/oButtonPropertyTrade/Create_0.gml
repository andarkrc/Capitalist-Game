type = "";
width = 32;
height = 32;
image = undefined;
text = "√";
color = c_white;
secondary_color = c_black;
overlay_color = c_ltgrey;
font = fnLeelawadee16;
property = 0;
targeted_player = -1;
added_to_trade = false;
active = false;
mouse_hover = false;
selected = false;


///@function left_click_action
left_click_action = function()
{
	with(oGameHandler)
	{
		if (other.active && players[player_turn].id == client.server_id)
		{
			if (other.targeted_player == players[player_turn].id)
			{
				packet_send(client.client, packet_create("cl_info_switch_propertyg",
				[INT, INT], [client.server_id, other.property]));
			}
			else if (other.targeted_player == players[trade_target].id)
			{
				packet_send(client.client, packet_create("cl_info_switch_propertyr",
				[INT, INT], [client.server_id, other.property]));
			}
		}
	}
}

