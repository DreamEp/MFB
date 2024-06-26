extends Node

##########################################################
# This is the player's movement controller.
# Instead of placing all of the movement stuff inside
# of the player, we move the code to a separate component
##########################################################

@onready var player : Player = get_owner()
@onready var playerSprite2D: Sprite2D = $"../Sprite2D"
@onready var animPlayer: AnimationPlayer = $"../AnimationPlayer"

func _physics_process(_delta):
	var velocity = player.velocity
	var x_move = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_move = Input.get_action_strength("down") - Input.get_action_strength("up")
	var move = Vector2(x_move, y_move)
	#if move.x < 0:
		#playerSprite2D.flip_h = true
		#if player.aim_position.x > 0:
			#playerSprite2D.flip_h = false
		#else:
			#playerSprite2D.flip_h = true
	#elif move.x > 0:
		#playerSprite2D.flip_h = false
	if player.aim_position.x < 0:
		playerSprite2D.flip_h = true
	else:
		playerSprite2D.flip_h = false
		
	if move != Vector2.ZERO: 
		animPlayer.queue("walk")
	else:
		animPlayer.queue("idle")

	velocity = move.normalized() * player.movement_speed
	player.velocity = velocity
	player.move_and_slide() 
