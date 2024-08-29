extends Node2D
class_name PlayerInterraction

@onready var player: Player = get_owner()
@onready var leveling = $Leveling
@onready var mainNode: MainNode = get_tree().get_first_node_in_group("main_scene")

func _on_grab_area_area_entered(area):
	if area is Experience:  
		area.target = player


func _on_interract_area_area_entered(area):
	if area is Experience: 
		var gem_exp = area.collect()
		leveling.calculate_experience(gem_exp)
	elif area is Chest:
		area.collect()
		leveling.retrieveWeaponsChest()
		
func game_over():
	player.queue_free()
	mainNode.load_scene("game_over")
