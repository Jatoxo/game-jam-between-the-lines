extends Node

var roles : Array = ["Fact checker","Politician","Boomer", "Conspiracy theorist","Bot","Hater","Fan","Zoomer"]
var players : Dictionary = {}
var role_path : Dictionary = {"Fact checker":"res://assets/pictures/roles/faktencheck.png","Politician":"res://assets/pictures/roles/politishian_role.png","Boomer":"res://assets/pictures/roles/rentnerin.png", "Conspiracy theorist":"","Bot":"","Hater":"","Fan":"","Zoomer":"","standard":"res://assets/pictures/roles/standardrolle.png"}

func set_player(id:int,username:String,avatar:int):
	if not players.has(id):
		players[id] = {}
	players[id]["username"] = username
	players[id]["avatar_id"] = avatar
	pass

func get_avatar_texture(avatar_id: int) -> Texture2D:
	var path = "res://assets/pictures/ava/ava%d.png" % avatar_id
	return load(path) as Texture2D
	
func role_assignment(id : int) -> String:
	roles.shuffle()
	players[id]["role"] = roles[id]
	return players[id]["role"]
