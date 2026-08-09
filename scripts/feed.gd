extends Control

var comment_nodes: Dictionary = {}
var startingText: String = "Hey Everyone, I have a question. Is it true that back then, in the time of the Frog King, there were pink frogs?"
@export var startingUser : String = "Rapunzel"
@export var startingAvatar : int = 1

func _ready() -> void:
	if not Lobby.active_game:
		Lobby.active_game = CommentGame.new()
	var root_node = $ScrollContainer/CommentRoot
	root_node.commentID = 0
	comment_nodes["0"] = root_node
	root_node.setup(startingUser, startingText, startingAvatar)

	Lobby.active_game.comment_added.connect(_on_comment_added)
	
func _on_comment_added(comment:Dictionary):
	var CommentScene = load("res://comment_root.tscn")
	var node = CommentScene.instantiate()
	node.comment_id = comment["commentID"]
	node.setup(comment["username"], comment["text"], comment["avatarID"])
	comment_nodes[comment["commentID"]] = node
	var parent_id = comment["parentID"]
	if parent_id == "" or not comment_nodes.has(parent_id):
		$ScrollContainer/CommentRoot/IndentedReplies/RepliesBox.add_child(node)
	else:
		comment_nodes[parent_id].attach_reply(node)
		
		
