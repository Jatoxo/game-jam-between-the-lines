extends Control
var role_name : String = "Fan"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/CenterContainer/Role.set_role(role_name)
	pass # Replace with function body.



func _on_acknowledge_pressed() -> void:
	Lobby.acknowledge_role.rpc_id(1)
	get_tree().change_scene_to_file("res://scenes/idle.tscn")
