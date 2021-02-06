extends RigidBody2D

func _integrate_forces(state : Physics2DDirectBodyState) -> void:
	# no rotation on rigid body
	self.rotation_degree = 0
