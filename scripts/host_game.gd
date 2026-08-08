extends "res://scripts/ui_screen.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lobby.create_game()


# Close the whole lobby when we exit
func on_go_back():
	Lobby.remove_multiplayer_peer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
