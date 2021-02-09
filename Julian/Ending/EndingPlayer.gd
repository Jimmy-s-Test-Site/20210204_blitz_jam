extends Node2D

signal pressed_enter

enum SCENES {
	ACCEPTED,
	RESET,
	JOIN,
	RECYCLING
}

export(PackedScene) var accepted
export(PackedScene) var reset
export(PackedScene) var join
export(PackedScene) var recycling

export(SCENES) var playing

func _ready():
	self.play(self.playing)

func play(option):
	for child in self.get_children():
		if child.is_connected("pressed_enter", self, "on_ending_pressed_enter"):
			child.disconnect("pressed_enter", self, "on_ending_pressed_enter")
		
		child.queue_free()
	
	self.playing = option
	
	var scene = null
	match option:
		SCENES.ACCEPTED:
			scene = self.accepted
		SCENES.RESET:
			scene = self.reset
		SCENES.JOIN:
			scene = self.join
		SCENES.RECYCLING:
			scene = self.recycling
	
	var scene_instance : Object = scene.instance()
	
	if not scene_instance.is_connected("pressed_enter", self, "on_ending_pressed_enter"):
		scene_instance.connect("pressed_enter", self, "on_ending_pressed_enter")
	
	self.add_child(scene_instance)

func on_ending_pressed_enter():
	self.emit_signal("pressed_enter")
