extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const suspect_object = preload("res://Scenes/Suspect.tscn")
const string_object = preload("res://Scenes/ConnectionCylinder.tscn")
var free_z = -3
const z_increment = 0.4
const x_pos = -3
const y_pos = 0
const sus_scale = 0.6

var suspects = [
	"Gonker Monker",
	"Grunkle Bob",
	"Jerry",
	"Smorg Smorgosbord",
	"Blooper Blonser",
	"Fondeler Franz",
	"Marty McFart"
]

var string_chain = []

var prev_len = 0
var last_sus = null
var connection_vertical_coord = -3
var connection_vertical_step = 0.6
# Called when the node enters the scene tree for the first time.
func _ready():
	prev_len = CursorController.suspectChain.size()
	pass # Replace with function body.
	for suspect in suspects:
		var sus = suspect_object.instance()
		sus.suspect_name = suspect
		self.add_child(sus)
		sus.translation.x = x_pos
		sus.translation.y = y_pos
		sus.translation.z = free_z
		sus.scale = Vector3(sus_scale, sus_scale, sus_scale)
		free_z += z_increment
		CursorController.suspectInfo[suspect] = {
			"name": suspect,
			"list_translation" : sus.translation,
			"node": sus,
			"in_list" : true
		}
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if prev_len != CursorController.suspectChain.size():
		prev_len = CursorController.suspectChain.size()
		
		if prev_len == 0:
			var last_info = CursorController.suspectInfo[last_sus.suspect_name]
			last_sus.translation = last_info["list_translation"]
			connection_vertical_coord -= connection_vertical_step
			last_info["in_list"] = true
			last_sus = null
			if string_chain.size() != 0:
				var last_string = string_chain.pop_back()
				self.remove_child(last_string)
				last_string.queue_free()
		
		var latest = null
		var latest_info = null
		if prev_len != 0:
			latest = CursorController.suspectChain[-1]	
			latest_info = CursorController.suspectInfo[latest.suspect_name] 
		
		if latest_info != null and latest_info["in_list"]:
			latest.translation.x = 3
			latest.translation.z = connection_vertical_coord
			connection_vertical_coord += connection_vertical_step
			latest_info["in_list"] = false
			
			
			if last_sus != null:
				var conn = string_object.instance()
				self.add_child(conn)
				conn.translation = latest.translation
				conn.translation.y = latest.translation.y - 0.3
				conn.node2 = latest
				conn.node1 = last_sus
				string_chain.push_back(conn)
			
			last_sus = latest
		elif last_sus != null:
			var last_info = CursorController.suspectInfo[last_sus.suspect_name] 
			last_sus.translation = last_info["list_translation"]
			connection_vertical_coord -= connection_vertical_step
			last_info["in_list"] = true
			if string_chain.size() > 0:
				var conn = string_chain.pop_back()
				self.remove_child(conn)
				conn.queue_free()
			if CursorController.suspectChain.size() > 0:
				last_sus = CursorController.suspectChain[-1]
			else:
				last_sus = null
		
		if last_sus != null:
			print("last_sus: ", last_sus.suspect_name)
		print("stringeroo", string_chain.size())
			
