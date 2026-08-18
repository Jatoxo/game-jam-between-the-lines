extends Node
class_name GameManager

# So the idea with this is to manage scene transitions and stuff,
# so that we can do custom scene transitions and global audio and stuff.
# This isn't intended for any actual game business logic


@export
var scene_manager : SceneManager


static func of(node: Node) -> GameManager:
	var current := node
	while current:
		if current is GameManager:
			return current
		
		current = current.get_parent()
	
	# When no GameManager has been found, we create it?
	# (This feels kinda cursed, but if we start individual scenes, they
	# would stop functioning outside of a game manager)
	return null


func change_scene_to_file(new_scene_path : String):
	scene_manager.change_scene_to_file(new_scene_path)
	
func change_scene_to_packed(new_scene : PackedScene):
	scene_manager.change_scene_to_packed(new_scene)
