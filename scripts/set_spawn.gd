extends Area2D

func _ready():
	connect("body_enter", self, "body_enter")

func body_enter(body):
	if body.is_in_group("player"):
		body.spawn.set_pos(body.get_pos())