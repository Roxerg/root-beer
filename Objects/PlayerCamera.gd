extends Camera

var speed = 0.6
var edge_margin = 50
var screen_size = Vector2(0,0)
var y_rot = 0
var x_rot = 0
var x_rot_limit = 45

func _ready():
	screen_size = get_viewport().size

func _process(delta):
	screen_size = get_viewport().size
	var mouse_pos = get_viewport().get_mouse_position()
	var x_rot_delta = 0
	var y_rot_delta = 0

	if mouse_pos.x < edge_margin:
		y_rot_delta = speed * delta
	elif mouse_pos.x > screen_size.x - edge_margin:
		y_rot_delta = -speed * delta

	if mouse_pos.y < edge_margin:
		x_rot_delta = speed * delta
	elif mouse_pos.y > screen_size.y - edge_margin:
		x_rot_delta = -speed * delta

	y_rot += y_rot_delta
	x_rot = min(max(x_rot + x_rot_delta, -x_rot_limit), x_rot_limit)

	set_rotation(Vector3(x_rot, y_rot, 0))
