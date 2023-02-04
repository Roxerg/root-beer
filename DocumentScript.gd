extends MeshInstance


var currently_focused = false


func _on_Area_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			currently_focused = true
		var viewport_pos = get_viewport().get_mouse_position()
		var from = CursorController.camera.project_ray_origin(viewport_pos)
		var to = from + CursorController.camera.project_ray_normal(viewport_pos) * 100
		var cursorPos = Plane(Vector3.UP, transform.origin.y).intersects_ray(from, to)
		if cursorPos != self.global_transform.origin:
			print("cursor", viewport_pos, "cast",  cursorPos, "object ", self.global_transform.origin)

func _process(delta):
	if currently_focused and CursorController.mouse_held:
		var viewport_pos = get_viewport().get_mouse_position()
		var from = CursorController.camera.project_ray_origin(viewport_pos)
		var to = from + CursorController.camera.project_ray_normal(viewport_pos) * 100
		var cursorPos = Plane(Vector3.UP, transform.origin.y).intersects_ray(from, to)
		self.global_transform.origin.x = lerp(self.global_transform.origin.x, cursorPos.x, delta*25)
		self.global_transform.origin.z = lerp(self.global_transform.origin.z, cursorPos.z, delta*25)
		
	else:
		currently_focused = false
	
	
		
