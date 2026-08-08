extends VBoxContainer
@onready var username_label = $Comment/ContentBox/Header/Username
@onready var text_box = $Comment/ContentBox/Text
@onready var avatar_box = $Comment/ContentBox/Header/Avatar
@onready var replies_box = $IndentedReplies/RepliesBox

func _ready():
	$Comment/ContentBox/Actions/ReplyButton.pressed.connect(_on_reply_button_pressed)

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
	pass
