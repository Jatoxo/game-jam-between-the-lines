extends VBoxContainer # Comment
@onready var username_label = $Comment/ContentBox/Header/Username
@onready var text_box = $Comment/ContentBox/MarginContainer/Text
@onready var avatar_box = $Comment/ContentBox/Header/Avatar
@onready var replies_box = $IndentedReplies/RepliesBox
var texture = load("res://icon.svg")
var author : int

func setup(username:String,text:String,avatar:Texture):
	username_label.text = username
	text_box.text = text
	avatar_box.texture = avatar

func add_reply(username:String,text:String,avatar:Texture):
	var CommentScene = load("res://scenes/comment_root.tscn")
	var reply = CommentScene.instantiate()
	replies_box.add_child(reply)
	reply.setup(username,text,avatar)
	return reply


func _on_reply_button_pressed() -> void:
	PlayerData.set_player(0,"anton",2)
	add_reply(PlayerData.players[0]["username"], "ich bin ein berliner",PlayerData.get_avatar_texture(PlayerData.players[0]["avatar_id"]) )
	pass
