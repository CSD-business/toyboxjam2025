extends State

@export
var idle_state: State
@export
var locomote_state: State

func enter() -> void:
	super()
	#Trigger animation.
	#Spawn smoke puff particle.
	$"../..".queue_free()
