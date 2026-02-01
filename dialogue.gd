extends Node2D

# Called when the node enters the scene tree for the first time.
func tutorial():
	Dialogic.start("tutorial_timeline")
func catch_mask():
	Dialogic.start("first_room_timeline")	
func catch_key():
	Dialogic.start("key_timeline")
