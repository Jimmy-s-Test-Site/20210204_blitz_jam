extends Control

signal pressed_enter

func _input(event):
	if event.is_action_pressed("continue"):
		self.emit_signal("pressed_enter")

func _on_Button_pressed():
	self.emit_signal("pressed_enter")
