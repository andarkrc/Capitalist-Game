///@function createBackButton
///@param {Real} xx_
///@param {Real} yy_
function createBackButton(xx_, yy_){
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextImage))
	{
		type = "Back";
		text = "Back";
		width = 128;
		height = 128;
		
		///@function left_click_action
		left_click_action = function(){
			room_goto(rMainMenu);
		}
		
		button_id = id;
	}
	return button_id;
}

///@function createHostButton
///@param {Real} xx_
///@param {Real} yy_
function createHostButton(xx_, yy_){
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextImage))
	{
		type = "Host";
		text = "Host";
		width = 128;
		height = 128;
		
		///@function left_click_action
		left_click_action = function(){
			global.connection_type = "server";
			room_goto(rTest);
		}
		
		button_id = id;
	}
	return button_id;
}

///@function createJoinButton
///@param {Real} xx_
///@param {Real} yy_
function createJoinButton(xx_, yy_){
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oButtonTextImage))
	{
		type = "Join";
		text = "Join";
		width = 128;
		height = 128;
		
		///@function left_click_action
		left_click_action = function(){
			global.connection_type = "client";
			room_goto(rTest);
		}
		
		button_id = id;
	}
	return button_id;
}

///@function createNameTextBox
///@param {Real} xx_
///@param {Real} yy_
function createNameTextBox(xx_, yy_){
	var button_id = undefined;
	with(instance_create_layer(xx_, yy_, "GUI", oTextBox))
	{
		type = "PlayerName";
		text = global.player_name;
		width = 128;
		height = 32;
		
		///@function enter_action
		enter_action = function(){
			global.player_name = text;
		}
		
		button_id = id;
	}
	return button_id;
}