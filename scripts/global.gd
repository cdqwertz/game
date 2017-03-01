extends Node

var time = 0
var coins = 0
var level = 1
var last_level = 1

var all_coins = []
var all_times = []

var level_editor_data = []

func _ready():
	load_game()
	
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
	
	update_coins(n)
	update_times(n)
	coins = 0
	time = 0
	
	save_game()
	
func update_coins(n):
	while all_coins.size() < n + 1:
		all_coins.append(0)
	
	if all_coins[n] < coins:
		all_coins[n] = coins
		
func update_times(n):
	while all_times.size() < n + 1:
		all_times.append(-1)
	
	if all_times[n] > time or all_times[n] == -1:
		all_times[n] = time
		
func get_best_time(n):
	while all_times.size() < n + 1:
		all_times.append(-1)
		
	return all_times[n]
	
func get_best_coins(n):
	while all_coins.size() < n + 1:
		all_coins.append(0)
	
	return all_coins[n]
	
func save_game():
	var data = {}
	data["level"] = level
	data["all_times"] = all_times
	data["all_coins"] = all_coins
	
	var my_file = File.new()
	my_file.open("user://game_data.txt", my_file.WRITE)
	my_file.store_string(data.to_json())
	my_file.close()
	
func load_game():
	var my_file = File.new()
	if my_file.file_exists("user://game_data.txt"):
		my_file.open("user://game_data.txt", my_file.READ)
		
		var content = my_file.get_as_text()
		print(content)
		var data = {}
		data.parse_json(content)
			
		my_file.close()
		
		if data.has("level"):
			level = data["level"]
			
		if data.has("all_coins"):
			all_coins = data["all_coins"]
			
		if data.has("all_times"):
			all_times = data["all_times"]