extends Node2D

signal pressed_enter

const room := preload("res://Julian/Rooms/Rooms.gd")

enum ENDING_SCENES {
	ACCEPTED,
	RESET,
	JOIN,
	RECYCLING
}

export(float) var fade_time

var total_points : int = 0

func _ready():
	self.load_room(self.room.Names.Room0)

func load_room(room_name : int):
	$CanvasLayer/AnimationPlayer.play("fade_in")
	yield($CanvasLayer/AnimationPlayer, "animation_finished")
	
	self.remove_all_rooms()
	
	yield(self.get_tree().create_timer(self.fade_time), "timeout")
	
	self.add_room(room_name)
	
	$CanvasLayer/AnimationPlayer.play("fade_out")
	yield($CanvasLayer/AnimationPlayer, "animation_finished")

func remove_all_rooms():
	for node in self.get_children():
		if node is Room:
			if node.is_connected("goto_room", self, "load_room"):
				node.disconnect("goto_room", self, "load_room")
			
			if node.is_connected("add_points", self, "add_points"):
				node.disconnect("add_points", self, "add_points")
			
			node.queue_free()

func add_room(room_name : int):
	var room_scene = load(room.Scenes[room_name]).instance()
	
	if not room_scene.is_connected("goto_room", self, "load_room"):
		room_scene.connect("goto_room", self, "load_room")
	
	if not room_scene.is_connected("goto_ending", self, "goto_ending"):
		room_scene.connect("goto_ending", self, "goto_ending")
	
	if not room_scene.is_connected("add_points", self, "add_points"):
		room_scene.connect("add_points", self, "add_points")
	
	if room_name == self.room.Names.RoomEnd:
		room_scene.total_points = self.total_points
	
	self.add_child(room_scene)

func add_points(points : int):
	self.total_points += points

func goto_ending(ending):
	self.emit_signal("pressed_enter", self.total_points, ending)
