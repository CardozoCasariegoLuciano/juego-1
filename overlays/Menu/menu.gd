extends CanvasLayer


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_button_button_up() -> void:
	Globals.paused = false
	queue_free()
