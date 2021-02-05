extends KinematicBody2D

export (int) var speed = 200

var target = Vector2()
var velocity = Vector2()
# Declare member variables here, movement actions
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('left'):
		velocity.x += 1
	if Input.is_action_pressed('right'):
		velocity.x -= 1
#	if Input.is_action_pressed('jump'):
#		velocity.x += 1
	
	velocity = velocity.normalized() * speed
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
