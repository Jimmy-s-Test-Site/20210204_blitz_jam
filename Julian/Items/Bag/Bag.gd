extends RigidBody2D
#Added
var held = false
var velocity = Vector2()
var speed = 175

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("pickup"): 
		velocity.x = -speed 
		if held:
			return
		mode = RigidBody2D.MODE_STATIC
		held = true
	position += velocity * speed * delta 
	$bag.play("pickup")
	
func drop(impulse=Vector2.ZERO):
	if Input.is_action_pressed("drop"): 
		velocity.x = -speed 
		if held: 
			mode = RigidBody2D.MODE_RIGID
			apply_central_impulse(impulse)
			held = false
