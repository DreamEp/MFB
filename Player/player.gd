extends CharacterBody2D
class_name Player

#Variables
@export var player_level: int = 1
@export_group("Speed Values")
@export var movement_speed: float = 60.0
@export var acceleration_time: float = 0.1
@export_group("Offensive Values")
@export var attack_damage: float = 5.0
@export var attack_area: float = 2.0
@export var attack_coldown: float = 2.0
@export var attack_knockback: float = 2.0
@export var spell_damage: float = 5.0
@export var spell_area: float = 2.0
@export var spell_coldown: float = 2.0
@export var spell_knockback: float = 2.0
@export_group("Defensive Values")
@export var knockback_recovery: float = 3.0
@export var armor: float = 2.0
@export var evasiness: float = 0
@export var block: float = 0
@export_group("Misc Values")
@export var collectible_area: float = 2.0
@export var additional_attack_proctile: float = 0
@export var additional_spell_proctile: float = 0
@export var rarity_chance: float = 1.0
@export var player_experience: float
@export var player_experience_level: float = 1.0
@export var player_collected_experience: float = 0

#Nodes
@onready var healthBar: TextureProgressBar = get_tree().get_first_node_in_group("hud").get_node("HealthBar")
@onready var expBar: ProgressBar = get_tree().get_first_node_in_group("hud").get_node("ExperienceBar")
@onready var healthLabel: Label = healthBar.get_node("HealthLabel")
@onready var expLabel: Label = expBar.get_node("LevelLabel")
@onready var healthComponent: HealthComponent = $HealthComponent

var alive := true
var idle := true
var walk := false
var attack := false
var hurt := false
var stunned := false

var aim_position : Vector2 = Vector2(1, 0)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var half_viewport = get_viewport_rect().size / 2.0
		aim_position = (event.position - half_viewport)

func _ready():
	print(healthBar.name)
	set_healthbar(healthComponent.MAX_HEALTH, healthComponent.MAX_HEALTH)
	set_expbar(player_experience, 5.0)
	
func _process(_delta):
	set_healthbar(healthComponent.health, healthComponent.MAX_HEALTH)

func set_healthbar(set_value: float = 0, set_max_value: float = 100):
	healthBar.max_value = set_max_value
	healthBar.value = set_value 
	healthLabel.text = str(set_value)+"/"+str(set_max_value)

func set_expbar(set_value: float = 0, set_max_value: float = 100):
	expBar.max_value = set_max_value
	expBar.value = set_value
	expLabel.text = str(player_experience_level, " ------- " + str(set_value)+"/"+str(set_max_value))
