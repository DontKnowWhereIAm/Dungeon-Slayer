/// @description Insert description here
// You can write your code in this editor
if (room == Room1) {
    // Set the player's starting position for Room1
    x = 100;
    y = 450;

    // Reset dash charges and count
    dashCharges = 5;
    dashCount = 0;

    // Sync dash charges with HUD
    global.dash_charges = dashCharges;
	
	global.tokens = 0;
    global.score = 0;
    hp = 100;
    global.health = hp;
}