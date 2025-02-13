extends Node

var score = 0
var paused = false


var save_path = "user://save_game.dat"

var game_data: Dictionary = {
	"max_score": 0
}

func save_game() -> void:
	var save_file = FileAccess.open(save_path,FileAccess.WRITE)
	
	save_file.store_var(game_data)
	save_file = null
	
func load_game() -> void:
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path,FileAccess.READ)
		game_data = save_file.get_var()
		save_file = null

 
