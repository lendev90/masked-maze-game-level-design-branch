extends CharacterBody2D


@export var SPEED = 300.0
@export var is_masked := true
@export var death_cooldown = 1.0
@export var normal_path: TileMapLayer;
@export var mask_path: TileMapLayer;


func _ready() -> void:
	if mask_path != null:
		mask_path.visible = is_masked
	else:
		mask_path = get_tree().get_first_node_in_group("mask_path")
	
	if normal_path == null:
		normal_path = get_tree().get_first_node_in_group("normal_path")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("mask"):
		is_masked = false
		if mask_path != null:
			mask_path.visible = is_masked
			normal_path.visible = not is_masked

	if Input.is_action_just_released("mask"):
		is_masked = true
		if mask_path != null:
			mask_path.visible = is_masked
			normal_path.visible = not is_masked

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if(direction != Vector2.ZERO):
		velocity = direction * SPEED
		# footstep_sound.play()
	else:
		velocity = Vector2.ZERO

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider is TileMapLayer:
			if collider.name == "deadly":
				die()
			print("Collided with TileMapLayer: ", collider.name)
	move_and_slide()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if(area.is_in_group("scene_switches")):
		area.switch_scene()

	if(area.is_in_group("enemy")):
		var enemy = area.get_parent()
		if(enemy and enemy is CharacterBody2D):
			monster_death()

func monster_death() -> void:
	if not is_masked:
		visible = false
		await get_tree().create_timer(death_cooldown).timeout
		get_tree().reload_current_scene()

func die() -> void:
	visible = false
	await get_tree().create_timer(death_cooldown).timeout
	get_tree().reload_current_scene()
