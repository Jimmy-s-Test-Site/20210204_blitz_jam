extends Node2D
class_name Room

signal goto_room

const room := preload("res://Julian/Rooms/Rooms.gd")
const room_scenes := room.SceneLocations
const room_names := room.Names

export (room.Names) var exit_a : int

func exit(exit_name : int) -> void:
	self.emit_signal("goto_room", exit_name)
