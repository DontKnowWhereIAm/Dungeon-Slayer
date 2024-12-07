/// @description Insert description here
// You can write your code in this editor

if (state != "dashing") 
{
	hp = hp -10;
	instance_destroy(obj_dashableBullet);
}

if (state == "dashing") 
{
	global.score++;
}	