extends Node

##########################################################
# This is the player's movement controller.
# Instead of placing all of the movement stuff inside
# of the player, we move the code to a separate component
##########################################################

@onready var player : Player = get_owner()
@onready var sprite2Dplayer : Sprite2D = get_node("%Sprite2D")
@onready var WalkTimer : Timer = get_node("%WalkTimer")


func _physics_process(_delta):
	var velocity = player.velocity
	var x_move = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_move = Input.get_action_strength("down") - Input.get_action_strength("up") #Attention le mouvement sur l'axe y est inversé sur Godot donc bien faire down - up !
	var move = Vector2(x_move, y_move) #Définit le vector du mouvement en interpretant x, et y (direction) 
	
	#Ici on comare la position X du vector, si elle est positif on va a droite, et on flip alors notre personnage vers la bonne direction
	if move.x < 0:
		sprite2Dplayer.flip_h = true
	#Sinon on ne le flip pas si on va a gauche
	elif move.x > 0:
		sprite2Dplayer.flip_h = false
	
	#Ici on fait l'annimation de la marche en jouant sur les frames (2)	
	if move != Vector2.ZERO: #On verifie si on bouge ou non
		if WalkTimer.is_stopped(): #Si le WalkTimer est arreté
			if sprite2Dplayer.frame >= sprite2Dplayer.hframes - 1: #Frame start to 0 and hframe at 2 that's why we set -1
				sprite2Dplayer.frame = 0 #It reset it to 0
			else: 
				sprite2Dplayer.frame += 1 #It increase the frame by 1
			WalkTimer.start()
	# Reassign velocity and move the player
	
	velocity = move.normalized()*player.movement_speed #Définit la physique du mouvement, la vitesse etc | Normalized permet de se déplacer de la meme vitesse en diagonale sinon on serait plus rapide
	player.velocity = velocity
	player.move_and_slide() 
