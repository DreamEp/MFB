extends CharacterBody2D
class_name RangedAttack

@onready var player: Player = get_tree().get_first_node_in_group("player")
var attack_speed
var increase_attack_speed
var elemental_type
var enemy_damage
var direction

var facing_left

func _ready():
	facing_left = player.global_position.x > global_position.x
	if not facing_left:
		if self.scale.x > 0:
			self.scale.x = self.scale.x * -1
		else:
			pass
	else:
		if self.scale.x < 0:
			self.scale.x = self.scale.x * -1
		else:
			pass
	$AnimationPlayer.play("range_attack")
	direction = global_position.direction_to(player.global_position).rotated(player.global_rotation)

func _physics_process(delta):
	#var direction = global_position.direction_to(player.global_position).rotated(global_rotation)
	#velocity = direction * attack_speed * increase_attack_speed
	#move_and_slide()
	velocity = direction * attack_speed * increase_attack_speed
	move_and_slide()
	
func _on_range_attack_body_entered(body):
	if body is Player :
		var hitbox: HitboxComponent = player.get_node("HitboxComponent")
		var attack = Attack.new()
		attack.elemental_modifier = 0.5
		attack.can_crit = false
		attack.knockback_force = 0
		attack.stun_time = 0
		attack.attack_position = global_position
		attack.target = player
		attack.attacker = self		
		var effective_damage = attack.calculate_effective_damage(elemental_type, enemy_damage)
		attack.effective_damage = effective_damage
		hitbox.damage(attack)
		on_player_hit()
		
func on_player_hit():
	queue_free()
