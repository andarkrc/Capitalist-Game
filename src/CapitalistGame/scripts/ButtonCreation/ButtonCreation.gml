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

///@function create_send_trade_button
///@param {Real} xx_
///@param {Real} yy_
function create_send_trade_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Send a Trade";
		text = "Send a Trade";
		extra_text = "[Press 1-6]";
		fn = fnLeelawadee12;
		width = 128;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			// Nothing
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_confirm_trade_button
///@param {Real} xx_
///@param {Real} yy_
function create_confirm_trade_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Confirm Trade";
		text = "Confirm Trade";
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

///@function create_cancel_trade_button
///@param {Real} xx_
///@param {Real} yy_
function create_cancel_trade_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Cancel Trade";
		text = "Cancel Trade";
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

///@function create_accept_trade_button
///@param {Real} xx_
///@param {Real} yy_
function create_accept_trade_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Accept Trade";
		text = "Accept Trade";
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

///@function create_deny_trade_button
///@param {Real} xx_
///@param {Real} yy_
function create_deny_trade_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Deny Trade";
		text = "Deny Trade";
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

#endregion

#region Trade Money & Cards Buttons
///@function create_trade_add_100g_button
///@param {Real} xx_
///@param {Real} yy_
function create_trade_add_100g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Add $100";
		text = "Add $100";
		fn = fnLeelawadee12;
		width = 160;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_button_press_add_100",
			[INT, STRING], [oClientHandler.server_id, "g"]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_trade_add_10g_button
///@param {Real} xx_
///@param {Real} yy_
function create_trade_add_10g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Add $10";
		text = "Add $10";
		fn = fnLeelawadee12;
		width = 160;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_button_press_add_10",
			[INT, STRING], [oClientHandler.server_id, "g"]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_trade_remove_100g_button
///@param {Real} xx_
///@param {Real} yy_
function create_trade_remove_100g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Remove $100";
		text = "Remove $100";
		fn = fnLeelawadee12;
		width = 160;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_button_press_remove_100",
			[INT, STRING], [oClientHandler.server_id, "g"]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_trade_remove_10g_button
///@param {Real} xx_
///@param {Real} yy_
function create_trade_remove_10g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Remove $10";
		text = "Remove $10";
		fn = fnLeelawadee12;
		width = 160;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_button_press_remove_10",
			[INT, STRING], [oClientHandler.server_id, "g"]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_trade_add_cardg_button
///@param {Real} xx_
///@param {Real} yy_
function create_trade_add_cardg_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Add 1 Jail Card";
		text = "Add 1 Jail Card";
		fn = fnLeelawadee12;
		width = 160;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_button_press_add_card",
			[INT, STRING], [oClientHandler.server_id, "g"]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_trade_remove_cardg_button
///@param {Real} xx_
///@param {Real} yy_
function create_trade_remove_cardg_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Remove 1 Jail Card";
		text = "Remove 1 Jail Card";
		fn = fnLeelawadee12;
		width = 160;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_button_press_remove_card",
			[INT, STRING], [oClientHandler.server_id, "g"]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_trade_add_100r_button
///@param {Real} xx_
///@param {Real} yy_
function create_trade_add_100r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Add $100";
		text = "Add $100";
		fn = fnLeelawadee12;
		width = 160;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_button_press_add_100",
			[INT, STRING], [oClientHandler.server_id, "r"]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_trade_add_10r_button
///@param {Real} xx_
///@param {Real} yy_
function create_trade_add_10r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Add $10";
		text = "Add $10";
		fn = fnLeelawadee12;
		width = 160;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_button_press_add_10",
			[INT, STRING], [oClientHandler.server_id, "r"]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_trade_remove_100r_button
///@param {Real} xx_
///@param {Real} yy_
function create_trade_remove_100r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Remove $100";
		text = "Remove $100";
		fn = fnLeelawadee12;
		width = 160;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_button_press_remove_100",
			[INT, STRING], [oClientHandler.server_id, "r"]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_trade_remove_10r_button
