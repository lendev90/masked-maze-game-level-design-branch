extends Area2D

@export var curr_cam: Camera2D
@export var move_dir = "up"
@export var change_offset: float = 2.0

func _ready() -> void:
	# curr_cam = get_viewport().get_camera_2d()
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var viewport_height = get_viewport_rect().size.y
		var viewport_width = get_viewport_rect().size.x
		var new_pos = Vector2.ZERO

		if move_dir == "up" and body.global_position.y < curr_cam.position.y and body.direction.y < 0:
			curr_cam.position = Vector2(curr_cam.position.x, curr_cam.position.y - viewport_height)
		elif move_dir == "down" and body.global_position.y > curr_cam.position.y and body.direction.y > 0:
			curr_cam.position = Vector2(curr_cam.position.x, curr_cam.position.y + viewport_height)
		elif move_dir == "left" and body.global_position.x < curr_cam.position.x and body.direction.x < 0:
			curr_cam.position = Vector2(curr_cam.position.x - viewport_width, curr_cam.position.y)
		elif move_dir == "right" and body.global_position.x > curr_cam.position.x and body.direction.x > 0:
			curr_cam.position = Vector2(curr_cam.position.x + viewport_width, curr_cam.position.y)
		
		
