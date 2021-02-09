extends KinematicBody2D
###will need to set ProjectileContainer to empty 2DNODE in (PARENT) Node...aka Room
enum BEHAVIOURS {good, bad, neutral}
enum MOVEMENT {stationary, path, chase}

export (Curve2D) var DronePath						#The # and location of each Stop on Path
export (int) var DroneSpeed := 50 					#drone movement speed
var move_direction = 0 								#movement facing direction in radians
export (float) var BulletDelay := 0.7 				#delay before next bullet fires
export (PackedScene) var Projectile 				#droppable container for projectile scene
export (NodePath) var ProjectileContainer			#The NODEPATH to the Projectile Container
export (NodePath) var PlayerNodePath				##The NODEPATH to the Player Container
export (int) var Energy := 2 						#drone Energy/HP
export (Vector2) var ShootingAt := Vector2(-1,-1)#was -1 0    #what it's target is. Player/Mannequin/free shooting
export (BEHAVIOURS) var Hostility = BEHAVIOURS.good	#Tells if drone is good/bad/neutral
export (MOVEMENT) var Move_Type = MOVEMENT.stationary #Tells type of movement statiionary/path/chase

var target 											#Target to shoot

onready var EnemyToPlayer = self.global_position
onready var MoveToPlayer = self.global_position

onready var shoot_Timer = $bullet_Timer 			#A timer node called bullet_Timer
onready var path_follow = get_parent()				#Variable to follow Path2D

###FOR MOVE PATH-make new Path2D node and then a child node of PathFollow2D. 'Enemy' as child of PathFollow2D.
###In Path2D add 'curve' on right side side then click small buttons in middle at top to draw path. 'close path'
###In Path2D make sure 'rotate' is off & 'rotation' is set to 0.

func _ready():
	shoot_Timer.start(BulletDelay) #start bullet timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match Move_Type:
		MOVEMENT.chase:
			EnemyToPlayer = self.global_position - self.get_node(PlayerNodePath).global_position
			position += (DroneSpeed*.5) * ShootingAt * delta * EnemyToPlayer
		MOVEMENT.path:
			MovementLoop(delta) #call movement loop every frame
		MOVEMENT.stationary:	
			pass

func _process(delta):
#	if self.get_node(PlayerNodePath).global_position != null:
	EnemyToPlayer = self.global_position - self.get_node(PlayerNodePath).global_position
	
func MovementLoop(delta): #move along the PathFollow2D 
	var prepos = path_follow.get_global_position()
	path_follow.set_offset(path_follow.get_offset() + DroneSpeed + delta)
	var pos = path_follow.get_global_position()
	move_direction = (pos.angle_to_point(prepos) / 3.14)*180  #if need to turn the drone facing direction
	
func shoot(): #Method to create an instanced projectile and shoot it a direction
	print ("SHOOTING!")#############################
	var new_bullet = Projectile.instance()
	var DirectionToPlayer = EnemyToPlayer.normalized() #direction bw player and enemy
	new_bullet.global_position = 	self.global_position + DirectionToPlayer * $SpawnRadius.position.length() * -1
	new_bullet.name = "Projectile"
	new_bullet.direction = self.ShootingAt
	new_bullet.DroneOwner = self
	get_node(ProjectileContainer).add_child(new_bullet)

func _on_bullet_Timer_timeout():#on timeout - shoot and restart timer
	if target is PhysicsBody2D and target != null:
		shoot()
	
func _on_DroneVision_body_entered(body):
	var bodyIsPlayer = body.name == "Player"
	var bodyIsDrone = body.name.begins_with("Drone")
	var bodyIsGoodDrone = bodyIsDrone and body.Hostility == BEHAVIOURS.good
	var bodyIsBadDrone = bodyIsDrone and body.Hostility == BEHAVIOURS.bad
	var bodyIsNeutralDrone = bodyIsDrone and body.Hostility == BEHAVIOURS.neutral

	match Hostility:
		BEHAVIOURS.bad:
			if bodyIsPlayer or bodyIsGoodDrone:
				target = body
				Move_Type = MOVEMENT.chase
				
		BEHAVIOURS.good:
			if bodyIsBadDrone:
				target = body	

func _on_DroneVision_body_exited(body):
	if target != null:
		if target.name == body.name:
			target = null

func _on_DroneCollider_body_entered(body):
	var bodyIsPlayer = body.name == "Player"
	var bodyIsBullet = body.name.begins_with("PlayerShooting") or body.name.begins_with("Projectile")

	if bodyIsPlayer:
		print("Drone -> Player")
		pass #GO TO GAMEOVER
	elif bodyIsBullet:
		print("DRONE HIT")
		queue_free()
