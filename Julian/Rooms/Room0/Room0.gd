extends Room

#signal goto_room
#
#const room := preload("res://Julian/Rooms/Rooms.gd")
#const room_scenes := room.SceneLocations
#const room_names := room.Names
#
#export (room.Names) var exit_a : int
#
#func _ready() -> void:
#	print(room_scenes[room_names.Room0])
#
#func exit(exit_name : int) -> void:
#	self.emit_signal("goto_room", exit_name)
#
#func _on_DoorA_body_entered(body : Node) -> void:
#	print(self.exit_a)
#	self.exit(self.exit_a)
