extends Node2D
class_name AxeCircle

var axe_scene: PackedScene = preload("res://Player/Skills/Spells/AxeCircle/axe.tscn")

@onready var player: Player = get_owner()
@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")

@export var player_position : Marker2D
@export_group("Upgradable Axe Circle")
@export var axe_circle_count: int = 5
@export var axe_circle_rate: float = 5
@export var axe_circle_radius: int = 30

var can_spawn_axe = false

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(axe_circle_rate).timeout
	can_spawn_axe = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func spawnAxeCircle():
	var axe_count = axe_circle_count + player.additional_spell_proctile + player.additional_attack_proctile
	var axe_rate = axe_circle_rate - (axe_circle_rate * (player.attack_speed/100))
	if can_spawn_axe:
		can_spawn_axe = false
		for i in axe_count:
			var spawned_axe = axe_scene.instantiate()
			var spawned_axe_angle = i * (360 / axe_count)
			var spawned_axe_direction =  Vector2(player_position.global_position.x + axe_circle_radius * cos(deg_to_rad(spawned_axe_angle)), player_position.global_position.y + axe_circle_radius * sin(deg_to_rad(spawned_axe_angle)))
			spawned_axe.current_rotation = spawned_axe_angle
			spawned_axe.axe_circle_radius = axe_circle_radius
			spawned_axe.position = spawned_axe_direction
			spawned_axe.rotation = spawned_axe_angle
			##################################################
			# Strategy Relevant Code:
			# Here, we loop over all of the upgrades currently
			# on the player, and apply their upgrade to the
			# spawned axe.
			##################################################
			#for strategy in player.upgrades:
				#strategy.apply_upgrade(spawned_arrow)
			get_tree().root.call_deferred("add_child",spawned_axe)
		await get_tree().create_timer(axe_rate).timeout
		can_spawn_axe = true
	
	##################################################
	# Strategy Relevant Code:
	# Here, we loop over all of the upgrades currently
	# on the player, and apply their upgrade to the
	# spawned axe.
	##################################################
	#for strategy in player.upgrades:
		#strategy.apply_upgrade(spawned_axe)
