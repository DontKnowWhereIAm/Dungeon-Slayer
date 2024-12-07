/// @description Insert description here
// You can write your code in this editor


if destroy == true {
	instance_destroy();
}

if point_distance(xstart, ystart, x, y) > maxDist {
	destroy = true;
}


xspd = lengthdir_x( spd, dir);
yspd = lengthdir_y( spd, dir);

x += xspd;
y += yspd;

//FORCED THE MERGE BELOW DIDN'T WANT TO BREAK THIS BUT ALL BELOW NEEDS TO BE FIXED
var kill_range = 20;

// Check for nearby enemies within the kill range
with (obj_enemy) {
    if (point_distance(other.x, other.y, x, y) <= kill_range) {
        // Destroy both the enemy and the projectile
		global.score += 20;
        instance_destroy();
        with (other) instance_destroy();
    }
}

with (obj_enemy2) {
    if (point_distance(other.x, other.y, x, y) <= kill_range) {
        global.enemyKills += 1; // Increment kill counter
		global.score += 20;
        instance_destroy();
        with (other) instance_destroy();
   }
}

with (obj_enemy3) {
    if (point_distance(other.x, other.y, x, y) <= kill_range) {
        global.enemyKills += 1; // Increment kill counter
		global.score += 20;
        instance_destroy();
        with (other) instance_destroy();
   }  
}

if (place_meeting(x, y, obj_enemy4)){
    global.enemyKills += 1;
	global.score += 20;
    show_debug_message("Enemy4 killed. Total kills: " + string(global.enemyKills));
    with (instance_nearest(x, y, obj_enemy4)) instance_destroy();
    instance_destroy();
}


if (place_meeting(x, y, obj_enemy5)) {
    global.enemyKills += 1;
	global.score += 20;
    show_debug_message("Enemy5 killed. Total kills: " + string(global.enemyKills));
    with (instance_nearest(x, y, obj_enemy5)) instance_destroy();
    instance_destroy();
}
