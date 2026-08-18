
extends GameScene


@export var avatar_size: int = 150
@export var avatar_group: ButtonGroup
@export var avatar_textures: Array[Texture2D]  # index-matched to buttons
var username : String
var role : String


func get_selected_avatar() -> int:
	var pressed_button = avatar_group.get_pressed_button()
	if pressed_button == null:
		return 0
	var index = pressed_button.get_index()+1
	return index


func _on_line_edit_text_submitted(new_text: String) -> void:
	username = new_text


func _on_submit_pressed() -> void:
	username = $VBoxContainer/UsernameInput.text
	username = username.strip_edges()
	
	if len(username) == 0 or get_selected_avatar() == 0:
		return
	
	PlayerData.set_player.rpc_id(1,username,get_selected_avatar())
	Lobby.client_avatar_id = get_selected_avatar()
	Lobby.client_username = username
	 
	if not username == null:
		get_tree().change_scene_to_file("res://scenes/idle.tscn")
		pass

# Leave lobby
func on_go_back():
	Lobby.remove_multiplayer_peer()
