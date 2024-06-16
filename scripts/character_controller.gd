extends Node2D

@onready var a_chan = $"A-Chan"
@onready var yagoo = $YAGOO

var spread_amount = 85
var height_amount = 20

var character_left_postiion = Vector2(-spread_amount, -height_amount)
var character_right_position = Vector2(spread_amount, -height_amount)

var EXPRESSIONS = {
	"happy": "happy",
	"unhappy": "unhappy",
	"blush": "blush",
	"angry": "angry",
	"displeased": "displeased",
	"sad": "sad",
}

func toggle_character(character: AnimatedSprite2D):
	character.visible = !character.visible

func set_idle(character: AnimatedSprite2D, expression: String):
	character.play(expression)
	character.stop()
	character.set_frame_and_progress(0, 0)

func play_expression(character: AnimatedSprite2D, expression: String, time: float):
	character.play(expression)
	await get_tree().create_timer(time).timeout
	set_idle(character, expression)

func _ready():
	set_idle(a_chan, EXPRESSIONS.happy)
	a_chan.position = character_left_postiion
	set_idle(yagoo, EXPRESSIONS.unhappy)
	yagoo.position = character_right_position
	
	toggle_character(a_chan)
	toggle_character(yagoo)
