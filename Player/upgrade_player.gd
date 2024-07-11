extends Node2D

@onready var leveling = get_owner()
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var healthComponent: HealthComponent = player.get_node("HealthComponent")
@onready var levelUpPanel: Panel = get_tree().get_first_node_in_group("hud").get_node("LevelUp")
@onready var upgradeOption: VBoxContainer = levelUpPanel.get_node("UpgradeOption")
@onready var collectedWeapons: GridContainer = get_tree().get_first_node_in_group("hud").get_node("CollectedWeapons")
@onready var collectedUpgrades: GridContainer = get_tree().get_first_node_in_group("hud").get_node("CollectedUpgrades")


@onready var itemContainer = preload("res://HUD&Menu/HUD/item_container.tscn")
@onready var itemOption = preload("res://HUD&Menu/HUD/item_option.tscn")


var collected_upgrades = []
var upgrade_options = []

var rarity_chances: Dictionary = {
	"common": 100,
	"uncommon": 50,
	"rare": 25,
	"epic": 10,
	"leg": 5
}

func update_rarity_chances(base_rarity_chances):
	var player_chance = player.rarity_chance
	
	var common_chance = rarity_chances["common"]
	var uncommon_chance = rarity_chances["uncommon"]
	var rare_chance = rarity_chances["rare"]
	var epic_chance = rarity_chances["epic"]
	var leg_chance = rarity_chances["leg"]
	if player_chance >= 1  && player_chance <= 100:
		common_chance = 80
		uncommon_chance += uncommon_chance * (player_chance / 100)
		rare_chance += rare_chance * (player_chance / 100) 
		epic_chance +=  epic_chance * (player_chance / 100)
		leg_chance +=  leg_chance * (player_chance / 100)
	if player_chance >= 101  && player_chance <= 200:
		common_chance = 60
		uncommon_chance = 100
		rare_chance += rare_chance * (player_chance / 100)
		epic_chance +=  epic_chance * (player_chance / 100)
		leg_chance +=  leg_chance * (player_chance / 100)
	if player_chance >= 201  && player_chance <= 300:
		common_chance = 40
		uncommon_chance = 100 * (player_chance / 700)
		rare_chance += rare_chance * (player_chance / 100)
		epic_chance +=  epic_chance * (player_chance / 100)
		leg_chance +=  leg_chance * (player_chance / 100)
	if player_chance >= 301  && player_chance <= 400:
		common_chance = 20
		uncommon_chance = 100 * (player_chance / 800)
		rare_chance = 100
		epic_chance +=  epic_chance * (player_chance / 100)
		leg_chance +=  leg_chance * (player_chance / 100)
	if player_chance >= 401:
		common_chance = 5
		uncommon_chance = 20
		rare_chance = 30
		epic_chance +=  epic_chance * (player_chance / 100)
		leg_chance +=  leg_chance * (player_chance / 100)
		
	var calculate_chance = {
		"common": common_chance,
		"uncommon": uncommon_chance,
		"rare": rare_chance,
		"epic": epic_chance,
		"leg": leg_chance
	}
	
	return calculate_chance
		
func get_random_up():
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
	
func get_random_player_upgrade():
	var dblist = []
	for i in UpgradeDb.UPGRADES:
		if UpgradeDb.UPGRADES[i]["type"] == "upgrade":
			if UpgradeDb.UPGRADES[i]["prerequisite"].size() > 0:
				var to_add = true
				for u in UpgradeDb.UPGRADES[i]["prerequisite"]:
					if u not in collected_upgrades:
						to_add = false
				if to_add:
					dblist.append(i)
			else:
				dblist.append(i)
		else:
			pass

	if dblist.size() > 0: 
		var rarity_chances_updated = update_rarity_chances(rarity_chances)
		var weighted_dblist = []
		for item in dblist:
			var rarity = UpgradeDb.UPGRADES[item].get("rarity", "")
			if rarity == "":  # If no specific rarity, add it with all rarities
				for r in rarity_chances_updated.keys():
					var chance = rarity_chances_updated[r]
					weighted_dblist.append({"item": item, "rarity": r, "chance": chance})
			else:  # If specific rarity, add it only with that rarity
				var chance = rarity_chances.get(rarity, 1)
				weighted_dblist.append({"item": item, "rarity": rarity, "chance": chance})
			
		var random_item = pick_random_upgrade(weighted_dblist)
		upgrade_options.append(random_item) 
		return random_item
	else:
		return null
	
func get_random_player_attack():
	var dblist = [] #La pull d'opptions d'upgrade
	for i in UpgradeDb.UPGRADES:
		if UpgradeDb.UPGRADES[i]["type"] == "attack":
			if i in collected_upgrades: #Si on a déjà trouvé l'upgrade
				pass #On ne fait rien
			elif i in upgrade_options: #Si l'upgrade est déjà ajouté en option
				pass #On ne fait rien
			elif UpgradeDb.UPGRADES[i]["prerequisite"].size() > 0: #Si il y'a des prérequis pour l'upgrade:
				var to_add = true #On créer une variable pour savoir si on ajoute ou non l'upgrade dans notre pull
				for u in UpgradeDb.UPGRADES[i]["prerequisite"]: #On loop à travers les prérequis
					if not u in collected_upgrades: #Si le prérequis n'est pas dans nos upgrade déjà récolté
						to_add = false #On ne l'ajoute pas
				if to_add: 
					dblist.append(i) #Sinon on l'ajoute dans notre pull d'upgrade
			else:
				dblist.append(i) #Si il n'y a pas de prérequis on l'ajoute directement
		else: 
			pass

func pick_random_upgrade(list_upgrades_chance):
	var total_chance = 0
	for upgrade in list_upgrades_chance:
		total_chance += upgrade["chance"]
	var number_to_upgrade = {}
	var assigned_numbers = []
	for upgrade in list_upgrades_chance:
		var num_numbers = int(200 * upgrade["chance"] / total_chance)
		for _i in range(num_numbers):
			var number
			while true:
				number = randi() % 200
				if number not in assigned_numbers:
					break
			assigned_numbers.append(number)
			number_to_upgrade[number] = upgrade

	var random_number = randi() % 200
	while random_number not in number_to_upgrade:
		random_number = randi() % 200
	print("Player chance = " + str(player.rarity_chance))
	print(number_to_upgrade[random_number])
	return number_to_upgrade[random_number]
	
	
func upgrade_character(upgrade):
	var upgrade_value = UpgradeDb.UPGRADES[upgrade]["value"]
	match upgrade:
		"armor":
			player.armor += upgrade_value
		"speed":
			player.movement_speed += upgrade_value
		"tome":
			player.spell_area += upgrade_value
		"scroll":
			player.spell_coldown += upgrade_value
		"ring":
			player.additional_proctile += upgrade_value
		"food":
			healthComponent.health += upgrade_value
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
	leveling.calculate_experience(0) #Permet de gérer plusieurs level up d'un coup

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

