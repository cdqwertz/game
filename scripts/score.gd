extends Control

var text = ""
export var font = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
export(Texture) var texture

func _ready():
	pass
	
func _draw():
	var size = get_size()
	var i = 0
	for c in text:
		var p = font.find(c)
		var r = Rect2(Vector2(p*5, 0), Vector2(5, 7))
		
		draw_texture_rect_region(texture, Rect2(Vector2(i*size.x*1.2, 0), Vector2(size.x, size.y)), r)
		
		i += 1
		
	print(size)
	update()
	
func set_text(t):
	text = t
	update()
