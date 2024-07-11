extends Node
class_name Leveling


@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var expBar: ProgressBar = get_tree().get_first_node_in_group("hud").get_node("ExperienceBar")
@onready var expLabel: Label = expBar.get_node("LevelLabel")
@onready var levelUpPanel: Panel = get_tree().get_first_node_in_group("hud").get_node("LevelUp")
@onready var upgradeOption: VBoxContainer = levelUpPanel.get_node("UpgradeOption")

@onready var levelUpSound = $LevelUpSound
@onready var upgradePlayer = $UpgradePlayer

@onready var itemOption = preload("res://HUD&Menu/HUD/item_option.tscn")

func calculate_experience(gem_exp):
	var exp_required = calculate_experience_cap() 
	player.player_collected_experience += gem_exp 
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
	levelUpSound.play()
	expLabel.text = str("Level : ",player.player_experience_level)
	print(player.player_experience_level)
	var tween = levelUpPanel.create_tween()
	tween.tween_property(levelUpPanel, "position", Vector2(220, 50), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	levelUpPanel.visible = true
	var options = 0
	var optionsmax = 3 
	while options < optionsmax:
		var option_choice = itemOption.instantiate()
		option_choice.item = upgradePlayer.get_random_player_upgrade()
		upgradeOption.add_child(option_choice)
		options += 1
	get_tree().paused = true
