extends Control

var blanks = ResourceGlobal.blanks

func _ready() -> void:
	print(blanks)
	generateBlanks()

func generateBlanks():
	blanks.shuffle()
