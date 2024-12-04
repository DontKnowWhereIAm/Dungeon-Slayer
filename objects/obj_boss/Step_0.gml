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
            bullet.speed = 5;
        }
        // Fire dashable bullets every 90 frames
        if (phase_timer % 90 == 0) {
            var dashable_bullet = instance_create_layer(x, y, "Instances", obj_dashableBullet);
            dashable_bullet.direction = random(360); // Random direction
            dashable_bullet.speed = 4;
        }
        break;

    case 3:
        // Phase 3: Mixed patterns
        if (phase_timer % 45 == 0) { // Fire standard bullets faster
            var bullet = instance_create_layer(x, y, "Instances", obj_bullet);
            bullet.direction = point_direction(x, y, obj_player.x, obj_player.y);
            bullet.speed = 6;
        }
        if (phase_timer % 75 == 0) { // Fire dashable bullets
            var dashable_bullet = instance_create_layer(x, y, "Instances", obj_dashableBullet);
            dashable_bullet.direction = random(360);
            dashable_bullet.speed = 5;
        }
        if (phase_timer % 120 == 0) { // Special attack or slam
            with (obj_player) {
                if (distance_to_object(obj_boss) < 50) {
                    hp -= 10; // Damage the player if too close
                }
            }
        }
        break;
}
