extends TextureButton
class_name  ItemOption

@onready var itemName = $BackgroundColor/LabelItemName
@onready var itemDescription = $BackgroundColor/LabelItemDescription
@onready var itemLevel = $BackgroundColor/LabelItemLevel
@onready var itemIcon = $BackgroundColor/BackgroundItemColor/ItemIcon
@onready var backgroundColor = $BackgroundColor

var item = null
@onready var player = get_tree().get_first_node_in_group("player")

signal selected_upgrade(upgrade)

func _ready() -> void:
	connect("selected_upgrade", Callable(player, "upgrade_character"))
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
	itemName.text = UpgradeDb.UPGRADES[item["item"]]["displayname"]
	itemDescription.text = UpgradeDb.UPGRADES[item["item"]]["details"]
	itemLevel.text = UpgradeDb.UPGRADES[item["item"]]["level"]
	itemIcon.texture = load(UpgradeDb.UPGRADES[item["item"]]["icon"])
	
func _on_pressed()-> void:
	selected_upgrade.emit(item)

func _on_mouse_entered():
	print("entered")
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1) * 1.025, 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.play()
	backgroundColor.color = Color.WEB_GRAY

func _on_mouse_exited():
	print("exited")
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.play()
	backgroundColor.color = Color.DARK_GRAY
