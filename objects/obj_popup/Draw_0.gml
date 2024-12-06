/// @description Insert description here
// You can write your code in this editor

if (active) {
    // Set the font for the pop-up
    draw_set_font(fnt_popup);

    // Draw the background box
    draw_set_color(c_black); // Background color
    draw_rectangle(room_width / 4, room_height / 1.2 - 50, room_width * 3 / 4, room_height / 1.2 + 50, false);

    draw_set_color(c_white); // Border color
    draw_rectangle(room_width / 4 - 2, room_height / 1.2 - 52, room_width * 3 / 4 + 2, room_height / 1.2 + 52, false);

    // Draw text in red
    draw_set_color(c_red);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(room_width / 2, room_height / 1.2, text);
}