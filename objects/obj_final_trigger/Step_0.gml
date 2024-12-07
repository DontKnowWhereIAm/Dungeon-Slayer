/// @description Insert description here
// You can write your code in this editor

if (place_meeting(x, y, obj_player)) {
    if (!instance_exists(obj_popup)) {
        var new_popup = instance_create_layer(room_width / 2, room_height / 1.2, "GUI", obj_popup);
        new_popup.text = "Well done. You are ready to move on.";
        show_debug_message("Final pop-up triggered.");

        // Transition to Room1 after a delay
        alarm[0] = 180; // Wait 1 second before transitioning to the next room
    }
}