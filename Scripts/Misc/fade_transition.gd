extends ColorRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var opening: bool = false
@export var fade_finished: Signal = Signal()

func _ready() -> void:
	if opening:
		play_fade(true)

func play_fade(open: bool):
	print("Playing fade: ", open)
	print("Animation Player: ", animation_player)
	if open:
		animation_player.play("fade_out")
	else:
		animation_player.play("fade_in")
	
