extends Sprite


export (int) var Health :=3 
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_MannequinArea_body_entered(body):
	var bodyIsPlayer = body.name == "Player"				#if Player enters MannequinArea then bodyIsPlayer is true
	var bodyIsDrone = body.name.begins_with("Drone")		#if Drone enters MannequinArea then bodyIsDrone is true
	var bodyIsProjectile = body.name == "Projectile"		#if Projectile enters MannequinArea then bodyIsProjectile is true

	if bodyIsPlayer:	#if bodyIsPlayer is true -> get 5 points and make mannequin disappear
		#points+5
		queue_free() 
	elif bodyIsDrone or bodyIsProjectile:	#if bodyIsDrone/Projetile is true -> make mannequin disappear
		queue_free()
