extends Node

const UPGRADES_PATH = "res://Art/Player/Upgrades/"
const ATTACKS_PATH = "res://Art/Player/Attacks/"
const SPELLS_PATH = "res://Art/Player/Spells/"
var UPGRADES = {
	"arrow1": {
		"icon": ATTACKS_PATH + "Arrow.png",
		"displayname": "Arrow Attacks",
		"details": "An arrow is thrown at a random enemy",
		"level": 1,
		"rarity": "common",
		"prerequisite": [],
		"type": "attack"
	},
	"arrow2": {
		"icon": ATTACKS_PATH + "Arrow.png",
		"displayname": "Arrow Attacks",
		"details": "An addition Arrow is thrown",
		"level": 2,
		"rarity": "uncommon",
		"prerequisite": ["Arrow Attacks1"],
		"type": "attack"
	},
	"arrow3": {
		"icon": ATTACKS_PATH + "Arrow.png",
		"displayname": "Arrow Attacks",
		"details": "Arrow now pass through another enemy and do + 3 damage",
		"level": 3,
		"rarity": "rare",
		"prerequisite": ["Arrow Attacks2"],
		"type": "attack"
	},
	"arrow4": {
		"icon": ATTACKS_PATH + "Arrow.png",
		"displayname": "Arrow Attacks",
		"details": "An additional 2 arrows are thrown",
		"level": 4,
		"rarity": "epic",
		"prerequisite": ["Arrow Attacks3"],
		"type": "attack"
	},
	"axe1": {
		"icon": SPELLS_PATH + "Axe.png",
		"displayname": "Axe Rotation",
		"details": "A magical axe will follow you attacking enemies in a straight line",
		"level": 1,
		"rarity": "common",
		"prerequisite": [],
		"type": "spell"
	},
	"axe2": {
		"icon": SPELLS_PATH + "Axe.png",
		"displayname": "Axe Rotation",
		"details": "The axe will now attack an additional enemy per attack",
		"level": 2,
		"rarity": "uncommon",
		"prerequisite": ["Axe Rotation1"],
		"type": "spell"
	},
	"axe3": {
		"icon": SPELLS_PATH + "Axe.png",
		"displayname": "Axe Rotation",
		"details": "The axe will attack another additional enemy per attack",
		"level": 3,
		"rarity": "rare",
		"prerequisite": ["Axe Rotation2"],
		"type": "spell"
	},
	"axe4": {
		"icon": SPELLS_PATH + "Axe.png",
		"displayname": "Axe Rotation",
		"details": "The axe now does + 5 damage per attack and causes 20% additional knockback",
		"level": 4,
		"rarity": "epic",
		"prerequisite": ["Axe Rotation3"],
		"type": "spell"
	},
	"thunder1": {
		"icon": SPELLS_PATH + "Thunder.png",
		"displayname": "Thunder bolt",
		"details": "A magical thunder will follow you attacking enemies in a straight line",
		"level": 1,
		"rarity": "common",
		"prerequisite": [],
		"type": "spell"
	},
	"thunder2": {
		"icon": SPELLS_PATH + "Thunder.png",
		"displayname": "Thunder bolt",
		"details": "The thunder will now attack an additional enemy per attack",
		"level": 2,
		"rarity": "uncommon",
		"prerequisite": ["Thunder bolt1"],
		"type": "spell"
	},
	"thunder3": {
		"icon": SPELLS_PATH + "Thunder.png",
		"displayname": "Thunder bolt",
		"details": "The thunder will attack another additional enemy per attack",
		"level": 3,
		"rarity": "rare",
		"prerequisite": ["Thunder bolt2"],
		"type": "spell"
	},
	"thunder4": {
		"icon": SPELLS_PATH + "Thunder.png",
		"displayname": "Thunder bolt",
		"details": "The thunder now does + 5 damage per attack and causes 20% additional knockback",
		"level": 4,
		"rarity": "epic",
		"prerequisite": ["Thunder bolt3"],
		"type": "spell"
	},
	"add_armor": {
		"icon": UPGRADES_PATH + "Armor.png",
		"displayname": "Armor",
		"details": "Reduces incomming damage",
		"level": 1,
		"rarity": "",
		"value": 1,
		"prerequisite": [],
		"type": "upgrade"
	},
	"add_block": {
		"icon": UPGRADES_PATH + "Shield.png",
		"displayname": "Shield",
		"details": "Increase block chance",
		"level": 1,
		"rarity": "",
		"value": 1,
		"prerequisite": [],
		"type": "upgrade"
	},
	"add_collect_area": {
		"icon": UPGRADES_PATH + "Pearl.png",
		"displayname": "Pearl",
		"details": "Increase area of collect",
		"level": 1,
		"rarity": "",
		"value": 0.2,
		"prerequisite": [],
		"type": "upgrade"
	},
	"add_mov_speed": {
		"icon": UPGRADES_PATH + "Boots.png",
		"displayname": "Boots",
		"details": "Increase movement speed",
		"level": 1,
		"rarity": "",
		"value": 0.2,
		"prerequisite": [],
		"type": "upgrade"
	},
	"add_attack_dmg": {
		"icon": UPGRADES_PATH + "Sword.png",
		"displayname": "Sword",
		"details": "Increase attack damage",
		"level": 1,
		"rarity": "",
		"value": 2,
		"prerequisite": [],
		"type": "upgrade"
	},
	"add_spell_dmg": {
		"icon": UPGRADES_PATH + "MagicHat.png",
		"displayname": "Magic Hat",
		"details": "Increase spell damage",
		"level": 1,
		"rarity": "",
		"value": 2,
		"prerequisite": [],
		"type": "upgrade"
	},
	"add_attack_speed": {
		"icon": UPGRADES_PATH + "Gloves.png",
		"displayname": "Gloves",
		"details": "Increase attacks speed",
		"level": 1,
		"rarity": "",
		"value": 0.2,
		"prerequisite": [],
		"type": "upgrade"
	},
	"add_area_spell": {
		"icon": UPGRADES_PATH + "Tome.png",
		"displayname": "Tome",
		"details": "Increases the size of spells",
		"level": 1,
		"rarity": "",
		"value": 0.10,
		"prerequisite": [],
		"type": "upgrade"
	},
	"add_cdr_spell": {
		"icon": UPGRADES_PATH + "Scroll.png",
		"displayname": "Scroll",
		"details": "Decreases the cooldown of spells",
		"level": 1,
		"rarity": "",
		"value": 0.5,
		"prerequisite": [],
		"type": "upgrade"
	},
	"add_spell_proj": {
		"icon": UPGRADES_PATH + "Ring.png",
		"displayname": "Ring",
		"details": "Your spells now spawn 1 more additional attack",
		"level": 1,
		"rarity": "leg",
		"value": 1,
		"prerequisite": [],
		"type": "upgrade"
	},
	"add_attacks_proj": {
		"icon": UPGRADES_PATH + "Stone.png",
		"displayname": "Stone",
		"details": "Your attacks now spawn 1 more additional attack",
		"level": 1,
		"rarity": "epic",
		"value": 1,
		"prerequisite": [],
		"type": "upgrade"
	},
	"food": {
		"icon": UPGRADES_PATH + "Food.png",
		"displayname": "Food",
		"details": "Heals you for 20 health",
		"level": "N/A",
		"rarity": "common",
		"value": 20,
		"prerequisite": [],
		"type": "item"
	}
}
