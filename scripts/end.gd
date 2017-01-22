extends Area2D

export var next_level = ""
export var box = false

func _ready():
	connect("body_enter", self, "body_enter")

func body_enter(body):
	if not(box) and body.is_in_group("player"):
		get_tree().change_scene(next_level)
		
	if box and body.is_in_group("box"):
		get_tree().change_scene(next_level)