extends Node2D
#
#@onready var player: Player = get_owner()
#@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")
#@onready var animPlayer: AnimationPlayer = $"../AnimationPlayer"
#
#@onready var axe_scene: PackedScene = preload("res://Objects/Attacks/axe.tscn")
#@export var firing_position : Marker2D
#
#@export_group("Bow")
#@onready var arrow_scene: PackedScene = preload("res://Objects/Attacks/arrow.tscn")
#@export var base_arrow_count: int = 0
#@export_range(0, 360) var arc: float = 0
#@export_range(0, 5) var base_bow_rate: float = 10
#var can_bow_attack = false
#var auto_attack = false
#var auto_aim = false
#
#@onready var spriteBow = $FiringPosition/Bow
#@onready var settings_resource: DefaultSettingsResource = preload("res://Resources/Settings/DefaultSettings.tres")
#
#func _ready():
	#await get_tree().create_timer(base_bow_rate).timeout
	#can_bow_attack = true
	##spriteBow.visible = false
#
#func _physics_process(_delta):
	#if(settings_resource.auto_aim_state):
		#bowAttack()
	#else:
		#if Input.is_action_just_pressed("left_click"):
			#bowAttack()
			#
#func spawnAxe():
	#var spawned_axe := axe_scene.instantiate()
	#self.add_child(spawned_axe)
	#if is_instance_valid(enemy):
		#spawned_axe.global_position = player.global_position
		#spawned_axe.rotation = enemy.global_position.angle()
	#else:
		#spawned_axe.global_position = player.global_position
		#spawned_axe.target = get_global_mouse_position()
		#
		#
#func bowAttack():
	#var arrow_count = base_arrow_count + player.additional_spell_proctile + player.additional_attack_proctile
	#var bow_rate = base_bow_rate - (base_bow_rate * (player.attack_coldown/100))
	#spriteBow.visible = true
	#if can_bow_attack:
		#can_bow_attack = false
		#var mouse_direction = get_global_mouse_position() - firing_position.global_position
		#for i in arrow_count:
			#var new_arrow = arrow_scene.instantiate()
			#new_arrow.position = firing_position.global_position
			#
			#if arrow_count == 1:
				#new_arrow.rotation = mouse_direction.angle()
			#else:
				#var arc_rad = deg_to_rad(arc + ((arc * arrow_count)/arrow_count))
				#var increment = arc_rad / (arrow_count - 1)
				#new_arrow.global_rotation = (
					#mouse_direction.angle() +
					#increment * i -
					#arc_rad / 2
				#)
			#get_tree().root.call_deferred("add_child", new_arrow)
		#await get_tree().create_timer(bow_rate).timeout
		#can_bow_attack = true
		##spriteBow.visible = false
