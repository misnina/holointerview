extends Node2D

@onready var character_controller = $Character_Controller
@onready var character_speaking = $"Character Label/character_speaking"
@onready var dialogue_container = $Text/dialogue

var ready_dialogue = []
signal dialogue_skipped
var read = true

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _input(event):
	if (event.is_action_pressed("enter") and read):
		await get_tree().create_timer(0.1).timeout
		dialogue_skipped.emit()
		await get_tree().create_timer(0.5).timeout
		read = true

func read_from_queue():
	if ready_dialogue.size() > 0:
		print("skilled false from dialogue")
		read = false
		await display_dialogue(ready_dialogue[0][0], ready_dialogue[0][1], ready_dialogue[0][2], ready_dialogue[0][3], ready_dialogue[0][4])
		ready_dialogue[0][5] = true
		ready_dialogue = await ready_dialogue.filter(func(item): return item[5] == false)
		read = true
	else:
		print('no more dialogue')

func queue_dialogue(character, dialogue, expression, text_speed, speak_speed):
	ready_dialogue.append([character, dialogue, expression, text_speed, speak_speed, false])

func change_label(character_name):
	character_speaking.text = "[center]%s[/center]" % character_name

func display_dialogue(character, dialogue, expression, text_speed, speak_speed):
	change_label(character.name)
	character_controller.play_expression(character.sprite, expression, translate_time_from_dialogue(dialogue, text_speed))
	var displayed_text = ""
	for char in dialogue:
		dialogue_container.text = displayed_text + char
		if not read:
			await get_tree().create_timer(speak_speed).timeout
			displayed_text = displayed_text + char
		else:
			read = true
			break
	dialogue_container.text = dialogue 

func translate_time_from_dialogue(dialogue, text_speed):
	if (dialogue.length() / text_speed) <= 0 :
		return 0.8
	else:
		return dialogue.length() / text_speed

func seperated_text(dialogue):
	var text_array = []
	for char in dialogue:
		text_array.append(char)
	return text_array

func _on_dialogue_skipped():
	read_from_queue()
	pass # Replace with function body.
