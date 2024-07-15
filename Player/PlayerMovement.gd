extends Node

@onready var player : Player = get_owner()
@onready var playerSprite2D: Sprite2D = $"../Sprite2D"
@onready var animPlayer: AnimationPlayer = $"../AnimationPlayer"

func _physics_process(_delta):
	var x_move = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_move = Input.get_action_strength("down") - Input.get_action_strength("up")
	var move = Vector2(x_move, y_move)
	var velocity = move.normalized() * player.movement_speed
	player.velocity = velocity
	player.move_and_slide() 
