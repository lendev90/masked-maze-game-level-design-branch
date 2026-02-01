extends Control

@onready var _animated_sprite = $AnimatedSprite2D
@export var target_scene: String
@export var node:Node2D
@export var scene_switcher_from_to:Vector2 = Vector2 (-1,-1)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !GlobalVariables.cut2_played:
		_animated_sprite.play("default")
	else:
		handle_switch(GlobalVariables.cut2_played)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	handle_switch(GlobalVariables.cut2_played)
	GlobalVariables.cut2_played = true
	

func handle_switch(cut2_played:bool):
	var tree = get_tree()
	var path = "res://Scenes/" + target_scene + ".tscn"
	if cut2_played:
		GlobalVariables.switch_scene_from_to = Vector2 (0,1)
	GlobalVariables.switch_scene_from_to = scene_switcher_from_to
	tree.call_deferred("change_scene_to_file", path)
