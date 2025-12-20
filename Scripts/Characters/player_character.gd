extends CharacterBody2D

@onready var sprite = $PlayerSprite
@onready var interacting_component = $InteractingComponent

@export var SPEED = 300

var input_enabled = true
var input_disabled_by = ""

func _ready():
	SignalBus.connect("dialogue_started", disable_input_for_dialogue)
	SignalBus.connect("dialogue_finished", enable_input_after_dialogue)

func _input(event: InputEvent) -> void:
	if (not input_enabled):
		return
	if (event.is_action_pressed("interact")):
		interacting_component.interact_with_object() 

func _physics_process(_delta: float) -> void:
	if (not input_enabled):
		return

	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_up", "move_down")

	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	play_animation(direction_x, direction_y)

	move_and_slide()

func play_animation(direction_x, direction_y):
	
	if (direction_y != 0):
		if (direction_y == 1):
			sprite.play("move_down")
		else:
			sprite.play("move_up")

	elif (direction_x != 0):
		if (direction_x == 1):
			sprite.play("move_right")
		else:
			sprite.play("move_left")

	else:
		sprite.pause()

func disable_input_for_dialogue(_scene):
	input_enabled = false
	input_disabled_by = "dialogue"
	play_animation(0, 0) # pause animation

func enable_input_after_dialogue(_scene):
	await get_tree().create_timer(0.1).timeout # Wait before reenabling
	input_enabled = true
	input_disabled_by = ""
