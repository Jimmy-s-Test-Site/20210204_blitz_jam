extends KinematicBody2D
###will need to set ProjectileContainer to empty 2DNODE in (PARENT) Node...aka Room
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
export (NodePath) var PlayerNodePath
var target 

onready var EnemyToPlayer = self.global_position#####################
#		var self_position_to_player = self.global_position - self.Player.global_position
#onready var EnemyToPlayer = self.global_position - self.get_node(PlayerNodePath).global_position
onready var shoot_Timer = $bullet_Timer 			#A timer node called bullet_Timer
onready var path_follow = get_parent()#Variable to follow Path2D

###FOR MOVE PATH-make new Path2D node and then a child node of PathFollow2D. 'Enemy' as child of PathFollow2D.
###In Path2D add 'curve' on right side side then click small buttons in middle at top to draw path. 'close path'

func _ready():
	#shoot()
	shoot_Timer.start(BulletDelay) #start bullet timer
#		$DroneVision/RayCast2D.add_collision_exception(self) #add exception for if raycast collides wih self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	MovementLoop(delta) #call movement loop every frame
	
func _process(delta):
#	if self.get_node(PlayerNodePath).global_position != null:
	EnemyToPlayer = self.global_position - self.get_node(PlayerNodePath).global_position
	
func MovementLoop(delta): #move along the PathFollow2D 
	var prepos = path_follow.get_global_position()
	path_follow.set_offset(path_follow.get_offset() + DroneSpeed + delta)
	var pos = path_follow.get_global_position()
	move_direction = (pos.angle_to_point(prepos) / 3.14)*180  #if you need to turn the drone
	
func shoot(): #Method to create an instanced projectile and shoot it a direction
#	if BEHAVIOURS.bad:
#		if $Player.position <
	print ("SHOOTING!")#############################
	var new_bullet = Projectile.instance()
	var spawnRadius = $SpawnRadius.position * $SpawnRadius.global_scale
	print(target)
	var droneToTarget = (target.global_position - self.global_position).normalized() #gives direction only
	print(spawnRadius)
	new_bullet.position = self.position + droneToTarget * spawnRadius.length()
	new_bullet.name = "Projectile"
	new_bullet.direction = self.ShootingAt
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
		BEHAVIOURS.good:
			if bodyIsBadDrone:
				target = body	

func _on_DroneVision_body_exited(body):
	if target != null:
		if target.name == body.name:
			target = null