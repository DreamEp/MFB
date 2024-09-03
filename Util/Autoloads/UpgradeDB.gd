extends Node

const UPGRADES_PATH = "res://Art/Player/Upgrades/"
const ATTACKS_PATH = "res://Art/Player/Skills/Attacks/"
const SPELLS_PATH = "res://Art/Player/Skills/Spells/"
var UPGRADES = {
	"AxeRotation1": {
		"icon": SPELLS_PATH + "AxeRotation.png",
		"displayname": "Axe Rotation",
		"details": "Multiple axes rotating around the player",
		"level": 1,
		"rarity": "common",
		"prerequisite": [],
		"type": "spell"
	},
	"AxeRotation2": {
		"icon": SPELLS_PATH + "AxeRotation.png",
		"displayname": "Axe Rotation",
		"details": "An increaseitional axe is rotating around the player",
		"level": 2,
		"rarity": "uncommon",
		"prerequisite": ["Axe Rotation1"],
		"type": "spell"
	},
	"AxeRotation3": {
		"icon": SPELLS_PATH + "AxeRotation.png",
		"displayname": "Axe Rotation",
		"details": "The axes is rotating way faster around the player",
		"level": 3,
		"rarity": "rare",
		"prerequisite": ["Axe Rotation2"],
		"type": "spell"
	},
	"AxeRotation4": {
		"icon": SPELLS_PATH + "AxeRotation.png",
		"displayname": "Axe Rotation",
		"details": "An increaseitional 2 axes is rotating around the player",
		"level": 4,
		"rarity": "epic",
		"prerequisite": ["Axe Rotation3"],
		"type": "spell"
	},
	"CalamityShot1": {
		"icon": ATTACKS_PATH + "CalamityShot.png",
		"displayname": "Calamity Shot",
		"details": "Multiple arrows are fired all around the player",
		"level": 1,
		"rarity": "common",
		"prerequisite": [],
		"type": "attack"
	},
	"CalamityShot2": {
		"icon": ATTACKS_PATH + "CalamityShot.png",
		"displayname": "Calamity Shot",
		"details": "Reduce a bit the coldown of Calamity Shot",
		"level": 2,
		"rarity": "uncommon",
		"prerequisite": ["Calamity Shot1"],
		"type": "attack"
	},
	"CalamityShot3": {
		"icon": ATTACKS_PATH + "CalamityShot.png",
		"displayname": "Calamity Shot",
		"details": "There is one more salve fired by Calamity Shot",
		"level": 3,
		"rarity": "rare",
		"prerequisite": ["Calamity Shot2"],
		"type": "attack"
	},
	"CalamityShot4": {
		"icon": ATTACKS_PATH + "CalamityShot.png",
		"displayname": "Calamity Shot",
		"details": "Calamity Shot pierce one more enemy",
		"level": 4,
		"rarity": "epic",
		"prerequisite": ["Calamity Shot3"],
		"type": "attack"
	},
	"SpreadShot1": {
		"icon": ATTACKS_PATH + "SpreadShot.png",
		"displayname": "Spread Shot",
		"details": "Four arrows are fired in the direction of the enemy",
		"level": 1,
		"rarity": "common",
		"prerequisite": [],
		"type": "attack"
	},
	"SpreadShot2": {
		"icon": ATTACKS_PATH + "SpreadShot.png",
		"displayname": "Spread Shot",
		"details": "Arrow pierce one more enemy",
		"level": 2,
		"rarity": "uncommon",
		"prerequisite": ["Spread Shot1"],
		"type": "attack"
	},
	"SpreadShot3": {
		"icon": ATTACKS_PATH + "SpreadShot.png",
		"displayname": "Spread Shot",
		"details": "Three more arrows are fired",
		"level": 3,
		"rarity": "rare",
		"prerequisite": ["Spread Shot2"],
		"type": "attack"
	},
	"SpreadShot4": {
		"icon": ATTACKS_PATH + "SpreadShot.png",
		"displayname": "Spread Shot",
		"details": "increase one salve",
		"level": 4,
		"rarity": "epic",
		"prerequisite": ["Spread Shot3"],
		"type": "attack"
	},
	"RainOfArrows1": {
		"icon": SPELLS_PATH + "RainOfArrows.png",
		"displayname": "Rain of Arrows",
		"details": "Multiple arrows are raining at the position of the enemy",
		"level": 1,
		"rarity": "common",
		"prerequisite": [],
		"type": "spell"
	},
	"RainOfArrows2": {
		"icon": SPELLS_PATH + "RainOfArrows.png",
		"displayname": "Rain of Arrows",
		"details": "Arrow pierce one more enemy",
		"level": 2,
		"rarity": "uncommon",
		"prerequisite": ["Rain of Arrows1"],
		"type": "spell"
	},
	"RainOfArrows3": {
		"icon": SPELLS_PATH + "RainOfArrows.png",
		"displayname": "Rain of Arrows",
		"details": "It's raininng dayyyy",
		"level": 3,
		"rarity": "rare",
		"prerequisite": ["Rain of Arrows2"],
		"type": "spell"
	},
	"RainOfArrows4": {
		"icon": SPELLS_PATH + "RainOfArrows.png",
		"displayname": "Rain of Arrows",
		"details": "increase more arrows to the raining",
		"level": 4,
		"rarity": "epic",
		"prerequisite": ["Rain of Arrows3"],
		"type": "spell"
	},
	"DeathlyShot1": {
		"icon": ATTACKS_PATH + "DeathlyShot.png",
		"displayname": "Deathly Shot",
		"details": "One deathly arrow is fired in the direction of an enemy dealing massive damage and passing through all enemies",
		"level": 1,
		"rarity": "common",
		"prerequisite": [],
		"type": "attack"
	},
	"DeathlyShot2": {
		"icon": ATTACKS_PATH + "DeathlyShot.png",
		"displayname": "Deathly Shot",
		"details": "Reduce the cd of Deathly Shot",
		"level": 2,
		"rarity": "uncommon",
		"prerequisite": ["Deathly Shot1"],
		"type": "attack"
	},
	"DeathlyShot3": {
		"icon": ATTACKS_PATH + "DeathlyShot.png",
		"displayname": "Deathly Shot",
		"details": "increase one arrow to the Deathly Shot",
		"level": 3,
		"rarity": "rare",
		"prerequisite": ["Deathly Shot2"],
		"type": "attack"
	},
	"DeathlyShot4": {
		"icon": ATTACKS_PATH + "DeathlyShot.png",
		"displayname": "Deathly Shot",
		"details": "Increase range of Deathly Shot",
		"level": 4,
		"rarity": "epic",
		"prerequisite": ["Deathly Shot3"],
		"type": "attack"
	},
	"CrescentStrike1": {
		"icon": ATTACKS_PATH + "CrescentStrike.png",
		"displayname": "Crescent Strike",
		"details": "One deadly axe is thrown to the enemy",
		"level": 1,
		"rarity": "common",
		"prerequisite": [],
		"type": "attack"
	},
	"CrescentStrike2": {
		"icon": ATTACKS_PATH + "CrescentStrike.png",
		"displayname": "Crescent Strike",
		"details": "Two deadly axe is throwwn to the enemy",
		"level": 2,
		"rarity": "uncommon",
		"prerequisite": ["Crescent Strike1"],
		"type": "attack"
	},
	"CrescentStrike3": {
		"icon": ATTACKS_PATH + "CrescentStrike.png",
		"displayname": "Crescent Strike",
		"details": "Axes came back to the player",
		"level": 3,
		"rarity": "rare",
		"prerequisite": ["Crescent Strike2"],
		"type": "attack"
	},
	"CrescentStrike4": {
		"icon": ATTACKS_PATH + "CrescentStrike.png",
		"displayname": "Crescent Strike",
		"details": "One more salve of axes is thrown",
		"level": 4,
		"rarity": "epic",
		"prerequisite": ["Crescent Strike3"],
		"type": "attack"
	},
	"increase_armor": {
		"icon": UPGRADES_PATH + "Armor.png",
		"displayname": "Armor",
		"details": "Reduces incomming damage by 10%",
		"level": 1,
		"rarity": "",
		"value": 10,
		"prerequisite": [],
		"type": "upgrade"
	},
	"increase_block": {
		"icon": UPGRADES_PATH + "Shield.png",
		"displayname": "Shield",
		"details": "Increase block chance by 10%",
		"level": 1,
		"rarity": "",
		"value": 10,
		"prerequisite": [],
		"type": "upgrade"
	},
	"increase_collect_area": {
		"icon": UPGRADES_PATH + "Pearl.png",
		"displayname": "Pearl",
		"details": "Increase area of collect by 10%",
		"level": 1,
		"rarity": "",
		"value": 10,
		"prerequisite": [],
		"type": "upgrade"
	},
	"increase_mov_speed": {
		"icon": UPGRADES_PATH + "Boots.png",
		"displayname": "Boots",
		"details": "Increase movement speed by 10%",
		"level": 1,
		"rarity": "",
		"value": 10,
		"prerequisite": [],
		"type": "upgrade"
	},
	"increase_attack_dmg": {
		"icon": UPGRADES_PATH + "Sword.png",
		"displayname": "Sword",
		"details": "Increase attack damage by 10%",
		"level": 1,
		"rarity": "",
		"value": 10,
		"prerequisite": [],
		"type": "upgrade"
	},
	"increase_spell_dmg": {
		"icon": UPGRADES_PATH + "MagicHat.png",
		"displayname": "Magic Hat",
		"details": "Increase spell damage by 10%",
		"level": 1,
		"rarity": "",
		"value": 10,
		"prerequisite": [],
		"type": "upgrade"
	},
	"increase_attack_speed": {
		"icon": UPGRADES_PATH + "Gloves.png",
		"displayname": "Gloves",
		"details": "Increase attacks speed by 10%",
		"level": 1,
		"rarity": "",
		"value": 10,
		"prerequisite": [],
		"type": "upgrade"
	},
	"increase_area_spell": {
		"icon": UPGRADES_PATH + "Tome.png",
		"displayname": "Tome",
		"details": "Increases the size of spells by 10%",
		"level": 1,
		"rarity": "",
		"value": 10,
		"prerequisite": [],
		"type": "upgrade"
	},
	"increase_cdr_spell": {
		"icon": UPGRADES_PATH + "Scroll.png",
		"displayname": "Scroll",
		"details": "Decreases the cooldown of spells by 10%",
		"level": 1,
		"rarity": "",
		"value": 10,
		"prerequisite": [],
		"type": "upgrade"
	},
	"add_spell_proj": {
		"icon": UPGRADES_PATH + "Ring.png",
		"displayname": "Ring",
		"details": "Your spells now spawn 1 more increaseitional attack",
		"level": 1,
		"rarity": "leg",
		"value": 1,
		"prerequisite": [],
		"type": "upgrade"
	},
	"add_attacks_proj": {
		"icon": UPGRADES_PATH + "Stone.png",
		"displayname": "Stone",
		"details": "Your attacks now spawn 1 more increaseitional attack",
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
