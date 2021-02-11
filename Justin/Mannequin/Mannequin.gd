extends Sprite

signal add_points

export(int) var Health := 3 
export(int) var points := 1

func _on_MannequinArea_body_entered(body):
	var bodyIsPlayer = body.name == "Player"						#if Player enters MannequinArea then bodyIsPlayer is true
	var bodyIsDrone = body.name.begins_with("Drone")				#if Drone enters MannequinArea then bodyIsDrone is true
	var bodyIsProjectile = body.name.begins_with("Projectile")		#if Projectile enters MannequinArea then bodyIsProjectile is true
	if bodyIsPlayer:	#if bodyIsPlayer is true -> get 5 points and make mannequin disappear
		self.emit_signal("add_points", self.points)
		queue_free() 
	elif bodyIsDrone or bodyIsProjectile:	#if bodyIsDrone/Projetile is true -> make mannequin disappear
		queue_free()

func _on_MannequinArea_area_entered(area):
	var areaIsProjectile = area.name.begins_with("PlayerShooting") or area.name.begins_with("@PlayerShooting")		#if Projectile enters MannequinArea then bodyIsProjectile is true
	if areaIsProjectile:	#if bodyIsDrone/Projectile is true -> make mannequin disappear
		queue_free()
