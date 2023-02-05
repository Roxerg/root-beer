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

var string_chain = []

var prev_len = 0
var last_sus_name = null
var last_sus_obj = null

var suspectInfo = {}

var connection_vertical_coord = -3
var connection_vertical_step = 0.6
# Called when the node enters the scene tree for the first time.
func _ready():
	prev_len = CursorController.suspectChain.size()
	pass # Replace with function body.
	for suspect in CursorController.suspectList:
		var sus = suspect_object.instance()
		self.add_child(sus)
		sus.set_sus_name(suspect)
		sus.translation.x = x_pos
		sus.translation.y = y_pos
		sus.translation.z = free_z
		sus.scale = Vector3(sus_scale, sus_scale, sus_scale)
		free_z += z_increment
		suspectInfo[suspect] = {
			"name": suspect,
			"list_translation" : sus.translation,
			"node": sus,
			"in_list" : true
		}
	for suspect in CursorController.suspectChain:
		var sus = suspect_object.instance()
		sus.suspect_name = suspect
		self.add_child(sus)
		sus.set_sus_name(suspect)
		sus.translation.x = 3
		sus.translation.z = connection_vertical_coord
		sus.translation.y = y_pos
		sus.scale = Vector3(sus_scale, sus_scale, sus_scale)
		connection_vertical_coord += connection_vertical_step
		suspectInfo[suspect] = {
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
			var last_info = suspectInfo[last_sus_name]
			suspectInfo[last_sus_name]["node"].translation = last_info["list_translation"]
			connection_vertical_coord -= connection_vertical_step
			last_info["in_list"] = true
			last_sus_name = null
			if string_chain.size() != 0:
				var last_string = string_chain.pop_back()
				self.remove_child(last_string)
				last_string.queue_free()
		
		var latest_name = null
		var latest_info = null
		if prev_len != 0:
			latest_name = CursorController.suspectChain[-1]	
			latest_info = suspectInfo[latest_name] 
		
		if latest_info != null and latest_info["in_list"]:
			suspectInfo[latest_name]["node"].translation.x = 3
			suspectInfo[latest_name]["node"].translation.z = connection_vertical_coord
			connection_vertical_coord += connection_vertical_step
			latest_info["in_list"] = false
			
			
			if last_sus_name != null:
				var conn = string_object.instance()
				self.add_child(conn)
				conn.translation = suspectInfo[latest_name]["node"].translation
				conn.translation.y = suspectInfo[latest_name]["node"].translation.y - 0.3
				conn.node2 = suspectInfo[latest_name]["node"]
				conn.node1 = suspectInfo[last_sus_name]["node"]
				string_chain.push_back(conn)
			
			last_sus_name = latest_name
		elif last_sus_name != null:
			var last_info = suspectInfo[last_sus_name]
			suspectInfo[last_sus_name]["node"].translation = last_info["list_translation"]
			connection_vertical_coord -= connection_vertical_step
			last_info["in_list"] = true
			if string_chain.size() > 0:
				var conn = string_chain.pop_back()
				self.remove_child(conn)
				conn.queue_free()
			if CursorController.suspectChain.size() > 0:
				last_sus_name = CursorController.suspectChain[-1]
			else:
				last_sus_name = null
		
		if last_sus_name != null:
			print("last_sus: ", last_sus_name)
		print("stringeroo", string_chain.size())
			
