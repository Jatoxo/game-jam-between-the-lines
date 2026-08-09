extends VBoxContainer # Comment
var username_label = "Comment/ContentBox/Header/Username"
var text_box = "Comment/ContentBox/MarginContainer/Text"
var avatar_box = "Comment/ContentBox/Header/Avatar"
@onready var replies_box = $IndentedReplies/RepliesBox
var commentID : int
var texture = load("res://icon.svg")
var author : int

func setup(username:String,text:String,avatarID:int):
	get_node(username_label).text = username
	get_node(text_box).text = text
	get_node(avatar_box).texture = PlayerData.get_avatar_texture(avatarID)
	

func add_reply(username:String,text:String,avatarID:int):
	var CommentScene = load("res://scenes/comment_root.tscn")
	var reply = CommentScene.instantiate()
	replies_box.add_child(reply)
	reply.setup(username,text,avatarID)
	return reply

func attach_reply(reply_node: Node):
	$IndentedReplies/RepliesBox.add_child(reply_node)
	
func _on_reply_button_pressed() -> void:
	var blank_node = load("res://scenes/blank_selection.tscn")
	var blank_instance = blank_node.instantiate()
	blank_instance.parentID = commentID
	get_tree().change_scene_to_node(blank_instance)
	
	pass
