extends RefCounted
class_name CommentGame
#Hier hat der Server seine Daten und steuert alles.


var constructiveness = 0 # Limit bei +1000 und -200
#personal scores
var factchecker = 0 #Win bei 100
var politician = 0
var boomer = 0
var fan = 0

const CONSTRUCTIVENESS_MAX = 1000
const CONSTRUCTIVENESS_MIN = -200
const WIN_SCORE = 100

signal score_changed(score_name: String, new_value: int)
signal player_won(role: String)

const SCORE_KEY_MAP = {
	"Constructiveness": "constructiveness",
	"Factchecker": "factchecker",
	"Politician": "politician",
	"Boomer": "boomer"
}

# Wer sich an wen "anheftet" -> fan_id : target_role (z.B. "factchecker")
var fan_attachments: Dictionary = {}

func apply_comment(comment_data: Dictionary) -> void:
	if not comment_data.has("scores"):
		push_warning("Kommentar hat kein 'scores'-Feld")
		return
	
	var json_scores = comment_data["scores"]
	for json_key in json_scores:
		if not SCORE_KEY_MAP.has(json_key):
			push_warning("Unbekannter Score-Key in JSON: " + json_key)
			continue
		var internal_name = SCORE_KEY_MAP[json_key]
		_add_score(internal_name, json_scores[json_key])
	
	_apply_fan_bonus(json_scores)

func _add_score(score_name: String, amount: int) -> void:
	if amount == 0:
		return
	match score_name:
		"constructiveness":
			constructiveness = clamp(constructiveness + amount, CONSTRUCTIVENESS_MIN, CONSTRUCTIVENESS_MAX)
		"factchecker":
			factchecker += amount
		"politician":
			politician += amount
		"boomer":
			boomer += amount
		"fan":
			fan += amount
		_:
			push_warning("Unbekannter Score: " + score_name)
			return
	score_changed.emit(score_name, get(score_name))
	_check_win(score_name)
	
func _apply_fan_bonus(json_scores: Dictionary) -> void:
	for fan_id in fan_attachments:
		var target_role = fan_attachments[fan_id] # z.B. "Factchecker"
		if json_scores.has(target_role):
			var bonus = json_scores[target_role]
			if bonus != 0:
				fan += bonus
				score_changed.emit("fan", fan)
				_check_win("fan")
				
func attach_fan(fan_id, target_role: String) -> void:
	fan_attachments[fan_id] = target_role

func _check_win(score_name: String) -> void:
	if score_name == "constructiveness":
		return
	if get(score_name) >= WIN_SCORE:
		player_won.emit(score_name)

#Comment Memory

signal comment_added(comment:Dictionary)
var comments : Dictionary = {}
var next_id = 0
func _generate_id() -> String:
	next_id += 1
	return str(next_id)

func add_comment(data:Dictionary):
	var comment : Dictionary
	var id = _generate_id()
	comment = {
		"username":data["username"],
		"avatarID":data["avatarID"],
		"text":data["text"],
		"commentID" : id,
		"parentID" : data["parentID"]
	}
	comments[id] = comment
	pass

@rpc("any_peer")
func request_add_comment(username: String,avatarID:int,parent_id: int, text: String):
	var comment = Lobby.active_game.add_comment({
		"parentID": parent_id,
		"username": username,
		"avatarID": avatarID,
		"text": text
	})
	#broadcast_comment.rpc(comment)

@rpc("authority", "call_local")
func broadcast_comment(comment: Dictionary):
	Lobby.active_game.comments[comment["id"]] = comment
	Lobby.active_game.comment_added.emit(comment)

@rpc("any_peer")
func request_full_sync():
	return Lobby.active_game.comments
