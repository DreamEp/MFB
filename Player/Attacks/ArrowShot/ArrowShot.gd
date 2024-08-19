extends Node2D
class_name ArrowShot

var arrow_scene: PackedScene = preload("res://Player/Attacks/ArrowShot/arrow.tscn")

@export var firing_position : Marker2D
@export_group("Upgradable Arrows Shot")
@export var shot_arrow_count: int = 5
@export_range(0, 360) var shot_range: float = 25
@export_range(0, 5) var shot_rate: float = 3

@onready var player: Player = get_owner()
@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")

var can_shot = false

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(shot_rate).timeout
	can_shot = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func spawnArrowShot(enemy_position):
	var arrow_count = shot_arrow_count + player.additional_spell_proctile + player.additional_attack_proctile
	var bow_rate = shot_rate - (shot_rate * (player.attack_coldown/100))
	if can_shot:
		can_shot = false
		var mouse_direction = enemy_position - firing_position.global_position
		for i in arrow_count:
			var spawned_arrow = arrow_scene.instantiate()
			spawned_arrow.position = firing_position.global_position
			
			if arrow_count == 1:
				spawned_arrow.rotation = mouse_direction.angle()
			else:
				var arc_rad = deg_to_rad(shot_range + ((shot_range * arrow_count)/arrow_count))
				var increment = arc_rad / (arrow_count - 1)
				spawned_arrow.global_rotation = (
					mouse_direction.angle() +
					increment * i -
					arc_rad / 2
				)
			##################################################
			# Strategy Relevant Code:
			# Here, we loop over all of the upgrades currently
			# on the player, and apply their upgrade to the
			# spawned axe.
			##################################################
			#for strategy in player.upgrades:
				#strategy.apply_upgrade(spawned_arrow)
			get_tree().root.call_deferred("add_child",spawned_arrow)
		await get_tree().create_timer(bow_rate).timeout
		can_shot = true
	
