extends KinematicBody2D

#Variables
var VELOCIDAD_MAXIMA = 100
var ACELERACION = 350
var FRICCION = 850

enum {
	RUN
}

onready var animation_player = $AnimationPlayer

var velocidad = Vector2.ZERO#(0, 0) 
var direccion_vector = Vector2.DOWN#(0, 1)
var direccion = Vector2.ZERO#(0, 0)

var estado = RUN

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Se ejecuto BIEN")
	

func run_state(delta):
	var input_vector = Vector2.ZERO
	
	#Si solo se presiona ui_right el valor del vectorX da 1 (movimiento 1 a la derecha)
	#Si solo se presiona ui_left el valor del vector da -1 (movimiento 1 a la izquierda)
	#Si se presionan los 2 el valor del vector da 0 (movimiento 0)
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	#Si el vector NO es (0, 0)
	#Si el usuario esta tocando al personaje
	if input_vector != Vector2.ZERO:
		direccion_vector = input_vector
		#move_toward(Mueve, hacia, por el valor)
		velocidad = velocidad.move_toward(input_vector * VELOCIDAD_MAXIMA, ACELERACION * delta)
		_play_animation("Run")
	#Si el usuario no esta tocando al personaje
	else:
		velocidad = velocidad.move_toward(input_vector * VELOCIDAD_MAXIMA, FRICCION * delta)
		_play_animation("Idle")
	velocidad = move_and_slide(velocidad)
	
	
func _physics_process(delta):
	match estado:
		RUN:
			run_state(delta)
		
func _play_animation(animation_type: String) -> void:
	var animation_name = animation_type + "_" + _get_direction_string(direccion_vector.angle())
	
	if animation_name != animation_player.current_animation:
		animation_player.stop(true)
		
	animation_player.play(animation_name)

func _get_direction_string(angle: float) -> String:
	var angle_deg = round(rad2deg(angle))
	if angle_deg > -180 and angle_deg < 180:
		return "Right"
	return "Left"
