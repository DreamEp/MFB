extends Node

const UPGRADES_PATH = "res://Art/Player/Upgrades/"
const ATTACKS_PATH = "res://Art/Player/Attacks/"
var UPGRADES = {
	"arrow1": {
		"icon": ATTACKS_PATH + "arrow.png",
		"displayname": "Arrow Attacks",
		"details": "A spear of ice is thrown at a random enemy",
		"level": 1,
		"rarity": "common",
		"prerequisite": [],
		"type": "attack"
	},
	"arrow2": {
		"icon": ATTACKS_PATH + "ice_spear.png",
		"displayname": "Arrow Attacks",
		"details": "An addition Ice Spear is thrown",
		"level": 2,
		"rarity": "uncommon",
		"prerequisite": ["arrow1"],
		"type": "attack"
	},
	"arrow3": {
		"icon": ATTACKS_PATH + "ice_spear.png",
		"displayname": "Arrow Attacks",
		"details": "Ice Spears now pass through another enemy and do + 3 damage",
		"level": 3,
		"rarity": "rare",
		"prerequisite": ["arrow2"],
		"type": "attack"
	},
	"arrow4": {
		"icon": ATTACKS_PATH + "ice_spear.png",
		"displayname": "Arrow Attacks",
		"details": "An additional 2 Ice Spears are thrown",
		"level": 4,
		"rarity": "epic",
		"prerequisite": ["arrow3"],
		"type": "attack"
	},
	"axe1": {
		"icon": ATTACKS_PATH + "axe.png",
		"displayname": "axe",
		"details": "A magical axe will follow you attacking enemies in a straight line",
		"level": 1,
		"rarity": "common",
		"prerequisite": [],
		"type": "attack"
	},
	"axe2": {
		"icon": ATTACKS_PATH + "axe.png",
		"displayname": "axe",
		"details": "The axe will now attack an additional enemy per attack",
		"level": 2,
		"rarity": "uncommon",
		"prerequisite": ["axe1"],
		"type": "attack"
	},
	"axe3": {
		"icon": ATTACKS_PATH + "axe.png",
		"displayname": "axe",
		"details": "The axe will attack another additional enemy per attack",
		"level": 3,
		"rarity": "rare",
		"prerequisite": ["axe2"],
		"type": "attack"
	},
	"axe4": {
		"icon": ATTACKS_PATH + "axe.png",
		"displayname": "axe",
		"details": "The axe now does + 5 damage per attack and causes 20% additional knockback",
		"level": 4,
		"rarity": "epic",
		"prerequisite": ["axe3"],
		"type": "attack"
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
