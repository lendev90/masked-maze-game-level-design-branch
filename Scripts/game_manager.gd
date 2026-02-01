extends Node2D

@export var player_scene_path: String = "res://Scenes/SceneObjects/player.tscn"
@export var player_node: Node2D = null
@export var player_start_point: Node2D

# player settings
@export var player_will_fall := false

func _ready() -> void:
	if GlobalVariables.switch_scene_from_to.x == -1:
		GlobalVariables.player_start_pos = player_start_point.global_position
	else:
		var switchers = get_tree().get_nodes_in_group("scene_switches")
		for switch in switchers:
			if switch.scene_switcher_from_to == GlobalVariables.switch_scene_from_to:
				GlobalVariables.player_start_pos = switch.node.global_position
	create_player()
	

func _process(delta: float) -> void:
	pass

func create_player() -> void:
	var pos = Vector2.ZERO

	if(GlobalVariables.player_start_pos != null):
		pos = GlobalVariables.player_start_pos

	var player_scene = load(player_scene_path)

	var player_instance = player_scene.instantiate()
	player_instance.will_fall = player_will_fall	
	player_instance.global_position = pos
	player_instance.scale = Vector2.ONE


	add_child(player_instance)
