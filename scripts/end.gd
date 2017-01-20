extends Area2D

export var next_level = ""

func _ready():
	connect("body_enter", self, "body_enter")

func body_enter(body):
	if body.is_in_group("player"):
		get_tree().change_scene(next_level)