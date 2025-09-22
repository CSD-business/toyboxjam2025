extends State

@export
var attack_state: State

##The current unit to target and locomote to.
var target : Node

func enter() -> void:
	super()
	#Get the enemy that we are locomoting to,
	#it shouldn't change(?)
	
func _physics_process(delta):
	#Research the navigation planes for this
	#It should also rotate to face the enemy
	#If target isn't set, find target.
	if (target == null):
		find_target()
	else:
		#Else, move + rotate to target.
		locomote()
		#If terget is in attack range, move to attack state.
		if (target.location.length <= $"../../Stats Component".Unit_Range):
			$"..".change_state(attack_state)

func find_target() -> State:
	#Get all Units on the field.
	var target_list: Array[Node] = []
	for child in parent.get_children():
		if child == Unit:
			target_list.append(child)
	
	#Find the distances to all found Units.
	var distance_list: Array[float] = []
	for Unit in target_list:
		var dist = $"../..".location.distance_to(Unit.location)
		distance_list.append(dist)
	
	#Select the closest distance Unit as the current target.
	target = target_list[distance_list.min()]
	
	return

func locomote():
	pass
