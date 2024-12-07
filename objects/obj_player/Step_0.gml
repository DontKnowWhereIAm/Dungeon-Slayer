/// @description Player movement with dash-based passable objects

var dash = keyboard_check_pressed(vk_space);
var shoot = mouse_check_button(mb_left);
var shoot2 = mouse_check_button(mb_right);

attackCooldown = attackCooldown - 1;
dashCooldown = dashCooldown - 1;
resistTimer = resistTimer -1;

if (resistTimer > 0)
{
	// won't work for big damage but too much of a hassle otherwise
	hpLock = hp;
	hp = hpLock;
}


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
		dashCount += 1; // Increment dash count FIRST
		show_debug_message("Dash Count: " + string(dashCount));
		//dashCharges = dashCharges - 1;
		dashCooldown = 30;
		dashRecharge = 120;
        dashSpd = 5;
        dashDuration = 30;
		dashCharges -= 1;
		resistTimer = 45;

		
		// Sync dash charges with HUD
        global.dash_charges = dashCharges;
		
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
		
		hp -= 15;
		global.health = hp; // Sync with HUD
		
		// Check if health is 0 or below
		if (hp <= 0) {
			instance_destroy();
			room_goto(rm_lose); // Transition to Lose Screen
		}
		else {
	        if (room == Room1) {
				x = 200; // Starting position in Room1
				y = 400;
			} 
			else if (room == Room2) {
				x = 100; // Starting position in Room2
				y = 450;
			}
			else if (room == rm_tutorial) {
				x = 200;
				y = 400;
			}
			else if (room == rm_puzzle) {
				x = 50;
				y = 515;
			}
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
		//dashCharges = dashCharges + 1
		dashCharges += 1;
		show_debug_message("Dash Recharged! Current Charges: " + string(dashCharges));
	}
}

// Check if a pop-up box is active
if (instance_exists(obj_popup) && obj_popup.active) {
    canMove = false; // Disable movement
	
} 
else {
    canMove = true; // Enable movement
	
}

if (hp <= 0) {
	instance_destroy();
	room_goto(rm_lose); // Transition to Lose Screen
}

// Track dashes
/*
if (keyboard_check_pressed(vk_space) && dashCharges >= 1) {
    dashCount += 1; // Increment dash count
	show_debug_message("Dash Count: " + string(dashCount)); // Debug message
}
*/

// Trigger pop-up after 3 dashes
/*if (tutorialStep == 0 && dashCount == 3 && !instance_exists(obj_popup)) {
    tutorialStep = 1; // Move to the next step
    var new_popup = instance_create_layer(room_width / 2, room_height / 1.2, "GUI", obj_popup);
    new_popup.text = "Now try collecting the tokens on the floor.";
    show_debug_message("Second pop-up triggered!");
}*/
if (tutorialStep == 0) {
    // Check for 3 dashes
    if (dashCount == 3 ){
        tutorialStep = 1;
        var new_popup = instance_create_layer(room_width / 2, room_height / 1.2, "GUI", obj_popup);
        new_popup.text = "Now try collecting the tokens on the floor.";
        show_debug_message("Second pop-up triggered!");
    }
}


if (tutorialStep == 1) {
    // Check for collecting 3 tokens
    if (global.tokens == 3 && !instance_exists(obj_popup)) {
        tutorialStep = 2;
        var new_popup = instance_create_layer(room_width / 2, room_height / 1.2, "GUI", obj_popup);
        new_popup.text = "Now try using a dash mechanic to go through the passable wall.";
        show_debug_message("Third pop-up triggered!");
    }
}

// Aiming and shooting logic
aimDir = point_direction(x, y, mouse_x, mouse_y);

if (shoot && attackCooldown <= 0 && !shoot2 && state != "dashing" && state != "sword attack")
{
	attackCooldown = 30;
	state = "sword attack"
	attackTimer = 10;
}

if (state = "sword attack")
{
	// PLAY SOUND HERE
	// sprite_index = spr_swordAttack; // IMPORTANT AND NOT DONE
	
	var _attackInst = instance_create_depth(x, y, depth - 100, obj_attack2);
    with (_attackInst) {
        dir = other.aimDir;
    }
}


if (state == "sword_attack") {
    attackTimer--;
    if (attackTimer <= 0) {
        state = "empty";
    }
}


if (shoot2  && attackCooldown <= 0 && !shoot && state != "sword attack") 
{
	// PLAY SOUND HERE
	attackCooldown = 40;
    var _attackInst = instance_create_depth(x, y, depth - 100, obj_attack);
    with (_attackInst) {
        dir = other.aimDir;
    }
}

if (state != "sword_attack" || "dashing") 
{
	state = "empty";
}
if (global.enemyKills == 2 && !instance_exists(obj_popup) && !global.dashPopupShown) {
    global.dashPopupShown = true; // Mark the pop-up as shown
    var new_popup = instance_create_layer(room_width / 2, room_height / 1.2, "GUI", obj_popup);
    new_popup.text = "Try using the dash to go through traps.";
    show_debug_message("Dash tutorial pop-up triggered.");
}

if (room == rm_puzzle) {
    if (global.timer > 0) {
        global.timer -= (1 / room_speed) * 100; // Decrease timer in hundredths
    } else if (global.timer <= 0) {
        // Reset player position when the timer runs out
        x = 50; // Starting X-coordinate in the puzzle room
        y = 515; // Starting Y-coordinate in the puzzle room
        global.timer = 3000; // Reset timer to 20 seconds
        show_debug_message("Time's up! Resetting player position.");
    }
}
