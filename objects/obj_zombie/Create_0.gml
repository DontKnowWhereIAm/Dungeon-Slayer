/// @description Insert description here
// You can write your code in this editor
//Speed on enemy
baseEnemy_speed = 3;
enemy_speed = baseEnemy_speed;
hp = 5;
stunTimer = 0;

state = "idle";
playerObj = obj_player;
detectionRadius = 150;
attackRange = 40;
grappleRange = 20;
attackCooldown = 0;
grappleTimer = 0;