/// @description Insert description here
// You can write your code in this editor
if (place_meeting(x, y, obj_player)) {
    if (!instance_exists(obj_popup)) {
        var new_popup = instance_create_layer(room_width / 2, room_height / 1.2, "GUI", obj_popup);
        new_popup.text = "Great job! Keep exploring around";
        show_debug_message("Dash area pop-up triggered.");

        // Destroy or deactivate the trigger
        instance_destroy();
    }
}