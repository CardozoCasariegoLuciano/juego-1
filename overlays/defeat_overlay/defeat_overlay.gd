extends CanvasLayer
signal restart_game

@onready var label: Label = $Control/VBoxContainer/HBoxContainer/Label

func _ready() -> void:
	label.text = str(Globals.score)

func _on_button_button_up() -> void:
	restart_game.emit()
