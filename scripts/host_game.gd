extends "res://scripts/ui_screen.gd"


@export var placeholderPlayerIcon : Texture2D

@onready var playerList : PlayerList = $PlayerList



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lobby.create_game()
	
	Lobby.player_connected.connect(_player_connected)

func _player_connected(id : int, info):
	playerList.add_player(id, placeholderPlayerIcon, "Choosing a name...")


# Close the whole lobby when we exit
func on_go_back():
	Lobby.remove_multiplayer_peer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
