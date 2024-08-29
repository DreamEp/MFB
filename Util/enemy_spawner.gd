extends Node2D
class_name EnemySpawner

@export var spawns : Array[SpawnInfo] = []
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var gameTimer: Label = get_tree().get_first_node_in_group("hud").get_node("GameTimer")
@onready var tileMap: TileMap = $"../TileMap"

var time = 0.1
@export var pass_time = 0

func retrieve_spawnable_tile():
	var vpr = get_viewport_rect().size * randf_range(1.05, 1.40)
	var top_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
	var top_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y - vpr.y/2)
	var bottom_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)
	
	var pos_side = ["up", "down", "right", "left"].pick_random() 
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
	
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	
	# Ensure the returned vector is also within the specified range
	var start_x = max(-24*16, player.global_position.x - vpr.x/2)
	var end_x = min(23*16, player.global_position.x + vpr.x/2)
	var start_y = max(-15*16, player.global_position.y - vpr.y/2)
	var end_y = min(17*16, player.global_position.y + vpr.y/2)
	
	x_spawn = max(min(x_spawn, end_x), start_x)
	y_spawn = max(min(y_spawn, end_y), start_y)
	
	return Vector2(x_spawn, y_spawn)

				
func _physics_process(delta):
	pass_time += delta
	change_time()
	#print("time : %s, pass_time : %s" % [time, pass_time])
	
func _ready():
	_on_timer_timeout()
	
func _on_timer_timeout():
	time += 1
	var enemy_spawns = spawns
	for i in enemy_spawns:
		if time >= i.time_start and time <= i.time_end + 1: 
			if i.spawn_delay_counter <= i.enemy_spawn_delay: 
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter = 0.1 
				var new_enemy = i.enemy_type 
				var counter = 0
				while counter < i.enemy_num: 
					#var enemy_spawn: EnemyRes = new_enemy.instantiate() 
					var spawn_pos = retrieve_spawnable_tile() #get_random_position() 
					new_enemy.instantiate_enemy(self, spawn_pos)

					#add_child(enemy_spawn) 
					counter += 1 

func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(1.05, 1.40)
	var top_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
	var top_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y - vpr.y/2)
	var bottom_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)
	
	var pos_side = ["up", "down", "right", "left"].pick_random() 
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
	
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	
	return Vector2(x_spawn, y_spawn)


func change_time():
	time = int(pass_time)
	var m = int(time / 60.0)
	var s = time % 60
	if m < 10:
		m = str(0, m)
	if s < 10:
		s = str(0, s)
	gameTimer.text = str(m, ":", s)
