/// @description Player movement with dash-based passable objects

var dash = keyboard_check_pressed(vk_space);
var shoot = mouse_check_button(mb_left);

if (canMove)
{
    // Speed Calculation
    moveVector_x = (keyboard_check(vk_right) - keyboard_check(vk_left));
    moveVector_y = (keyboard_check(vk_down) - keyboard_check(vk_up));
    var objSpeed = moveSpeed;

    // Handle diagonal movement
    if (moveVector_x != 0 && moveVector_y != 0)
    {
        objSpeed = moveSpeed_diag;
    }

    // Check if dash is pressed and initiate dash properties
    if (dash) 
    {
        dashSpd = 5;
        dashDuration = 30;

        // Create dash trail particle effect
        var trail_x = x - lengthdir_x(8, image_angle);
        var trail_y = y - lengthdir_y(8, image_angle);
        part_particles_create(part_system, trail_x, trail_y, part_trail, 1);
    }

    // Apply dash effect if dash is active
    if (dashDuration > 0) 
    {
        objSpeed *= dashSpd;              // Apply dash speed multiplier
        dashSpd = max(dashSpd - 0.12, 1);  // Gradually decay dash speed
        dashDuration--;                    // Reduce dash duration each frame
    }

    // Calculate movement after any dash adjustments
    var move_x = objSpeed * moveVector_x;
    var move_y = objSpeed * moveVector_y;

    // Collision detection with conditional pass-through
    if (dashDuration <= 0) 
    {
		if (instance_place(x + move_x, y + move_y, obj_trap))  // Assuming obj_trap is the specific trap object
    {
        if (room == Room1) {
			x = 200; // Starting position in Room1
			y = 400;
		} 
		else if (room == Room2) {
			x = 100; // Starting position in Room2
			y = 450;
		}
    }
        // Not dashing: Check for collision with both obj_block and obj_passable
        if (instance_place(x + move_x, y + move_y, obj_block) || instance_place(x + move_x, y + move_y, obj_passable))
        {
            move_x = 0;
            move_y = 0;
        }
	}
	
    else
	
    {
        // Dashing: Only check collision with obj_block; ignore obj_passable
        if (instance_place(x + move_x, y + move_y, obj_block))
        {
            move_x = 0;
            move_y = 0;
        }
    }

    // Apply movement after handling collisions
    x += move_x;
    y += move_y;
}

// Aiming and shooting logic
aimDir = point_direction(x, y, mouse_x, mouse_y);

if (shoot) 
{
    var _attackInst = instance_create_depth(x, y, depth - 100, obj_attack);
    with (_attackInst) {
        dir = other.aimDir;
    }
}
