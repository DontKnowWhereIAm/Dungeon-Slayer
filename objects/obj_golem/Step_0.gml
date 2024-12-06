// Handle stun timer
if (stunTimer > 0) {
    stunTimer--;
    if (stunTimer == 0) {
        enemy_speed = baseEnemy_speed; // Reset speed after stun
        if (hp > 0) state = "chasing"; // Resume chasing if not dead
    }
}

// Handle attack cooldown
if (attackCooldown > 0) attackCooldown--;

// Check for death
if (hp <= 0) {
    instance_destroy(); // Destroy Golem instance on death
    // Optional: Add death animation or effects here
}

// Calculate distance and direction to the player
var distToPlayer = point_distance(x, y, playerObj.x, playerObj.y);
var dirToPlayer = point_direction(x, y, playerObj.x, playerObj.y);

// State management
if (state == "idle") {
    // Wander randomly in idle state
    if (random(100) < 1) {
        var wanderDir = random(360);
        x += lengthdir_x(enemy_speed, wanderDir);
        y += lengthdir_y(enemy_speed, wanderDir);
    }

    // Detect player and transition to chasing
    if (distToPlayer < detectionRadius) {
        state = "chasing";
    }
}

if (state == "chasing") {
    // Chase player
    if (distToPlayer > attackRange) {
        x += lengthdir_x(enemy_speed, dirToPlayer);
        y += lengthdir_y(enemy_speed, dirToPlayer);
    } else {
        state = "attacking"; // Switch to attack if within range
    }
}

if (state == "attacking") {
    if (attackCooldown <= 0) {
        // Perform strong attack
        lastAttackDir = dirToPlayer; // Store the attack direction
        attackCooldown = 60; // Cooldown duration

        // Strong attack logic
        var attackRadius = 80; // Area of effect
        if (point_in_circle(playerObj.x, playerObj.y, x, y, attackRadius)) {
            if (!playerObj.is_dashing) { // Only damage player if not dashing
                playerObj.hp -= 5; 
                global.health = playerObj.hp; // Sync health with HUD
            }
        }

        // Enter stun briefly after attacking
        stunTimer = 20;
        state = "stun";
    }
}

if (state == "hurt" && hp > 0) {
    state = "stun"; // Transition to stun state if hurt
}

if (state == "stun" && hp > 0) {
    enemy_speed = 0; // Stop movement during stun
}

// Check for rear attack by the player
if (playerObj.state == "sword attack" && hp > 0) {
    var dirToGolem = point_direction(playerObj.x, playerObj.y, x, y);
    var rearThreshold = 90; // Degrees threshold for determining a rear attack

    if (point_in_circle(playerObj.x, playerObj.y, x, y, 50)) { // Within sword attack range
        if (abs(angle_difference(dirToGolem, lastAttackDir)) > 180 - rearThreshold) {
            // If hit from behind, apply increased damage
            hp -= 8;
        } else {
            // Regular damage
            hp -= 3;
        }
    }
}