extends Node

@onready var player : Player = get_owner()
@onready var playerSprite2D: Sprite2D = $"../Sprite2D"
@onready var animPlayer: AnimationPlayer = $"../AnimationPlayer"

func _physics_process(_delta):
	playerSprite2D.flip_h = (player.get_global_mouse_position().x - player.global_position.x) < 0
		
	if !player.alive:
		animPlayer.play("death")
		return
		
	if player.hurt:
		animPlayer.play("hurt")
		return
		
	if !player.velocity:
		animPlayer.play("idle")
		return
		
	var animation_name = "walk"
	
	animPlayer.play(animation_name)
	
func set_no_hurt():
	player.hurt = false
