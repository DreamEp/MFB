extends Node

const UPGRADES_PATH = "res://Art/Player/Upgrades/"
const ATTACKS_PATH = "res://Art/Player/Attacks/"
const UPGRADES = {
	"arrow1": {
		"icon": ATTACKS_PATH + "arrow.png",
		"displayname": "Arrow Attacks",
		"details": "A spear of ice is thrown at a random enemy",
		"level": "Level: 1",
		"rarity": "common",
		"prerequisite": [],
		"type": "attack"
	},
	"arrow2": {
		"icon": ATTACKS_PATH + "ice_spear.png",
		"displayname": "Arrow Attacks",
		"details": "An addition Ice Spear is thrown",
		"level": "Level: 2",
		"rarity": "uncommon",
		"prerequisite": ["arrow1"],
		"type": "attack"
	},
	"arrow3": {
		"icon": ATTACKS_PATH + "ice_spear.png",
		"displayname": "Arrow Attacks",
		"details": "Ice Spears now pass through another enemy and do + 3 damage",
		"level": "Level: 3",
		"rarity": "rare",
		"prerequisite": ["arrow2"],
		"type": "attack"
	},
	"arrow4": {
		"icon": ATTACKS_PATH + "ice_spear.png",
		"displayname": "Arrow Attacks",
		"details": "An additional 2 Ice Spears are thrown",
		"level": "Level: 4",
		"rarity": "epic",
		"prerequisite": ["arrow3"],
		"type": "attack"
	},
	"axe1": {
		"icon": ATTACKS_PATH + "axe.png",
		"displayname": "axe",
		"details": "A magical axe will follow you attacking enemies in a straight line",
		"level": "Level: 1",
		"rarity": "common",
		"prerequisite": [],
		"type": "attack"
	},
	"axe2": {
		"icon": ATTACKS_PATH + "axe.png",
		"displayname": "axe",
		"details": "The axe will now attack an additional enemy per attack",
		"level": "Level: 2",
		"rarity": "uncommon",
		"prerequisite": ["axe1"],
		"type": "attack"
	},
	"axe3": {
		"icon": ATTACKS_PATH + "axe.png",
		"displayname": "axe",
		"details": "The axe will attack another additional enemy per attack",
		"level": "Level: 3",
		"rarity": "rare",
		"prerequisite": ["axe2"],
		"type": "attack"
	},
	"axe4": {
		"icon": ATTACKS_PATH + "axe.png",
		"displayname": "axe",
		"details": "The axe now does + 5 damage per attack and causes 20% additional knockback",
		"level": "Level: 4",
		"rarity": "epic",
		"prerequisite": ["axe3"],
		"type": "attack"
	},
	"armor": {
		"icon": UPGRADES_PATH + "Helmet.png",
		"displayname": "Armor",
		"details": "Reduces Damage",
		"level": "",
		"rarity": "",
		"value": 1,
		"prerequisite": [],
		"type": "upgrade"
	},
	"speed": {
		"icon": UPGRADES_PATH + "Boots.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased",
		"level": "",
		"rarity": "",
		"value": 0.50,
		"prerequisite": [],
		"type": "upgrade"
	},
	"tome": {
		"icon": UPGRADES_PATH + "Tome.png",
		"displayname": "Tome",
		"details": "Increases the size of spells",
		"level": "",
		"rarity": "",
		"value": 0.10,
		"prerequisite": [],
		"type": "upgrade"
	},
	"scroll": {
		"icon": UPGRADES_PATH + "Scroll.png",
		"displayname": "Scroll",
		"details": "Decreases the cooldown of spells",
		"level": "",
		"rarity": "",
		"value": 0.5,
		"prerequisite": [],
		"type": "upgrade"
	},
	"ring": {
		"icon": UPGRADES_PATH + "Ring.png",
		"displayname": "Ring",
		"details": "Your spells now spawn 1 more additional attack",
		"level": "",
		"rarity": "leg",
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
