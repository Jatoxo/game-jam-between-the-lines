extends Control

var blank : String
var fillers = ResourceGlobal.fillers
var parentID :int = Global.pending_comment["parentID"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$VBoxContainer/MarginContainer/PanelContainer.add_theme_style_override("modulate_color",Color.GREEN)
	#$VBoxContainer/MarginContainer/PanelContainer/RichTextLabel.text = blank 
	if Global.pending_comment != null:
		var data = Global.pending_comment
		blank = data["blank"]
		var panel = $VBoxContainer/MarginContainer/PanelContainer
		var label = panel.get_node("RichTextLabel")
		
		label.text = blank
		
		var new_style = StyleBoxFlat.new()
		
		# Sanftere Farbe statt reinem Color.GREEN
		new_style.bg_color = Color(0.75, 0.92, 0.78)  # pastelliges Grün
		
		# Abgerundete Ecken für den "Sprechblasen"-Look
		new_style.corner_radius_top_left = 16
		new_style.corner_radius_top_right = 16
		new_style.corner_radius_bottom_left = 16
		new_style.corner_radius_bottom_right = 16
		
		# Innenabstand, damit der Text nicht am Rand klebt
		new_style.content_margin_left = 16
		new_style.content_margin_right = 16
		new_style.content_margin_top = 10
		new_style.content_margin_bottom = 10
		
		new_style.border_width_left = 2
		new_style.border_width_right = 2
		new_style.border_width_top = 2
		new_style.border_width_bottom = 2
		new_style.border_color = Color(0.55, 0.8, 0.6)
	
										 
		panel.add_theme_stylebox_override("panel", new_style)
		Global.pending_comment = null
	
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
	if MockServer.active:
		MockServer.submit_player_comment(blank, fillers[num])
		get_tree().change_scene_to_file("res://scenes/mock_comments.tscn")
		return
	var text1 = ""
	var text2 = ""
	var x = 0
	while blank[x] != "[": #ersten Textbaustein
		text1 += blank[x]
		x+= 1 
	x += 7 # BLANK] überspringen
	while x < len(blank): #zweiten Blank Textbaustein
		text2 += blank[x]
		x += 1
	var comment = text1 + " " + fillers[num]["text"] + text2
	
	Lobby.active_game.apply_comment(fillers[num])
	print(comment) # rpc_id(1,Lobby.client_username,Lobby.client_avatar_id
	Lobby.active_game.request_add_comment("uwu", 3, parentID, comment)
	#print(blank+fillers[num]["text"])
	get_tree().change_scene_to_file("res://feed.tscn")
	pass
