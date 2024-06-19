extends Node

##########################################################
# This is the enemy's movement controller.
# Instead of placing all of the movement stuff inside
# of the enemy, we move the code to a separate component
##########################################################

@onready var player : Player = get_tree().get_first_node_in_group("player")
@onready var enemy : Enemy = get_owner()
@onready var sprite2DEnemy : Sprite2D = get_parent().get_node("Sprite2D")
@onready var walkAnimation : AnimationPlayer = get_parent().get_node("AnimationPlayer")

func _ready():
	walkAnimation.play("walk")
	
func _physics_process(_delta):
	#knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var velocity = enemy.velocity
	var direction = enemy.global_position.direction_to(player.global_position)
	velocity = direction * enemy.movemement_speed
	#velocity += knockback
	enemy.velocity = velocity
	enemy.move_and_slide()
	
	#There we get a gap so it don't flip permanently
	if direction.x > 0.1:
		sprite2DEnemy.flip_h = false
	elif direction.x < 0.1:
		sprite2DEnemy.flip_h = true
