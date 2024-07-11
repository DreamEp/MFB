extends Node2D

@onready var player: Player = get_owner()
@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")
@onready var animPlayer: AnimationPlayer = $"../AnimationPlayer"

@onready var axe_scene: PackedScene = preload("res://Objects/Attacks/axe.tscn")
@export var firing_position : Marker2D

@export_group("Bow")
@onready var arrow_scene: PackedScene = preload("res://Objects/Attacks/arrow.tscn")
@export var arrow_count: int = 0
@export_range(0, 360) var arc: float = 0
@export_range(0, 5) var bow_rate: float = 10
var can_bow_attack = true
var auto_attack = false
var auto_aim = false

@onready var spriteBow = $FiringPosition/Bow

func _ready():
	spriteBow.visible = false

func _physics_process(_delta):
	bowAttack()
	#if Input.is_action_just_pressed("left_click"):
		#if sign(player.aim_position.x) != sign(firing_position.position.x):
			#firing_position.position.x *= -1
			#
		#var mouse_direction := get_global_mouse_position() - firing_position.global_position
		#
		#animPlayer.clear_queue()
		#animPlayer.queue("attack")
		#bowAttack()
			
func spawnAxe():
	var spawned_axe := axe_scene.instantiate()
	self.add_child(spawned_axe)
	if is_instance_valid(enemy):
		spawned_axe.global_position = player.global_position
		spawned_axe.rotation = enemy.global_position.angle()
	else:
		spawned_axe.global_position = player.global_position
		spawned_axe.target = get_global_mouse_position()
		
		
func bowAttack():
	spriteBow.visible = true
	if can_bow_attack:
		can_bow_attack = false
		var mouse_direction = get_global_mouse_position() - firing_position.global_position
		for i in arrow_count:
			var new_arrow = arrow_scene.instantiate()
			new_arrow.position = firing_position.global_position
			
			if arrow_count == 1:
				new_arrow.rotation = mouse_direction.angle()
			else:
				var arc_rad = deg_to_rad(arc + ((arc * arrow_count)/arrow_count))
				var increment = arc_rad / (arrow_count - 1)
				new_arrow.global_rotation = (
					mouse_direction.angle() +
					increment * i -
					arc_rad / 2
				)
			get_tree().root.call_deferred("add_child", new_arrow)
		await get_tree().create_timer(bow_rate).timeout
		can_bow_attack = true
		#spriteBow.visible = false
