extends Node2D

@onready var leveling = get_owner().get_node("Leveling")
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var healthComponent: HealthComponent = player.get_node("HealthComponent")
@onready var levelUpPanel: Panel = get_tree().get_first_node_in_group("hud").get_node("LevelUp")
@onready var levelUpLabel: Label = levelUpPanel.get_node("LevelingUp")
@onready var upgradeOption: VBoxContainer = levelUpPanel.get_node("UpgradeOption")
@onready var CollectedSkills: GridContainer = get_tree().get_first_node_in_group("hud").get_node("CollectedSkills")
@onready var collectedUpgrades: GridContainer = get_tree().get_first_node_in_group("hud").get_node("CollectedUpgrades")
@onready var grabArea: CollisionShape2D = $"../../GrabArea/CollisionShape2D"


@onready var itemContainer = preload("res://HUD&Menu/HUD/item_container.tscn")
@onready var itemOption = preload("res://HUD&Menu/HUD/item_option.tscn")

var upgrade_options = []
var collected_upgrades = []
var collected_weapons_spells_names_level = []
var collected_supports_skills_names = []
var collected_names = []

func _ready():
	for child in CollectedSkills.get_children():
		child.queue_free()
	for child in collectedUpgrades.get_children():
		child.queue_free()
	if player.items[0].skills.size() > 0 :
		for skill in player.items[0].skills:
			var level = skill.level
			var title = skill.title
			collected_weapons_spells_names_level.append(title+str(level))
			if skill.support_skills != null:
				for support in skill.support_skills:
					collected_supports_skills_names.append({
						"skill" : skill.title,
						"support" : support.title
					})
					skill = support.activate(skill)

var rarity_chances: Dictionary = {
	"common": 100,
	"uncommon": 50,
	"rare": 25,
	"epic": 10,
	"leg": 5
}

func update_rarity_chances(base_rarity_chances):
	var player_chance = player.rarity_chance
	
	var common_chance = base_rarity_chances["common"]
	var uncommon_chance = base_rarity_chances["uncommon"]
	var rare_chance = base_rarity_chances["rare"]
	var epic_chance = base_rarity_chances["epic"]
	var leg_chance = base_rarity_chances["leg"]
	if player_chance >= 1  && player_chance <= 100:
		common_chance = 100
		uncommon_chance += uncommon_chance * (player_chance / 100)
		rare_chance += rare_chance * (player_chance / 100) 
		epic_chance +=  epic_chance * (player_chance / 100)
		leg_chance +=  leg_chance * (player_chance / 100)
	if player_chance >= 101  && player_chance <= 200:
		common_chance = 80
		uncommon_chance = 100
		rare_chance += rare_chance * (player_chance / 100)
		epic_chance +=  epic_chance * (player_chance / 100)
		leg_chance +=  leg_chance * (player_chance / 100)
	if player_chance >= 201  && player_chance <= 300:
		common_chance = 60
		uncommon_chance = 100 * (player_chance / 700)
		rare_chance += rare_chance * (player_chance / 100)
		epic_chance +=  epic_chance * (player_chance / 100)
		leg_chance +=  leg_chance * (player_chance / 100)
	if player_chance >= 301  && player_chance <= 400:
		common_chance = 40
		uncommon_chance = 100 * (player_chance / 800)
		rare_chance = 100
		epic_chance +=  epic_chance * (player_chance / 100)
		leg_chance +=  leg_chance * (player_chance / 100)
	if player_chance >= 401:
		common_chance = 20
		uncommon_chance = 30
		rare_chance = 40
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
	
