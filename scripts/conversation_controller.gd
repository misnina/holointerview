extends Node2D

@onready var character_controller = $Character_Controller
@onready var character_speaking = $"Character Label/character_speaking"
@onready var dialogue_container = $Text/dialogue

func change_label(character_name):
	character_speaking.text = "[center]%s[/center]" % character_name

func display_dialogue(character, dialogue, expression, text_speed, speak_speed):
	change_label(character.name)
	character_controller.play_expression(character.sprite, expression, translate_time_from_dialogue(dialogue, text_speed))
	var displayed_text = ""
	for char in dialogue:
		dialogue_container.text = displayed_text + char
		await get_tree().create_timer(speak_speed).timeout
		displayed_text = displayed_text + char

func translate_time_from_dialogue(dialogue, text_speed):
	return dialogue.length() / text_speed

func seperated_text(dialogue):
	var text_array = []
	for char in dialogue:
		text_array.append(char)
	return text_array
	
func display_text_type(seperated_text, dialogue_container):
	pass
