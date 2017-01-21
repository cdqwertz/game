extends Node

var time = 0
var coins = 0

func _ready():
	pass
	
func add_coin(c=1):
	coins += c
	
	var gui = get_tree().get_root().get_node("world/gui")
	if gui:
		gui.update_gui()