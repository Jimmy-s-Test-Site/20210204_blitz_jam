extends KinematicBody2D

var direction = Vector2.ZERO #direction set to 0
export (int) var speed := 20 #speed of bullet

var DroneOwner: KinematicBody2D

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	self.rotate(deg2rad(2)) #rotate at 2 radians
	if collision:
		if !collision.collider.name.begins_with("Projectile") or collision.collider.name==DroneOwner.name:
			queue_free()

