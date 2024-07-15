extends Node2D
class_name Interraction

@onready var player: Player = get_owner()

@onready var leveling = $Leveling

func _on_grab_area_area_entered(area):
	if area is Experience:  
		area.target = player


func _on_interract_area_area_entered(area):
	if area is Experience: 
		var gem_exp = area.collect()
		leveling.calculate_experience(gem_exp)
