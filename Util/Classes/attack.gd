class_name Attack

# Strictly a elemental_type class, used for passing attack information
# between hurtboxes and hitboxes

var elemental_modifier: float = 0 #export_range(0,1)
var knockback_force: float = 100.0
var stun_time: float = 1.0
var can_crit: bool = false
var attack_position: Vector2
var attacker
var target

var effective_damage: float = 0


var floating_number_scene: PackedScene = preload("res://HUD&Menu/HUD/floating_number.tscn")

func defense(attack_damage) -> float:
	if attack_damage == 0 and target.armor == 0:
		return 0.0
	print("before calculation defense : %s" % attack_damage)
	print("target armor : %s" % str(target.armor))
	var calculated_attack_damage = attack_damage / (attack_damage+target.armor)
	print("after calculation defense : %s" % calculated_attack_damage)	
	return calculated_attack_damage

func crit(crit_chance) -> float:
	if can_crit:
		can_crit = false
		var num = randf_range(0,1)
		if num <= crit_chance:
			can_crit = true
			return 2.0
		else:
			can_crit = false
			return 1.0
	else:
		return 1.0

func randomness():
	return randf_range(0.90, 1.1)

func elemental_damage(elemental_type) -> float:
	if elemental_type == target.type_resistant:
		elemental_modifier = 0.5
		target.elemental_animation_player.play("resistant")
	else:
		elemental_modifier = 0.0
	
	return (1 - elemental_modifier)
	
func effectiveness(elemental_type) -> float:
	if elemental_type == target.type_effective:
		target.elemental_animation_player.play("effective")
		return 1.5
	else:
		return 1.0

func spawn_floating_number(current_damage):
	var number = floating_number_scene.instantiate()
	number.position = attack_position
	number.find_child("Label").text = "%.2f" % current_damage
	
	if can_crit == false:
		number.find_child("AnimationPlayer").play("normal")
	else:
		number.find_child("AnimationPlayer").play("crit")
		
	target.get_tree().current_scene.add_child(number)

func calculate_effective_damage(elemental_type, attack_damage) -> float:
	if attacker is Player:
		effective_damage = attack_damage * defense(attack_damage  * (attacker.increase_attack_damage / 100)) * crit(attacker.crit_chance * (attacker.increase_crit_chance / 100)) * randomness() \
		* elemental_damage(elemental_type) * effectiveness(elemental_type)
		spawn_floating_number(effective_damage)
	else:
		effective_damage = attack_damage * defense(attack_damage) * randomness()
		
	return effective_damage

func print_dmg(attack_damage):
	print("I am an attack with %s damage !" %attack_damage)
