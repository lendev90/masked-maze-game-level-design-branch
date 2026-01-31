extends Node2D

@export var main_menu_scene: PackedScene
@onready var fade_transition: ColorRect = $FadeTransition

func _on_button_button_down() -> void:
	fade_transition.show()
	
	fade_transition.play_fade("fade_in")
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_packed(main_menu_scene)
