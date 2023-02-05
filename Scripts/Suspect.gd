extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var label = get_node("Label3D")


var suspect_connections = []
var suspect_name = "Guy McGyverson"

var characters = 'abcdefghijklmnopqrstuvwxyz'

func _ready():
	label.text = suspect_name

func generate_word(chars, length):
	var word: String
	var n_char = len(chars)
	for i in range(length):
		word += chars[randi()% n_char]
	return word

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if CursorController.suspectChain.size() > 0 and CursorController.suspectChain[-1] == self:
				CursorController.suspectChain.pop_back()
			elif not CursorController.suspectChain.has(self):
				CursorController.suspectChain.push_back(self)
			print(CursorController.suspectChain.size())
