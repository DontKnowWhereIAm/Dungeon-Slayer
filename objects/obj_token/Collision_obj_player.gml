/// @description Insert description here
// You can write your code in this editor

if (instance_exists(obj_player)) {
    var player = instance_find(obj_player, 0); // Get the obj_player instance

    // Only allow collection if tutorialStep is 1 or greater
  if (player.tutorialStep >= 1) {
        global.tokens += 1;  // Update token count
		global.score += 10;
        instance_destroy();  // Destroy the token

        // Trigger third pop-up if conditions are met
        if (player.tutorialStep == 1 && global.tokens == 3 && !instance_exists(obj_popup)) {
            player.tutorialStep = 2; // Move to the next step
            var new_popup = instance_create_layer(room_width / 2, room_height / 1.2, "GUI", obj_popup);
            new_popup.text = "Now try using a dash mechanic to go through the passable wall.";
        }
    }
	
}