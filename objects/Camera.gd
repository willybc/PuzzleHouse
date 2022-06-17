extends Camera2D

export(NodePath) var player_path
onready var player = get_node(player_path)

func _process(delta):
	position = player.position
