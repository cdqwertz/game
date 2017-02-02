extends Area2D

export var next_level = ""
export var level = 1
export var box = false

func _ready():
	connect("body_enter", self, "body_enter")

func body_enter(body):
	if not(box) and body.is_in_group("player"):
		#get_tree().change_scene(next_level)
		global.finish_level(level)
		get_tree().change_scene("res://scenes/select_level.tscn")
		
	if box and body.is_in_group("box"):
		#get_tree().change_scene(next_level)
		global.finish_level(level)
		get_tree().change_scene("res://scenes/select_level.tscn")