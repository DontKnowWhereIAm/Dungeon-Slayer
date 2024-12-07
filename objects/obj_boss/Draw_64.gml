/// @description Insert description here
// You can write your code in this editor

// Draw GUI Event in obj_boss
var bar_width = 500;  // Width of the health bar
var bar_height = 30;  // Height of the health bar
var x_pos = (1920 - bar_width) / 2;  // Center horizontally
var y_pos = 50;  // Position vertically at the top

// Calculate health bar fill
var hp_percentage = boss_health / max_hp;
var bar_fill = bar_width * hp_percentage;

// Draw health bar background
draw_set_color(c_black);
draw_rectangle(x_pos - 2, y_pos - 2, x_pos + bar_width + 2, y_pos + bar_height + 2, false);

// Draw health bar fill
draw_set_color(c_red);
draw_rectangle(x_pos, y_pos, x_pos + bar_fill, y_pos + bar_height, false);

// Draw health bar border
draw_set_color(c_white);
draw_rectangle(x_pos, y_pos, x_pos + bar_width, y_pos + bar_height, true);

draw_set_font(fnt_boss);
draw_set_color(c_white);
draw_text((1920 - bar_width) / 2, y_pos - 30, "The Forgotten One");
draw_text((1920 - bar_width) / 2, y_pos + bar_height + 20, string(floor(boss_health)) + " / " + string(max_hp));

draw_set_font(-1);