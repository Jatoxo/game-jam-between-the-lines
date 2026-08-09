extends Node

# Autoload named Lobby


# ---- Game State -------

# Ongoing full game (Server only)
var active_game : CommentGame

# Client game state (Client Only)
var client_state : ClientState

# -------------------------

var client_username
var client_avatar_id


# These signals can be connected to by a UI lobby scene or the game scene.
signal player_connected(peer_id, player_info)
signal player_disconnected(peer_id)
signal server_disconnected

signal player_identity_changed(peer_id)

const PORT = 1182
const DEFAULT_SERVER_IP = "127.0.0.1" # IPv4 localhost
const MAX_CONNECTIONS = 10


func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)


func join_game(address = "", port : int = -1):
	if address.is_empty():
		address = DEFAULT_SERVER_IP
	if port == -1:
		port = PORT
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(address, PORT)
	if error:
		return error
	multiplayer.multiplayer_peer = peer


func create_game():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, MAX_CONNECTIONS)
	if error:
		return error
	multiplayer.multiplayer_peer = peer

	#players[1] = player_info
	#player_connected.emit(1, player_info)
	


func remove_multiplayer_peer():
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
	#players.clear()


# When the server decides to start the game from a UI scene,
# do Lobby.load_game.rpc(filepath)
@rpc("call_local", "reliable")
func load_game(game_scene_path):
	get_tree().change_scene_to_file(game_scene_path)




# Every peer will call this when they have loaded the game scene.
@rpc("any_peer", "call_local", "reliable")
func player_loaded():
	if multiplayer.is_server():
		pass
		#players_loaded += 1
		#if players_loaded == players.size():
		#	$/root/Game.start_game()
		#	players_loaded = 0


# ONLY SERVER
func start_game():
	if not multiplayer.is_server():
		return 
		
	active_game = CommentGame.new()


func start_game_client():
	print("Starting client game")
	client_state = ClientState.new()



func _on_player_connected(id):
	player_connected.emit(id, null)
	pass


func _on_player_disconnected(id):
	#players.erase(id)
	player_disconnected.emit(id)

func _on_connected_ok():
	var peer_id = multiplayer.get_unique_id()
	#players[peer_id] = player_info
	#player_connected.emit(peer_id, player_info)

func _on_connected_fail():
	remove_multiplayer_peer()


func _on_server_disconnected():
	remove_multiplayer_peer()
	#players.clear()
	server_disconnected.emit()
	

@rpc("authority","call_remote","reliable")
func displayRole(role : String):
	var role_scene = load("res://scenes/role_assigment.tscn")
	var instance = role_scene.instantiate()
	instance.role_name = role
	get_tree().change_scene_to_node(instance)
	
