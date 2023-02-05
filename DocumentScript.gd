extends MeshInstance


var currently_focused = false
var drag_start = 0
var zoomed_in = false
var orig_transform
onready var deselect_checker_left = get_node("ExitClick/CollisionShape")
onready var deselect_checker_right = get_node("ExitClick/CollisionShape2")

func _ready():
	CursorController.docs_layer.append(self)
	deselect_checker_left.disabled = true
	deselect_checker_right.disabled = true
	
func _on_Area_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and not zoomed_in:
		if event.button_index == BUTTON_LEFT and event.pressed:
			drag_start = event.position
			currently_focused = true
			self.global_transform.origin.y=1
		elif event.button_index == BUTTON_LEFT and not event.pressed:
			CursorController.update_docs_layers(self)			
			if (event.position - drag_start).length() < 10:
				$Meow.play()
				# If the distance between the start and end of the mouse movement is less than 5, it's a click
				if not zoomed_in:
					zoomed_in = true
					orig_transform = self.global_transform.origin
					deselect_checker_left.disabled = false
					deselect_checker_right.disabled = false
					self.global_transform.origin.x=0
					self.global_transform.origin.z=0
					self.global_transform.origin.y=6
		var viewport_pos = get_viewport().get_mouse_position()
		var from = CursorController.camera.project_ray_origin(viewport_pos)
		var to = from + CursorController.camera.project_ray_normal(viewport_pos) * 100
		var cursorPos = Plane(Vector3.UP, transform.origin.y).intersects_ray(from, to)
		if cursorPos != self.global_transform.origin:
			print("cursor", viewport_pos, "cast",  cursorPos, "object ", self.global_transform.origin)

func _process(delta):
	if currently_focused and CursorController.mouse_held and not zoomed_in:
		var viewport_pos = get_viewport().get_mouse_position()
		var from = CursorController.camera.project_ray_origin(viewport_pos)
		var to = from + CursorController.camera.project_ray_normal(viewport_pos) * 100
		var cursorPos = Plane(Vector3.UP, transform.origin.y).intersects_ray(from, to)
		self.global_transform.origin.x = lerp(self.global_transform.origin.x, cursorPos.x, delta*25)
		self.global_transform.origin.z = lerp(self.global_transform.origin.z, cursorPos.z, delta*25)
	else:
		currently_focused = false


func _on_ExitClick_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			self.global_transform.origin = orig_transform
			deselect_checker_left.disabled = true
			deselect_checker_right.disabled = true
			zoomed_in = false
