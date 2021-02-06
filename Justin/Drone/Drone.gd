extends KinematicBody2D
##will need to set ProjectileContainer to empty 2DNODE in Room Node
enum BEHAVIOURS {good, bad, neutral}

export (Curve2D) var DronePath						#The # and location of each Stop on Path
export (int) var DroneSpeed := 500 					#drone movement speed
var move_direction = 0 								#movement direction
export (float) var BulletDelay := 0.7 				#delay before next bullet fires
export (PackedScene) var Projectile 				#droppable container for projectile scene
export (NodePath) var ProjectileContainer# = get_parent().get_node("ProjectileContainer")#The NODEPATH to the Projectile Container
export (int) var Energy := 2 						#drone Energy/HP
export (Vector2) var ShootingAt := Vector2(-1,0)    #what it's target is. Player/Mannequin/free shooting
export (BEHAVIOURS) var Hostility = BEHAVIOURS.good	#Tells if drone is good/bad/neutral

#Path2D    Curve2D

onready var shoot_Timer = $bullet_Timer 			#A timer node called bullet_Timer
onready var path_follow = get_parent()#Variable to follow Path2D


func _ready():
	shoot_Timer.start(BulletDelay) #start bullet timer
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	MovementLoop(delta) #call movement loop every frame

func MovementLoop(delta): #move along the PathFollow2D 
	var prepos = path_follow.get_global_position()
	path_follow.set_offset(path_follow.get_offset() + DroneSpeed + delta)
	var pos = path_follow.get_global_position()
	move_direction = (pos.angle_to_point(prepos) / 3.14)*180  #if you need to turn the drone
	
func shoot():
	var new_bullet = Projectile.instance()
	new_bullet.global_position = self.global_position + $SpawnRadius.position.length() * ShootingAt
	new_bullet.name = "Projectile"
	new_bullet.direction = self.ShootingAt
	get_node(ProjectileContainer).add_child(new_bullet)
	#$ProjectileContainer.add_child(new_bullet)

func _on_Drone_tree_entered(): #if drone is touched then damage player
	print ("Drone Touched")
#	player.receive_damage_manger():

func _on_bullet_Timer_timeout():#on timeout shoot and restart timer
	shoot()
	shoot_Timer.start(BulletDelay)
