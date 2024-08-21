extends StatusEffect
class_name Exhaust

func _init(time = 3) -> void:
	super._init(time)
	animation_name = "exhaust"

func apply(target):
	super.apply(target)
	target.attack_speed += 0.25

func remove(target):
	super.remove(target)
	target.attack_speed -= 0.25
