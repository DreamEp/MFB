extends TextureRect

var upgrade = null
@onready var item_container = $"."
@onready var item_texture = $ItemTexture
@onready var label_item_number = $LabelItemNumber

@onready var base_parent_size = item_container.size # Size of the parent container
@onready var base_child_size = item_texture.size  # Original size of the child image
	
func _ready():
	if upgrade != null:
		item_texture.texture = load(upgrade["icon"])
		label_item_number.text = str(upgrade["level"])
		scaleChild(base_parent_size, base_child_size)

func update_level(key):
	var current_key = key.to_lower()
	if UpgradeDb.UPGRADES.has(current_key):
		upgrade = UpgradeDb.UPGRADES[current_key]
		if upgrade.has("level"):
			upgrade["level"] += 1
			label_item_number.text = str(upgrade["level"])
		
func scaleChild(parent_size, child_size):
	
	var scale_x = (parent_size.x - 6) / child_size.x
	var scale_y = (parent_size.y - 6) / child_size.y

	item_texture.scale = Vector2(scale_x, scale_y)
	
