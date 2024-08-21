extends CharacterBody2D
class_name Player

#Variables
@export var player_level: int = 1
@export_group("Speed Values")
@export var movement_speed: float = 60.0
@export var acceleration_time: float = 0.1
@export_group("Offensive Values")
@export var attack_damage: float = 10.0
@export_range(0, 1) var crit_chance: float = 10
@export var attack_area: float = 2.0
@export var attack_speed: float = 2.0
@export var knockback_force: float = 2.0
@export var spell_damage: float = 5.0
@export var spell_area: float = 2.0
@export var spell_coldown: float = 2.0
@export var spell_knockback: float = 2.0
@export var spell_duration: float = 2.0
@export var bullet_speed: float = 10.0
@export_group("Defensive Values")
@export var knockback_recovery: float = 3.0
@export var armor: float = 100.0
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
@export var player_collected_skills: Array = []

#Nodes
@onready var healthBar: TextureProgressBar = get_tree().get_first_node_in_group("hud").get_node("HealthBar")
@onready var expBar: ProgressBar = get_tree().get_first_node_in_group("hud").get_node("ExperienceBar")
@onready var currentStatus: Label = get_tree().get_first_node_in_group("hud").get_node("CurrentStatus")
@onready var statusAnimationPlayer: AnimationPlayer = get_tree().get_first_node_in_group("hud").get_node("StatusAnimationPlayer")
@onready var healthLabel: Label = healthBar.get_node("HealthLabel")
@onready var expLabel: Label = expBar.get_node("LevelLabel")
@onready var healthComponent: HealthComponent = $HealthComponent

var alive := true
var idle := true
var walk := false
var attack := false
var hurt := false
var stunned := false

var status_effects: Array = []
var aim_position : Vector2 = Vector2(1, 0)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var half_viewport = get_viewport_rect().size / 2.0
		aim_position = (event.position - half_viewport)

func _ready():
	set_healthbar(healthComponent.MAX_HEALTH, healthComponent.MAX_HEALTH)
	set_expbar(player_experience, 5.0)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_1:
			apply_status_effect(Stun.new(2))
		if event.keycode == KEY_2:
			apply_status_effect(Slow.new(3))
		if event.keycode == KEY_3:
			apply_status_effect(Haste.new(3))
		if event.keycode == KEY_4:
			apply_status_effect(Exhaust.new(2))
		if event.keycode == KEY_5:
			apply_status_effect(Berserk.new(3))
			
func _process(delta):
	set_healthbar(healthComponent.health, healthComponent.MAX_HEALTH)
	
	for i in range(status_effects.size()):
		var effect = status_effects[i]
		effect.duration -= delta
		
		if effect.duration < 0:
			effect.remove(self)
			status_effects.remove_at(i)
			print(status_effects)
			reset_effect()
			break

func set_healthbar(set_value: float = 0, set_max_value: float = 100):
	healthBar.max_value = set_max_value
	healthBar.value = set_value 
	healthLabel.text = str(set_value)+"/"+str(set_max_value)

func set_expbar(set_value: float = 0, set_max_value: float = 100):
	expBar.max_value = set_max_value
	expBar.value = set_value
	expLabel.text = str(player_experience_level, " ------- " + str(set_value)+"/"+str(set_max_value))
	
func play(animation_name):
	statusAnimationPlayer.play(animation_name)

func apply_status_effect(effect):
	for i in range(status_effects.size()):
		if status_effects[i].get_class_name() == effect.get_class_name():
			status_effects[i].duration = effect.duration
			return
	status_effects.append(effect)
	effect.apply(self)
	print(status_effects)

func reset_effect():
	for i in status_effects:
		i.apply(self)