///@param {Real} xx_
///@param {Real} yy_
function create_trade_remove_10r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Remove $10";
		text = "Remove $10";
		fn = fnLeelawadee12;
		width = 160;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_button_press_remove_10",
			[INT, STRING], [oClientHandler.server_id, "r"]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_trade_add_cardr_button
///@param {Real} xx_
///@param {Real} yy_
function create_trade_add_cardr_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Add 1 Jail Card";
		text = "Add 1 Jail Card";
		fn = fnLeelawadee12;
		width = 160;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_button_press_add_card",
			[INT, STRING], [oClientHandler.server_id, "r"]));
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_trade_remove_cardr_button
///@param {Real} xx_
///@param {Real} yy_
function create_trade_remove_cardr_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextExtra))
	{
		type = "Remove 1 Jail Card";
		text = "Remove 1 Jail Card";
		fn = fnLeelawadee12;
		width = 160;
		height = 32;
		
		///@function left_click_action
		left_click_action = function()
		{
			packet_send(oClientHandler.client, packet_create("cl_info_button_press_remove_card",
			[INT, STRING], [oClientHandler.server_id, "r"]));
		}
		
		button_id = id;
	}
	return button_id;
}
#endregion

#region Property Trade Buttons Given
///@function create_brown1g_button
///@param {Real} xx_
///@param {Real} yy_
function create_brown1g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Brown 1";
		color = #964B00;
		secondary_color = c_white;
		property = 2;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_brown2g_button
///@param {Real} xx_
///@param {Real} yy_
function create_brown2g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Brown 2";
		color = #964B00;
		secondary_color = c_white;
		property = 4;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_lightblue1g_button
///@param {Real} xx_
///@param {Real} yy_
function create_lightblue1g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Light Blue 1";
		color = c_aqua;
		secondary_color = c_black;
		property = 7;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_lightblue2g_button
///@param {Real} xx_
///@param {Real} yy_
function create_lightblue2g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Light Blue 2";
		color = c_aqua;
		secondary_color = c_black;
		property = 9;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_lightblue3g_button
///@param {Real} xx_
///@param {Real} yy_
function create_lightblue3g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Light Blue 3";
		color = c_aqua;
		secondary_color = c_black;
		property = 10;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_pink1g_button
///@param {Real} xx_
///@param {Real} yy_
function create_pink1g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Pink 1";
		color = c_fuchsia;
		secondary_color = c_white;
		property = 12;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_pink2g_button
///@param {Real} xx_
///@param {Real} yy_
function create_pink2g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Pink 2";
		color = c_fuchsia;
		secondary_color = c_white;
		property = 14;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_pink3g_button
///@param {Real} xx_
///@param {Real} yy_
function create_pink3g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Pink 3";
		color = c_fuchsia;
		secondary_color = c_white;
		property = 15;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_orange1g_button
///@param {Real} xx_
///@param {Real} yy_
function create_orange1g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Orange 1";
		color = c_orange;
		secondary_color = c_white;
		property = 17;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_orange2g_button
///@param {Real} xx_
///@param {Real} yy_
function create_orange2g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Orange 2";
		color = c_orange;
		secondary_color = c_white;
		property = 19;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_orange3g_button
///@param {Real} xx_
///@param {Real} yy_
function create_orange3g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Orange 3";
		color = c_orange;
		secondary_color = c_white;
		property = 20;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_red1g_button
///@param {Real} xx_
///@param {Real} yy_
function create_red1g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Red 1";
		color = c_red;
		secondary_color = c_white;
		property = 22;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_red2g_button
///@param {Real} xx_
///@param {Real} yy_
function create_red2g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Red 2";
		color = c_red;
		secondary_color = c_white;
		property = 24;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_red3g_button
///@param {Real} xx_
///@param {Real} yy_
function create_red3g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Red 3";
		color = c_red;
		secondary_color = c_white;
		property = 25;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_yellow1g_button
///@param {Real} xx_
///@param {Real} yy_
function create_yellow1g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Yellow 1";
		color = c_yellow;
		secondary_color = c_black;
		property = 27;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_yellow2g_button
