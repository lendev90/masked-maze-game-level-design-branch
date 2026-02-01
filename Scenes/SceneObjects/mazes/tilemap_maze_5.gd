extends Node2D


@export var spike_timer := 0.0


func _process(delta: float) -> void:
	if spike_timer >= 2.5:
		$Spikes.collision_enabled = !$Spikes.collision_enabled
		#print($Spikes.collision_enabled)
		spike_timer = 0.0
	spike_timer += delta
