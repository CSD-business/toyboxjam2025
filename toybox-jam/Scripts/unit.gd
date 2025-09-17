class_name Unit
extends CharacterBody3D

@onready
var animations = $AnimationPlayer

@onready
var state_machine = $"State Machine"

@onready
var stats = $"Stats Component"

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
