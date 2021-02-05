extends RigidBody2D

func _integrate_forces(state : Physics2DDirectBodyState) -> void:
	self.rotation_degree = 0
