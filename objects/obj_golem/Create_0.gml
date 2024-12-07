/// @description Insert description here
// You can write your code in this editor
baseEnemy_speed = 1;
enemy_speed = baseEnemy_speed;
hp = 15;
stunTimer = 0;

state = "idle";
playerObj = obj_player;
detectionRadius = 500;
attackRange = 70;
attackCooldown = 0;
lastAttackDir = 0;