extends CanvasLayer

var time = 0
onready var text_coins = get_node("coins")
onready var text_time = get_node("time")

func _ready():
	update_gui()
	set_process(true)
	
func _process(delta):
	time += delta
	var t = round(time*10)
	text_time.set_text(str(t))
	global.time = t

func update_gui():
	text_coins.set_text(str(global.coins))