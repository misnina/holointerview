extends Node

# CHARACTERS.ACHAN, dialogue_test, "happy", current_speak_speed, current_text_speed
const INTRODUCTION = {
	"name": "INTRODUCTION",
	"dialogue": [
		["ACHAN", "Hello welcome to the world", "happy", "none"],
		["YAGOO", "I'm not sure I'm happy to be here, to be frankly honest.", "unhappy", "none"],
		["ACHAN", "Sir, is this dialogue system not to your liking?", "sad", "none"],
		["YAGOO", "Are we entirely sure that we keep writing dialogue correctly? I think we're really going to need an editor. I hope you seeing this can help!", "blush", "none"],
		["CHOICE", ["Choice 1", "Choice 2", "Choice 3 but this is longer"], "happy", [["pleasing", 10], ["depressing", 10], ["talented", 10]]],
	],
}

const INTRODUCTION_C0 = {
	"name": "INTRODUCTION",
	"dialogue": [
		["ACHAN", "Is that so?", "happy", "none"],
	]
}
const INTRODUCTION_C1 = INTRODUCTION_C0
const INTRODUCTION_C2 = INTRODUCTION_C0

const GETING_TO_KNOW_YOU = {
	"name": "GETING_TO_KNOW_YOU",
	"dialogue": [
		["ACHAN", "Let's get to know you.", "happy", "none"],
		["YAGOO", "Don't be worried, we'll be very nice.", "happy", "none"],
		["ACHAN", "How will you deal with controvorsy in case of a critical mistake?", "unhappy", "none"],
		["YAGOO", "Don't you think that's a little too extreme?", "unhappy", "none"],
		["ACHAN", "I think that it's important to know. How would you deal with it?", "unhappy", "none"],
		["CHOICE", ["Apologize", "Blow Over", "Double Down"], "happy", [["pleasing", 10], ["talented", 10], ["unhinged", 10]]]
	]
}

const GETING_TO_KNOW_YOU_C0 = {
	"name": "GETING_TO_KNOW_YOU_C0",
	"dialogue": [
		["ACHAN", "I think that's a good way to go about it.", "happy", "none"],
		["YAGOO", "Is that it? Maybe that's a little boring.", "displeased", "none"],
	]
}

const GETING_TO_KNOW_YOU_C1 = {
	"name": "GETING_TO_KNOW_YOU_C1",
	"dialogue": [
		["ACHAN", "Are you sure that it will go away?", "unhappy", "none"],
		["YAGOO", "Getting much done by doing nothing, things will always pass.", "happy", "none"],
	]
}

const GETING_TO_KNOW_YOU_C2 = {
	"name": "GETING_TO_KNOW_YOU_C2",
	"dialogue": [
		["YAGOO", "Sticking to your ideals is important!", "happy", "none"],
		["ACHAN", "Would that please anyone in the end?", "displeased", "none"],
	]
}
