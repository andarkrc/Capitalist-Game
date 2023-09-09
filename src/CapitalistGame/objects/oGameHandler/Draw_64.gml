var ratio_x = 1080/room_width;
var ratio_y = 720/room_height;

drawSetup(,,, fa_left);

if(game_started == false)
{
	var xx = display_get_gui_width()/2 - 144*array_length(players)/2 + 8;
	var yy = display_get_gui_height()/2 - 48;
	for(var i = 0; i < array_length(players); i++)
	{
		drawSetup(c_white, 0.8);
		draw_rectangle(xx*ratio_x, yy*ratio_y, (xx+128)*ratio_x, (yy+128)*ratio_y, false);
		drawSetup(players[i].color, 1);
		draw_text_transformed(xx+64, yy-16, players[i].name, ratio_x, ratio_y, 0);
		draw_sprite_stretched(asset_get_index($"sPiece{players[i].piece}"), 0, xx*ratio_x, yy*ratio_y, 128*ratio_x, 128*ratio_y);
		
		if(players[i].ready)
		{
			drawSetup(c_green, 1);
			draw_text_transformed(xx+64, yy+144, "Ready", ratio_x, ratio_y, 0);
		}
		else if(!players[i].ready)
		{
			drawSetup(#B00000, 1);
			draw_text_transformed(xx+64, yy+144, "Not Ready", ratio_x, ratio_y, 0);
		}
		xx += 144;
	}
	
	if(game_starting)
	{
		drawSetup(c_red);
		draw_text_transformed(room_width/2*ratio_x, room_height/10*ratio_y, $"Game starting in {game_starting_counter} ...", ratio_x, ratio_y, 0);
	}
}
else if(game_started)
{
	drawSetup(,,,fa_left);
	//draw_text(16, 16, $"MY ID : {my_player_id} -- TURN ID : {players[player_turn-1].id}");
	//draw_line(display_get_gui_width()/2, 0, display_get_gui_width()/2, display_get_gui_height());
	
	var xx = display_get_gui_width()/2 - 80*array_length(players)/2 + 8;
	var yy = display_get_gui_height() - 160;
	for(var i = 0; i < array_length(players); i++)
	{
		drawSetup(c_ltgray, 0.8);
		draw_rectangle(xx, yy, (xx+64), (yy+64), false);
		drawSetup(players[i].color, 1);
		var nw = string_width(players[i].name);
		var nh = string_height(players[i].name);
		var mw = string_width($"${players[i].money}");
		var mh = string_height($"${players[i].money}");
		drawSetup(c_white, 0.7);
		draw_rectangle(xx+32 - nw/2, yy-nh-mh-nh/2-2, xx+32 + nw/2, yy-nh-mh+nh/2-2, false);
		drawSetup(players[i].color, 1);
		draw_text_transformed(xx+32, yy-nh-mh-1, players[i].name, 1, 1, 0);
		drawSetup(c_white, 0.7);
		draw_rectangle(xx+32 - mw/2, yy-mh-mh/2-1, xx+32 + mw/2, yy-mh+mh/2-1, false);
		drawSetup(c_black);
		draw_text_transformed(xx+32, yy-mh, $"${players[i].money}", 1, 1, 0);
		draw_sprite_stretched(asset_get_index($"sPiece{players[i].piece}"), 0, xx, yy, 64, 64);
		var color1 = players[player_turn-1].jail_cards >= 1 ? c_white : c_grey;
		var color2 = players[player_turn-1].jail_cards == 2 ? c_white : c_grey;
		draw_sprite_ext(sJailCard, 0, xx +32-32-2, yy+80-8, 1, 1, 0, color1, 1);
		draw_sprite_ext(sJailCard, 0, xx +32+2, yy+80-8, 1, 1, 0, color2, 1);
		if(!dice_rolling && dice1 != 0 && players[player_turn-1].id == players[i].id)
		{
			draw_sprite_stretched(sDice, dice1, xx + 32 - 32-4, yy + 80+40-8, 32, 32);
			draw_sprite_stretched(sDice, dice2, xx + 32 + 4, yy + 80+40-8, 32, 32);
		}
		//Input Detection For Trading :)
		if(!auction_active)
		{
			if(players[player_turn-1].id == my_player_id)
			{
				if(!card_displayed && !trade_active)
				{
					if(!players[player_turn-1].is_in_jail || players[player_turn-1].turns_in_jail < 3)
					{
						if(!(player_has_property && !players[player_turn-1].player_sold_property))
						{
							if(!(!dice_rolling && !player_turn_ready && spaces_left == 0))
							{
								if(player_turn_ready && !property_upgrade_active)
								{
									if(mouse_check_button_pressed(mb_left))
									{
										if(players[i].id != my_player_id)
										{
											var mgx = device_mouse_x_to_gui(0);
											var mgy = device_mouse_y_to_gui(0);
											if(point_in_rectangle(mgx, mgy, xx, yy, (xx+64), (yy+64)))
											{
												trade_active = true;
												array_push(events, {type : "player_event_trade_start", other_player : players[i].id});
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
		
		xx += 80;
	}
	
	if(card_displayed)
	{
		if(card_type == "chest")
		{
			draw_sprite_stretched(sCommunityChestCards, card_index+1, display_get_gui_width()/2 - 256, display_get_gui_height()/3 - 128, 512, 256);
		}
		else if(card_type == "chance")
		{
			draw_sprite_stretched(sChanceCards, card_index+1, display_get_gui_width()/2 - 256, display_get_gui_height()/3 - 128, 512, 256);
		}
	}
	if(!trade_active)
	{
		if(!auction_active)
		{
			if(players[player_turn-1].id == my_player_id)
			{
				var mx = display_get_gui_width();
				var my = display_get_gui_height();
				var mousex = device_mouse_x_to_gui(0);
				var mousey = device_mouse_y_to_gui(0);
				drawSetup(c_white, 0.7);
				draw_rectangle(0, 0, mx, 96, false);
				//Display Action For Enter Key
				if(card_displayed == false)
				{
					if(!trade_active)
					{
						if(!players[player_turn-1].is_in_jail || players[player_turn-1].turns_in_jail < 3)
						{
							if(player_has_property && !players[player_turn-1].player_sold_property)
							{
								drawSetup(c_white, 0.7);
								draw_rectangle(mx/2 - 64-64-64, 16, mx/2 + 64-64-64, 48, false);
								drawSetup(c_black, 0.7);
								draw_rectangle(mx/2 - 64-64-64, 16, mx/2 + 64-64-64, 48, true);
								draw_text(mx/2-64-64, 32, "Buy Property");
								draw_text(mx/2-64-64, 32+32, "Press Enter");
					
								drawSetup(c_white, 0.7);
								draw_rectangle(mx/2 - 64+64+64, 16, mx/2 + 64+64+64, 48, false);
								drawSetup(c_black, 0.7);
								draw_rectangle(mx/2 - 64+64+64, 16, mx/2 + 64+64+64, 48, true);
								draw_text(mx/2+64+64, 32, "Auction");
								draw_text(mx/2+64+64, 32+32, "Press Space");
								if(mouse_check_button_pressed(mb_left))
								{
									if(point_in_rectangle(mousex, mousey, mx/2 - 64-64-64, 16, mx/2 + 64-64-64, 48))
									{
										key_press_enter = true;
									}
									if(point_in_rectangle(mousex, mousey, mx/2 - 64+64+64, 16, mx/2 + 64+64+64, 48))
									{
										key_press_space = true;
									}
								}
							}
							else
							{
								if(!dice_rolling && !player_turn_ready && spaces_left == 0)
								{
									drawSetup(c_white, 0.7);
									draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, false);
									drawSetup(c_black, 0.7);
									draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, true);
									draw_text(mx/2, 32, "Roll Dice");
									draw_text(mx/2, 32+32, "Press Enter");
									if(mouse_check_button_pressed(mb_left))
									{
										if(point_in_rectangle(mousex, mousey, mx/2 - 64, 16, mx/2 + 64, 48))
										{
											key_press_enter = true;
										}
									}
								}
								else
								{
									if(player_turn_ready)
									{
										if(!property_upgrade_active)
										{
											drawSetup(c_white, 0.7);
											draw_rectangle(mx/2 - 64-64-128, 16, mx/2 + 64-64-128, 48, false);
											drawSetup(c_black, 0.7);
											draw_rectangle(mx/2 - 64-64-128, 16, mx/2 + 64-64-128, 48, true);
											draw_text(mx/2-64-64-64, 32, "End Turn");
											draw_text(mx/2-64-64-64, 32+32, "Press Enter");
					
											drawSetup(c_white, 0.7);
											draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, false);
											drawSetup(c_black, 0.7, fnSmall);
											draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, true);
											draw_text(mx/2, 32, "Manage Properties");
											drawSetup(c_black, 0.7);
											draw_text(mx/2, 32+32, "Press Space");
										
											drawSetup(c_white, 0.7);
											draw_rectangle(mx/2 + 64 + 64, 16, mx/2 + 64+64+128, 48, false);
											drawSetup(c_black, 0.7, fnMedium);
											draw_rectangle(mx/2 + 64 + 64, 16, mx/2 + 64+64+128, 48, true);
											draw_text(mx/2+64+128, 32, "Trade Players");
											drawSetup(c_black, 0.7);
											draw_text(mx/2+64+128, 32+32, "Click an Icon");
											if(mouse_check_button_pressed(mb_left))
											{
												if(point_in_rectangle(mousex, mousey, mx/2 - 64-64-128, 16, mx/2 + 64-64-128, 48))
												{
													key_press_enter = true;
												}
												if(point_in_rectangle(mousex, mousey, mx/2 - 64, 16, mx/2 + 64, 48))
												{
													key_press_space = true;
												}
											}
										}
										else
										{
											drawSetup(c_white, 0.7);
											draw_rectangle(mx/2 - 16-128-16-128, 16, mx/2 -16-128-16, 48, false);
											drawSetup(c_black, 0.7);
											draw_rectangle(mx/2 - 16-128-16-128, 16, mx/2 -16-128-16, 48, true);
											draw_text(mx/2 -16-128-16-64, 32, "Upgrade");
											draw_text(mx/2 -16-128-16-64, 32+32, "Press Enter");
									
											drawSetup(c_white, 0.7);
											draw_rectangle(mx/2 - 16-128, 16, mx/2 - 16, 48, false);
											drawSetup(c_black, 0.7);
											draw_rectangle(mx/2 - 16-128, 16, mx/2 - 16, 48, true);
											draw_text(mx/2 - 16-64, 32, "Downgrade");
											draw_text(mx/2 - 16-64, 32+32, "Press Space");
									
											drawSetup(c_white, 0.7);
											draw_rectangle(mx/2 + 16, 16, mx/2 + 16+128, 48, false);
											drawSetup(c_black, 0.7, fnSmall);
											draw_rectangle(mx/2 + 16, 16, mx/2 + 16+128, 48, true);
											draw_text(mx/2 + 16+64, 32, "Change Property");
											drawSetup(c_black, 0.7);
											draw_text(mx/2 + 16+64, 32+32, "Press A, D");
									
											drawSetup(c_white, 0.7);
											draw_rectangle(mx/2 + 16+128+16, 16, mx/2 + 16+128+16+128, 48, false);
											drawSetup(c_black, 0.7);
											draw_rectangle(mx/2 + 16+128+16, 16, mx/2 + 16+128+16+128, 48, true);
											draw_text(mx/2 + 16+128+16+64, 32, "Finish");
											draw_text(mx/2 + 16+128+16+64, 32+32, "Press Backspace");
									
											if(mouse_check_button_pressed(mb_left))
											{
												if(point_in_rectangle(mousex, mousey, mx/2 - 16-128-16-128, 16, mx/2 -16-128-16, 48))
												{
													key_press_enter = true;
												}
												if(point_in_rectangle(mousex, mousey, mx/2 - 16-128, 16, mx/2 - 16, 48))
												{
													key_press_space = true;
												}
												if(point_in_rectangle(mousex, mousey, mx/2 + 16, 16, mx/2 + 16+128, 48))
												{
													key_press_a = true;
												}
												if(point_in_rectangle(mousex, mousey, mx/2 + 16+128+16, 16, mx/2 + 16+128+16+128, 48))
												{
													key_press_backspace = true;
												}
											}
											if(mouse_check_button_pressed(mb_right))
											{
												if(point_in_rectangle(mousex, mousey, mx/2 + 16, 16, mx/2 + 16+128, 48))
												{
													key_press_d = true;
												}
											}
										}
									}
								}
							}
						}
						else
						{
							if(players[player_turn-1].jail_cards > 0)
							{
								drawSetup(c_white, 0.7);
								draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, false);
								drawSetup(c_black, 0.7);
								draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, true);
								draw_text(mx/2, 32, "Use Jail Card");
								draw_text(mx/2, 32+32, "Press Enter");
								if(mouse_check_button_pressed(mb_left))
								{
									if(point_in_rectangle(mousex, mousey, mx/2 - 64, 16, mx/2 + 64, 48))
									{
										key_press_enter = true;
									}
								}
							}
							else
							{
								drawSetup(c_white, 0.7);
								draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, false);
								drawSetup(c_black, 0.7);
								draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, true);
								draw_text(mx/2, 32, "Pay Jail Fee");
								draw_text(mx/2, 32+32, "Press Enter");
								if(mouse_check_button_pressed(mb_left))
								{
									if(point_in_rectangle(mousex, mousey, mx/2 - 64, 16, mx/2 + 64, 48))
									{
										key_press_enter = true;
									}
								}
							}
						}
					}
					else
					{
					
					}
				}
			}
		}
		else
		{
			var mx = display_get_gui_width();
			var my = display_get_gui_height() - 128;
			drawSetup(c_white, 0.7);
			draw_rectangle(mx/2 - 160, my/2 - 160, mx/2 + 160, my/2 + 160, false);
			drawSetup(c_black, 0.7);
			draw_rectangle(mx/2 - 160, my/2 - 160, mx/2 + 160, my/2 + 160, true);
			drawSetup(c_black);
			draw_text(mx/2, my/2 - 128, $"Auction for : {board[players[player_turn-1].position].name}");
			draw_text(mx/2, my/2 -  64, $"Property Value: ${board[players[player_turn-1].position].price}");
			draw_text(mx/2, my/2, $"Auction Value : ${auction_value}");
			draw_text(mx/2, my/2 + 64, $"Last Bid :  ${last_bid}");
			draw_text(mx/2, my/2 + 128, $"Last Bidder : {last_bidder}");
		
			my = display_get_gui_height();
			if(players[auction_players[auction_turn-1]].id == my_player_id)
			{
				drawSetup(c_white, 0.7);
				draw_rectangle(0, 0, mx, 64, false);
			
				drawSetup(c_white, 0.7);
				draw_rectangle(mx/2 - 64-128-64, 16, mx/2 + 64-128-64, 48, false);
				drawSetup(c_black, 0.7);
				draw_rectangle(mx/2 - 64-128-64, 16, mx/2 + 64-128-64, 48, true);
				draw_text(mx/2-128-64, 32, "Bid $100");
				draw_text(mx/2-128-64, 32+32, "Press Enter");
			
				drawSetup(c_white, 0.7);
				draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, false);
				drawSetup(c_black, 0.7);
				draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, true);
				draw_text(mx/2, 32, "Bid $10");
				draw_text(mx/2, 32+32, "Press Space");
			
				drawSetup(c_white, 0.7);
				draw_rectangle(mx/2 - 64 + 128+64, 16, mx/2 + 64 + 128+64, 48, false);
				drawSetup(c_black, 0.7);
				draw_rectangle(mx/2 - 64 + 128+64, 16, mx/2 + 64 + 128+64, 48, true);
				draw_text(mx/2 + 128+64, 32, "Withdraw");
				draw_text(mx/2 + 128+64, 32+32, "Press Backspace");
			}
		}
	}
	else
	{
		var mx = display_get_gui_width();
		var my = display_get_gui_height();
		var mousex = device_mouse_x_to_gui(0);
		var mousey = device_mouse_y_to_gui(0);
		
		if(trader1 == my_player_id)
		{
			drawSetup(c_white, 0.7);
			draw_rectangle(mx/2 - 64-64-64, 16, mx/2 + 64-64-64, 48, false);
			drawSetup(c_black, 0.7);
			draw_rectangle(mx/2 - 64-64-64, 16, mx/2 + 64-64-64, 48, true);
			draw_text(mx/2-64-64, 32, "Send Trade");
			draw_text(mx/2-64-64, 32+32, "Press Enter");
					
			drawSetup(c_white, 0.7);
			draw_rectangle(mx/2 - 64+64+64, 16, mx/2 + 64+64+64, 48, false);
			drawSetup(c_black, 0.7);
			draw_rectangle(mx/2 - 64+64+64, 16, mx/2 + 64+64+64, 48, true);
			draw_text(mx/2+64+64, 32, "Cancel");
			draw_text(mx/2+64+64, 32+32, "Press Space");
		}
		if(trader2 == my_player_id)
		{
			drawSetup(c_white, 0.7);
			draw_rectangle(mx/2 - 64-64-64, 16, mx/2 + 64-64-64, 48, false);
			drawSetup(c_black, 0.7);
			draw_rectangle(mx/2 - 64-64-64, 16, mx/2 + 64-64-64, 48, true);
			draw_text(mx/2-64-64, 32, "Accept Trade");
			draw_text(mx/2-64-64, 32+32, "Press Enter");
					
			drawSetup(c_white, 0.7);
			draw_rectangle(mx/2 - 64+64+64, 16, mx/2 + 64+64+64, 48, false);
			drawSetup(c_black, 0.7);
			draw_rectangle(mx/2 - 64+64+64, 16, mx/2 + 64+64+64, 48, true);
			draw_text(mx/2+64+64, 32, "Decline Trade");
			draw_text(mx/2+64+64, 32+32, "Press Space");
		}
		if(mouse_check_button_pressed(mb_left))
		{
			if(point_in_rectangle(mousex, mousey, mx/2 - 64-64-64, 16, mx/2 + 64-64-64, 48))
			{
				key_press_enter = true;
			}
			if(point_in_rectangle(mousex, mousey, mx/2 - 64+64+64, 16, mx/2 + 64+64+64, 48))
			{
				key_press_space = true;
			}
		}
	}
}