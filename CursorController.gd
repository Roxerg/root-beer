extends Spatial

onready var camera = get_node("/root/Level/Camera")

var is_win = false
var mouse_held = false

var suspectList =  []
var suspectChain = []
var winChain = [
	"Whiskers",
	"Socks",
	"Fluffy"
]
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
		
	if suspectChain == winChain:
		is_win = true

func add_new_suspect_name(sus_name):
	if not suspectList.has(sus_name):
		suspectList.append(sus_name)

