extends Sprite2D

@onready var mask_ui: Sprite2D = $"."

func _ready() -> void:
	mask_ui.frame = 1
		
func toggle(masked: bool):
	if masked:
		mask_ui.frame = 1
	else:
		mask_ui.frame = 0
