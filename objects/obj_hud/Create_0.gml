/// @description Insert description here
// You can write your code in this editor
//global.tokens = 0;        // Collected tokens

if (!variable_global_exists("tokens")) {
    global.tokens = 0; // Initialize tokens to 0
}

if (!variable_global_exists("score_reset")) {
    global.score_reset = false; // Flag to track if the score has been reset
}


// HUD positioning
hud_x = 30;
hud_y = 15;