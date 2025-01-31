extends Node2D
signal on_defeat_event

@onready var timer: Timer = $Timer
@onready var area_2d: Area2D = $Area2D
@onready var line_2d: Line2D = $Line2D

func _on_body_entered(body: Node2D) -> void:
	if(body is Fruit):
		body.set_color(true, timer.wait_time)
		if(cant_godots_in_area() <= 1):
			timer.start()

func _on_body_exited(body: Node2D) -> void:
	if(body is Fruit and cant_godots_in_area() <= 1):
		body.set_color(false, 0)

func _on_timer_timeout() -> void:
	if(cant_godots_in_area() >= 1):
		on_defeat_event.emit(true)

func cant_godots_in_area() -> int:
	var items_in_area = area_2d.get_overlapping_bodies()
	var godots_in_area = 0
	
	for a in items_in_area:
		if a is Fruit:
			godots_in_area += 1
			
	return godots_in_area
