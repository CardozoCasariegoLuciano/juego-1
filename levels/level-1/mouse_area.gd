extends Area2D
signal on_create_godot

@onready var timer: Timer = $Timer

var can_create_new_fruit = true
var is_mouse_in_area = false

func _input(event: InputEvent) -> void:
	if(!Globals.paused and is_mouse_in_area and can_create_new_fruit and event is InputEventMouseButton and event.is_pressed()):
		can_create_new_fruit = false
		on_create_godot.emit()
		timer.start()

func _on_timer_timeout() -> void:
	can_create_new_fruit = true

func _on_mouse_entered() -> void:
	is_mouse_in_area = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_mouse_mouse_exited() -> void:
	is_mouse_in_area = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
