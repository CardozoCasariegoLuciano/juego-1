extends RigidBody2D

const SPEED = 400.0



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_entered(body: Node2D) -> void:
	if body is Player:
		var direction = position.direction_to(body.position).normalized()	
		apply_central_impulse(direction * SPEED)
