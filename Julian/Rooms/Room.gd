extends Node2D
class_name Room

signal goto_room
signal add_points
signal goto_ending

const room := preload("res://Julian/Rooms/Rooms.gd")

enum ENDING_SCENES {
	ACCEPTED,
	RESET,
	JOIN,
	RECYCLING
}

export(NodePath) var door_container_path
export(NodePath) var mannequin_container_path

func _ready() -> void:
	var door_container : Node2D = self.get_node(self.door_container_path)
	var mannequin_container : Node2D = self.get_node(self.mannequin_container_path)
	
	for door in door_container.get_children():
		self.on_Door_body_entered(door)
	
	for mannequin in mannequin_container.get_children():
		self.on_Mannequin_added_points(mannequin)

func on_Door_body_entered(door : Area2D) -> void:
	yield(door, "body_entered")
	self.exit(door)

func on_Mannequin_added_points(mannequin : Sprite):
	yield(mannequin, "add_points")
	
	self.emit_signal("add_points", mannequin.points)

func exit(door : Area2D) -> void:
	self.emit_signal("add_points", door.points)
	self.emit_signal("goto_room", door.destination)
	
	if door.uses_ending:
		self.emit_signal("goto_ending", door.ending_destination)
