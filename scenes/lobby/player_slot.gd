extends Control

@export var playerName : String = "Choosing name..."
@export var avatar : Texture2D

@onready var icon = $HBoxContainer/MarginContainer/TextureRect
@onready var nameLabel = $HBoxContainer/PlayerName

func _ready() -> void:
	nameLabel.text = playerName
	
