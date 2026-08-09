extends Control
var role_name : String = "Boomer"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if MockServer.active and MockServer.player_role != "":
		role_name = MockServer.player_role
	$VBoxContainer/CenterContainer/Role.set_role(role_name)
	pass # Replace with function body.


func _on_button_pressed() -> void:
	if MockServer.active:
		get_tree().change_scene_to_file("res://scenes/blank_selection.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/idle.tscn")
