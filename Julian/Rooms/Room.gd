extends Node2D
class_name Room

signal goto_room

const room := preload("res://Julian/Rooms/Rooms.gd")

export (Array, NodePath) var exits

func _ready() -> void:
	for exit in self.exits:
		var exit_scene : Area2D = self.get_node(exit)
		
		self.on_Door_body_entered(exit_scene)
		#if not exit_scene.is_connected("body_entered", self, "on_Door_body_entered"):
		#	exit_scene.connect("body_entered", self, "on_Door_body_entered")

func on_Door_body_entered(exit_scene : Area2D) -> void:
	yield(exit_scene, "body_entered")
	self.exit(exit_scene.destination)

func exit(exit_name : int) -> void:
	self.emit_signal("goto_room", exit_name)


