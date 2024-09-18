extends Node

##########################################################
# This is the enemy's movement controller.
# Instead of placing all of the movement stuff inside
# of the enemy, we move the code to a separate component
##########################################################

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var enemy: Enemy = get_owner()
@onready var enemySprite2D: Sprite2D = $"../Sprite2D"
@onready var animPlayer: AnimationPlayer = $"../AnimationPlayer"

func _ready():
	pass
	
func _physics_process(_delta):
	#knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	#var separation = (player.position - enemy.position).length()
	#if separation >= 500 and enemy.enemy_type == "base":
		#enemy.queue_free()
	#if enemy.alive:
		#var velocity = enemy.velocity
		#var direction = enemy.global_position.direction_to(player.global_position)
		#velocity = direction * enemy.movemement_speed
		##velocity += knockback
		#enemy.velocity = velocity
		#enemy.move_and_slide()
	#else:
		return
