extends Node

##########################################################
# This is the player's movement controller.
# Instead of placing all of the movement stuff inside
# of the player, we move the code to a separate component
##########################################################

@onready var player : Player = get_owner()
#@onready var sprite2DPlayer : Sprite2D = get_node("%Sprite2D")
#@onready var WalkTimer : Timer = get_node("%WalkTimer")
@onready var animatedSprite2DPlayer : AnimatedSprite2D = $"../AnimatedSprite2D"

func _physics_process(_delta):
	var velocity = player.velocity
	var x_move = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_move = Input.get_action_strength("down") - Input.get_action_strength("up") #Attention le mouvement sur l'axe y est inversé sur Godot donc bien faire down - up !
	var move = Vector2(x_move, y_move) #Définit le vector du mouvement en interpretant x, et y (direction) 
	
	#Ici on comare la position X du vector, si elle est positif on va a droite, et on flip alors notre personnage vers la bonne direction
	if move.x < 0:
		#sprite2DPlayer.flip_h = true
		animatedSprite2DPlayer.flip_h = true
	#Sinon on ne le flip pas si on va a gauche
	elif move.x > 0:
		#sprite2DPlayer.flip_h = false
		animatedSprite2DPlayer.flip_h = false
	
	if move != Vector2.ZERO: #On verifie si on bouge ou non
		animatedSprite2DPlayer.play("walk")
	else:
		animatedSprite2DPlayer.play("idle")
	# Reassign velocity and move the player
	velocity = move.normalized() * player.movement_speed #Définit la physique du mouvement, la vitesse etc | Normalized permet de se déplacer de la meme vitesse en diagonale sinon on serait plus rapide
	player.velocity = velocity
	player.move_and_slide() 