///@param {Real} xx_
///@param {Real} yy_
function create_yellow2g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Yellow 2";
		color = c_yellow;
		secondary_color = c_black;
		property = 28;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_yellow3g_button
///@param {Real} xx_
///@param {Real} yy_
function create_yellow3g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Yellow 3";
		color = c_yellow;
		secondary_color = c_black;
		property = 30;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_green1g_button
///@param {Real} xx_
///@param {Real} yy_
function create_green1g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Green 1";
		color = c_green;
		secondary_color = c_white;
		property = 32;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_green2g_button
///@param {Real} xx_
///@param {Real} yy_
function create_green2g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Green 2";
		color = c_green;
		secondary_color = c_white;
		property = 33;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_green3g_button
///@param {Real} xx_
///@param {Real} yy_
function create_green3g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Green 3";
		color = c_green;
		secondary_color = c_white;
		property = 35;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_darkblue1g_button
///@param {Real} xx_
///@param {Real} yy_
function create_darkblue1g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Dark Blue 1";
		color = c_navy;
		secondary_color = c_white;
		property = 38;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_darkblue2g_button
///@param {Real} xx_
///@param {Real} yy_
function create_darkblue2g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Dark Blue 2";
		color = c_navy;
		secondary_color = c_white;
		property = 40;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_railroad1g_button
///@param {Real} xx_
///@param {Real} yy_
function create_railroad1g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Railroad 1";
		color = c_black;
		secondary_color = c_white;
		property = 6;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_railroad2g_button
///@param {Real} xx_
///@param {Real} yy_
function create_railroad2g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Railroad 2";
		color = c_black;
		secondary_color = c_white;
		property = 16;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_railroad3g_button
///@param {Real} xx_
///@param {Real} yy_
function create_railroad3g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Railroad 3";
		color = c_black;
		secondary_color = c_white;
		property = 26;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_railroad4g_button
///@param {Real} xx_
///@param {Real} yy_
function create_railroad4g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Railroad 4";
		color = c_black;
		secondary_color = c_white;
		property = 36;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_company1g_button
///@param {Real} xx_
///@param {Real} yy_
function create_company1g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Company 1";
		color = c_yellow;
		secondary_color = c_black;
		property = 13;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_company2g_button
///@param {Real} xx_
///@param {Real} yy_
function create_company2g_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Company 2";
		color = c_aqua;
		secondary_color = c_black;
		property = 29;
		with(oGameHandler)
		{
			other.targeted_player = players[player_turn].id;
		}
		
		button_id = id;
	}
	return button_id;
}
#endregion

#region Property Trade Buttons Recieved
///@function create_brown1r_button
///@param {Real} xx_
///@param {Real} yy_
function create_brown1r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Brown 1";
		color = #964B00;
		secondary_color = c_white;
		property = 2;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_brown2r_button
///@param {Real} xx_
///@param {Real} yy_
function create_brown2r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Brown 2";
		color = #964B00;
		secondary_color = c_white;
		property = 4;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_lightblue1r_button
///@param {Real} xx_
///@param {Real} yy_
function create_lightblue1r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Light Blue 1";
		color = c_aqua;
		secondary_color = c_black;
		property = 7;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_lightblue2r_button
///@param {Real} xx_
///@param {Real} yy_
function create_lightblue2r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Light Blue 2";
		color = c_aqua;
		secondary_color = c_black;
		property = 9;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_lightblue3r_button
///@param {Real} xx_
///@param {Real} yy_
function create_lightblue3r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Light Blue 3";
		color = c_aqua;
		secondary_color = c_black;
		property = 10;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_pink1r_button
///@param {Real} xx_
///@param {Real} yy_
function create_pink1r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Pink 1";
		color = c_fuchsia;
		secondary_color = c_white;
		property = 12;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_pink2r_button
///@param {Real} xx_
///@param {Real} yy_
function create_pink2r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Pink 2";
		color = c_fuchsia;
		secondary_color = c_white;
		property = 14;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_pink3r_button
