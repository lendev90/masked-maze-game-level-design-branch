extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var mask = get_tree().get_first_node_in_group("mask")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalVariables.mask_catched:
		queue_free()
	else:
		_animated_sprite.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GlobalVariables.mask_catched = true
		mask.visible = true
		get_tree().get_first_node_in_group("dialogues").catch_mask()
		body.is_masked = true
		body.handle_mask()
		queue_free()
