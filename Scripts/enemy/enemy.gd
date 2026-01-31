extends CharacterBody2D

@export var float_amplitude = 10.0
@export var float_speed = 100.0
@export var chase_speed = 300.0
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

var start_point: Vector2
var time := 0.0
var player: Node2D = null
var chasing := false


func _ready() -> void:
	start_point = position
	
	get_player()

func _process(delta: float) -> void:
	handle_animation()

func _physics_process(delta: float) -> void:
	time += delta

	if player and player.is_masked:
		return
	if chasing and player:
		chase_player(delta)
	else:
		idle_float(delta)

func idle_float(delta: float) -> void:
	velocity = Vector2.ZERO

	var offset_y = sin(time*float_speed) * float_amplitude
	print("time: ", time)
	print("offset y: ", offset_y)
	position.y = start_point.y + offset_y

	move_and_slide()

func chase_player(delta: float) -> void:
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * chase_speed

	move_and_slide()


func get_player() -> void:
	if(player == null):
		var players = get_tree().get_nodes_in_group("player")
		if(players.size() > 0):
			player = players[0]


func _on_follow_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		chasing = true



func _on_follow_area_body_exited(body: Node2D) -> void:
	if body == player:
		# player = null
		chasing = false

func handle_animation() -> void:
	if (player && player.is_masked):
		animation_player.play("hidded")
	else :
		animation_player.play("idle")
		
