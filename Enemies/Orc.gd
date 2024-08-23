extends EnemyRes
class_name Orc

@export_group("Stat Values")
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

var enemyNode: PackedScene = preload("res://Enemies/enemy.tscn")

func instantiate_orc(tree, spawn_pos):
	var orc: Enemy = enemyNode.instantiate()
	
	orc.movemement_speed = movemement_speed
	orc.health = health
	orc.enemy_damage = enemy_damage
	orc.attack_speed = attack_speed
	orc.knockback_recovery = knockback_recovery
	orc.armor = armor
	orc.min_experience = min_experience
	orc.max_experience = max_experience
	orc.elemental_type = elemental_type
	orc.type_resistant = type_resistant
	orc.type_effective = type_effective
	orc.enemy_type = enemy_type
	orc.enemySpritePath = enemySpritePath
	orc.global_position = spawn_pos
	
	tree.add_child(orc)
	

func instantiate_enemy(tree, spawn_pos):
	instantiate_orc(tree, spawn_pos)
