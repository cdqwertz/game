extends Node2D

onready var my_score = get_node("gui/score")
onready var my_best_time = get_node("gui/best_time")
onready var my_best_coins = get_node("gui/best_coins")
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
	
func set_best_time(t):
	my_best_time.set_text(str(t))
	
func set_best_coins(c):
	my_best_coins.set_text(str(c))
