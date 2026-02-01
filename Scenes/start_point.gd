extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !GlobalVariables.cut1_played:
		Dialogue.tutorial()
		GlobalVariables.cut1_played = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
