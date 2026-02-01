extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var mask = get_tree().get_first_node_in_group("mask")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_animated_sprite.play("default")


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GlobalVariables.mask_catched = true
		mask.visible = true
		body.is_masked = true
		body.handle_mask()
		queue_free()
