/// @description Insert description here
// You can write your code in this editor



canMove = true;

moveSpeed = 3;
moveSpeed_diag = 2;
moveVector_x = 0;
moveVector_y = 0;

dashCharges = 999;

dashSpd = 0;
dashDuration = 0;

//Sprite code
part_system = part_system_create();
part_trail = part_type_create();

// Customize particle type for afterimage effect
part_type_sprite(part_trail, spr_testPlayer, true, false, false);
part_type_size(part_trail, 1, 1, 0, 0);     // Size range of particles
part_type_color1(part_trail, c_white);         // Color of the particles
part_type_alpha3(part_trail, 0.5, 0.3, 0);         // Starts with semi-transparency and fades out
part_type_life(part_trail, 10, 20);                // Lifetime of particles
part_type_speed(part_trail, 0, 0, 0, 0);       // No movement speed