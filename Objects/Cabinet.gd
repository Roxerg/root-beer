extends Spatial

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouse:
		var screen_pos = event.get_position()
		var ray = get_viewport().get_camera().get_camera_screen_ray(screen_pos)
		var result = get_tree().intersect_ray(ray, self)
		if result:
			var mesh = self.get_node("CabinetModel").get_mesh()
			mesh.materials[0].set_param("diffuse_color", Color(0.5, 0.5, 1))
		else:
			var mesh = self.get_node("CabinetModel").get_mesh()
			mesh.materials[0].set_param("diffuse_color", Color(1, 1, 1))
	return
