extends Node2D
class_name Room

signal goto_room

const room := preload("res://Julian/Rooms/Rooms.gd")

export (Array, NodePath) var door_paths

func _ready() -> void:
	for door_path in self.door_paths:
		var door : Area2D = self.get_node(door_path)
		self.on_Door_body_entered(door)

func on_Door_body_entered(door : Area2D) -> void:
	yield(door, "body_entered")
	self.exit(door)

func exit(door : Area2D) -> void:
	self.emit_signal("goto_room", door.destination)
