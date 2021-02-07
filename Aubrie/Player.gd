extends KinematicBody2D

const speed =100
const gravity = 10
const jump = -200
const Floor = Vector2(0, -1)
export (NodePath) var ProjectileContainer = get_parent().get_node("ProjectileContainer")
var ShootingAt = Vector2.ZERO

var velocity = Vector2()
var on_ground = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("left"): 
		velocity.x = -speed 
	elif Input.is_action_pressed("right"):
		velocity.x = speed
	else:
		velocity.x =0 
	
	if Input.is_action_pressed("jump"):
		if on_ground == true:
			velocity.y = jump
			on_ground = false
#	if is_on_floor():
#		on_ground = true
#	else: 
#		on_ground = false
	on_ground = is_on_floor()
		
	velocity.y += gravity
	velocity = move_and_slide(velocity, Floor)


	
	



