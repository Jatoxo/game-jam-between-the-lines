extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_join_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/join_game.tscn")


func _on_create_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/lobby/host_game.tscn")

	
func _on_mock_game_pressed() -> void:
	MockServer.start_game()
	get_tree().change_scene_to_file("res://scenes/role_assigment.tscn")
