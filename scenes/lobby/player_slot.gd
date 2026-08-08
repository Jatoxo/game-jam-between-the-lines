extends Control
class_name PlayerSlot

@export var playerName : String = "Choosing name...":
	set(value):
		set_slot_name(value)
@export var avatar : Texture2D:
	set(value):
		set_avatar(value)

@onready var icon = $HBoxContainer/MarginContainer/Icon
@onready var nameLabel = $HBoxContainer/PlayerName



func _ready() -> void:
	nameLabel.text = playerName

func set_avatar(value):
	icon.texture = value

func set_slot_name(value):
	nameLabel.text = value
