extends StatusEffect
class_name Berserk

func _init(time = 3) -> void:
	super._init(time)
	animation_name = "berserk"

func apply(target):
	super.apply(target)
	target.attack_speed *= 2

func remove(target):
	super.remove(target)
	target.attack_speed /= 2
