extends Node
class_name SceneManager

# This where the actual scenes be chilling
@onready
var scene_stack = $SceneStack

# Change the scene
# This custom way allows retaining things across scenes, or implementing 
# scene transitions
func change_scene_to_file(new_scene_path : String):
	var new_scene : PackedScene = load(new_scene_path)
	
	change_scene_to_packed(new_scene)

func change_scene_to_packed(new_scene : PackedScene):
	if scene_stack.get_child_count() != 0:
		# There is another scene currently active
		var current_scene = scene_stack.get_child(0)
	
		# Bye bye old scene
		current_scene.queue_free()
	
	# Add the new scene
	var new_scene_node = new_scene.instantiate()
	scene_stack.add_child(new_scene_node)
	
	
