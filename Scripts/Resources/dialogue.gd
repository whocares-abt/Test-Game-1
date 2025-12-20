class_name Dialogue
extends Resource

@export var speaker : String
@export var speaker_id : int
@export var line : String
@export var dialogue_id : int

# Responses has key as response_id and values as response
@export var responses : Dictionary

# Maps the response to the corresponding next scene by response id or any other metric
@export var next_scene : Dictionary
