#class_name BoxTarget
extends KinematicBody2D

const directions = {
	"up": Vector2.UP,
	"down": Vector2.DOWN,
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT
}

onready var ray = $RayCast2D
const grid_size = 16

enum {
	STATIC,
	DINAMIC
}
var move_direction: String
#var teleporting = false

var VELOCIDAD_MAXIMA = 100
var ACELERACION = 350
var FRICCION = 850

var velocidad = Vector2.ZERO
var direccion_vector = Vector2.DOWN
var direccion = Vector2.ZERO

var estado = STATIC

var player_direction
var box_direction

var contador = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Se ejecuto bien la caja")

func _on_interact(grado):
	if grado == 0:
		player_direction = "Abajo"
		box_direction = "Arriba"
	elif grado == 180:
		player_direction = "Arriba"
		box_direction = "Abajo"
	elif grado == -90:
		player_direction = "Derecha"
		box_direction = "Izquierda"
	elif grado == 90:
		player_direction = "Izquierda"
		box_direction = "Derecha"
	else:
		print("Error")

	contador +=1
	print("Me esta tocando, ay dios mio!, por mi", box_direction, contador)
	

func move(dir: String) -> bool:
	move_direction = dir
	var vector_position = directions[dir] * grid_size
	ray.cast_to = vector_position
	ray.force_raycast_update()
	if !ray.is_colliding():
		self.position += directions[dir] * grid_size
		return true
	return false
