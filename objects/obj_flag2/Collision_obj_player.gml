/// @description Insert description here
// You can write your code in this editor
obj_player.x = 100;
obj_player.y = 400;
audio_stop_sound(snd_main);
audio_play_sound(snd_boss, 1, true)
room_goto(rm_boss);