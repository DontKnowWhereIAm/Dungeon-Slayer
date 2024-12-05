/// @description Player movement with dash-based passable objects

var dash = keyboard_check_pressed(vk_space);
var shoot = mouse_check_button(mb_left);
var shoot2 = mouse_check_button(mb_right);

attackCooldown = attackCooldown - 1;
dashCooldown = dashCooldown - 1;


if (canMove)
{
    // Speed Calculation
    moveVector_x = (keyboard_check(ord("D")) - keyboard_check(ord("A")));
    moveVector_y = (keyboard_check(ord("S")) - keyboard_check(ord("W")));
    var objSpeed = moveSpeed;

    // Handle diagonal movement
    if (moveVector_x != 0 && moveVector_y != 0)
    {
        objSpeed = moveSpeed_diag;
    }

    // Check if dash is pressed and initiate dash properties
    if (dash && dashCooldown <= 0 && dashCharges > 0) 
    {
		dashCharges = dashCharges - 1;
		dashCooldown = 30;
		dashRecharge = 120;
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
		is_dashing = true;
        objSpeed *= dashSpd;              // Apply dash speed multiplier
        dashSpd = max(dashSpd - 0.12, 1);  // Gradually decay dash speed
        dashDuration--;                    // Reduce dash duration each frame
    }
	
	if (dashDuration <= 0)
	{ 
		is_dashing = false;
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

// Dash recharge mechanics
if (dashCharges < minDashCharge)
{
	dashRecharge = dashRecharge - 1;
	if (dashRecharge <= 0)
	{
		dashRecharge = 60;
		dashCharges = dashCharges + 1
	}
}

// Aiming and shooting logic
aimDir = point_direction(x, y, mouse_x, mouse_y);

if (shoot && attackCooldown <= 0 && !shoot2)
{
	attackCooldown = 20;
	state = "sword attack"
	attackTimer = 10;
	swordDir = aimDir;
}

if (state = "sword attack")
{
	// PLAY SOUND HERE
	sprite_index = spr_swordAttack; // IMPORTANT AND NOT DONE
	image_angle = swordDir;
	var attackRadius = 50
	var attackArc = 75;
	
	with (obj_enemy) {
		var dirToEnemy = point_direction(other.x, other.y, x, y);
        if (point_in_circle(other.x, other.y, x, y, attackRadius) &&
            abs(angle_difference(swordDir, dirToEnemy)) <= attackArc / 2) {
            hp -= 3; 
        }
	}
}

if (state == "sword_attack") {
    attackTimer--;
    if (attackTimer <= 0) {
        state = "empty";
    }
}


if (shoot2  && attackCooldown <= 0 && !shoot) 
{
	// PLAY SOUND HERE
	attackCooldown = 40;
    var _attackInst = instance_create_depth(x, y, depth - 100, obj_attack);
    with (_attackInst) {
        dir = other.aimDir;
    }
}
