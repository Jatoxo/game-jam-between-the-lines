extends Node
class_name GameScene

@export var previousScreen : PackedScene

@onready
var game_manager = GameManager.of(self)


func change_scene(new_scene_path : String):
	# If it does, use it do scene transition
	
	if not game_manager:
		# This is kinda cursed, since this only works because the methods have 
		# the same name
		game_manager = get_tree()
		
	game_manager.change_scene_to_file(new_scene_path)
	

func on_go_back():
	pass
	
func go_back():
	on_go_back()
	
	if not game_manager:
		game_manager = get_tree()
	
	game_manager.change_scene_to_packed(previousScreen)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		# Deferred is requiered to prevent new scene from immediately
		# also receiving this signal
		call_deferred("go_back")



func _on_back_button_pressed() -> void:
	go_back()
	
