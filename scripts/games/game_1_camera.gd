extends Camera2D

onready var player_1 = get_parent().get_node("player_1")
onready var player_2 = get_parent().get_node("player_2")

func _ready():
	set_process(true)
	
func _process(delta):
	var x_1 = player_1.get_pos().x
	var x_2 = player_2.get_pos().x
	
	var x = x_1
	if x_2 > x:
		x = x_2
		
	if abs(x_2 - x_1) > 64 * 4:
		print("Done")
	
	set_pos(Vector2(x, 0))
	
	print(get_viewport_rect().size)

