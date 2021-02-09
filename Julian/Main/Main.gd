extends Node2D

const room := preload("res://Julian/Rooms/Rooms.gd")

enum ENDING_SCENES {
	ACCEPTED,
	RESET,
	JOIN,
	RECYCLING
}

enum PLAY_OPTIONS {
	START,
	GAME,
	ENDING
}

var PLAY_SCENES = {
	PLAY_OPTIONS.START  : "res://Julian/Start/Start.tscn",
	PLAY_OPTIONS.GAME   : "res://Julian/Game/Game.tscn",
	PLAY_OPTIONS.ENDING : "res://Julian/Ending/EndingPlayer.tscn"
}

var playing = self.PLAY_OPTIONS.START

func _ready():
	self.play(self.playing)

func play(option : int, ending : int = -1):
	for child in self.get_children():
		if child.is_connected("pressed_enter", self, "on_scene_pressed_enter"):
			child.disconnect("pressed_enter", self, "on_scene_pressed_enter")
		
		child.queue_free()
	
	self.playing = option
	
	var scene : Object = load(PLAY_SCENES[option]).instance()
	if not scene.is_connected("pressed_enter", self, "on_scene_pressed_enter"):
		scene.connect("pressed_enter", self, "on_scene_pressed_enter")
	
	self.add_child(scene)
	
	match self.playing:
		PLAY_OPTIONS.ENDING:
			if ending != -1:
				scene.play(ending)

func on_scene_pressed_enter(total_score = 0, goto_ending = -1):
	match self.playing:
		PLAY_OPTIONS.START:
			self.play(PLAY_OPTIONS.GAME)
		PLAY_OPTIONS.GAME:
			self.play(PLAY_OPTIONS.ENDING, goto_ending)
		PLAY_OPTIONS.ENDING:
			for child in self.get_children():
				if child.playing == ENDING_SCENES.RESET:
					self.play(PLAY_OPTIONS.GAME)
