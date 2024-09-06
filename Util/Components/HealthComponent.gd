extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 20.0
var health : float
#@onready var animatedSprite2D:AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var animPlayer: AnimationPlayer = $"../AnimationPlayer"

func _ready():
	if get_parent() is Player:
		health = MAX_HEALTH
	else:
		health = get_parent().health
		MAX_HEALTH = health

func _process(_delta):
	pass
	
func damage(attack: Attack):
	if attack:
		if get_parent() is Player:
			print("health of enemy : " + str(health))
		health -= snapped(attack.effective_damage, 0.01)
		if health <= 0:
			get_parent().alive = false
		else:
			get_parent().hurt = true
