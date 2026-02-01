extends Node2D

@export var timeline: String
# Called when the node enters the scene tree for the first time.

func catch_mask():
	Dialogic.start(timeline)
