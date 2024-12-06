/// @description Insert description here
// You can write your code in this editor
if keyboard_check(ord("R")){
	room_restart()
}
if keyboard_check(ord("G")){
	game_restart()
}
if keyboard_check(ord("N")){
room_goto_next()
}
if keyboard_check(ord("B")){
room_goto_previous()
}
if keyboard_check(ord("L")){
	obj_player.hp = 999;
}
if keyboard_check(ord("D")){
	obj_player.dashCharges = 999;
}
if keyboard_check(ord("A")){
	obj_player.attackCooldown = -99999;
}