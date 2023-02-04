extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const suspect_object = preload("res://Scenes/Suspect.tscn")
var free_z = -3
const z_increment = 0.6
const x_pos = -2
const y_pos = 0

var suspects = [
	"Gonker Monker",
	"Grunkle Bob",
	"Jerry",
	"Smorg Smorgosbord",
	"Blooper Blonser",
	"Fondeler Franz",
	"Marty McFart"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	for suspect in suspects:
		var sus = suspect_object.instance()
		sus.suspect_name = suspect
		self.add_child(sus)
		sus.translation.x = x_pos
		sus.translation.y = y_pos
		sus.translation.z = free_z
		free_z += z_increment
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
