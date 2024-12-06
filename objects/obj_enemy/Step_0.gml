/// @description Insert description here
// You can write your code in this editor
if (stunTimer > 0) 
{
	stunTimer = stunTimer - 1;
	if (stunTimer = 0) 
	{
		enemy_speed = baseEnemy_speed;
	}
}

if (hp <= 0) 
{
	instance_destroy();
}

if (state = "hurt" && hp > 0)
{
	// sound will go here in CHILDS
	state = "stun";
}

if (state = "stun" && hp > 0)
{
	enemy_speed = 0;
	stunTimer = 5;
}