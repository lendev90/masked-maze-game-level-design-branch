extends Area2D

@onready var scene_switcher: Area2D = $"."
@export var target_scene: String
@export var node:Node2D
@export var scene_switcher_from_to:Vector2 = Vector2 (-1,-1)

func switch_scene() -> void:
	if GlobalVariables.key_catched:
		GlobalVariables.cut1_played = false
		GlobalVariables.cut2_played = false
		GlobalVariables.key_catched = false
		GlobalVariables.mask_catched = false
		var tree = get_tree()
		var path = "res://Scenes/" + target_scene + ".tscn"
		GlobalVariables.switch_scene_from_to = scene_switcher_from_to
		tree.call_deferred("change_scene_to_file", path)
