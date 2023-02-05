extends Spatial

func _input(event):
	if event is InputEventKey and event.is_pressed() and event.scancode == KEY_1:
		get_tree().change_scene("Scenes/Room.tscn")
	elif event is InputEventKey and event.is_pressed() and event.scancode == KEY_2:
		get_tree().change_scene("Scenes/Computer.tscn")
	elif event is InputEventKey and event.is_pressed() and event.scancode == KEY_3:
		get_tree().change_scene("res://Scenes/Desktop.tscn")
