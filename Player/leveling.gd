extends Node
class_name Leveling


@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var expBar: ProgressBar = get_tree().get_first_node_in_group("hud").get_node("ExperienceBar")
@onready var expLabel: Label = expBar.get_node("LevelLabel")
@onready var levelUpPanel: Panel = get_tree().get_first_node_in_group("hud").get_node("LevelUp")
@onready var levelUpLabel: Label = levelUpPanel.get_node("LevelingUp")
@onready var upgradeOption: VBoxContainer = levelUpPanel.get_node("UpgradeOption")

@onready var levelUpSound = $LevelUpSound
@onready var upgradePlayer = $UpgradePlayer

@onready var itemOption = preload("res://HUD&Menu/HUD/item_option.tscn")

var list_of_upgrade

func set_experience(gem_exp):
	player.player_collected_experience += gem_exp 

func calculate_experience():
	var exp_required = calculate_experience_cap() 
	if player.player_experience + player.player_collected_experience >= exp_required: 
		player.player_collected_experience -= exp_required - player.player_experience 
		player.player_experience_level += 1 
		player.player_experience = 0
		exp_required = calculate_experience_cap() 
		levelup() 
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
	
func levelup():
	get_tree().paused = true	
	list_of_upgrade = []
	levelUpSound.play()
	expLabel.text = str("Level : ",player.player_experience_level)
	var tween = levelUpPanel.create_tween()
	tween.tween_property(levelUpPanel, "position", Vector2(220, 50), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	levelUpPanel.visible = true
	var options = 0
	var optionsmax = 3 
	if player.player_experience_level % 5 == 0:
		levelUpLabel.text = "Level Up !\nUpgrade a support skill !!"
		while options < optionsmax:
			var option_choice = itemOption.instantiate()
			var random_choice = upgradePlayer.get_random_player_support_upgrade() #get_random_player_attack() #get_random_player_upgrade()
			if random_choice.size() == 2:
				option_choice.item = random_choice["support"] 
				option_choice.skill_name = random_choice["skill"]
			else:
				option_choice.item = random_choice #get_random_player_attack() #get_random_player_upgrade()
				list_of_upgrade.append(str(option_choice.item["item"] + "_" + option_choice.item["rarity"]))
			upgradeOption.add_child(option_choice)
			options += 1
	else:
		levelUpLabel.text = "Level Up !\nSelect a passive !!"
		while options < optionsmax:
			var option_choice = itemOption.instantiate()
			option_choice.item = upgradePlayer.get_random_player_upgrade() #get_random_player_attack() #get_random_player_upgrade()
			list_of_upgrade.append(str(option_choice.item["item"] + "_" + option_choice.item["rarity"]))
			upgradeOption.add_child(option_choice)
			options += 1
	#get_tree().paused = true
	
func retrieveWeaponsChest():
	get_tree().paused = true	
	list_of_upgrade = []
	var tween = levelUpPanel.create_tween()
	tween.tween_property(levelUpPanel, "position", Vector2(220, 50), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	levelUpPanel.visible = true
	levelUpLabel.text = "Chest colected !\nSelect your next Skill !!"
	var options = 0
	var optionsmax = 3 
	while options < optionsmax:
		var option_choice = itemOption.instantiate()
		var random_choice = upgradePlayer.get_random_player_attack()
		if random_choice:
			option_choice.item = random_choice #get_random_player_attack() #get_random_player_upgrade()
			list_of_upgrade.append(str(option_choice.item["item"] + "_" + option_choice.item["rarity"]))
		upgradeOption.add_child(option_choice)
		options += 1

func retrieveSupportLootChest():
	get_tree().paused = true	
	list_of_upgrade = []
	var tween = levelUpPanel.create_tween()
	tween.tween_property(levelUpPanel, "position", Vector2(220, 50), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	levelUpPanel.visible = true
	levelUpLabel.text = "Chest collected !\nSelect your next support skill !!"
	var options = 0
	var optionsmax = 3 
	while options < optionsmax:
		var option_choice = itemOption.instantiate()
		var random_choice = upgradePlayer.get_random_player_supports()
		if random_choice:
			option_choice.item = random_choice["support"] #get_random_player_attack() #get_random_player_upgrade()
			option_choice.skill_name = random_choice["skill"]
		upgradeOption.add_child(option_choice)
		options += 1
