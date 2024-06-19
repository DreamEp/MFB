extends CharacterBody2D
class_name Axe

@export var speed := 150.0
@export var attack_damage := 5.0
@export var knockback_force := 2
@export var stun_time := 1
@export var max_pierce := 1

var current_pierce_count := 0
@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")

#func _ready():
	#if hurtbox:
		#hurtbox.hit_enemy.connect(on_enemy_hit)


func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(enemy.global_position)
	velocity = direction * speed
	move_and_collide(velocity*delta)


func on_enemy_hit():
	current_pierce_count += 1
	if current_pierce_count >= max_pierce:
		queue_free()


func _on_hitbox_component_area_entered(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		attack.stun_time = stun_time
		
		hitbox.damage(attack)
