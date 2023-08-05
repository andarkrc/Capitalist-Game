type = "";
width = 0;
height = 0;
image = undefined;
text = "";
font = fnMedium;
mouse_hover = false;
selected = false;
can_write = false;
line_flash = false;


var fn = function (){
	line_flash = !line_flash;
}
ts_flash = time_source_create(time_source_game, 1, time_source_units_seconds, fn, [], -1);

///@function enter_action
enter_action = function(){
}