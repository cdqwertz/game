extends CanvasLayer

var time = 0
onready var text_coins = get_node("coins")
onready var text_time = get_node("time")

func _ready():
	update_gui()
	set_process(true)
	
func _process(delta):
	time += delta
	text_time.set_text(str(round(time*10)))

func update_gui():
	text_coins.set_text(str(global.coins))