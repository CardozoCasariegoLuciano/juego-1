extends Node2D

@onready var godot_1: TextureRect = $godot_list/VBoxContainer/godot_1
@onready var godot_2: TextureRect = $godot_list/VBoxContainer/godot_2
@onready var godot_3: TextureRect = $godot_list/VBoxContainer/godot_3
@onready var next_godot: Area2D = $next_godot
@onready var current_godots: Node2D = $Current_godots
@onready var points: Label = $points/Label
@onready var merge_sound: AudioStreamPlayer = $MergeSound

var defeat_overlay: CanvasLayer
var godots_list = []

func _ready() -> void:
	start()

func _on_create_godot() -> void:
	var type = godots_list.pop_front()
	create_new_fruit(type, Vector2(next_godot.position.x, next_godot.position.y + 50))
	update_nexts_godots(1)

func on_join_fruits(fruit_1: Godots, fruit_2: Godots):
	merge_sound.play()
	fruit_1.visible = false
	fruit_2.visible = false
	var new_fruit_position = Vector2(fruit_1.position.x, fruit_1.position.y)
	create_new_fruit(fruit_1.type + 1, new_fruit_position)
	Globals.score =+ Globals.score + ((fruit_1.type + 1) * 100)
	points.text = str(Globals.score)
	fruit_1.queue_free()
	fruit_2.queue_free()

func create_new_fruit(level: int, init_position: Vector2):
	var PATH = "res://entities/Godots/godot_" + str(level) + ".tscn"
	var scene = load(PATH)
	
	if(scene == null):
		print("Se llego al nivel maximo de Godots")
		return

	var new_fruit = scene.instantiate()
	new_fruit._init_fruit(level, init_position)
	new_fruit.on_join_fruits.connect(on_join_fruits)
	current_godots.call_deferred("add_child", new_fruit)

func update_nexts_godots(times):
	for a in range(times):
		var random_number = randi() % 4 + 1
		godots_list.append(random_number)
		
	next_godot.update_sprite(load("res://assets/godots/"+ str(godots_list[0]) + "_godot.png"))
	godot_1.texture = load("res://assets/godots/"+ str(godots_list[1]) + "_godot.png")
	godot_2.texture = load("res://assets/godots/"+ str(godots_list[2]) + "_godot.png")
	godot_3.texture = load("res://assets/godots/"+ str(godots_list[3]) + "_godot.png")

func _on_defeat_line(_value) -> void:
	if (Globals.paused): return
	var scene = load("res://overlays/defeat_overlay/defeat_overlay.tscn")
	defeat_overlay = scene.instantiate()
	
	defeat_overlay.connect("restart_game", start)
	add_child(defeat_overlay)
	
	next_godot.visible = false
	Globals.paused = true

func start():
	for child in current_godots.get_children():
		current_godots.remove_child(child)
		
	update_nexts_godots(4)
	next_godot.visible = true
	Globals.paused = false
	Globals.score = 0
	points.text = "0"
	
	if defeat_overlay != null:
		defeat_overlay.queue_free()
		
func _on_menu_button() -> void:
	Globals.paused = true
	var menu_scene = preload("res://overlays/Menu/menu.tscn")
	add_child(menu_scene.instantiate())

#TODO Guardar el mayor record
#TODO Exportarlo a Android
