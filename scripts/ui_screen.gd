extends Control

@export var previousScreen : PackedScene

func _on_go_back():
	print("Yuuuwaa")
	pass
	
func go_back():
	_on_go_back()
	get_tree().change_scene_to_packed(previousScreen)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		go_back()


func _on_back_button_pressed() -> void:
	go_back()
