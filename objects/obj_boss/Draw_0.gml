/// @description Insert description here
// You can write your code in this editor

shader_set(shader_red);
shader_set_uniform_f(shader_get_uniform(shader_red, "u_flash_amount"), flash_intensity);

draw_self();
shader_reset();