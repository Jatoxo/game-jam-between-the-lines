extends Control #PlayerCreation
@export var avatar_size: int = 96
@export var avatar_group: ButtonGroup
@export var avatar_textures: Array[Texture2D]  # index-matched to buttons
var username : String
var role : String
var id = 0#multiplayer.multiplayer_peer

func _ready() -> void:
	_build_buttons(avatar_size)
func get_selected_avatar() -> int:
	var pressed_button = avatar_group.get_pressed_button()
	if pressed_button == null:
		return 0
	var index = pressed_button.get_index()+1
	return index

func _build_buttons(size:int):
	for child in $VBoxContainer/GridContainer.get_children():
		child.custom_minimum_size = Vector2(size, size)  
		child.ignore_texture_size = true 
		child.size_flags_vertical = Control.SIZE_EXPAND_FILL 
		child.size_flags_horizontal = Control.SIZE_EXPAND_FILL 
		child.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		child.ignore_texture_size = true
	

func _on_line_edit_text_submitted(new_text: String) -> void:
	username = new_text


func _on_submit_pressed() -> void:
	username = $VBoxContainer/UsernameInput.text
	
	PlayerData.set_player.rpc_id(1,id,username,get_selected_avatar())
	if not username == null:
		get_tree().change_scene_to_file("res://scenes/idle.tscn")
		pass


	
