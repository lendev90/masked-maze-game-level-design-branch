extends Area2D

@export var curr_cam: Camera2D
@export var move_dir = "up"

func _ready() -> void:
	curr_cam = get_viewport().get_camera_2d()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Switching camera")
		print(curr_cam.position)
		var offset_y = curr_cam.offset.y
		var offset_x = curr_cam.offset.x
		var new_pos = Vector2.ZERO

		if move_dir == "up":
			new_pos = Vector2(curr_cam.position.x, curr_cam.position.y - offset_y)
		elif move_dir == "down":
			new_pos = Vector2(curr_cam.position.x, curr_cam.position.y + offset_y)
		elif move_dir == "left":
			new_pos = Vector2(curr_cam.position.x - offset_x, curr_cam.position.y)
		elif move_dir == "right":
			new_pos = Vector2(curr_cam.position.x + offset_x, curr_cam.position.y)
		curr_cam.global_position = new_pos
		
		