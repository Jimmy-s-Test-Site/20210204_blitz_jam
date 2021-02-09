extends Node2D
class_name Room

signal goto_room
signal add_points
signal goto_ending

const room := preload("res://Julian/Rooms/Rooms.gd")

enum SCENES {
	ACCEPTED,
	RESET,
	JOIN,
	RECYCLING
}

export(NodePath) var door_container_path

func _ready() -> void:
	var door_container : Node2D = self.get_node(self.door_container_path)
	
	for door in door_container.get_children():
		self.on_Door_body_entered(door)

func on_Door_body_entered(door : Area2D) -> void:
	yield(door, "body_entered")
	self.exit(door)

func exit(door : Area2D) -> void:
	self.emit_signal("add_points", door.points)
	self.emit_signal("goto_room", door.destination)
