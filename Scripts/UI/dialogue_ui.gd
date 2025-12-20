extends Control

@onready var dialogue_text_box = $DialogueText
@onready var speaker_text_box = $SpeakerText

signal continue_dialogue

func _ready() -> void:
	SignalBus.connect("dialogue_started", display_dialogue)

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_accept")):
		continue_dialogue.emit()

func display_dialogue(speaker_id, dialogue):
	# Dialogue in form of array of speaker and dialogue
	dialogue_text_box.visible = true
	speaker_text_box.visible = true
	
	for line in dialogue:
		speaker_text_box.text = line["speaker"]
		dialogue_text_box.text = line["dialogue"]
		
		await continue_dialogue
		
	dialogue_text_box.visible = false
	speaker_text_box.visible = false

	SignalBus.emit_signal("dialogue_finished", speaker_id)
