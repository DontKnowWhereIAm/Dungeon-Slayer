/// @description Insert description here
// You can write your code in this editor

if (instance_exists(obj_player)) {
    // Set the direction to aim at the player
    direction = point_direction(x, y, obj_player.x, obj_player.y);
} else {
    // If the player doesn't exist, default to shooting downward
    direction = 270;
}

// Set the bullet's speed (do not use hspeed or vspeed)
speed = 16;