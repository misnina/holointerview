extends Node

@onready var conversation_controller = $Conversation_Controller

var CHARACTERS = {
	"ACHAN": {
		"name": "A-CHAN",
		"sprite": "a_chan",
		"sound": "unspecified"
	},
	"YAGOO": {
		"name": "YAGOO",
		"sprite": "yagoo",
		"sound": "unspecified"
	},
}

#TEMP
@onready var button = $Button
var current_speak_speed = 50
var current_text_speed = 0.015

var dialogue_test = "Hello mama mia bekka de boopa."

func _ready():
	load_characters()

func load_characters():
	CHARACTERS.ACHAN.sprite = conversation_controller.character_controller.a_chan
	CHARACTERS.YAGOO.sprite = conversation_controller.character_controller.yagoo

func _on_button_pressed():
	conversation_controller.queue_dialogue(CHARACTERS.ACHAN, dialogue_test, "happy", current_speak_speed, current_text_speed)
	conversation_controller.queue_dialogue(CHARACTERS.YAGOO, "alkdjflkfjladksjafslkjfls", "happy", current_speak_speed, current_text_speed)
	conversation_controller.read_from_queue()
	pass # Replace with function body.
