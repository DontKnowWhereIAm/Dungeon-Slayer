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

