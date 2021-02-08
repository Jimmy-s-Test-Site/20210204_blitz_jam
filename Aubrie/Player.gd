extends KinematicBody2D

#const speed =175
#const gravity = 10
#const jump = -300
const Floor = Vector2(0, -1)
const Shoot = preload("res://Aubrie/Player Shooting.tscn")
#Added for pickup
#const PickUp = preload ("res://Aubrie/Bag.tscn")

export (int) var speed = 175
export (int) var gravity = 10
export (int) var jump = -300
export (NodePath) var BulletContainerPath
#export (NodePath) var BagPickDrop

var velocity = Vector2()
var on_ground = false
var is_attacking = false
#var BagPickup = null
#var BagDrop = null

#func _ready():
#	$AnimatedSprite.play("Run")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("right"): 
		velocity.x = speed
		$AnimatedSprite.play("Run")
		$AnimatedSprite2.play("Run")
#		$AnimatedSprite.flip_h = false
#		if sign($Position2D.position.x) == -1:
#			$Position2D.position.x *= -1
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
		$AnimatedSprite.play("Run")
		$AnimatedSprite2.play("Run")
#		$AnimatedSprite.flip_h = true
#		if sign($Position2D.position.x) == 1:
#			$Position2D.position.x *= -1
	else:
		velocity.x =0 
		if on_ground == true:
			$AnimatedSprite.play("Idle")	
			$AnimatedSprite2.play("Idle")
			
	match int(sign(get_local_mouse_position().x)):
		-1:
			$AnimatedSprite.flip_h = true
			$AnimatedSprite2.flip_h = true
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
		1:
			$AnimatedSprite.flip_h = false
			$AnimatedSprite2.flip_h = false
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
				
		
	if Input.is_action_just_pressed("jump"):
		if on_ground == true:
			velocity.y = jump
			on_ground = false
			
	if Input.is_action_just_pressed("shoot"):
		var bullet = Shoot.instance()
		if sign($Position2D.position.x) == 1:
			print (true)
			bullet.set_shooting_direction(1)
		else:
			bullet.set_shooting_direction(-1)
			print(false)
		bullet.global_position = self.global_position
		bullet.velocity = get_local_mouse_position().normalized()
		get_node(BulletContainerPath).add_child(bullet)
		bullet.position = $Position2D.global_position
		$AnimatedSprite.play("Shoot")
		$AnimatedSprite2.play("Shoot")
	
	#Added 
#	if Input.is_action_pressed ("pickup"):
#		if self.BagPickup != null:
#			self.BagPickup = null
#		else:
#			for i in get_slide_count():
#				var collision = get_slide_collision(i)
#				if collision.collider.name.begins_with("Bag"):
#					self.BagPickup = collision.collider
#				self.BagPickup
#

#		if self.BagDrop != null:
#			self.BagDrop = null
#		else:
#			for i in get_slide_count():
#				var collision = get_slide_collision(i)
#				if collision.collider.name.begins_with("Bag"):
#					self.BagDrop = collision.collider
#			self.BagDrop
#
		
	velocity.y += gravity
	#on_ground = is_on_floor()
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
		if velocity.y < 0:
			$AnimatedSprite.play("Jump")
			$AnimatedSprite2.play("Jump")
		else:
			$AnimatedSprite.play("Fall")
			$AnimatedSprite2.play("Fall")
	velocity = move_and_slide(velocity, Floor)
	

	

	
	



