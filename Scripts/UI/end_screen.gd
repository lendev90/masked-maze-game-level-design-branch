extends Node2D

@export var main_menu_scene: PackedScene
@export var fade_transition_scene: PackedScene

func _on_button_button_down() -> void:
	var fade_transition: ColorRect = fade_transition_scene.instantiate()
	get_tree().current_scene.add_child(fade_transition)
	
	fade_transition.play_fade(false)
	await get_tree().create_timer(1.0).timeout
	# get_tree().change_scene_to_packed(main_menu_scene)
