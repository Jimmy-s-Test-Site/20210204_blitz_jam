extends Node2D

const room := preload("res://Julian/Rooms/Rooms.gd")

export(float) var fade_time

func _ready():
	self.load_room(room.Names.Room0)

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
			
			node.queue_free()

func add_room(room_name : int):
	var room_scene = load(room.Scenes[room_name]).instance()
	
	if not room_scene.is_connected("goto_room", self, "load_room"):
		room_scene.connect("goto_room", self, "load_room")
	
	self.add_child(room_scene)
