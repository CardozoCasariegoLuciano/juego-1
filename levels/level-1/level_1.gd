extends Node2D
@onready var timer: Timer = $Timer
@onready var label: Label = $CanvasLayer/Label

var can_create_new_fruit = true
var godots_list = []

func _ready() -> void:
	for a in range(3):
		var random_number = randi() % 4 + 1
		godots_list.append(random_number)
		label.text = label.text + " " + str(random_number)

func _on_clickdetector_input(event: InputEvent) -> void:
	if(can_create_new_fruit and event is InputEventMouseButton and event.is_pressed()):
		can_create_new_fruit = false
		var type = godots_list.pop_front()
		create_new_fruit(type, Vector2(event.position.x, 0))
		
		var random_number = randi() % 4 + 1
		godots_list.append(random_number)
		label.text = " ".join(godots_list)

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

#TODO Frutas:
	#Crear frutas con su logica de union --DONE
	#Instanciarlas con un click -- DONE
	#Estilos de las fruta -- DONE
	#Mostrar las siguientes 3 frutas -- WIP
	#Mostrar el origen de creacion junto al Limite de derrota
	#Mostrar la guia de caida de la fruta

#TODO Partida:
	#Mostrar el puntaje actual
	#Mostrar el puntaje record
	#Mostrar todas las frutas del juego y su orden

#TODO Poderes:
	#Limpiar una fruta
	#Undo
	#Descartar la fruta actual
	
#TODO Pantallas:
	#Menu inicial
	#Menu de sonido
