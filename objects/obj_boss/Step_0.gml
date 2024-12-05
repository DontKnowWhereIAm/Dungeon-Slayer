// Increment the phase timer
phase_timer++;

// Switch based on the current phase
switch (boss_phase) {
    case 1:
        // Phase 1: Standard bullet attacks
        if (boss_health <= 75) {
            boss_phase = 2; // Transition to phase 2
            phase_timer = 0; // Reset the timer for the new phase
        }
        if (phase_timer % 60 == 0) { // Fire a bullet every 60 frames
            var bullet = instance_create_layer(x, y, "Instances", obj_bullet);
            bullet.direction = point_direction(x, y, obj_player.x, obj_player.y);
            bullet.speed = 5;
        }
        break;

    case 2:
        // Phase 2: Standard and dashable bullets
        if (boss_health <= 50) {
            boss_phase = 3; // Transition to phase 3
            phase_timer = 0; // Reset the timer for the new phase
        }
        // Fire standard bullets every 60 frames
        if (phase_timer % 60 == 0) {
            var bullet = instance_create_layer(x, y, "Instances", obj_bullet);
            bullet.direction = point_direction(x, y, obj_player.x, obj_player.y);
            bullet.speed = 8;
        }
        // Fire dashable bullets every 90 frames
        if (phase_timer % 90 == 0) {
            var dashable_bullet = instance_create_layer(x, y, "Instances", obj_dashableBullet);
            dashable_bullet.direction = random(360); // Random direction
            dashable_bullet.speed = 8;
        }
        break;

    case 3:
        // Phase 3: Mixed patterns
        if (phase_timer % 45 == 0) { // Fire standard bullets faster
            var bullet = instance_create_layer(x, y, "Instances", obj_bullet);
            bullet.direction = point_direction(x, y, obj_player.x, obj_player.y);
            bullet.speed = 10;
        }
        if (phase_timer % 75 == 0) { // Fire dashable bullets
            var dashable_bullet = instance_create_layer(x, y, "Instances", obj_dashableBullet);
            dashable_bullet.direction = random(360);
            dashable_bullet.speed = 8;
        }
        if (phase_timer % 120 == 0) { 
            with (obj_player) {
                if (distance_to_object(obj_boss) < 50) {
                    obj_player.hp -= 10; 
                }
            }
        }
        break;
}

if (boss_health < 50) {
    // Handle teleportation
    if (teleport_cooldown <= 0) {
        var new_x, new_y;
        var attempts = 0;
        var max_attempts = 10; // Limit attempts to prevent infinite loops

        repeat (max_attempts) {
            // Generate random coordinates within room bounds
            new_x = irandom_range(50, (room_width-50));
            new_y = irandom_range(50, (room_height-50));

            // Check distance to player
            if (point_distance(new_x, new_y, obj_player.x, obj_player.y) >= 50) {
                // Safe position found
                x = new_x;
                y = new_y;
                break;
            }
            attempts += 1;
        }

        // Reset teleport cooldown (e.g., 120 frames)
        teleport_cooldown = 150;
    } else {
        teleport_cooldown -= 1;
    }
}

if (boss_health <= 0) {
    instance_destroy();
}

if (flash_timer > 0) {
    flash_timer -= 1;
    flash_intensity = flash_timer / 30;
} else {
    flash_intensity = 0.0;
}

