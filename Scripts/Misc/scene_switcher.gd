extends Area2D

@export var target_scene: String

func switch_scene() -> void:
	var tree = get_tree()
	var path = "res://Scenes/" + target_scene + ".tscn"
	tree.call_deferred("change_scene_to_file", path)