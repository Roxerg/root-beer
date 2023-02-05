extends Spatial

func _input(event):
	if event is InputEventKey and event.is_pressed() and event.scancode == KEY_2:
		get_tree().change_scene("Scenes/Computer.tscn")
