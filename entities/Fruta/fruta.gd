extends RigidBody2D
class_name Fruit

signal on_join_fruits(fruit_1: Fruit, fruit_2: Fruit)
@onready var fruta_detector: Area2D = $"fruta-detector"
@export var type = 1
var is_on_floor = false

func _init_fruit(init_type, init_position):
	type = init_type
	position = init_position

func _on_fruta_detector(body: Node2D) -> void:
	if body is Fruit and body != self:
		is_on_floor = !body.is_on_floor
		if(!is_on_floor and body.type == type):
			on_join_fruits.emit(body, self)
