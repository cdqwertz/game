extends Area2D

func _ready():
	connect("body_enter", self, "body_enter")

func body_enter(body):
	if body.is_in_group("player"):
		global.add_coin()
		queue_free()