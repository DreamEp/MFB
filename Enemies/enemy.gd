extends CharacterBody2D
class_name Enemy

@export_group("Stat Values")
@export var movemement_speed: float = 40.0
@export var health: float = 10.0
@export var enemy_damage: float = 1.0
@export var knockback_recovery: float = 3.0
@export var armor: float = 2.0
@export var min_experience: int = 0
@export var max_experience: int = 5

@onready var enemySprite2D: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

