extends State

@export
var idle_state: State
@export
var locomote_state: State

func enter() -> void:
	super()
	#Stop moving
	parent.velocity.x = 0
	parent.velocity.z = 0
	#Get the aggro'd enemy and lower its health by attack
	#parent.stats.Unit_Damage
