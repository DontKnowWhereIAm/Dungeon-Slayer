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


var kill_range = 20;

// Check for nearby enemies within the kill range
with (obj_enemy) {
    if (point_distance(other.x, other.y, x, y) <= kill_range) {
        // Destroy both the enemy and the projectile
        instance_destroy();
        with (other) instance_destroy();
    }
}

with (obj_enemy2) {
    if (point_distance(other.x, other.y, x, y) <= kill_range) {
        
        instance_destroy();
        with (other) instance_destroy();
   }
}

with (obj_enemy3) {
    if (point_distance(other.x, other.y, x, y) <= kill_range) {
        
        instance_destroy();
        with (other) instance_destroy();
   }
   
}
