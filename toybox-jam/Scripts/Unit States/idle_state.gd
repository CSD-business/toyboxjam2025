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

func get_target(target: Unit) -> State:
	#Get the list of enemies
	#If there is an enemy, start moving to it
	
	var target_list: Array[Node] = []
	for child in parent.get_children():
		if child == Unit:
			target_list.append(child)
	
	if target:
		return locomote_state
	else: 
		return null
