extends Control


var blanks = ResourceGlobal.blanks

func _ready() -> void:
	generateBlanks()
	for i in 3:
		var node = get_node(get_text_path(i)+"/TextureButton")
		node.pressed.connect(func(): _on_button_pressed(i))

func get_text_path(num:int) -> String:
	return "ScrollContainer/VBoxContainer/CommentCard%s/PanelContainer" %num

func generateBlanks():
	blanks.shuffle()
	for i in 3:
		var node = get_node(get_text_path(i)+"/RichTextLabel")
		node.text = blanks[i]
		pass
		
func _on_button_pressed(num : int):
	var scene = load("res://scenes/filler_selection.tscn")
	var instance = scene.instantiate()
	instance.blank = blanks[num]
	get_tree().change_scene_to_node(instance)
	pass
