#region Menu Buttons

///@function create_back_button
///@param {Real} xx_
///@param {Real} yy_
function create_back_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextImage))
	{
		type = "Back";
		text = "Back";
		width = 128;
		height = 128;
		
		///@function left_click_action
		left_click_action = function()
		{
			room_goto(rMainMenu);
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_host_button
///@param {Real} xx_
///@param {Real} yy_
function create_host_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextImage))
	{
		type = "Host";
		text = "Host";
		width = 128;
		height = 128;
		
		///@function left_click_action
		left_click_action = function()
		{
			oTextBox.enter_action();
			global.connection_type = "server";
			room_goto(rTest);
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_join_button
///@param {Real} xx_
///@param {Real} yy_
function create_join_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextImage))
	{
		type = "Join";
		text = "Join";
		width = 128;
		height = 128;
		
		///@function left_click_action
		left_click_action = function()
		{
			oTextBox.enter_action();
			global.connection_type = "client";
			room_goto(rTest);
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_name_text_box
///@param {Real} xx_
///@param {Real} yy_
function create_name_text_box(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oTextBox))
	{
		type = "PlayerName";
		text = global.player_name;
		width = 128;
		height = 32;
		
		///@function enter_action
		enter_action = function()
		{
			global.player_name = text;
		}
		
		button_id = id;
	}
	return button_id;
}

#endregion

#region Gameplay Buttons

///@function create_roll_dice_button
///@param {Real} xx_
///@param {Real} yy_
function create_roll_dice_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Roll Dice";
		text = "Roll the Dice";
		extra_text = "[Press SPACE]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_primary",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_pay_fee_primary_button
///@param {Real} xx_
///@param {Real} yy_
function create_pay_fee_primary_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Pay Fee";
		text = "Pay the Fee";
		extra_text = "[Press SPACE]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_primary",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_purchase_property_button
///@param {Real} xx_
///@param {Real} yy_
function create_purchase_property_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Purchase Property";
		text = "Purchase Property";
		extra_text = "[Press SPACE]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_primary",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_end_turn_button
///@param {Real} xx_
///@param {Real} yy_
function create_end_turn_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "End Turn";
		text = "End Turn";
		extra_text = "[Press SPACE]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_primary",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_bet_100_button
///@param {Real} xx_
///@param {Real} yy_
function create_bet_100_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Bet 100";
		text = "Bet $100";
		extra_text = "[Press SPACE]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_primary",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_bet_10_button
///@param {Real} xx_
///@param {Real} yy_
function create_bet_10_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Bet 10";
		text = "Bet $10";
		extra_text = "[Press ENTER]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_secondary",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_auction_withdraw_button
///@param {Real} xx_
///@param {Real} yy_
function create_auction_withdraw_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Auction Withdraw";
		text = "Withdraw";
		extra_text = "[Press CTRL]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_extra",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_upgrade_property_button
///@param {Real} xx_
///@param {Real} yy_
function create_upgrade_property_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Upgrade Property";
		text = "Upgrade";
		extra_text = "[Press SPACE]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_primary",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_downgrade_property_button
///@param {Real} xx_
///@param {Real} yy_
function create_downgrade_property_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Downgrade Property";
		text = "Downgrade";
		extra_text = "[Press ENTER]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_secondary",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_change_property_button
///@param {Real} xx_
///@param {Real} yy_
function create_change_property_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Change Property";
		text = "Change Property";
		extra_text = "[Press ENTER]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_next_property",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_finish_managing_button
///@param {Real} xx_
///@param {Real} yy_
function create_finish_managing_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Finish Managing";
		text = "Finish";
		extra_text = "[Press CTRL]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_extra",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_manage_properties_button
///@param {Real} xx_
///@param {Real} yy_
function create_manage_properties_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Manage Properties";
		text = "Manage Properties";
		extra_text = "[Press ENTER]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_secondary",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_auction_property_button
///@param {Real} xx_
///@param {Real} yy_
function create_auction_property_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Auction Property";
		text = "Auction Property";
		extra_text = "[Press ENTER]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_secondary",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_pay_fee_secondary_button
///@param {Real} xx_
///@param {Real} yy_
function create_pay_fee_secondary_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Pay Fee";
		text = "Pay the Fee";
		extra_text = "[Press ENTER]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_secondary",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_use_card_secondary_button
///@param {Real} xx_
///@param {Real} yy_
function create_use_card_secondary_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Use Card";
		text = "Use Jail Card";
		extra_text = "[Press ENTER]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_secondary",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_use_card_extra_button
///@param {Real} xx_
///@param {Real} yy_
function create_use_card_extra_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Use Card";
		text = "Use Jail Card";
		extra_text = "[Press CTRL]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_key_press_extra",
			[INT], [oClientHandler.server_id]));
		}
		
		button_id = id;
	}
	return button_id;
}

#endregion