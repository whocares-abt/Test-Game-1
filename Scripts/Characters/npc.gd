extends Node2D

@onready var interactable = $Interactable

@export var npc_name = "Alice01"
@export var dialogue = [
	{
		"speaker": "Alice01",
		"dialogue": "How are you?",
	},
	{
		"speaker": "Alice01",
		"dialogue": "You must be exhausted",
	},
	{
		"speaker": "",
		"dialogue": "This is how it looks without a speaker",
	},
]

@export var id = 01

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact
	SignalBus.connect("dialogue_finished", _on_dialogue_end)

func _on_interact():
	interactable.is_interactable = false
	SignalBus.emit_signal("dialogue_started", id, dialogue)

func _on_dialogue_end(speaker_id):
	if (speaker_id == id):
		interactable.is_interactable = true
