extends Control

@onready var dialogue_text_box = $DialogueText
@onready var speaker_text_box = $SpeakerText
@onready var response_menu = $ResponseMenu

var curr_speaker_id = 0
var curr_dialogue_scene
var curr_responses

signal continue_dialogue

func _ready() -> void:
	SignalBus.connect("dialogue_started", display_dialogue_scene)
	
	response_menu.change_alignment(BoxContainer.ALIGNMENT_END)
	response_menu.connect("menu_item_chosen", _on_player_response)
	response_menu.remove_menu()

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_accept")):
		continue_dialogue.emit()

func display_dialogue_scene(dialogue_scene : DialogueScene):

	# Dialogue in form of array of speaker and dialogue
	dialogue_text_box.visible = true
	speaker_text_box.visible = true
	curr_dialogue_scene = dialogue_scene
	
	for dialogue in dialogue_scene.scene:
		speaker_text_box.text = dialogue.speaker
		dialogue_text_box.text = dialogue.line

		if dialogue.responses:
			display_responses(dialogue.responses)
			curr_responses = dialogue.responses
			await SignalBus.player_chose_response
		else:
			await continue_dialogue

	dialogue_text_box.visible = false
	speaker_text_box.visible = false

	SignalBus.emit_signal("dialogue_finished", curr_dialogue_scene)

func display_responses(responses : Dictionary):
	response_menu.create_menu(responses.values(), true)

func _on_player_response(player_response):
	response_menu.remove_menu()

	var response_id
	for id in curr_responses:
		if (curr_responses[id] == player_response):
			response_id = id
			break
	
	SignalBus.emit_signal("player_chose_response", response_id, player_response)
