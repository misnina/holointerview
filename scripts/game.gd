extends Node

@onready var conversation_controller = $Conversation_Controller

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

func _ready():
	load_characters()
	game_flow()

func load_characters():
	CHARACTERS.ACHAN.sprite = conversation_controller.character_controller.a_chan
	CHARACTERS.YAGOO.sprite = conversation_controller.character_controller.yagoo

func load_dialogue(scenario):
	for dialogue in scenario.dialogue:
		conversation_controller.queue_dialogue(CHARACTERS["%s" % dialogue[0]], dialogue[1], dialogue[2], current_speak_speed, current_text_speed, dialogue[3], scenario.name)
	
func load_scenario(scenario):
	load_dialogue(scenario)
	
func check_for_advance(flag, stat, stat_requirement):
	return (StatsAndFlags.FLAGS[flag]) and (StatsAndFlags.STATS[stat] >= stat_requirement)
	
func _on_conversation_controller_conversation_finished():
	game_flow()
	
# Full Conversation Loop
func game_flow():
	if not StatsAndFlags.FLAGS.INTRODUCTION:
		load_scenario(DialogueHolder.INTRODUCTION)
		return
	if not StatsAndFlags.FLAGS.GETTING_TO_KNOW_YOU:
		load_scenario(DialogueHolder.GETTING_TO_KNOW_YOU)
		return
	if check_for_advance("GETTING_TO_KNOW_YOU", "pleasing", 10):
		load_scenario(DialogueHolder.DO_YOU_WANT_TO_BE_AN_IDOL)
		return
