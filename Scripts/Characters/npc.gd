extends Node2D

@onready var interactable = $Interactable

@export var npc_name = "Alice01"
@export var dialogue_scene = load("res://Resources/Dialogues/test_dialogue.tres")

@export var scene_id = 01

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact
	SignalBus.connect("dialogue_finished", _on_dialogue_end)

func _on_interact():
	interactable.is_interactable = false
	SignalBus.emit_signal("dialogue_started", dialogue_scene)

func _on_dialogue_end(scene : DialogueScene):
	if (scene.scene_id == scene_id):
		interactable.is_interactable = true
