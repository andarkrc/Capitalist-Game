vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
global.vertex_format = vertex_format_end();

///@function bufferAddPoint
///@param {Id.VertexBuffer} vbuffer_
///@param {Real} xx_
///@param {Real} yy_
///@param {Real} zz_
///@param {Real} nx_
///@param {Real} ny_
///@param {Real} nz_
///@param {Real} textu_
///@param {Real} textv_
///@param {Constant.Color} vcolor_
///@param {Real} valpha_
function bufferAddPoint(vbuffer_, xx_, yy_, zz_, nx_, ny_, nz_, textu_, textv_, vcolor_, valpha_){
	vertex_position_3d(vbuffer_, xx_, yy_, zz_);
	vertex_normal(vbuffer_, nx_, ny_, nz_);
	vertex_texcoord(vbuffer_, textu_, textv_);
	vertex_color(vbuffer_, vcolor_, valpha_);
}

///@function loadOBJModelFile
///@param {String} filename_
///@param {Constant.Color} special_color_
///@param {Real} special_alpha_
function loadOBJModelFile(filename_, special_color_ = c_white, special_alpha_ = 1){
	var file = file_text_open_read(filename_);
	var vertex_x = ds_list_create();
	var vertex_y = ds_list_create();
	var vertex_z = ds_list_create();
	
	var vertex_nx = ds_list_create();
	var vertex_ny = ds_list_create();
	var vertex_nz = ds_list_create();
	
	var vertex_u = ds_list_create();
	var vertex_v = ds_list_create();
	
	var vbuff = vertex_create_buffer();
	vertex_begin(vbuff, global.vertex_format);
	
	while(!file_text_eof(file))
	{
		var line = file_text_read_string(file);
		file_text_readln(file);
		
		var terms = [];
		var index = 0;
		terms[0] = "";
		terms[string_count(" ", line)] = "";
		for(var i = 1; i <= string_length(line); i++)
		{
			if(string_char_at(line, i) == " ")
			{
				index++;
				terms[index] = "";
			}
			else
			{
				terms[index] = terms[index] + string_char_at(line, i);
			}
		}
		switch(terms[0])
		{
			case "v":
				ds_list_add(vertex_x, real(terms[1]));
				ds_list_add(vertex_y, real(terms[2]));
				ds_list_add(vertex_z, real(terms[3]));
				break;
			case "vt":
				ds_list_add(vertex_u, real(terms[1]));
				ds_list_add(vertex_v, real(terms[2]));
				break;
			case "vn":
				ds_list_add(vertex_nx, real(terms[1]));
				ds_list_add(vertex_ny, real(terms[2]));
				ds_list_add(vertex_nz, real(terms[3]));
				break;
			case "f":
				for(var n = 1; n <= 3; n++)
				{
					var data = [];
					index = 0;
					data[0] = "";
					data[string_count("/", terms[n])] = "";
					for(var i = 1; i <= string_length(terms[n]); i++)
					{
						if(string_char_at(terms[n], i) == "/")
						{
							index++;
							data[index] = "";
						}
						else
						{
							data[index] = data[index] + string_char_at(terms[n], i);
						}
					}
					var xx = ds_list_find_value(vertex_x, real(data[0])-1);
					var yy = ds_list_find_value(vertex_y, real(data[0])-1);
					var zz = ds_list_find_value(vertex_z, real(data[0])-1);
					
					var uu = ds_list_find_value(vertex_u, real(data[1])-1);
					var vv = ds_list_find_value(vertex_v, real(data[1])-1);
					
					var nx = ds_list_find_value(vertex_nx, real(data[2])-1);
					var ny = ds_list_find_value(vertex_ny, real(data[2])-1);
					var nz = ds_list_find_value(vertex_nz, real(data[2])-1);
					bufferAddPoint(vbuff, xx, yy, zz, nx, ny, nz, uu, vv, special_color_, special_alpha_);
				}
				break;
			default : break; 
		}
	}
	vertex_end(vbuff);
	ds_list_destroy(vertex_x);
	ds_list_destroy(vertex_y);
	ds_list_destroy(vertex_z);
	
	ds_list_destroy(vertex_u);
	ds_list_destroy(vertex_v);
	
	ds_list_destroy(vertex_nx);
	ds_list_destroy(vertex_ny);
	ds_list_destroy(vertex_nz);
	file_text_close(file);
	
	return vbuff;
}

global.models = ds_map_create();
ds_map_add(global.models, "Potato", loadOBJModelFile("potato.obj"));
ds_map_add(global.models, "Rat", loadOBJModelFile("bike.obj"));
ds_map_add(global.models, "Duck", loadOBJModelFile("bike.obj"));
ds_map_add(global.models, "Dog", loadOBJModelFile("bike.obj"));
ds_map_add(global.models, "Cat", loadOBJModelFile("bike.obj"));
ds_map_add(global.models, "Bike", loadOBJModelFile("bike.obj"));
ds_map_add(global.models, "Dice", loadOBJModelFile("bike.obj"));