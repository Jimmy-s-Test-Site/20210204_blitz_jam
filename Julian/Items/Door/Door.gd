extends Area2D

const room := preload("res://Julian/Rooms/Rooms.gd")

enum ENDING_SCENES {
	ACCEPTED,
	RESET,
	JOIN,
	RECYCLING
}

export(room.Names) var destination
export(bool) var uses_ending = false
export(ENDING_SCENES) var ending_destination
export(int) var points
