extends Control
var role_name : String = "Fan"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/CenterContainer/Role.set_role(role_name)
	pass # Replace with function body.


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/idle.tscn")
	
