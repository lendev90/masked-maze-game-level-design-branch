extends CharacterBody2D

# states
@export var is_masked := false
@export var can_start := false
@export var will_fall := false

# Cooldowns
@export var death_cooldown = 1.0
@export var spawn_cooldown := 0.8
@export var fall_cooldown := 1.0

@export var normal_path: TileMapLayer;
@export var mask_path: TileMapLayer;

# Nodes
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream: AudioStreamPlayer2D = $AudioStreamPlayer2D


# Sounds
@export var sounds := {
	"walk": preload("res://Audio/footstep.mp3"),
	"toggle_mask": preload("res://Audio/toggle_mask.wav"),
	"die": preload("res://Audio/die.wav")
}

# Footstep
var footstep_timer := 0.0
@export var footstep_interval := 0.4


var mask_node = null

# Input
var direction := Vector2.ZERO
@export var SPEED = 300.0



func _ready() -> void:
	if GlobalVariables.mask_catched == true:
		is_masked = true
	if(will_fall):
		fall()
	else:
		spawn()
	find_nodes()

func fall() -> void:
	animation_player.play("fall")
	await get_tree().create_timer(fall_cooldown).timeout
	can_start = true

func spawn() -> void:
	animation_player.play("spawn")
	await get_tree().create_timer(spawn_cooldown).timeout
	can_start = true


func find_nodes():
	if mask_path != null:
		mask_path.visible = is_masked
	else:
		mask_path = get_tree().get_first_node_in_group("mask_path")
		mask_path.visible = is_masked
	
	if normal_path == null:
		normal_path = get_tree().get_first_node_in_group("normal_path")
		normal_path.visible = not is_masked
		
	if mask_node == null:
		mask_node = get_tree().get_first_node_in_group("mask")

func _process(delta: float) -> void:
	handle_animation()

	if Input.is_action_just_pressed("mask") and GlobalVariables.mask_catched == true:
		is_masked = false
		handle_mask()

	if Input.is_action_just_released("mask") and GlobalVariables.mask_catched == true:
		is_masked = true
		handle_mask()

func _physics_process(delta: float) -> void:
	if not can_start:
		return
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if(direction != Vector2.ZERO):
		velocity = direction * SPEED
		handle_footstep_sound(delta)
		
	else:
		footstep_timer = 0
		velocity = Vector2.ZERO

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider is TileMapLayer:
			if collider.name == "deadly":
				die()
			if collider.name == "Spikes":
				die()
				
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
		die()

func die() -> void:
	visible = false
	await get_tree().create_timer(death_cooldown).timeout
	play_sound("die")
	get_tree().call_deferred("reload_current_scene")

func handle_animation() -> void:
	if !can_start: return
	if is_masked:
		if(direction != Vector2.ZERO):
			animation_player.play("masked_walk")
		else:
			animation_player.play("masked_idle")
	else:
		if(direction != Vector2.ZERO):
			animation_player.play("walk")
		else:
			animation_player.play("idle")

func handle_footstep_sound(delta) -> void:
	footstep_timer -= delta
	if footstep_timer <= 0:
		footstep_timer = footstep_interval
		audio_stream.play()
		
func handle_mask() -> void:
	if mask_path != null:
		if(mask_node):
			mask_node.toggle(is_masked)
			play_sound("toggle_mask")
		mask_path.visible = is_masked
		normal_path.visible = not is_masked

func play_sound(sound_name: String) -> void:
	if sound_name in sounds:
		audio_stream.stream = sounds[sound_name]
		audio_stream.play()
