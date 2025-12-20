extends Node2D

@onready var dialogue_interactable = $DialogueInteractable

@export var dialogue_scene = load("res://Resources/Dialogues/test_dialogue.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue_interactable.change_dialogue_scene(dialogue_scene)
