extends ColorRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var opening: bool = false
@export var fade_finished: Signal = Signal()

func _ready() -> void:
	if opening:
		show()
		play_fade("fade_out")

func play_fade(fade_state: String):
	animation_player.play(fade_state)
	
