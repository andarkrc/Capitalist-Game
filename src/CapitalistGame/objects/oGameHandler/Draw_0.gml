if(game_started)
{
	drawSetup();
	draw_sprite(sBoard, 0, 0, 0);
	for(var i = 2; i <= 10; i++)
	{
		if(board[i].owner != undefined)
		{
			drawSetup(board[i].owner.color);
			draw_rectangle(board[i].xx1, board[i].yy1+256, board[i].xx1+128-1, board[i].yy1+256+32, false);
		}
	}
	
	for(var i = 12; i <= 20; i++)
	{
		if(board[i].owner != undefined)
		{
			drawSetup(board[i].owner.color);
			draw_rectangle(board[i].xx1-32, board[i].yy1, board[i].xx1-1, board[i].yy1+128-1, false);
		}
	}
	
	for(var i = 22; i <= 30; i++)
	{
		if(board[i].owner != undefined)
		{
			drawSetup(board[i].owner.color);
			draw_rectangle(board[i].xx1, board[i].yy1-32, board[i].xx1+128-1, board[i].yy1-1, false);
		}
	}
	
	for(var i = 32; i <= 40; i++)
	{
		if(board[i].owner != undefined)
		{
			drawSetup(board[i].owner.color);
			draw_rectangle(board[i].xx1+256, board[i].yy1, board[i].xx1+256+32, board[i].yy1+128-1, false);
		}
	}
}