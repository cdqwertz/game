extends Area2D

export var level_name = ""
export var number = "1"

onready var text_press_enter = get_node("press_enter")

var objects = []

func _ready():
	text_press_enter.hide()
	
	connect("body_enter", self, "body_enter")
	connect("body_exit", self, "body_exit")
	set_process_unhandled_input(true)
	
func _unhandled_input(event):
	if (event.is_action_pressed("play_level")) and objects.size() > 0:
		if level_name == "":
			level_name = "level_" + number
		global.last_level = int(number)
		get_tree().change_scene("res://scenes/" + level_name + ".tscn")
	
	if event.is_action_pressed("back"):
		get_tree().change_scene("res://scenes/menu.tscn")

func body_enter(body):
	if body.is_in_group("player"):
		objects.append(body)
		var n = int(number)
		if n == global.level:
			text_press_enter.show()
		get_parent().set_level(number)
		get_parent().set_best_coins(global.get_best_coins(n))
		get_parent().set_best_time(global.get_best_time(n))

func body_exit(body):
	if body.is_in_group("player"):
		text_press_enter.hide()
		objects.remove(objects.find(body))
