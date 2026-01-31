extends Node2D

@export var first_maze_scene: PackedScene


func _on_texture_button_button_down() -> void:
	get_tree().change_scene_to_packed(first_maze_scene)
