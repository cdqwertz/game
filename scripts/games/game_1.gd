extends Node2D

var worlds = []

func _ready():
	randomize()
	
	set_process(true)
	
	for i in range(1, 7):
		worlds.push_back(load("res://scenes/games/game_1/world_" + str(i) + ".tscn"))
		
	var sizes = [20, 30, 20, 30, 25, 25]
		
	var it = 0
	var x = 6*64
	while it < 20:
		var n = randi()%worlds.size()
		var world = worlds[n]
		var obj = world.instance()
		add_child(obj)
		obj.set_pos(Vector2(x, 0))
		x += sizes[n]*64
		it += 1
		
func _process(delta):
	pass