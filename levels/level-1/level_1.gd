extends Node2D
@onready var timer: Timer = $Timer

@onready var godot_1: TextureRect = $godot_list/VBoxContainer/godot_1
@onready var godot_2: TextureRect = $godot_list/VBoxContainer/godot_2
@onready var godot_3: TextureRect = $godot_list/VBoxContainer/godot_3
@onready var next_godot: Area2D = $next_godot

var can_create_new_fruit = true
var godots_list = []

func _ready() -> void:
	update_nexts_godots(4)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event: InputEvent) -> void:
	if(can_create_new_fruit and event is InputEventMouseButton and event.is_pressed()):
		can_create_new_fruit = false
		var type = godots_list.pop_front()
		create_new_fruit(type, Vector2(next_godot.position.x, next_godot.position.y + 50))
		
		update_nexts_godots(1)
		timer.start()

func _on_timer_timeout() -> void:
	can_create_new_fruit = true

func on_join_fruits(fruit_1: Fruit, fruit_2: Fruit):
	fruit_1.visible = false
	fruit_2.visible = false
	var new_fruit_position = Vector2(fruit_1.position.x, fruit_1.position.y)
	create_new_fruit(fruit_1.type + 1, new_fruit_position)
	fruit_1.queue_free()
	fruit_2.queue_free()

func create_new_fruit(level: int, init_position: Vector2):
	var PATH = "res://entities/Fruits/fruit_" + str(level) + "e.tscn"
	var scene = load(PATH)
	
	if(scene == null):
		print("Se llego al nivel maximo de Godots")
		return

	var new_fruit = scene.instantiate()
	new_fruit._init_fruit(level, init_position)
	new_fruit.on_join_fruits.connect(on_join_fruits)
	call_deferred("add_child", new_fruit)

func _on_floor_detector(body: Node2D) -> void:
	if(body is Fruit):
		body.is_on_floor = true

func update_nexts_godots(times):
	for a in range(times):
		var random_number = randi() % 4 + 1
		godots_list.append(random_number)
		
	next_godot.update_sprite(load("res://assets/godots/"+ str(godots_list[0]) + "_godot.png"))
	godot_1.texture = load("res://assets/godots/"+ str(godots_list[1]) + "_godot.png")
	godot_2.texture = load("res://assets/godots/"+ str(godots_list[2]) + "_godot.png")
	godot_3.texture = load("res://assets/godots/"+ str(godots_list[3]) + "_godot.png")

#TODO Frutas:
	#Crear godots con su logica de union --DONE
	#Instanciarlas con un click -- DONE
	#Estilos de los godots -- DONE
	#Mostrar los siguientes 3 godots -- DONE
	#Mostrar el origen de creacion junto al Limite de derrota -- DONE
	#Mostrar la guia de caida de la fruta y sacar el mouse --DONE

#TODO Partida:
	#Mostrar Overlay de derrota
	#Mostrar el puntaje actual
	#Mostrar todas las frutas del juego y su orden
	#Mostrar el puntaje record

#TODO Poderes:
	#Limpiar una fruta
	#Undo
	#Descartar la fruta actual
	
#TODO Pantallas:
	#Menu inicial
	#Menu de sonido
