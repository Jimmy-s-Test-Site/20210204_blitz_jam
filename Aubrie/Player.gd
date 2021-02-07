extends KinematicBody2D

const speed =175
const gravity = 10
const jump = -300
const Floor = Vector2(0, -1)
const Shoot = preload("res://Aubrie/Player Shooting.tscn")

export (NodePath) var BulletContainerPath

var velocity = Vector2()
var on_ground = false

func _ready():
	$AnimationPlayer.play("IdleRight")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("left"): 
		velocity.x = -speed 
	elif Input.is_action_pressed("right"):
		velocity.x = speed
	else:
		velocity.x =0 
			
	if Input.is_action_just_pressed("jump"):
		if on_ground == true:
			velocity.y = jump
			on_ground = false
			
	if Input.is_action_just_pressed("shoot"):
		var bullet = Shoot.instance()
		bullet.global_position = self.global_position
		bullet.velocity = get_local_mouse_position().normalized()
		get_node(BulletContainerPath).add_child(bullet)
		bullet.position = $Position2D.global_position
		
	on_ground = is_on_floor()
		
	velocity.y += gravity
	velocity = move_and_slide(velocity, Floor)
	
	match int(sign(get_local_mouse_position().x)):
		-1:
			$AnimationPlayer.play("IdleLeft")
			pass
		1:
			$AnimationPlayer.play("IdleRight")
			pass



	
	


