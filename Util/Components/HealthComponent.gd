extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 20.0
var health : float


func _ready():
	health = MAX_HEALTH

func _process(_delta):
	pass
	
func damage(attack: Attack):
	health -= attack.attack_damage
	if health <= 0:
		get_parent().queue_free()
