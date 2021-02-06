extends Node2D

const room := preload("res://Julian/Rooms/Rooms.gd")

func _ready():
	self.load_room(room.Names.Room0)

func load_room(room_name : int):
	self.remove_all_rooms()
	self.add_room(room_name)

func remove_all_rooms():
	for node in self.get_children():
		if node is Room:
			node.queue_free()

func add_room(room_name : int):
	var room_scene = load(room.Scenes[room_name]).instance()
	
	if not room_scene.is_connected("goto_room", self, "load_room"):
		room_scene.connect("goto_room", self, "load_room")
	
	self.add_child(room_scene)
