extends EnemyRes
class_name Skeleton

@export_group("Base Stat")
@export var movemement_speed: float = 40.0
@export var health: float = 100
@export var enemy_damage: float = 5
@export var attack_speed: float = 0.8
@export var knockback_recovery: float = 3.0
@export_range(0,1000) var armor: float = 0
@export var min_experience: int = 0
@export var max_experience: int = 3
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

var enemyNode: PackedScene = preload("res://Enemies/Skeleton.tscn")

func instantiate_skeleton(tree, spawn_pos):
	var skeleton: Enemy = enemyNode.instantiate()
	
	skeleton.movemement_speed = movemement_speed
	skeleton.health = health
	skeleton.enemy_damage = enemy_damage
	skeleton.attack_speed = attack_speed
	skeleton.knockback_recovery = knockback_recovery
	skeleton.armor = armor
	skeleton.min_experience = min_experience
	skeleton.max_experience = max_experience
	skeleton.elemental_type = elemental_type
	skeleton.type_resistant = type_resistant
	skeleton.type_effective = type_effective
	skeleton.enemy_type = enemy_type
	skeleton.enemySpritePath = enemySpritePath
	skeleton.global_position = spawn_pos
	
	tree.add_child(skeleton)
	

func instantiate_enemy(tree, spawn_pos):
	instantiate_skeleton(tree, spawn_pos)
