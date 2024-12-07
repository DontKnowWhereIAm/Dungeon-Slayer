/// @description Insert description here
// You can write your code in this editor
var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Adjusted box dimensions
var box_left = gui_width / 6;             // Move the left side further left
var box_right = gui_width * 5 / 6;        // Move the right side further right
var box_top = gui_height / 1.2 - 50;      // Top position
var box_bottom = gui_height / 1.2 + 50;   // Bottom position

// Draw the background box
draw_set_color(c_black);
draw_rectangle(box_left, box_top, box_right, box_bottom, false);

// Draw the border
draw_set_color(c_white);
draw_rectangle(box_left - 2, box_top - 2, box_right + 2, box_bottom + 2, false);

// Draw the text
draw_set_color(c_red);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(gui_width / 2, gui_height / 1.2, text);