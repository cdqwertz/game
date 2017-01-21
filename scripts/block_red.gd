extends Area2D

onready var spawn = get_parent().get_node("spawn")

func _ready():
	connect("body_enter", self, "body_enter")
	
func body_enter(body):
	if body.is_in_group("player"):
		body.set_pos(spawn.get_pos())
		body.set_linear_velocity(Vector2(0, 0))
