extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_W):
		translation.z -= 0.05
	if Input.is_key_pressed(KEY_A):
		translation.x -= 0.05
	if Input.is_key_pressed(KEY_S):
		translation.z += 0.05
	if Input.is_key_pressed(KEY_D):
		translation.x += 0.05
