extends KinematicBody2D

#export (Array, PackedScene) var rooms : Array
export (int) var speed := 500 #drone movement speed
export (float) var bulletDelay := 0.7 #delay before next bullet fires
export (PackedScene) var projectile #droppable container for projectile scene
export (NodePath) var ProjectileContainer
onready var shoot_Timer = $bullet_Timer #A timer node called bullet_Timer
export (int) var energy := 3 #drone energy level
export (Vector2) var shootingAt := Vector2(-1,0)  #what it's target is. Player/Mannequin/free shooting


func _ready():
	shoot_Timer.start(bulletDelay) #start bullet timer
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func shoot():
	var bullet_directions = shootingAt
	var new_bullet = projectile.instance()
	new_bullet.global_position = self.global_position + $SpawnRadius.position.length() * shootingAt
	new_bullet.name = "Projectile"
	new_bullet.direction = self.shootingAt
	get_node(ProjectileContainer).add_child(new_bullet)
	

func _on_Drone_tree_entered(): #if drone is touched then damage player
	print ("Drone Touched")
#	player.receive_damage_manger():

func _on_bullet_Timer_timeout():#on timeout shoot and restart timer
	shoot()
	shoot_Timer.start(bulletDelay)
