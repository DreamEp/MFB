extends EnemyRes
class_name StoneGolemBoss

@export_group("Base Stat")
@export var movemement_speed: float = 200
@export var health: float = 1000
@export var enemy_damage: float = 20
@export var attack_speed: float = 0.5
@export var knockback_recovery: float = 3.0
@export_range(0,1000) var armor: float = 50
@export var min_experience: int = 150
@export var max_experience: int = 150
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

var enemyNode: PackedScene = preload("res://Enemies/Boss/StoneGolemBoss.tscn")

func instantiate_stoneGolemBoss(tree, spawn_pos):
	var stoneGolemBoss: Boss = enemyNode.instantiate()
	
	stoneGolemBoss.movemement_speed = movemement_speed
	stoneGolemBoss.health = health
	stoneGolemBoss.enemy_damage = enemy_damage
	stoneGolemBoss.attack_speed = attack_speed
	stoneGolemBoss.knockback_recovery = knockback_recovery
	stoneGolemBoss.armor = armor
	stoneGolemBoss.min_experience = min_experience
	stoneGolemBoss.max_experience = max_experience
	stoneGolemBoss.elemental_type = elemental_type
	stoneGolemBoss.type_resistant = type_resistant
	stoneGolemBoss.type_effective = type_effective
	stoneGolemBoss.enemy_type = enemy_type
	stoneGolemBoss.enemySpritePath = enemySpritePath
	stoneGolemBoss.global_position = spawn_pos
	
	tree.add_child(stoneGolemBoss)
	

func instantiate_enemy(tree, spawn_pos):
	instantiate_stoneGolemBoss(tree, spawn_pos)
