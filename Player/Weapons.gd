extends Node2D

@onready var player: Player = get_owner()
@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")
@onready var animPlayer: AnimationPlayer = $"../AnimationPlayer"

@onready var axe_scene: PackedScene = preload("res://Objects/Attacks/axe.tscn")


func _physics_process(_delta):
	if Input.is_action_just_pressed("left_click"):
		animPlayer.clear_queue()
		#animPlayer.create_tween().set_speed_scale(1.5)
		animPlayer.queue("attack")
		
			
func spawnAxe():
	var spawned_axe := axe_scene.instantiate()
	self.add_child(spawned_axe)
	if is_instance_valid(enemy):
		spawned_axe.global_position = player.global_position
		spawned_axe.rotation = enemy.global_position.angle()
	else:
		spawned_axe.global_position = player.global_position
		spawned_axe.target = get_global_mouse_position()
