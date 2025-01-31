extends RigidBody2D
class_name Godots

signal on_join_fruits(fruit_1: Godots, fruit_2: Godots)

@export var type = 1
@export var creation_offset_y = 0
var is_on_floor = false
var tween: Tween

func _init_fruit(init_type, init_position):
	type = init_type
	position = Vector2(init_position.x, init_position.y - creation_offset_y) 

func _on_fruta_detector(body: Node2D) -> void:
	if body is Godots and body != self:
		is_on_floor = !body.is_on_floor
		if(!is_on_floor and body.type == type):
			on_join_fruits.emit(body, self)
			
func set_color(is_in_line: bool, time: float):
	if(is_in_line):
		tween = create_tween()
		tween.tween_property(self, "modulate", Color(1, 0, 0), time)
	else:
		if(tween != null):
			tween.kill()
		modulate = "ffffff"
