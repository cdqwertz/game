extends Node2D

var data = []
var textures = []

var width = 32
var height = 16

func _ready():
	for t in ["grey", "blue", "orange", "red", "cyan", "lever_off", "box", "end"]:
		textures.append(load("res://sprites/" + t + ".png"))
	
	if not(global.get_level_editor_data().empty()):
		import_level(global.get_level_editor_data())
	else:
		clear_level()

func clear_level():
	data = []
	for i in range(0, width):
		var a = []
		for j in range(0, height):
			a.append(-1)
		data.append(a)

func set_block(pos, type):
	if pos.x < width and pos.y < height and pos.x >= 0 and pos.y >= 0:
		data[pos.x][pos.y] = type
		return true
	elif pos.x >= width and pos.y >= height:
		resize(pos.x, pos.y)
		if(not(pos.x >= width or pos.y >= height)):
			data[pos.x][pos.y] = type
			return true
		else:
			return false
	elif pos.x >= width and pos.y >= 0:
		resize_x(pos.x)
		data[pos.x][pos.y] = type
		return true
	elif pos.y >= height and pos.x >= 0:
		resize_y(pos.y)
		data[pos.x][pos.y] = type
		return true
	elif pos.y < 0 and pos.x >= 0 and pos.x < width:
		resize_up(height - (pos.y+1))
		set_pos(get_pos() + Vector2(0, pos.y*64))
		data[pos.x][0] = type
	elif pos.y < 0 and pos.x >= width:
		resize_up(height - (pos.y+1))
		set_pos(get_pos() + Vector2(0, pos.y*64))
		resize_x(pos.x)
		data[pos.x][0] = type
	else:
		return false
	
func get_block(pos):
	return data[pos.x][pos.y]
	
func resize(w, h):
	resize_y(h)
	resize_x(w)

func resize_x(w):
	while data.size() < w+1:
		var a = []
		for j in range(0, height):
			a.append(-1)
		data.append(a)
		
	width = w+1
	
func resize_y(h):
	for i in range(0, width):
		while data[i].size() < h+1:
			data[i].append(-1)
	
	height = h+1
	
func resize_up(h):
	for i in range(0, width):
		while data[i].size() < h+1:
			data[i].push_front(-1)
	
	height = h+1

func _draw():
	for i in range(0, data.size()):
		for j in range(0, data[i].size()):
			var texture = data[i][j]
			if texture != -1:
				draw_texture_rect(textures[texture], Rect2(Vector2(i*64, j*64), Vector2(64, 64)), false)
	
	var c = Color(0, 0, 0)
	
	draw_line(Vector2((width+1)*64, 0), Vector2((width+1)*64, (height+1)*64), c)
	draw_line(Vector2(0, (height+1)*64), Vector2((width+1)*64, (height+1)*64), c)
	
	for i in range(0, data.size()+1):
		draw_line(Vector2(i*64, 0), Vector2(i*64, (height+1)*64), c)
		
	for i in range(0, data[0].size()+1):
		draw_line(Vector2(0, i*64), Vector2((width+1)*64, i*64), c)
		
	var y = get_pos().y
	draw_line(Vector2(0, 1024-y), Vector2((width+1)*64, 1024 - y), Color(1, 0, 0))

func export_level():
	var d = str2var(var2str(data))
	var objects = []
	
	for t in textures:
		objects.append([])
	
	for i in range(0, d.size()):
		for j in range(0, d[i].size()):
			if d[i][j] == 5 or d[i][j] == 6 or d[i][j] == 7:
				var block = d[i][j]
				objects[block].append([i, j, 1, 1])
			elif d[i][j] != -1 and ((i > 0 and d[i][j] != d[i-1][j]) or i == 0) and ((j > 0 and d[i][j] != d[i][j-1]) or j == 0):
				var block = d[i][j]
				var search_x = true
				var x = 0
				var h = []
				while search_x:
					if i+x >= width:
						x -= 1
						search_x = false
					elif d[i+x][j] != block:
						x -= 1
						search_x = false
					else:
						var search_y = true
						var y = 0
						while search_y:
							if j+y >= height:
								h.append(y)
								search_y = false
								
							elif d[i+x][j+y] != block:
								h.append(y)
								search_y = false
							y += 1
					x += 1
				
				var y = 1
				if h.size() > 0:
					h.sort()
					y = h[0]
					
				objects[block].append([i, j, x, y])
					
				#print(str(randi()) + ": " + str(x) + " " + str(y))
				for k in range(i, i+x):
					for l in range(j, j+y):
						d[k][l] = -1
							
	return [objects, get_pos().y/64, width, height]
	
func play_level():
	global.set_level_editor_data(export_level())
	get_tree().change_scene("res://scenes/level_editor_play.tscn")
	
func import_level(d):
	set_pos(Vector2(0, d[1]*64))
	width = d[2] + 1
	height = d[3] + 1
	clear_level()
	
	var type = 0
	for i in d[0]:
		for object in i:
			var x = object[0]
			var y = object[1]
			var w = object[2]
			var h = object[3]
			
			for k in range(x, x+w):
				for l in range(y, y+h):
					data[k][l] = type
		type += 1
		
	update()
	
func save_level(path):
	var d = {"data" : export_level()}
	
	var my_file = File.new()
	my_file.open(path, my_file.WRITE)
	my_file.store_string(d.to_json())
	my_file.close()
	
func load_level(path):
	var d = {}
	
	var my_file = File.new()
	if my_file.file_exists(path):
		my_file.open(path, my_file.READ)
		
		var content = my_file.get_as_text()
		print(content)
		d.parse_json(content)
			
		my_file.close()
	
		if d.has("data"):
			import_level(d["data"])