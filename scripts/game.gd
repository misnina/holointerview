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
var current_text_speed = 20
var current_speak_speed = 0.03

var dialogue_test = "lorem isputim weird let's go hahah, let's goooooo"

func _ready():
	load_characters()

func load_characters():
	CHARACTERS.ACHAN.sprite = conversation_controller.character_controller.a_chan
	CHARACTERS.YAGOO.sprite = conversation_controller.character_controller.yagoo

func _on_button_pressed():
	conversation_controller.display_dialogue(CHARACTERS.ACHAN, dialogue_test, "happy", current_text_speed, current_speak_speed)
	pass # Replace with function body.
