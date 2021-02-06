extends KinematicBody2D

var direction = Vector2.ZERO #direction set to 0
export (int) var speed := 2000 #speed of bullet

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_slide(direction * speed * delta)
	self.rotate(deg2rad(2)) #rotate at 2 radians
