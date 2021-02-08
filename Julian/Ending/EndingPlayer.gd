extends Node2D

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
		child.queue_free()
	
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
	
	self.add_child(scene.instance())
