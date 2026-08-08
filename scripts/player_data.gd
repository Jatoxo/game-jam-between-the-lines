extends Node


var players : Dictionary = {}

func set_player(id:int,username:String,avatar:int):
	if not players.has(id):
		players[id] = {}
	players[id]["username"] = username
	players[id]["avatar_id"] = avatar
	pass

func get_avatar_texture(avatar_id: int) -> Texture2D:
	var path = "res://assets/pictures/ava/ava%d.png" % avatar_id
	return load(path) as Texture2D
	
