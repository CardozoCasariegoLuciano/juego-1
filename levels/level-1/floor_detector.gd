extends Area2D

func _on_floor_detector(body: Node2D) -> void:
	if(body is Godots):
		body.is_on_floor = true
