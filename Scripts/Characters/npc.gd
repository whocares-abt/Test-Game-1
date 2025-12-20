extends Node2D

@onready var interactable = $Interactable
@onready var dialogue_label = $Dialogue

@export var npc_name = ""
@export var dialogue = "Hello"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact
	dialogue_label.text = dialogue

func _on_interact():
	dialogue_label.visible = true
	interactable.is_interactable = false
	
	#await get_tree().create_timer(1).timeout
	#
	#dialogue_label.visible = false
	#interactable.is_interactable = true
