extends Area2D


const Speed = 100 
var velocity = Vector2()
var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_shooting_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
#	velocity.x = Speed * delta
#	translate(velocity)
	self.rotate(deg2rad(8)) #rotate at 2 radians
	position += velocity * Speed * delta #* direction
	$AnimatedSprite.play("Shoot")
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Player_Shooting_body_entered(body):
	queue_free()
