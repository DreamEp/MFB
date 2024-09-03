extends EnemyRes
class_name Slime

@export_group("Base Stat")
@export var movemement_speed: float = 40.0
@export var health: float = 20.0
@export var enemy_damage: float = 1.0
@export var attack_speed: float = 0.5
@export var knockback_recovery: float = 3.0
@export_range(0,1000) var armor: float = 200
@export var min_experience: int = 0
@export var max_experience: int = 5
@export_enum("Physical","Electric","Fire","Ice","Poison") var elemental_type: String
@export_enum("Physical","Electric","Fire","Ice","Poison", "None") var type_resistant: String
@export_enum("Physical","Electric","Fire","Ice","Poison", "None") var type_effective: String
@export_enum("base", "elite", "boss") var enemy_type: String
@export var enemySpritePath: String

@export_group("Stat Multiplicator")
var increase_movement_speed: float = 100
var increase_health: float = 100
var increase_enemy_damage: float = 100
var increase_attack_speed: float = 100
var increase_knockback_recovery: float = 100
var increase_armor: float = 100

var enemyNode: PackedScene = preload("res://Enemies/Slime.tscn")

func instantiate_slime(tree, spawn_pos):
	var slime: Enemy = enemyNode.instantiate()
	
	slime.movemement_speed = movemement_speed
	slime.health = health
	slime.enemy_damage = enemy_damage
	slime.attack_speed = attack_speed
	slime.knockback_recovery = knockback_recovery
	slime.armor = armor
	slime.min_experience = min_experience
	slime.max_experience = max_experience
	slime.elemental_type = elemental_type
	slime.type_resistant = type_resistant
	slime.type_effective = type_effective
	slime.enemy_type = enemy_type
	slime.enemySpritePath = enemySpritePath
	slime.global_position = spawn_pos
	
	tree.add_child(slime)
	

func instantiate_enemy(tree, spawn_pos):
	instantiate_slime(tree, spawn_pos)
