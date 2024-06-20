extends CharacterBody2D
class_name Enemy

@export_group("Stat Values")
@export var movemement_speed: float = 40.0
@export var health: float = 10.0
@export var enemy_damage: float = 1.0
@export var attack_speed: float = 0.5
@export var knockback_recovery: float = 3.0
@export var armor: float = 2.0
@export var min_experience: int = 0
@export var max_experience: int = 5

@onready var enemySprite2D: AnimatedSprite2D = $AnimatedSprite2D

var exp_gem: PackedScene = preload("res://Objects/experience_gem.tscn")
@onready var experienceGem: Node2D = get_tree().get_first_node_in_group("experience")



func _ready():
	pass

func _on_hitbox_component_body_entered(body):
	if body is Player:
		var hitbox: HitboxComponent = body.get_node("HitboxComponent")
		
		var attack = Attack.new()
		attack.attack_damage = enemy_damage
		attack.knockback_force = 0
		attack.attack_position = global_position
		attack.stun_time = 0
		
		enemySprite2D.play("attack", 1+(attack_speed))
		#enemySprite2D.animation_finished:
		hitbox.damage(attack)
		on_player_hit()
		
func _on_hitbox_component_body_exited(_body):
	enemySprite2D.play("walk")
	#qenemySprite2D.stop()		
		
func on_player_hit():
	pass
	

func _on_animated_sprite_2d_animation_finished():
	if enemySprite2D.get_animation() == "death":
		var new_gem = exp_gem.instantiate()
		new_gem.global_position = global_position
		new_gem.experience = randi_range(min_experience, max_experience)
		experienceGem.call_deferred('add_child', new_gem)
		pass
		#queue_free()
		
	else:
		enemySprite2D.play("walk")
