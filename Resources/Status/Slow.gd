extends StatusEffect
class_name Slow

func _init(time = 3) -> void:
	super._init(time)
	animation_name = "slow"

func apply(target):
	super.apply(target)
	target.movement_speed *= 0.25

func remove(target):
	super.remove(target)
	target.movement_speed /= 0.25
