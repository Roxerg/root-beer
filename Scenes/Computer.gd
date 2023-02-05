extends Spatial


var sound_player
var timer

func _ready():
	
	timer = get_node("Timer")
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.start()



func _on_Timer_timeout():
	sound_player = get_node("TypingSound")
	sound_player.play()

