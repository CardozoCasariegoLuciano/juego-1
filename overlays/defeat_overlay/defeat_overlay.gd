extends CanvasLayer
signal restart_game

func _on_button_button_up() -> void:
	restart_game.emit()
