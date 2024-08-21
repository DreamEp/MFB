extends Resource
class_name StatusEffect

var duration: float
var animation_name: String

func _init(time = 3):
	duration = time

func get_class_name():
	return animation_name

func apply(target):
	var playerHUD: Control = target.get_tree().get_first_node_in_group("hud")
	playerHUD.get_node("StatusAnimationPlayer").play(animation_name)
	playerHUD.find_child(animation_name).show()
	print(animation_name + " affected on" + target.name)

func remove(target):
	var playerHUD: Control = target.get_tree().get_first_node_in_group("hud")
	playerHUD.get_node("StatusEffectsBar").find_child(animation_name).hide()
	print(animation_name + " remove from" + target.name)
