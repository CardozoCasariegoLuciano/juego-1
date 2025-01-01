extends CharacterBody2D
class_name Player

const SPEED = 300.0


func _physics_process(delta: float) -> void:
	player_movement()



func player_movement():
	var direction = Vector2(Input.get_action_strength("rigth") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up"))
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.lerp(Vector2.ZERO, 0.3)
	move_and_slide()
	