func update_upgrade_value(upgrade, rarity) -> float:
	var value = 1.0
	var upgrade_value = upgrade["value"]
	match rarity:
		"uncommon": value = upgrade_value * 2.0
		"rare": value = upgrade_value * 3.0
		"epic": value = upgrade_value * 4.0
		"leg": value = upgrade_value * 5.5
	return value

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
			var upgrade = UpgradeDb.UPGRADES[item]
			var rarity = upgrade.get("rarity", "")
			if rarity == "":  # If no specific rarity, add it with all rarities
				for r in rarity_chances_updated.keys():
					var chance = rarity_chances_updated[r]
					#upgrade["rarity"] = r
					var updated_value = update_upgrade_value(upgrade, r)
					weighted_dblist.append({"item": item, "rarity": r, "value": updated_value, "chance": chance})
			else:  # If specific rarity, add it only with that rarity
				var chance = rarity_chances.get(rarity, 1)
				var updated_value = update_upgrade_value(upgrade, upgrade["rarity"])
				weighted_dblist.append({"item": item, "rarity": rarity, "value": updated_value, "chance": chance})

		var random_item = pick_random_upgrade(weighted_dblist)
		upgrade_options.append(random_item) 
		return random_item
	else:
		return null
	
func get_random_player_attack():
	var dblist = [] 
	for i in UpgradeDb.UPGRADES:
		if UpgradeDb.UPGRADES[i]["type"] == "attack" or UpgradeDb.UPGRADES[i]["type"] == "spell":
			var current_attack_spell = UpgradeDb.UPGRADES[i]
			var name_to_check = str(current_attack_spell["displayname"]) + str(current_attack_spell["level"]) 
			if name_to_check in collected_weapons_spells_names_level:
				pass 
			elif i in upgrade_options:
				pass 
			elif current_attack_spell["prerequisite"].size() > 0:
				var to_add = true 
				for u in current_attack_spell["prerequisite"]: 
					if not u in collected_weapons_spells_names_level:
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
			var upgrade = UpgradeDb.UPGRADES[item]
			var rarity = upgrade.get("rarity", "")
			if rarity == "":  # If no specific rarity, add it with all rarities
				for r in rarity_chances_updated.keys():
					var chance = rarity_chances_updated[r]
					weighted_dblist.append({"item": item, "rarity": r, "value": 0, "chance": chance})
			else:  # If specific rarity, add it only with that rarity
				var chance = rarity_chances.get(rarity, 1)
				weighted_dblist.append({"item": item, "rarity": rarity, "value": 0, "chance": chance})

		var random_item = pick_random_upgrade(weighted_dblist)
		#print(dblist)
		upgrade_options.append(random_item) 
		return random_item
	else:
		return null
		
func get_random_player_supports():
	var dblist = [] 
	if player.items[0].skills.size() > 0 :
		for skill in player.items[0].skills:
			if skill.support_skills.size() < 3:
				for i in UpgradeDb.UPGRADES:
					if UpgradeDb.UPGRADES[i]["type"] == "support":
						var current_support = UpgradeDb.UPGRADES[i]
						var name_to_check = {
							"skill" : skill.title,
							"support" : str(current_support["displayname"]) 
						}
						if name_to_check in collected_supports_skills_names:
							pass 
						elif name_to_check in upgrade_options:
							pass 
						elif current_support["prerequisite"].size() > 0:
							var to_add = false 
							for u in current_support["prerequisite"]: 
								if u in skill.tags:
									to_add = true 
							if to_add: 
								dblist.append({
									"skill" : skill.title,
									"support": current_support
									})
						else:
							dblist.append({
									"skill" : skill.title,
									"support": current_support
									})
					else: 
						pass
			
	if dblist.size() > 0: 
		var random = randi_range(0, dblist.size()-1)
		var random_support = dblist[random]
		upgrade_options.append({
						"skill" : random_support["skill"],
						"support" : random_support["support"]["displayname"] 
					}) 
		return random_support
	else:
		return null

func get_random_player_support_upgrade():
	var dblist = [] 
	if player.items[0].skills.size() > 0 :
		for skill in player.items[0].skills:
			if skill.support_skills.size() > 0:
				for support in skill.support_skills:
					if support.level < 10:
						var name_to_check = {
							"skill" : skill.title,
							"support" :support.title 
						}
						if name_to_check in upgrade_options:
							pass 
						else:
							for i in UpgradeDb.UPGRADES:
								if UpgradeDb.UPGRADES[i]["displayname"] == support.title:
									dblist.append({
											"skill" : skill.title,
											"support": UpgradeDb.UPGRADES[i]
											})
	if dblist.size() > 0: 
		var random = randi_range(0, dblist.size()-1)
		var random_support = dblist[random]
		upgrade_options.append({
						"skill" : random_support["skill"],
						"support" : random_support["support"]["displayname"] 
					}) 
		return random_support
	else:
		return get_random_player_upgrade()					
