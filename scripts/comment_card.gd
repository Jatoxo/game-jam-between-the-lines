extends MarginContainer

@export_multiline("Comment text") var comment : String

@onready var textbox = $PanelContainer/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textbox.text = comment
