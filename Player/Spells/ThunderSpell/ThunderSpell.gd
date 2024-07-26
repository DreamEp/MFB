extends Node2D
class_name ThunderSpell

var thunder_scene: PackedScene = preload("res://Player/Spells/ThunderSpell/thunder.tscn")

@onready var player: Player = get_owner()
@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")

@export var player_position : Marker2D
@export_group("Upgradable thunder spell")
@export var thunder_spell_count: int = 3
@export var thunder_spell_rate: float = 5
@export var thunder_spell_radius: int = 30

var can_spawn_thunder = false

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(thunder_spell_rate).timeout
	can_spawn_thunder = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func spawnThunderSpell(enemies_in_range):
	var thunder_count = thunder_spell_count + player.additional_spell_proctile
	var closest_enemies = get_n_closest_enemies(player.global_position, enemies_in_range, thunder_count)
	var thunder_rate = thunder_spell_rate - (thunder_spell_rate * (player.attack_coldown/100))
	var current_enemy = 0
	if can_spawn_thunder:
		can_spawn_thunder = false
		for i in thunder_count:
			var spawned_thunder = thunder_scene.instantiate()
			spawned_thunder.position = closest_enemies[current_enemy]
			current_enemy += 1
			##################################################
			# Strategy Relevant Code:
			# Here, we loop over all of the upgrades currently
			# on the player, and apply their upgrade to the
			# spawned thunder.
			##################################################
			#for strategy in player.upgrades:
				#strategy.apply_upgrade(spawned_arrow)
			get_tree().root.call_deferred("add_child",spawned_thunder)
		await get_tree().create_timer(thunder_rate).timeout
		can_spawn_thunder = true
	
	##################################################
	# Strategy Relevant Code:
	# Here, we loop over all of the upgrades currently
	# on the player, and apply their upgrade to the
	# spawned thunder.
	##################################################
	#for strategy in player.upgrades:
		#strategy.apply_upgrade(spawned_thunder)
		
func get_n_closest_enemies(player_pos: Vector2, enemies_positions: Array, n: int) -> Array:
	var distances = []
	for enemy_position in enemies_positions:
		var distance = player_pos.distance_to(enemy_position.global_position)
		distances.append({"position": enemy_position.global_position, "distance": distance})

	distances.sort_custom(sort_by_distance)

	var closest_enemies = []
	for i in range(min(n, distances.size())):
		closest_enemies.append(distances[i]["position"])

	return closest_enemies

func sort_by_distance(a, b):
	return a["distance"] < b["distance"]

