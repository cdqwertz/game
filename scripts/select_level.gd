extends Node2D

onready var my_score = get_node("gui/score")
onready var my_wall = get_node("wall")
onready var my_spawn = get_node("spawn")
onready var my_player = get_node("player")

func _ready():
	print("start_" + str(global.level))
	var my_sign = get_node("start_" + str(global.level))
	if my_sign:
		my_wall.set_pos(Vector2(my_sign.get_pos().x, 0))
	else:
		if global.level > 1:
			my_sign = get_node("start_" + str(global.level - 1))
			if my_sign:
				my_wall.set_pos(Vector2(my_sign.get_pos().x, 0))
	
	if global.level > 1:
		var last_level = get_node("start_" + str(global.level - 1))
		my_spawn.set_pos(last_level.get_pos() + Vector2(0, -32))
		my_player.set_pos(last_level.get_pos()+ Vector2(0, -32))
	
func set_level(name):
	my_score.set_text(name)
