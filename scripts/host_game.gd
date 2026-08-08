extends "res://scripts/ui_screen.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lobby.create_game()

func _on_go_back():
	print("Yaheet")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
