extends Node

enum Names {
	Room0,
	Room1
}

const SceneLocations = {
	Names.Room0: "res://Julian/Rooms/Room0/Room0.tscn",
	Names.Room1: "res://Julian/Rooms/Room1/Room1.tscn"
}

var Scenes = {
	Names.Room0: load(SceneLocations[Names.Room0]),
	Names.Room1: load(SceneLocations[Names.Room1])
}
