/// @description Insert description here
// You can write your code in this editor
var gui_width = display_get_gui_width();   // Get the GUI width
var gui_height = display_get_gui_height(); // Optional, if needed for positioning

// Box dimensions
var box_left = gui_width * 2 / 5;
var box_right = gui_width * 3 / 5;
var box_top = 10;      // Near the top of the screen
var box_bottom = 60;

// Draw the background box
draw_set_color(c_black);
draw_rectangle(box_left, box_top, box_right, box_bottom, false);

// Draw the border
draw_set_color(c_white);
draw_rectangle(box_left - 2, box_top - 2, box_right + 2, box_bottom + 2, false);

// Draw the score text
draw_set_color(c_red);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text((box_left + box_right) / 2, (box_top + box_bottom) / 2, score_text);