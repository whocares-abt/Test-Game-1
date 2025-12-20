extends Node2D

@onready var interactable = $Interactable

var curr_scene : DialogueScene
var curr_scene_id

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_dialogue_scene(load("res://Resources/Dialogues/test_dialogue.tres"))
	
	interactable.interact = _on_interact
	SignalBus.connect("dialogue_finished", _on_dialogue_end)

func change_dialogue_scene(new_scene : DialogueScene):
	curr_scene = new_scene
	curr_scene_id = new_scene.scene_id

func _on_interact():
	interactable.is_interactable = false
	SignalBus.emit_signal("dialogue_started", curr_scene)

func _on_dialogue_end(scene : DialogueScene):

	if (scene.scene_id == curr_scene_id):
		interactable.is_interactable = true
