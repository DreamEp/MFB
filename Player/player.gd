extends CharacterBody2D
class_name Player

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
@export var health: float = 60.0
@export var knockback_recovery: float = 3.0
@export var armor: float = 2.0
@export var evasiness: float = 0
@export var block: float = 0
@export_group("Misc Values")
@export var area_collectible: float = 2.0
