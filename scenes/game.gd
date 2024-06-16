extends Node

@onready var conversation_controller = $Conversation_Controller
@onready var dialogue_holder = $dialogue_holder

var CHARACTERS = {
	"CHOICE": {
		"name": "HOLO HOPEFUL",
		"sprite": "a_chan",
	},
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

var current_speak_speed = 50
var current_text_speed = 0.012

#Stats
var pleasing = 0
var unhinged = 0
var talented = 0
var charming = 0
var depressing = 0

func _ready():
	load_characters()
	load_dialogue(dialogue_holder.INTRODUCTION)

func load_characters():
	CHARACTERS.ACHAN.sprite = conversation_controller.character_controller.a_chan
	CHARACTERS.YAGOO.sprite = conversation_controller.character_controller.yagoo

func load_dialogue(dialogue_array):
	for dialogue in dialogue_array:
		conversation_controller.queue_dialogue(CHARACTERS["%s" % dialogue[0]], dialogue[1], dialogue[2], current_speak_speed, current_text_speed, dialogue[3])
