extends Node

const UPGRADES_PATH = "res://Art/Player/Upgrades/"
const ATTACKS_PATH = "res://Art/Player/Attacks/"
const UPGRADES = {
	"arrow1": {
		"icon": ATTACKS_PATH + "arrow.png",
		"displayname": "Arrow Attacks",
		"details": "A spear of ice is thrown at a random enemy",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "attacks"
	},
	"arrow2": {
		"icon": ATTACKS_PATH + "ice_spear.png",
		"displayname": "Arrow Attacks",
		"details": "An addition Ice Spear is thrown",
		"level": "Level: 2",
		"prerequisite": ["arrow1"],
		"type": "attacks"
	},
	"arrow3": {
		"icon": ATTACKS_PATH + "ice_spear.png",
		"displayname": "Arrow Attacks",
		"details": "Ice Spears now pass through another enemy and do + 3 damage",
		"level": "Level: 3",
		"prerequisite": ["arrow2"],
		"type": "attacks"
	},
	"arrow4": {
		"icon": ATTACKS_PATH + "ice_spear.png",
		"displayname": "Arrow Attacks",
		"details": "An additional 2 Ice Spears are thrown",
		"level": "Level: 4",
		"prerequisite": ["arrow3"],
		"type": "attacks"
	},
	"axe1": {
		"icon": ATTACKS_PATH + "axe.png",
		"displayname": "axe",
		"details": "A magical axe will follow you attacking enemies in a straight line",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "attacks"
	},
	"axe2": {
		"icon": ATTACKS_PATH + "axe.png",
		"displayname": "axe",
		"details": "The axe will now attack an additional enemy per attack",
		"level": "Level: 2",
		"prerequisite": ["axe1"],
		"type": "attacks"
	},
	"axe3": {
		"icon": ATTACKS_PATH + "axe.png",
		"displayname": "axe",
		"details": "The axe will attack another additional enemy per attack",
		"level": "Level: 3",
		"prerequisite": ["axe2"],
		"type": "attacks"
	},
	"axe4": {
		"icon": ATTACKS_PATH + "axe.png",
		"displayname": "axe",
		"details": "The axe now does + 5 damage per attack and causes 20% additional knockback",
		"level": "Level: 4",
		"prerequisite": ["axe3"],
		"type": "attacks"
	},
	"armor1": {
		"icon": UPGRADES_PATH + "Helmet.png",
		"displayname": "Armor",
		"details": "Reduces Damage By 1 point",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"armor2": {
		"icon": UPGRADES_PATH + "Helmet.png",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 2",
		"prerequisite": ["armor1"],
		"type": "upgrade"
	},
	"armor3": {
		"icon": UPGRADES_PATH + "Helmet.png",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 3",
		"prerequisite": ["armor2"],
		"type": "upgrade"
	},
	"armor4": {
		"icon": UPGRADES_PATH + "Helmet.png",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 4",
		"prerequisite": ["armor3"],
		"type": "upgrade"
	},
	"speed1": {
		"icon": UPGRADES_PATH + "Boots.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by 50% of base speed",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"speed2": {
		"icon": UPGRADES_PATH + "Boots.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by an additional 50% of base speed",
		"level": "Level: 2",
		"prerequisite": ["speed1"],
		"type": "upgrade"
	},
	"speed3": {
		"icon": UPGRADES_PATH + "Boots.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by an additional 50% of base speed",
		"level": "Level: 3",
		"prerequisite": ["speed2"],
		"type": "upgrade"
	},
	"speed4": {
		"icon": UPGRADES_PATH + "Boots.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased an additional 50% of base speed",
		"level": "Level: 4",
		"prerequisite": ["speed3"],
		"type": "upgrade"
	},
	"tome1": {
		"icon": UPGRADES_PATH + "Tome.png",
		"displayname": "Tome",
		"details": "Increases the size of spells an additional 10% of their base size",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"tome2": {
		"icon": UPGRADES_PATH + "Tome.png",
		"displayname": "Tome",
		"details": "Increases the size of spells an additional 10% of their base size",
		"level": "Level: 2",
		"prerequisite": ["tome1"],
		"type": "upgrade"
	},
	"tome3": {
		"icon": UPGRADES_PATH + "Tome.png",
		"displayname": "Tome",
		"details": "Increases the size of spells an additional 10% of their base size",
		"level": "Level: 3",
		"prerequisite": ["tome2"],
		"type": "upgrade"
	},
	"tome4": {
		"icon": UPGRADES_PATH + "Tome.png",
		"displayname": "Tome",
		"details": "Increases the size of spells an additional 10% of their base size",
		"level": "Level: 4",
		"prerequisite": ["tome3"],
		"type": "upgrade"
	},
	"scroll1": {
		"icon": UPGRADES_PATH + "Scroll.png",
		"displayname": "Scroll",
		"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"scroll2": {
		"icon": UPGRADES_PATH + "Scroll.png",
		"displayname": "Scroll",
		"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
		"level": "Level: 2",
		"prerequisite": ["scroll1"],
		"type": "upgrade"
	},
	"scroll3": {
		"icon": UPGRADES_PATH + "Scroll.png",
		"displayname": "Scroll",
		"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
		"level": "Level: 3",
		"prerequisite": ["scroll2"],
		"type": "upgrade"
	},
	"scroll4": {
		"icon": UPGRADES_PATH + "Scroll.png",
		"displayname": "Scroll",
		"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
		"level": "Level: 4",
		"prerequisite": ["scroll3"],
		"type": "upgrade"
	},
	"ring1": {
		"icon": UPGRADES_PATH + "Ring.png",
		"displayname": "Ring",
		"details": "Your spells now spawn 1 more additional attack",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"ring2": {
		"icon": UPGRADES_PATH + "Ring.png",
		"displayname": "Ring",
		"details": "Your spells now spawn an additional attack",
		"level": "Level: 2",
		"prerequisite": ["ring1"],
		"type": "upgrade"
	},
	"food": {
		"icon": UPGRADES_PATH + "Food.png",
		"displayname": "Food",
		"details": "Heals you for 20 health",
		"level": "N/A",
		"prerequisite": [],
		"type": "item"
	}
}
