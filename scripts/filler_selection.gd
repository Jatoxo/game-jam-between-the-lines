extends Control

var blank : String
var fillers = ResourceGlobal.fillers

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$VBoxContainer/MarginContainer/PanelContainer.add_theme_style_override("modulate_color",Color.GREEN)
	$VBoxContainer/MarginContainer/PanelContainer/RichTextLabel.text = blank 
	for i in 2:
		var scene = load("res://scenes/comment_card.tscn")
		var instance = scene.instantiate()
		instance.name = "CommentCard%s" %(i+3)
		$VBoxContainer/ScrollContainer/VBoxContainer.add_child(instance)
	for i in 5:
		var node = get_node(get_text_path(i)+"/TextureButton")
		node.pressed.connect(func(): _on_button_pressed(i))

	generateFillers()

func get_text_path(num:int) -> String:
	return "VBoxContainer/ScrollContainer/VBoxContainer/CommentCard%s/PanelContainer" %num

func generateFillers():
	fillers.shuffle()
	for i in 5:
		var node = get_node(get_text_path(i)+"/RichTextLabel")
		node.text = fillers[i]["text"]

func _on_button_pressed(num : int):
	print(blank+fillers[num]["text"])
	pass
