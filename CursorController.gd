extends Spatial

var mouse_held = false
var suspectList =  [
	"Gonker Monker",
	"Grunkle Bob",
	"Jerry",
	"Smorg Smorgosbord",
	"Blooper Blonser",
	"Fondeler Franz",
	"Marty McFart"
]
var suspectChain = []
var suspectInfo = {}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(1):
		mouse_held = true
	else:
		mouse_held = false
