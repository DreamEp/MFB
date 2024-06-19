class_name Attack

# Strictly a data class, used for passing attack information
# between hurtboxes and hitboxes

var attack_damage: float = 10.0
var knockback_force: float = 100.0
var stun_time: float = 1.0
var attack_position: Vector2

func print_dmg():
	print("I am an attack with %s damage !" %attack_damage)
