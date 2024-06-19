extends CharacterBody2D
class_name Enemy

@export_group("Stat Values")
@export var movemement_speed = 20
@export var health = 10
@export var enemy_damage = 1
@export var knockback_recovery = 3
@export var kobold_armor = 2
@export var min_experience = 0
@export var max_experience = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
