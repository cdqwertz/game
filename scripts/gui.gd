extends CanvasLayer

onready var coins = get_node("coins")

func _ready():
	update_gui()

func update_gui():
	coins.set_text(str(global.coins))