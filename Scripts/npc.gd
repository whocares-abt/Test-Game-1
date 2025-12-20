extends Node2D

@onready var interactable = $Interactable
@onready var dialogue = $Dialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	dialogue.visible = true
	interactable.is_interactable = false
	
	await get_tree().create_timer(1).timeout
	
	dialogue.visible = false
	interactable.is_interactable = true