#
#func get_random_up():
	#var dblist = [] #La pull d'opptions d'upgrade
	#for i in UpgradeDb.UPGRADES:
		#if i in collected_upgrades: #Si on a déjà trouvé l'upgrade
			#pass #On ne fait rien
		#elif i in upgrade_options: #Si l'upgrade est déjà ajouté en option
			#pass #On ne fait rien
		#elif UpgradeDb.UPGRADES[i]["type"] == "item": #Si l'upgrade est de type food
			#pass #On ne fait rien
		#elif UpgradeDb.UPGRADES[i]["prerequisite"].size() > 0: #Si il y'a des prérequis pour l'upgrade
			#var to_add = true #On créer une variable pour savoir si on ajoute ou non l'upgrade dans notre pull
			#for u in UpgradeDb.UPGRADES[i]["prerequisite"]: #On loop à travers les prérequis
				#if not u in collected_upgrades: #Si le prérequis n'est pas dans nos upgrade déjà récolté
					#to_add = false #On ne l'ajoute pas
			#if to_add: 
				#dblist.append(i) #Sinon on l'ajoute dans notre pull d'upgrade
		#else:
			#dblist.append(i) #Si il n'y a pas de prérequis on l'ajoute directement
	#if dblist.size() > 0: #Si la taille de notre pull d'upgrade est supérieur a 0
		#var randomitem = dblist.pick_random() #On prend un upgrade random de la liste
		#upgrade_options.append(randomitem) #On l'ajoute dans notre liste d'option
		#return randomitem #On retourne l'item random
	#else:
		#return null
	#
	
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
	if leveling.list_of_upgrade.size() < list_upgrades_chance.size():
		var random_number = randi() % 200
		while random_number not in number_to_upgrade:
			random_number = randi() % 200
		var value_to_check = str(number_to_upgrade[random_number]["item"] + "_" + number_to_upgrade[random_number]["rarity"])
		while value_to_check in leveling.list_of_upgrade:
			random_number = randi() % 200
			while random_number not in number_to_upgrade:
				random_number = randi() % 200
			value_to_check = str(number_to_upgrade[random_number]["item"] + "_" + number_to_upgrade[random_number]["rarity"])
		#print(number_to_upgrade[random_number])
		return number_to_upgrade[random_number]
	else:
		return null
	
	
