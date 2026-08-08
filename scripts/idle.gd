extends "res://scripts/ui_screen.gd"

func _ready():
	Lobby.player_disconnected.connect(player_disconnected)
	

func player_disconnected(id : int):
	if id == 0:
		print("SERVER DIED PANIC PANIC OH NOO")
		go_back()

# Leave the lobby on exit
func on_go_back():
	print("Disconnecting")
	Lobby.remove_multiplayer_peer()
	
