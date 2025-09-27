extends State

@export
var attack_state: State

##The current unit to target and locomote to.
var target : Node

func enter() -> void:
	super()
func exit() -> void:
	get_parent().aggro = target
	
func process_physics(delta : float) -> State:
	#Research the navigation planes for this
	#It should also rotate to face the enemy
	#If target isn't set, find target.
	if parent.stats.Unit_Type == "Tower":
		pass
	if (target == null):
		find_target()
	else: 
		#if the target is close enough, attack
		locomote(delta)
		#if we're close enough, attack
		if check_distance() <= parent.stats.Unit_Range:
			$"..".change_state(attack_state)
	return null

func find_target() -> Unit:
	#Get all Units on the field.
	var target_list: Array[Node] = []
	var closest_node = null
	var min_distance = INF
	var reference_position = parent.global_position
	for child in parent.get_parent().get_children():
		if child != parent:
			var distance_squared = child.global_position.distance_to(reference_position)
			if distance_squared < min_distance:
				min_distance = distance_squared
				closest_node = child
	print("Closest node is " + str(closest_node) + " and is " + str(min_distance) + " units away.")
	target = closest_node
	return closest_node
	
func locomote(delta):
	parent.global_position = parent.global_position.move_toward(target.global_position, parent.stats.Unit_Movement_Speed * delta)

func check_distance():
	var distance = parent.global_position.distance_to(target.global_position)
	#print("I am " + str(distance) + " units away from my target.")
	return distance
