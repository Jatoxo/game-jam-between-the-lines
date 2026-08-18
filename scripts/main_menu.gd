extends GameScene


func _on_join_game_pressed() -> void:
	change_scene("res://scenes/join_game.tscn")


func _on_create_game_pressed() -> void:
	change_scene("res://scenes/lobby/host_game.tscn")
