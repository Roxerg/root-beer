extends Spatial


onready var camera = get_node("/root/Room/Camera")
var mouse_held = false
var hitWall = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var docs_layer = []
var top_y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(1):
		mouse_held = true
	else:
		mouse_held = false

func update_docs_layers(doc):
	docs_layer.erase(doc)
	docs_layer.append(doc)
	for idx in len(docs_layer):
		docs_layer[idx].global_transform.origin.y = idx*0.001
	
