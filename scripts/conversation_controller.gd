extends Node2D

@onready var character_controller = $Character_Controller
@onready var character_speaking = $"Character Label/character_speaking"
@onready var dialogue_container = $Text/dialogue
@onready var game = $".."


const CHOICE = preload("res://scenes/choice.tscn")
const choice_pos_x = 60
const choice_positions = [Vector2(choice_pos_x, 8), Vector2(choice_pos_x, -12), Vector2(choice_pos_x, -32)]

signal conversation_finished

var ready_dialogue = []
signal dialogue_skipped
var read = true
var skipped = false

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _input(event):
	if (event.is_action_pressed("enter") and read):
		dialogue_skipped.emit()
	elif (event.is_action_pressed("enter") and not read):
		skipped = true

func read_from_queue():
	if ready_dialogue.size() > 0:
		read = false
		await display_dialogue(ready_dialogue[0][0], ready_dialogue[0][1], ready_dialogue[0][2], ready_dialogue[0][3], ready_dialogue[0][4], ready_dialogue[0][6], ready_dialogue[0][7])
		ready_dialogue[0][5] = true
		ready_dialogue = await ready_dialogue.filter(func(item): return item[5] == false)
		read = true
	else:
		print('no more dialogue')

func queue_dialogue(character, dialogue, expression, text_speed, speak_speed, points, senario_name):
	ready_dialogue.append([character, dialogue, expression, text_speed, speak_speed, false, points, senario_name])

func change_label(character_name):
	character_speaking.text = "[center]%s[/center]" % character_name

func display_dialogue(character, dialogue, expression, text_speed, speak_speed, points, scenario_name):
	if "HOLO HOPEFUL" not in character.name:
		change_label(character.name)
		character_controller.play_expression(character.sprite, expression, translate_time_from_dialogue(dialogue, text_speed))
		var displayed_text = ""
		for char in dialogue:
			dialogue_container.text = displayed_text + char
			if not read and not skipped:
				await get_tree().create_timer(speak_speed).timeout
				displayed_text = displayed_text + char
			else:
				read = true
				break
		dialogue_container.text = dialogue
	else:
		display_choice(dialogue, points, scenario_name)

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

func display_choice(choices: Array, points, scenario_name):
	print(points)
	var index = 0
	var choice_nodes = []
	for choice in choices:
		var newChoice = CHOICE.instantiate()
		newChoice.position = choice_positions[index]
		newChoice.get_child(0).text = "[center]%s[/center]" % choice
		var button = newChoice.get_child(1)
		choice_nodes.append(newChoice)
		button.button_down.connect(_on_choice_chosen.bind(choice, index, points, choice_nodes, scenario_name))
		add_child(newChoice)
		index += 1

func _on_dialogue_skipped():
	read_from_queue()

func _on_choice_chosen(choice, index, points, choice_nodes, scenario_name):
	StatsAndFlags.stats[points[index][0]] += points[index][1]
	print(str(StatsAndFlags.stats[points[index][0]]) + " %s points added" % points[index][0])
	game.load_scenario(DialogueHolder[scenario_name + "_C%s" % index])
	for choice_node in choice_nodes:
		choice_node.queue_free()
	conversation_finished.emit()
