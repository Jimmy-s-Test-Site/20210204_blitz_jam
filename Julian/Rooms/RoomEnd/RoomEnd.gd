extends Room

var total_points = 0

func exit(door : Area2D) -> void:
	.exit(door)
	
	if self.total_points > 0:
		self.emit_signal("goto_ending", ENDING_SCENES.ACCEPTED)
	else:
		self.emit_signal("goto_ending", ENDING_SCENES.RESET)
