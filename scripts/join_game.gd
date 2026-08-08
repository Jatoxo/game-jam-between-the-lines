extends "res://scripts/ui_screen.gd"

@onready var entryField = $IPEntry
@onready var errorLabel = $ErrorLabel
@onready var errorTimer = $ErrorLabel/Timer

# "join" button
func _on_button_pressed() -> void:
	var address = entryField.text.split(":")
	
	print(address)
	if len(address) < 2 or not address[1].is_valid_int() or not is_valid_ipv4(address[0]):
		display_error("Invalid IP")
		return
	
	
	var ip   = address[0]
	var port = int(address[1])
	
	print("Connecting to %s:%s" % [address, port])
	
	Lobby.join_game(ip, port)


var regex = RegEx.create_from_string(
	"^(?:(?:25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)\\.){3}(?:25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)$"
)
func is_valid_ipv4(ip: String) -> bool:
	return regex.search(ip) != null


func display_error(error : String):
	print(error)
	
	errorLabel.text = error
	
	errorLabel.visible = true
	errorTimer.start()
	
	

func _on_timer_timeout() -> void:
	errorLabel.visible = false
