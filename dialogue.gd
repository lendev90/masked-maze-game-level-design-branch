extends Node2D

@export var timeline: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.start("first_room_timeline")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
