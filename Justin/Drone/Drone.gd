extends KinematicBody2D

#export (Array, PackedScene) var rooms : Array
export (Array, Vector2) var DronePath# := Vector2()	#The # and location of each Stop on Path
#export (Array,Transform) var dronePath[NumberDronePaths] : Vector2
export (int) var Speed := 500 						#drone movement speed
export (float) var BulletDelay := 0.7 				#delay before next bullet fires
export (PackedScene) var Projectile 				#droppable container for projectile scene
export (NodePath) var ProjectileContainer
export (int) var Energy := 3 						#drone energy level
export (Vector2) var ShootingAt := Vector2(-1,0)    #what it's target is. Player/Mannequin/free shooting

onready var shoot_Timer = $bullet_Timer #A timer node called bullet_Timer

func _ready():
	shoot_Timer.start(BulletDelay) #start bullet timer
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func shoot():
	var bullet_directions = ShootingAt
	var new_bullet = Projectile.instance()
	new_bullet.global_position = self.global_position + $SpawnRadius.position.length() * ShootingAt
	new_bullet.name = "Projectile"
	new_bullet.direction = self.ShootingAt
	#get_node(ProjectileContainer).add_child(new_bullet)
	$ProjectileContainer.add_child(new_bullet)

func _on_Drone_tree_entered(): #if drone is touched then damage player
	print ("Drone Touched")
#	player.receive_damage_manger():

func _on_bullet_Timer_timeout():#on timeout shoot and restart timer
	shoot()
	shoot_Timer.start(BulletDelay)
