extends VBoxContainer # Comment
@onready var username_label = $Comment/ContentBox/Header/Username
@onready var text_box = $Comment/ContentBox/MarginContainer/Text
@onready var avatar_box = $Comment/ContentBox/Header/Avatar
@onready var replies_box = $IndentedReplies/RepliesBox
var commentID : int
var texture = load("res://icon.svg")
var author : int

func setup(username:String,text:String,avatarID:int):
	username_label.text = username
	text_box.text = text
	avatar_box.texture = PlayerData.get_avatar_texture(avatarID)
	

func add_reply(username:String,text:String,avatarID:int):
	var CommentScene = load("res://scenes/comment_root.tscn")
	var reply = CommentScene.instantiate()
	replies_box.add_child(reply)
	reply.setup(username,text,avatarID)
	return reply

func attach_reply(reply_node: Node):
	$IndentedReplies/RepliesBox.add_child(reply_node)
	
func _on_reply_button_pressed() -> void:
	PlayerData.set_player("anton",2)
	add_reply(PlayerData.players[0]["username"], "ich bin ein berliner",1 )
	pass
