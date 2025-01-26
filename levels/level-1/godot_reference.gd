extends Node2D


func _ready() -> void:
	generate_godots()

func generate_godots():
	var next_position = 0
	var next_scale_value = 0.1
	for lvl in range(1,10):
		
		var texture = load("res://assets/godots/" + str(lvl) + "_godot.png")
		if(texture == null):
			return
			
		var new_sprite = Sprite2D.new()
		new_sprite.texture =  texture
		add_child(new_sprite)
		
		new_sprite.scale = Vector2(next_scale_value , next_scale_value)
		new_sprite.position.x = next_position
		
		next_position = new_sprite.position.x + 30 + (lvl * 2)
		next_scale_value = next_scale_value + 0.01
