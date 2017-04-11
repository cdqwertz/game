extends Area2D

export var game_name = ""
onready var text_press_enter = get_node("press_enter")

var objects = []

func _ready():
	text_press_enter.hide()
	
	connect("body_enter", self, "body_enter")
	connect("body_exit", self, "body_exit")
	set_process_unhandled_input(true)
	
func _unhandled_input(event):
	if (event.is_action_pressed("play_level")) and objects.size() > 0:
		get_tree().change_scene("res://scenes/" + game_name + ".tscn")

func body_enter(body):
	if body.is_in_group("player"):
		objects.append(body)
		text_press_enter.show()

func body_exit(body):
	if body.is_in_group("player"):
		text_press_enter.hide()
		objects.remove(objects.find(body))
