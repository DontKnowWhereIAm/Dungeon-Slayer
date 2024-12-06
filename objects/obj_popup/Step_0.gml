/// @description Insert description here
// You can write your code in this editor

if (active) {
    // Increment the timer
    timer++;
    

    // After the hold time, allow the pop-up to disappear
    if (timer >= hold_time) {
        can_disappear = true;
        
    }

    // Check for player movement to dismiss the pop-up
    if (can_disappear) {
        if (keyboard_check(vk_left) || keyboard_check(vk_right) || keyboard_check(vk_up) || keyboard_check(vk_down)) {
            active = false; // Deactivate the pop-up
            instance_destroy(); // Destroy the pop-up instance
            show_debug_message("Pop-up dismissed!");
        }
    }
}