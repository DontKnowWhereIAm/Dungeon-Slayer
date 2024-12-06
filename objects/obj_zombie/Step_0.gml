/// @description Insert description here
// You can write your code in this editor

// Cooldowns
if (stunTimer > 0) {
    stunTimer -= 1;
    if (stunTimer <= 0) {
        enemy_speed = baseEnemy_speed; // Restore speed after stun
        if (hp > 0) state = "chasing"; // Return to chase state
    }
}
if (attackCooldown > 0) attackCooldown--;
if (grappleTimer > 0) grappleTimer--;

// Calculate distance and direction to player once
var distToPlayer = point_distance(x, y, playerObj.x, playerObj.y);
var dirToPlayer = point_direction(x, y, playerObj.x, playerObj.y);

// State management
switch (state) {
    case "idle":
        // Wander randomly
        if (random(100) < 1) {
            var wanderDir = random(360);
            x += lengthdir_x(enemy_speed, wanderDir);
            y += lengthdir_y(enemy_speed, wanderDir);
        }

        // Transition to chasing if player is detected
        if (distToPlayer < detectionRadius) {
            state = "chasing";
        }
        break;

    case "chasing":
        // Move toward player
        if (distToPlayer > attackRange) {
            x += lengthdir_x(enemy_speed, dirToPlayer);
            y += lengthdir_y(enemy_speed, dirToPlayer);
        } else {
            // Within attack range
            state = "attacking";
        }
        break;

    case "attacking":
        if (attackCooldown <= 0) {
            if (distToPlayer <= grappleRange) {
                // Start grapple attack
                state = "grappling";
                grappleTimer = 60; // Grapple duration
            } else {
                // Perform basic swing attack
                attackCooldown = 30; // Cooldown before next attack
                playerObj.hp -= 1;   // Damage the player
                state = "chasing";   // Return to chasing
            }
        }
        break;

    case "grappling":
        // Pull the player during grapple
        var pullSpeed = 2;
        playerObj.x += lengthdir_x(pullSpeed, dirToPlayer);
        playerObj.y += lengthdir_y(pullSpeed, dirToPlayer);

        // Release after grapple duration
        if (grappleTimer <= 0) {
            state = "chasing";
        }
        break;

    case "hurt":
        if (hp > 0) {
            // Play hurt sound here
            state = "stun";
        }
        break;

    case "stun":
        if (hp > 0) {
            enemy_speed = 0;    // Immobilize
            stunTimer = 5;      // Duration of stun
        }
        break;
}

// Death logic
if (hp <= 0) {
    instance_destroy();
    // Optional: Add sound or death animation here
}
