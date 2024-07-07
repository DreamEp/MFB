extends Node2D

@onready var player: Player = get_owner()
@onready var expBar: ProgressBar = get_tree().get_first_node_in_group("hud").get_node("ExperienceBar")
@onready var expLabel: Label = expBar.get_node("LevelLabel")
@onready var healthComponent: HealthComponent = player.get_node("HealthComponent")
@onready var levelUpPanel: Panel = get_tree().get_first_node_in_group("hud").get_node("LevelUp")
@onready var upgradeOption: VBoxContainer = levelUpPanel.get_node("UpgradeOption")
@onready var collectedWeapons: GridContainer = get_tree().get_first_node_in_group("hud").get_node("CollectedWeapons")
@onready var collectedUpgrades: GridContainer = get_tree().get_first_node_in_group("hud").get_node("CollectedUpgrades")
@onready var levelUpSound = $LevelUpSound

@onready var itemOption = preload("res://HUD&Menu/HUD/item_option.tscn")
@onready var itemContainer = preload("res://HUD&Menu/HUD/item_container.tscn")

var collected_upgrades = []
var upgrade_options = []

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
		option_choice.item = get_random_item()
		upgradeOption.add_child(option_choice)
		options += 1
	get_tree().paused = true

#Permet de remonter un item random (peut être améliorer en chargeant une seule fois cette liste)?	
func get_random_item():
	var dblist = [] #La pull d'opptions d'upgrade
	for i in UpgradeDb.UPGRADES:
		if i in collected_upgrades: #Si on a déjà trouvé l'upgrade
			pass #On ne fait rien
		elif i in upgrade_options: #Si l'upgrade est déjà ajouté en option
			pass #On ne fait rien
		elif UpgradeDb.UPGRADES[i]["type"] == "item": #Si l'upgrade est de type food
			pass #On ne fait rien
		elif UpgradeDb.UPGRADES[i]["prerequisite"].size() > 0: #Si il y'a des prérequis pour l'upgrade
			var to_add = true #On créer une variable pour savoir si on ajoute ou non l'upgrade dans notre pull
			for u in UpgradeDb.UPGRADES[i]["prerequisite"]: #On loop à travers les prérequis
				if not u in collected_upgrades: #Si le prérequis n'est pas dans nos upgrade déjà récolté
					to_add = false #On ne l'ajoute pas
			if to_add: 
				dblist.append(i) #Sinon on l'ajoute dans notre pull d'upgrade
		else:
			dblist.append(i) #Si il n'y a pas de prérequis on l'ajoute directement
	if dblist.size() > 0: #Si la taille de notre pull d'upgrade est supérieur a 0
		var randomitem = dblist.pick_random() #On prend un upgrade random de la liste
		upgrade_options.append(randomitem) #On l'ajoute dans notre liste d'option
		return randomitem #On retourne l'item random
	else:
		return null
		
func upgrade_character(upgrade):
	match upgrade:
		"armor1","armor2","armor3","armor4":
			player.armor += 1
		"speed1","speed2","speed3","speed4":
			player.movement_speed += 20.0
		"tome1","tome2","tome3","tome4":
			player.spell_area += 0.10
		"scroll1","scroll2","scroll3","scroll4":
			player.spell_coldown += 0.05
		"ring1","ring2":
			player.additional_proctile += 1
		"food":
			healthComponent.health += 20
			healthComponent.health = clamp(healthComponent.health, 0, healthComponent.MAX_HEALTH)
	adjust_gui_collection(upgrade)
	var option_children = upgradeOption.get_children() #On recupere les différentes options du pannel
	for i in option_children: 
		i.queue_free() #On supprime chaque option du pannel
	upgrade_options.clear() #On clear les options pour la prochaine fois
	collected_upgrades.append(upgrade) #On ajoute l'option choisi dans notre pull d'option déjà collecté
	levelUpPanel.visible = false #On rend invisible le pannel de monter de niveau
	levelUpPanel.position = Vector2(800, 50) #On replace loin le pannel pour avoir de nouveau l'effet quand il pop
	get_tree().paused = false #On met le jeux en marche à nouveau
	calculate_experience(0) #Permet de gérer plusieurs level up d'un coup

#Permet d'avoir les améliorations et armes qu'on a déjà récupéré
func adjust_gui_collection(upgrade):
	var get_upgraded_displayname = UpgradeDb.UPGRADES[upgrade]["displayname"] #Permet de récupérer de la db le displayname de l'upgrade
	var get_type = UpgradeDb.UPGRADES[upgrade]["type"] #Permet de recupérer le types de l'upgrade dans la db
	if get_type != "item": #On ne veut pas afficher la food
		var get_collected_displaynames = []
		for i in collected_upgrades:
			get_collected_displaynames.append(UpgradeDb.UPGRADES[i]["displayname"]) #On récupère tous les noms déjà collecté
		if not get_upgraded_displayname in get_collected_displaynames: #Si il n'a pas encore été collecté
			var new_item = itemContainer.instantiate() 
			new_item.upgrade = upgrade
			match get_type: #On l'ajoute dans le pannel correspondant
				"attacks":
					collectedWeapons.add_child(new_item)
				"upgrade":
					collectedUpgrades.add_child(new_item)
		else:			
			match get_type: #On met a jour son niveau dans le pannel correspondant
				"attacks":
					var current_weapons = collectedWeapons.get_children()
					for w in current_weapons: 
						if w.upgrade.substr(0, 3) == upgrade.substr(0, 3) and w.has_method("update_level"):
							w.update_level(upgrade)
				"upgrade":
					var current_upgrades = collectedUpgrades.get_children()
					for u in current_upgrades: 
						if u.upgrade.substr(0, 3) == upgrade.substr(0, 3) and u.has_method("update_level"):
							u.update_level(upgrade)
