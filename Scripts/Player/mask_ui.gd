extends Sprite2D

@onready var mask_ui: Sprite2D = $"."
	
func toggle(masked: bool):
	if masked:
		mask_ui.frame = 1
	else:
		mask_ui.frame = 0
