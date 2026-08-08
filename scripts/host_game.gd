extends "res://scripts/ui_screen.gd"


@export var placeholderPlayerIcon : Texture2D

@onready var playerList : PlayerList = $PlayerList



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lobby.create_game()
	
	Lobby.player_connected.connect(_player_connected)
	Lobby.player_disconnected.connect(_player_disconnected)
	Lobby.player_identity_changed.connect(_player_identity_changed)
	
	
func _player_connected(id : int, info):
	playerList.add_player(id, placeholderPlayerIcon, "Choosing a name...")

func _player_disconnected(id : int, info):
	playerList.remove_player(id)

func _player_identity_changed(id : int):
	var avatar_id = PlayerData.players[id]["avatar_id"]
	var username = PlayerData.players[id]["username"]
	
	var playerIcon = PlayerData.get_avatar_texture(avatar_id)
	
	playerList.edit_player(id, playerIcon, username)


# Close the whole lobby when we exit
func on_go_back():
	Lobby.remove_multiplayer_peer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
