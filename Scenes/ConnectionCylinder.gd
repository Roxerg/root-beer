extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var node1 = null
var node2 = null
onready var mesh = get_node("MeshInstance")
onready var init_transform = mesh.transform
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# print(atan2(sphere1.transform.origin, sphere2.transform.origin))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if node1 == null:
		return
	
	var pos1 = node1.get_global_translation()
	var pos2 = node2.get_global_translation()
	
	# var xxx = sphere2.get_global_position()
	
	# var midpoint = pos1+pos2
	# self.translation.x = midpoint.x
	# self.translation.z = midpoint.y

	# var angle = pos1.angle_to(pos2)
	# print(angle)
	var dist = pos1.distance_to(pos2)
	mesh.mesh.height = dist
	mesh.translation.z = -dist / 2
	# print(pos1)
	look_at(pos1, Vector3.RIGHT)
