extends State

@export
var locomote_state: State
@export
var attack_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.z = 0

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	return null
