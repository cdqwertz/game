extends Area2D

func _ready():
	connect("body_enter", self, "body_enter")

func body_enter(body):
	if body.is_in_group("player") or body.is_in_group("box"):
		global.add_coin()
		if body.is_in_group("player"):
			body.sample_player_coin.play("coin_1")
		
		queue_free()