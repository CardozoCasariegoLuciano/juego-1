extends Area2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var line_2d: Line2D = $Line2D

var left_corner = 67
var rigth_corner = 300

func _physics_process(_delta: float) -> void:
	var colition = ray_cast_2d.get_collider()
	if(colition):
		line_2d.set_point_position(1, Vector2(0, ray_cast_2d.get_collision_point().y - 160))

func _input(event: InputEvent) -> void:
	if(event is InputEventMouseMotion):
		position.x = clamp(event.position.x, left_corner, rigth_corner)

func update_sprite(texture):
	sprite_2d.texture = texture
