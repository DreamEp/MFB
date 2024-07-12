extends TextureButton
class_name  ItemOption

@onready var itemName = $BackgroundColor/LabelItemName
@onready var itemDescription = $BackgroundColor/LabelItemDescription
@onready var itemLevel = $BackgroundColor/LabelItemLevel
@onready var itemIcon = $BackgroundColor/BackgroundItemColor/ItemIcon
@onready var backgroundColor = $BackgroundColor

var item = null
@onready var player = get_tree().get_first_node_in_group("player")
@onready var interraction = player.get_node("Interraction")
@onready var leveling = interraction.get_node("Leveling")
@onready var upgrad = leveling.get_node("UpgradePlayer")

signal selected_upgrade(upgrade)
var base_color

func _ready():
	connect("selected_upgrade", Callable(upgrad, "upgrade_character"))
	if item == null:
		item = "food"
	match item["rarity"]:
		"uncommon":
			backgroundColor.color = Color(0.8, 0.8, 0.8, 1)
		"common":
			backgroundColor.color = Color(0.6, 0.9, 0.6, 1)
		"rare":
			backgroundColor.color = Color(0.7, 0.7, 1, 1)
		"epic":
			backgroundColor.color = Color(0.8, 0.6, 0.9, 1)
		"leg":
			backgroundColor.color = Color(1, 0.7, 0.7, 1)
		_:
			pass
	base_color = backgroundColor.color
	itemName.text = UpgradeDb.UPGRADES[item["item"]]["displayname"]
	itemDescription.text = UpgradeDb.UPGRADES[item["item"]]["details"]
	itemLevel.text = "Level : " + str(UpgradeDb.UPGRADES[item["item"]]["level"])
	itemIcon.texture = load(UpgradeDb.UPGRADES[item["item"]]["icon"])
	
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
