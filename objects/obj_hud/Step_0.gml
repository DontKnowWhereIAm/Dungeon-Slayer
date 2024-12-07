/// @description Insert description here
// You can write your code in this editor
if (instance_exists(obj_player)) {
    global.health = obj_player.hp;
    global.dash_charges = obj_player.dashCharges;
	global.dash_count = obj_player.dashCount;
}

if (!variable_global_exists("previous_room")) {
    global.previous_room = room; // Initialize the previous room
}

// Reset score when leaving the tutorial room
if (global.previous_room == rm_tutorial && room != rm_tutorial) {
    global.score = 0; //Reset score
	global.tokens = 0;// Reset tokens
    show_debug_message("Score and tokens reset after tutorial room");
}



global.previous_room = room; 