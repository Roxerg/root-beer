extends MeshInstance

var glow_color = Color(1, 1, 0, 1)
var glow_width = 1.0
var glow_enabled = false

func _input(event):
	if event is InputEventMouseMotion:
		# check if the mouse is over the mesh
		if get_world_2d().get_collision_segment_with_triangles(event.position, event.position + Vector2(0, 1)).collider == self:
			# if the mouse is over the mesh, turn on the glow effect
			glow_enabled = true
		else:
			# if the mouse is not over the mesh, turn off the glow effect
			glow_enabled = false
		
func _process(delta):
	if glow_enabled:
		# if the glow effect is enabled, draw a glowing outline around the mesh
		draw_rect(Rect2(-0.5, -0.5, 1, 1), glow_color, false, glow_width)
		draw_rect(Rect2(-0.5 + glow_width, -0.5 + glow_width, 1 - 2 * glow_width, 1 - 2 * glow_width), Color(0, 0, 0, 0), false)
