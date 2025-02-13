extends CanvasLayer
signal restart_game

@onready var label: Label = $Control/VBoxContainer/HBoxContainer/Label
@onready var value_record: Label = $Control/VBoxContainer/Record/value

func _ready() -> void:
	label.text = str(Globals.score)
	value_record.text = str(Globals.game_data["max_score"])

func _on_button_button_up() -> void:
	restart_game.emit()
