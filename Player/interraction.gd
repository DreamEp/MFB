extends Node2D

@onready var player: Player = get_owner()

func _on_grab_area_area_entered(area):
	if area is Experience:  
		area.target = player


func _on_interract_area_area_entered(area):
	if area is Experience: 
		var gem_exp = area.collect()
		#calculate_experience(gem_exp)
