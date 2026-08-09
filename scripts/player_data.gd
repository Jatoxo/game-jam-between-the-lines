extends Node

var players : Dictionary = {}
var role_path : Dictionary = {"Fact checker":"res://assets/pictures/roles/faktencheck.png","Politician":"res://assets/pictures/roles/politishian_role.png","Boomer":"res://assets/pictures/roles/rentnerin.png", "Conspiracy theorist":"res://assets/pictures/roles/conspiracy_role.png","Bot":"res://assets/pictures/roles/bot_role.png","Hater":"res://assets/pictures/roles/hater_role.png","Fan":"res://assets/pictures/roles/fan_role.png","Zoomer":"res://assets/pictures/roles/zoomer_role.png","standard":"res://assets/pictures/roles/standardrolle.png"}

@rpc("any_peer","call_remote","reliable")
func set_player(username:String,avatar:int):
	var id = multiplayer.get_remote_sender_id()
	if not players.has(id):
		players[id] = {}
	players[id]["username"] = username
	players[id]["avatar_id"] = avatar
	
	Lobby.emit_signal("player_identity_changed", id)
	pass

func get_avatar_texture(avatar_id: int) -> Texture2D:
	var path = "res://assets/pictures/ava/ava%d.png" % avatar_id
	return load(path) as Texture2D
