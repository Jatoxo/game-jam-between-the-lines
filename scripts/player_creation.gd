extends Control #PlayerCreation
@export var avatar_size: int = 96
@export var avatar_group: ButtonGroup
@export var avatar_textures: Array[Texture2D]  # index-matched to buttons
var username : String
var role : String
var id = 0 #get_id..

func _ready() -> void:
	_build_buttons(avatar_size)
func get_selected_avatar() -> int:
	var pressed_button = avatar_group.get_pressed_button()
	if pressed_button == null:
		return 0
	var index = pressed_button.get_index()+1
	return index

func _build_buttons(size:int):
	for child in $AspectRatioContainer/VBoxContainer/GridContainer.get_children():
		child.custom_minimum_size = Vector2(size, size)  
		child.ignore_texture_size = true 
		child.size_flags_vertical = Control.SIZE_EXPAND_FILL 
		child.size_flags_horizontal = Control.SIZE_EXPAND_FILL 
		child.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		child.ignore_texture_size = true
	

func _on_line_edit_text_submitted(new_text: String) -> void:
	username = new_text


func _on_submit_pressed() -> void:
	username = $AspectRatioContainer/VBoxContainer/UsernameInput.text
	PlayerData.set_player(id,username,get_selected_avatar()) 
	if not username == null:
		#exit scene
		$AspectRatioContainer/VBoxContainer.hide()
		role = PlayerData.role_assignment(id)
		$AspectRatioContainer/TextureRect.texture = load(PlayerData.role_path[role])
		$AspectRatioContainer/TextureRect.show()
		print(PlayerData.players[id])
		pass


	
