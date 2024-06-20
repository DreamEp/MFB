extends Node2D

@onready var player: Player = get_owner()

func _on_grab_area_area_entered(area):
	if area is Experience:  
		area.target = player


func _on_interract_area_area_entered(area):
	if area is Experience: 
		var gem_exp = area.collect()
		calculate_experience(gem_exp)
		
func calculate_experience(gem_exp):
	var exp_required = calculate_experience_cap() 
	player.player_collected_experience += gem_exp 
	if player.player_experience + player.player_collected_experience >= exp_required: 
		player.player_collected_experience -= exp_required - player.player_experience 
		player.player_experience_level += 1 
		player.player_experience = 0
		exp_required = calculate_experience_cap() 
		#levelup() 
	else:
		player.player_experience += player.player_collected_experience 
		player.player_collected_experience = 0
	player.set_expbar(player.player_experience, exp_required)
	
func calculate_experience_cap():
	var exp_cap = player.player_experience_level
	if player.player_experience_level < 20: 
		exp_cap = player.player_experience_level * 5
	elif player.player_experience_level < 40:
		exp_cap = 95 + (player.player_experience_level - 19) * 8 
	else:
		exp_cap = 255 + (player.player_experience_level - 39) * 12 
	return exp_cap
