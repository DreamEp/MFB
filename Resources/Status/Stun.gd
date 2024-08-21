extends StatusEffect
class_name Stun

var movement_speed
var attack_speed

func _init(time = 3) -> void:
	super._init(time)
	animation_name = "stun"

func apply(target):
	super.apply(target)
	movement_speed = target.movement_speed
	attack_speed = target.attack_speed

	target.movement_speed = 0
	target.attack_speed = 0

func remove(target):
	super.remove(target)
	target.movement_speed = movement_speed
	target.attack_speed = attack_speed
