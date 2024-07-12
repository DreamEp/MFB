extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 20.0
var health : float
#@onready var animatedSprite2D:AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var animPlayer: AnimationPlayer = $"../AnimationPlayer"

func _ready():
	health = MAX_HEALTH

func _process(_delta):
	pass
	
func damage(attack: Attack):
	if attack:
		health -= attack.attack_damage
		if health <= 0:
			if get_parent() is Enemy:
				enemy_death()
			elif get_parent() is Player:
				player_death()
		else:
			if get_parent() is Enemy:
				enemy_hurt()
			elif get_parent() is Player:
				player_hurt()
			
func enemy_death():
	animPlayer.clear_queue()
	animPlayer.stop()
	animPlayer.queue("death")
	
func player_death():
	animPlayer.clear_queue()
	animPlayer.stop()
	animPlayer.queue("death")
	
func enemy_hurt():
	animPlayer.clear_queue()
	animPlayer.stop()
	animPlayer.queue("hurt")
	
func player_hurt():
	animPlayer.clear_queue()
	animPlayer.stop()
	animPlayer.queue("hurt")
	
func deleteNode():
	var parent = get_parent()
	parent.queue_free()
