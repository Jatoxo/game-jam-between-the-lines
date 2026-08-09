extends "res://scripts/ui_screen.gd"


@export var placeholderPlayerIcon : Texture2D

@onready var playerList : PlayerList = $VBoxContainer/PlayerList

@onready var startButton = $VBoxContainer/StartGame/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lobby.create_game()
	
	Lobby.player_connected.connect(_player_connected)
	Lobby.player_disconnected.connect(_player_disconnected)
	Lobby.player_identity_changed.connect(_player_identity_changed)
	
	
func _player_connected(id : int, info):
	playerList.add_player(id, placeholderPlayerIcon, "Choosing a name...")
	startButton.disabled = not Lobby._is_ready_to_start()

func _player_disconnected(id : int):
	playerList.remove_player(id)
	startButton.disabled = not Lobby._is_ready_to_start()

func _player_identity_changed(id : int):
	var avatar_id = PlayerData.players[id]["avatar_id"]
	var username = PlayerData.players[id]["username"]
	
	var playerIcon = PlayerData.get_avatar_texture(avatar_id)
	
	playerList.edit_player(id, playerIcon, username)
	
	startButton.disabled = not Lobby._is_ready_to_start()


# Close the whole lobby when we exit
func on_go_back():
	Lobby.remove_multiplayer_peer()

# Start Game button
func _on_button_pressed() -> void:
	if Lobby._is_ready_to_start():
		Lobby.start_game()
