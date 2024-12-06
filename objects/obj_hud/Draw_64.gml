/// @description Insert description here
// You can write your code in this editor
draw_set_font(fnt_hud);
draw_set_color(c_white);
draw_set_halign(fa_left);

// Draw Tokens
draw_text(hud_x, hud_y, "Tokens: " + string(global.tokens));

// Draw Health Bar
var health_width = 200;
var health_height = 20;
var health_percentage = global.health / 100;
draw_set_color(c_black);
draw_rectangle(hud_x, hud_y + 30, hud_x + health_width, hud_y + 30 + health_height, false);
draw_set_color(c_red);
draw_rectangle(hud_x, hud_y + 30, hud_x + health_width * health_percentage, hud_y + 30 + health_height, false);

// Draw Score
draw_text(hud_x, hud_y + 60, "Score: " + string(global.score));

// Draw Dash Charges
draw_text(hud_x, hud_y + 90, "Dash Charges: " + string(global.dash_charges));

//draw_text(hud_x, hud_y + 120, "Dash Count: " + string(global.dash_count));


// Format the timer with two digits for hundredths
if (room == rm_puzzle){
	var seconds = floor(global.timer / 100);       // Whole seconds
	var hundredths = floor(global.timer) mod 100;  // Two-digit hundredths
	
	if (hundredths < 10) {
	    draw_text(hud_x, hud_y + 120, "Time Left: " + string(seconds) + ".0" + string(hundredths));
	} else {
	    draw_text(hud_x, hud_y + 120, "Time Left: " + string(seconds) + "." + string(hundredths));
	}
}