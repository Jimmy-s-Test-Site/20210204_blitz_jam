extends RigidBody2D

var is_on_floor = false
var floor_y

func _integrate_forces(state):
	self.rotation = 0
	if self.is_on_floor:
		self.position.y = self.floor_y

func _on_Block_body_entered(body):
	if not self.is_on_floor:
		self.is_on_floor = true
		self.floor_y = self.position.y
