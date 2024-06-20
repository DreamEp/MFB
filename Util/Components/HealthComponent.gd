extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 20.0
var health : float
@onready var animatedSprite2D:AnimatedSprite2D = $"../AnimatedSprite2D"

func _ready():
	health = MAX_HEALTH

func _process(_delta):
	pass
	
func damage(attack: Attack):
	health -= attack.attack_damage
	if health <= 0:
		if get_parent() is Enemy:
			animatedSprite2D.stop()
			animatedSprite2D.play("death")
			print("death")
		elif get_parent() is Player:
			animatedSprite2D.play("death")
			print("death")
		#get_parent().queue_free()
	else:
		animatedSprite2D.stop()
		animatedSprite2D.play("hurt")
