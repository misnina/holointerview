extends Node2D

@onready var progress_bar = $TextureProgressBar
@onready var rich_text_label = $RichTextLabel
@onready var flash_indicator = $flash_indicator

signal pump
signal finished_pump

@export var base_addition = 3
@export var top_percent = 20
@export var indicator_percent = 30
@export var bottom_percent = 30
@export var bonus_amount = 3.5
@export var pump_timing = 1.2

var overall_time = 0
var time = 0
var has_first_pump = false
var in_top_percentage = true
var color_switch = true

func _process(delta):
	overall_time += delta
	
	rich_text_label.text = str(round(overall_time))
	time += delta
	if (Input.is_action_just_pressed("action_1")):
		has_first_pump = true
		time = 0
	if (Input.is_action_just_pressed("action_2") and time < pump_timing and has_first_pump):
		emit_signal("pump", time)
		has_first_pump = false
		time = 0
	if (Input.is_action_just_pressed("action_2") and time > pump_timing and has_first_pump):
		progress_bar.value += base_addition - (base_addition / 10)
	if (time > (pump_timing + 0.5)):
		time = 0
	stobe_indicator(time)

func _on_pump(time):
	var time_left = pump_timing - time
	var score_amount = base_addition - (time_left * 3)
	var time_left_percent = (time_left / pump_timing) * 100
	if (time_left_percent <= top_percent):
		print('grabbed bonus')
		print(time)
		progress_bar.value += score_amount * bonus_amount
	elif (time_left_percent >= bottom_percent):
		print('too fast')
		print(time)
		progress_bar.value += score_amount / (0.5)
	else:
		print(time)
		progress_bar.value += score_amount * base_addition


func stobe_indicator(time):
	var progression_percentage = ((time / pump_timing) * 100)
	if (progression_percentage > 80 and has_first_pump and not progression_percentage > 100):
		if (color_switch):
			await get_tree().create_timer(0.05).timeout
			flash_indicator.modulate = Color(0, 0, 0)
			color_switch = false
		elif (not color_switch):
			await get_tree().create_timer(0.05).timeout
			flash_indicator.modulate = Color(255, 255, 255)
			color_switch = true

func _on_texture_progress_bar_value_changed(value):
	if (value == 100):
		print("game over!")
	pass # Replace with function body.
