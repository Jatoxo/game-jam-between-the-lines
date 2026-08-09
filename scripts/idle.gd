extends "res://scripts/ui_screen.gd"

@onready
var playerHint : PlayerSlot = $PanelContainer

@onready
var roleHint : RoleCard = $Role


func _ready():
	Lobby.player_disconnected.connect(player_disconnected)
	
	if Lobby.client_username:
		playerHint.playerName = Lobby.client_username
		playerHint.avatar = PlayerData.get_avatar_texture(Lobby.client_avatar_id)
	
	if Lobby.client_state:
		roleHint.set_role(Lobby.client_state.role)
		roleHint.visible = true


func player_disconnected(id : int):
	if id == 1:
		print("SERVER DIED PANIC PANIC OH NOO")
		go_back()

# Leave the lobby on exit
func on_go_back():
	print("Disconnecting")
	Lobby.remove_multiplayer_peer()
	