func upgrade_character(picked_upgrade, skill_name):
	var upgrade_name = picked_upgrade["displayname"]
	var upgrade_value
	if picked_upgrade["type"] == "upgrade" or picked_upgrade["type"] == "item":
		upgrade_value = picked_upgrade["value"]
	#var upgrade_rarity = picked_upgrade["rarity"]
		match upgrade_name:
			"Armor":
				player.increase_armor += upgrade_value
			"Shield":
				player.increase_block += upgrade_value
			"Pearl":
				player.increase_collectible_area += upgrade_value
				grabArea.apply_scale(Vector2(player.increase_collectible_area/100, player.increase_collectible_area/100))
			"Boots":
				player.increase_movement_speed += upgrade_value
			"Sword":
				player.increase_attack_damage += upgrade_value
			"Magic Hat":
				player.increase_spell_damage += upgrade_value
			"Gloves":
				player.increase_attack_speed += upgrade_value
			"Tome":
				player.increase_spell_area += upgrade_value
			"Scroll":
				player.increase_spell_coldown += upgrade_value
			"Ring":
				player.additional_spell_projectile += upgrade_value
			"Stone":
				player.additional_attack_projectile += upgrade_value
			"Food":
				healthComponent.health += upgrade_value
				healthComponent.health = clamp(healthComponent.health, 0, healthComponent.MAX_HEALTH)
		adjust_gui_collection(picked_upgrade)
		collected_names.append(upgrade_name)
		
	elif picked_upgrade["type"] == "attack" or picked_upgrade["type"] == "spell":
		collected_weapons_spells_names_level.append(str(picked_upgrade["displayname"]) + str(picked_upgrade["level"])) 
		var item_current_skills = player.items[0].skills
		var found = false
		
		var skill_path = "res://Resources/Skills/%ss/%s/%s.tres" %[picked_upgrade["type"].capitalize(), upgrade_name, picked_upgrade["displayname"]+str(picked_upgrade["level"])]
		var skill: Skill = ResourceLoader.load(skill_path)
		for i in range(item_current_skills.size()):			
			if item_current_skills[i] != null:
				if item_current_skills[i].title == picked_upgrade["displayname"]:
					if skill.support_skills.size() > 0: #If the current skill got supports then we play those
						for support in skill.support_skills:
							skill = support.activate(skill)
					elif item_current_skills[i].support_skills.size() > 0: #If the founded previous skill got supports
						skill.support_skills = item_current_skills[i].support_skills #Then the new skill got the previous supports
						for support in skill.support_skills:
							skill = support.activate(skill)
					item_current_skills[i] = skill
					found = true
					break
		if found == false:	
			if skill.support_skills != null:
				for support in skill.support_skills:
					skill = support.activate(skill)
			item_current_skills.append(skill)
		player.items[0].skills = item_current_skills
		adjust_gui_collection(picked_upgrade)
		collected_names.append(upgrade_name)
		
	elif picked_upgrade["type"] == "support":
		var item_current_skills = player.items[0].skills
		var name_to_check = {
						"skill" : skill_name,
						"support" : str(picked_upgrade["displayname"]) 
					}
		if name_to_check in collected_supports_skills_names:
			if item_current_skills.size() > 0:
				for skill in item_current_skills:
					if skill.title == skill_name:
						for support in skill.support_skills:
							if support.title == name_to_check["support"]:
								support.update_level(skill)
			player.items[0].skills = item_current_skills	
		else:
			collected_supports_skills_names.append({
							"skill" : skill_name,
							"support" : str(picked_upgrade["displayname"]) 
						})
			
			var support_path = "res://Resources/Skills/Supports/%s.tres" % upgrade_name
			var support: SupportSkill = ResourceLoader.load(support_path)
			
			if item_current_skills.size() > 0:
				for skill in item_current_skills:
					if skill.title == skill_name:
						skill.support_skills.append(support)
						support.activate(skill)
			player.items[0].skills = item_current_skills	
	var option_children = upgradeOption.get_children() 
	for i in option_children: 
		i.queue_free()
	upgrade_options.clear() 
	levelUpPanel.visible = false 
	levelUpPanel.position = Vector2(800, 50) 
	get_tree().paused = false 
	leveling.calculate_experience() 


func adjust_gui_collection(upgrade):
	var get_upgraded_displayname = upgrade["displayname"] 
	var get_type = upgrade["type"] 
	if get_type != "item": 
		if not get_upgraded_displayname in collected_names:
			var new_item = itemContainer.instantiate() 
			new_item.upgrade = upgrade
			match get_type: 
				"attack":
					CollectedSkills.add_child(new_item)
				"spell":
					CollectedSkills.add_child(new_item)
				"upgrade":
					collectedUpgrades.add_child(new_item)
		else:			
			match get_type: 
				"attack":
					var current_weapons = CollectedSkills.get_children()
					for w in current_weapons: 
						if w.upgrade["displayname"].substr(0, 3) == upgrade["displayname"].substr(0, 3) and w.has_method("update_level"):
							w.update_level(upgrade)
				"spell":
					var current_weapons = CollectedSkills.get_children()
					for w in current_weapons: 
						if w.upgrade["displayname"].substr(0, 3) == upgrade["displayname"].substr(0, 3) and w.has_method("update_level"):
							w.update_level(upgrade)
				"upgrade":
					var current_upgrades = collectedUpgrades.get_children()
					for u in current_upgrades: 
						if u.upgrade["displayname"].substr(0, 3) == upgrade["displayname"].substr(0, 3) and u.has_method("update_level"):
							u.update_level(upgrade)

