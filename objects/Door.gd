extends Area2D

var next_position

func _ready():
	next_position = get_node("DoorDestination").get_global_position()


func _on_Door_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "Player":
		body.set_position(next_position)
