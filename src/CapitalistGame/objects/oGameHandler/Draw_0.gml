if(game_started)
{
	drawSetup();
	draw_sprite(sBoard, 0, room_width/2 - 1664/2, room_height/2 - 1664/2);
	for(var i = 2; i <= 10; i++)
	{
		if(board[i].owner != undefined)
		{
			drawSetup(board[i].owner.color);
			draw_rectangle(board[i].xx1-4, board[i].yy1+256+8, board[i].xx1+128-5, board[i].yy1+288+8, false);
		}
	}
	
	for(var i = 12; i <= 20; i++)
	{
		if(board[i].owner != undefined)
		{
			drawSetup(board[i].owner.color);
			draw_rectangle(board[i].xx1-36, board[i].yy1+8, board[i].xx1-5, board[i].yy1+135, false);
		}
	}
	
	for(var i = 22; i <= 30; i++)
	{
		if(board[i].owner != undefined)
		{
			drawSetup(board[i].owner.color);
			draw_rectangle(board[i].xx1-4, board[i].yy1-24, board[i].xx1+123, board[i].yy1+7, false);
		}
	}
	
	for(var i = 32; i <= 40; i++)
	{
		if(board[i].owner != undefined)
		{
			drawSetup(board[i].owner.color);
			draw_rectangle(board[i].xx1+256-4, board[i].yy1 + 8, board[i].xx1+256-4+31, board[i].yy1+128 + 7, false);
		}
	}
}