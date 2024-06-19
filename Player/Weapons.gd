extends Node2D

@onready var player: Player = get_owner()
@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")
@onready var animatedSprite2DPlayer : AnimatedSprite2D = $"../AnimatedSprite2D"

@onready var axe_scene: PackedScene = preload("res://Objects/Attacks/axe.tscn")


func _physics_process(_delta):
	if Input.is_action_just_pressed("left_click"):
		animatedSprite2DPlayer.play("attack")
		var spawned_axe := axe_scene.instantiate()
		get_tree().root.add_child(spawned_axe)
		spawned_axe.global_position = player.global_position
		spawned_axe.rotation = enemy.global_position.angle()
