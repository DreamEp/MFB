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

var initial_anim_player_speed = 1

func _ready():
	initial_anim_player_speed = animPlayer.get_playing_speed()
	pass
	
func _physics_process(_delta):
	#There we get a gap so it don't flip permanently
	if (enemy.global_position.direction_to(player.global_position)).x > 0.1:
		enemySprite2D.flip_h = false
	elif (enemy.global_position.direction_to(player.global_position)).x < 0.1:
		enemySprite2D.flip_h = true
		
		
	if !enemy.alive:
		animPlayer.play("death", -1, 1.2)
		return
	
	if enemy.attacking:		
		animPlayer.set_speed_scale(enemy.attack_speed)
		animPlayer.play("attack")
		return
		
	if enemy.hurt:
		animPlayer.play("hurt")
		return
		
	if !enemy.velocity:
		animPlayer.play("idle")
		return
		
	var animation_name = "walk"
	
	animPlayer.play(animation_name)

func set_no_hurt():
	enemy.hurt = false
	
func reset_anim_speed_scale():
	animPlayer.set_speed_scale(initial_anim_player_speed)
