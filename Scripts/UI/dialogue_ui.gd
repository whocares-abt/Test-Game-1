extends Control

@onready var dialogue_text_box = $DialogueText
@onready var speaker_text_box = $SpeakerText
@onready var response_menu = $ResponseMenu

var curr_speaker_id = 0

signal continue_dialogue

func _ready() -> void:
	SignalBus.connect("dialogue_started", display_dialogue_scene)
	
	response_menu.change_alignment(BoxContainer.ALIGNMENT_END)
	response_menu.connect("menu_item_chosen", _on_player_response)
	response_menu.remove_menu()

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_accept")):
		continue_dialogue.emit()

func display_dialogue_scene(speaker_id, dialogue_scene : DialogueScene):
	# Dialogue in form of array of speaker and dialogue
	dialogue_text_box.visible = true
	speaker_text_box.visible = true
	curr_speaker_id = speaker_id
	
	for dialogue in dialogue_scene.scene:
		speaker_text_box.text = dialogue.speaker
		dialogue_text_box.text = dialogue.line
		
		if dialogue.responses:
			display_responses(dialogue.responses)
			await SignalBus.player_chose_response
		else:
			await continue_dialogue
		
	dialogue_text_box.visible = false
	speaker_text_box.visible = false

	SignalBus.emit_signal("dialogue_finished", curr_speaker_id)

func display_responses(responses):
	response_menu.create_menu(responses, true)

func _on_player_response(player_response):
	response_menu.remove_menu()
	SignalBus.emit_signal("player_chose_response", curr_speaker_id, player_response)
