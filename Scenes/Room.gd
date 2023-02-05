extends Spatial

<<<<<<< HEAD
var light

func _ready():
	light = get_node("/root/main_light")

func _process(delta):
	if is_pointing_at_object():
		light.set_param(LIGHT_PARAM_RANGE, 10)
		light.set_param(LIGHT_PARAM_ATTENUATION, 1)
	else:
		light.set_param(LIGHT_PARAM_RANGE, 5)
		light.set_param(LIGHT_PARAM_ATTENUATION, 0.5)

func is_pointing_at_object():
	# Code to determine if mouse is pointing at object
	# Return true or false
	return true
=======
func _input(event):
	if event is InputEventKey and event.is_pressed() and event.scancode == KEY_2:
		get_tree().change_scene("Scenes/Computer.tscn")
>>>>>>> jacob