///@param {Real} xx_
///@param {Real} yy_
function create_pink3r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Pink 3";
		color = c_fuchsia;
		secondary_color = c_white;
		property = 15;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_orange1r_button
///@param {Real} xx_
///@param {Real} yy_
function create_orange1r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Orange 1";
		color = c_orange;
		secondary_color = c_white;
		property = 17;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_orange2r_button
///@param {Real} xx_
///@param {Real} yy_
function create_orange2r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Orange 2";
		color = c_orange;
		secondary_color = c_white;
		property = 19;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_orange3r_button
///@param {Real} xx_
///@param {Real} yy_
function create_orange3r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Orange 3";
		color = c_orange;
		secondary_color = c_white;
		property = 20;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_red1r_button
///@param {Real} xx_
///@param {Real} yy_
function create_red1r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Red 1";
		color = c_red;
		secondary_color = c_white;
		property = 22;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_red2r_button
///@param {Real} xx_
///@param {Real} yy_
function create_red2r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Red 2";
		color = c_red;
		secondary_color = c_white;
		property = 24;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_red3r_button
///@param {Real} xx_
///@param {Real} yy_
function create_red3r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Red 3";
		color = c_red;
		secondary_color = c_white;
		property = 25;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_yellow1r_button
///@param {Real} xx_
///@param {Real} yy_
function create_yellow1r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Yellow 1";
		color = c_yellow;
		secondary_color = c_black;
		property = 27;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_yellow2r_button
///@param {Real} xx_
///@param {Real} yy_
function create_yellow2r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Yellow 2";
		color = c_yellow;
		secondary_color = c_black;
		property = 28;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_yellow3r_button
///@param {Real} xx_
///@param {Real} yy_
function create_yellow3r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Yellow 3";
		color = c_yellow;
		secondary_color = c_black;
		property = 30;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_green1r_button
///@param {Real} xx_
///@param {Real} yy_
function create_green1r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Green 1";
		color = c_green;
		secondary_color = c_white;
		property = 32;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_green2r_button
///@param {Real} xx_
///@param {Real} yy_
function create_green2r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Green 2";
		color = c_green;
		secondary_color = c_white;
		property = 33;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_green3r_button
///@param {Real} xx_
///@param {Real} yy_
function create_green3r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Green 3";
		color = c_green;
		secondary_color = c_white;
		property = 35;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_darkblue1r_button
///@param {Real} xx_
///@param {Real} yy_
function create_darkblue1r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Dark Blue 1";
		color = c_navy;
		secondary_color = c_white;
		property = 38;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_darkblue2r_button
///@param {Real} xx_
///@param {Real} yy_
function create_darkblue2r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Dark Blue 2";
		color = c_navy;
		secondary_color = c_white;
		property = 40;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_railroad1r_button
///@param {Real} xx_
///@param {Real} yy_
function create_railroad1r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Railroad 1";
		color = c_black;
		secondary_color = c_white;
		property = 6;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_railroad2r_button
///@param {Real} xx_
///@param {Real} yy_
function create_railroad2r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Railroad 2";
		color = c_black;
		secondary_color = c_white;
		property = 16;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_railroad3r_button
///@param {Real} xx_
///@param {Real} yy_
function create_railroad3r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Railroad 3";
		color = c_black;
		secondary_color = c_white;
		property = 26;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_railroad4r_button
///@param {Real} xx_
///@param {Real} yy_
function create_railroad4r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Railroad 4";
		color = c_black;
		secondary_color = c_white;
		property = 36;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_company1r_button
///@param {Real} xx_
///@param {Real} yy_
function create_company1r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Company 1";
		color = c_yellow;
		secondary_color = c_black;
		property = 13;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}

///@function create_company2r_button
///@param {Real} xx_
///@param {Real} yy_
function create_company2r_button(xx_, yy_)
{
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonPropertyTrade))
	{
		type = "Trade Company 2";
		color = c_aqua;
		secondary_color = c_black;
		property = 29;
		with(oGameHandler)
		{
			other.targeted_player = players[trade_target].id;
		}
		
		button_id = id;
	}
	return button_id;
}
#endregion