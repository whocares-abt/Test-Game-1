extends Control

@onready var dialogue_text_box = $DialogueText
@onready var speaker_text_box = $SpeakerText
@onready var response_menu = $ResponseMenu

signal continue_dialogue

func _ready() -> void:
	SignalBus.connect("dialogue_started", display_dialogue)
	
	response_menu.change_alignment(BoxContainer.ALIGNMENT_END)
	response_menu.connect("menu_item_chosen", _on_player_response)
	response_menu.remove_menu()

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
		
		if ("responses" in line):
			display_responses(line["responses"])
			await SignalBus.player_chose_response
		else:
			await continue_dialogue
		
	dialogue_text_box.visible = false
	speaker_text_box.visible = false

	SignalBus.emit_signal("dialogue_finished", speaker_id)

func display_responses(responses):
	response_menu.create_menu(responses, true)

func _on_player_response(player_response):
	response_menu.remove_menu()
	SignalBus.emit_signal("player_chose_response", player_response)
