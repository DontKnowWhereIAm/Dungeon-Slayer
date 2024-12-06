/// @description Insert description here
// You can write your code in this editor
if (instance_exists(obj_player)) {
    global.health = obj_player.hp;
    global.dash_charges = obj_player.dashCharges;
	global.dash_count = obj_player.dashCount;
}