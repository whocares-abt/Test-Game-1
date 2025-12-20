extends Node2D

@onready var interactable = $Interactable

# Name and id of the parent object
var object_name = "Alice01"
var object_id = 01

var dialogue_scene : DialogueScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact
	SignalBus.connect("dialogue_finished", _on_dialogue_end)

func _on_interact():
	interactable.is_interactable = false
	SignalBus.emit_signal("dialogue_started", object_id, dialogue_scene)

func _on_dialogue_end(speaker_id):
	if (speaker_id == object_id):
		interactable.is_interactable = true
