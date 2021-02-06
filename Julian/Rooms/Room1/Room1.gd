extends Node2D

signal goto_room

const room = preload("res://Julian/Rooms/Rooms.gd")
const room_scenes = room.SceneLocations
const room_names = room.Names

export (room.Names) var exit_a

func _ready():
	print(room_scenes[room_names.Room0])

func goto_room_0():
	self.emit_signal("goto_room", self.room_names.Room0)


func _on_DoorA_body_entered(body):
	pass # Replace with function body.
