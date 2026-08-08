extends Node

var roles : Array = ["Fact checker","Politician","Boomer", "Conspiracy theorist","Bot","Hater","Fan","Zoomer"]
var players : Dictionary = {}
var role_path : Dictionary = {"Fact checker":"res://assets/pictures/roles/faktencheck.png","Politician":"res://assets/pictures/roles/politishian_role.png","Boomer":"res://assets/pictures/roles/rentnerin.png", "Conspiracy theorist":"res://assets/pictures/roles/conspiracy_role.png","Bot":"res://assets/pictures/roles/bot_role.png","Hater":"res://assets/pictures/roles/hater_role.png","Fan":"res://assets/pictures/roles/fan_role.png","Zoomer":"","standard":"res://assets/pictures/roles/standardrolle.png"}

func set_player(id:int,username:String,avatar:int):
	if not players.has(id):
		players[id] = {}
	players[id]["username"] = username
	players[id]["avatar_id"] = avatar
	
	Lobby.emit_signal("player_identity_changed", id)
	pass

func get_avatar_texture(avatar_id: int) -> Texture2D:
	var path = "res://assets/pictures/ava/ava%d.png" % avatar_id
	return load(path) as Texture2D
	
func role_assignment(id : int) -> String:
	roles.shuffle()
	players[id]["role"] = roles[id]
	return players[id]["role"]
