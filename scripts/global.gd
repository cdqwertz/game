extends Node

var time = 0
var coins = 0
var level = 8

var level_editor_data = []

func _ready():
	pass
	
func add_coin(c=1):
	coins += c
	
	var gui = get_tree().get_root().get_node("world/gui")
	if gui:
		gui.update_gui()
		
func set_level_editor_data(d = []):
	level_editor_data = d
	
func get_level_editor_data():
	return level_editor_data
	
func finish_level(n):
	if n == level:
		level += 1
	elif n > level:
		level = n + 1