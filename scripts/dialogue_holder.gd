extends Node

# CHARACTERS.ACHAN, dialogue_test, "happy", current_speak_speed, current_text_speed
var INTRODUCTION = [
	["ACHAN", "Hello welcome to the world", "happy", "none"],
	["YAGOO", "I'm not sure I'm happy to be here, to be frankly honest.", "unhappy", "none"],
	["ACHAN", "Sir, is this dialogue system not to your liking?", "sad", "none"],
	["YAGOO", "Are we entirely sure that we keep writing dialogue correctly? I think we're really going to need an editor. I hope you seeing this can help!", "blush", "none"],
	["CHOICE", ["Choice 1", "Choice 2", "Choice 3 but this is longer"], "happy", [["pleasing", 10], ["depressing", 10], ["talented", 10]]]
]
