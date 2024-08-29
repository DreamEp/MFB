extends TextureButton
class_name  ItemOption

@onready var itemName = $BackgroundColor/LabelItemName
@onready var itemDescription = $BackgroundColor/LabelItemDescription
@onready var itemLevel = $BackgroundColor/LabelItemLevel
@onready var itemIcon = $BackgroundColor/BackgroundItemColor/ItemIcon
@onready var backgroundColor = $BackgroundColor

var item = null
@onready var player = get_tree().get_first_node_in_group("player")
@onready var playerInterraction = player.get_node("PlayerInterraction")
@onready var leveling = playerInterraction.get_node("Leveling")
@onready var upgrade = leveling.get_node("UpgradePlayer")

signal selected_upgrade(upgrade)
var base_color

func _ready():
	var item_level = 1
	var item_rarity = "common"
	connect("selected_upgrade", Callable(upgrade, "upgrade_character"))
	if item == null:
		for i in UpgradeDb.UPGRADES:
			if i == "food":
				item = UpgradeDb.UPGRADES[i]
	else:
		match item["rarity"]:
				"common":
					backgroundColor.color = Color(0.8, 0.8, 0.8, 1)
					item_rarity = "common"
					item_level = 1 
				"uncommon":
					backgroundColor.color = Color(0.6, 0.9, 0.6, 1)
					item_rarity = "uncommon"
					item_level = 2 
				"rare":
					backgroundColor.color = Color(0.7, 0.7, 1, 1)
					item_rarity = "rare"
					item_level = 3 
				"epic":
					backgroundColor.color = Color(0.8, 0.6, 0.9, 1)
					item_rarity = "epic"
					item_level = 4 
				"leg":
					backgroundColor.color = Color(1, 0.7, 0.7, 1)
					item_rarity = "leg"
					item_level = 5 
				_:
					pass
		item = UpgradeDb.UPGRADES[item["item"]]
		item["rarity"] = item_rarity
		item["level"] = item_level
	base_color = backgroundColor.color
	itemName.text = item["displayname"]
	itemDescription.text = item["details"]
	itemLevel.text = "Level : " + str(item["level"])
	itemIcon.texture = load(item["icon"])
	
func _on_pressed():
	selected_upgrade.emit(item)

func _on_mouse_entered():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1) * 1.025, 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.play()
	backgroundColor.color = base_color.lightened(0.15)

func _on_mouse_exited():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.play()
	backgroundColor.color = base_color
