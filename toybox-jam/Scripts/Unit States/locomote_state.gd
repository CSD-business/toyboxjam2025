extends State

@export
var attack_state: State

@onready var nav_agent: NavigationAgent3D = $"../../NavAgent3D"

##The current unit to target and locomote to.
var target : Node

func enter() -> void:
	super()
	$"../../AnimationPlayer".play("Pawn/pawn_locomotereal")
func exit() -> void:
	get_parent().aggro = target
	
func process_physics(delta : float) -> State:
	#If this unit is a Tower, don't proceed with target searching.
	if parent.stats.Unit_Type == "Tower":
		pass
	#If we don't have a target, search for a target.
	if (target == null):
		find_target()
		#Double check that we actually have a target. If not, pass.
		if (target == null):
			pass
	else: 
		#When we find a target, move towards that unit.
		locomote(delta)
	return null

func is_opposing_unit(unit : Node):
	var thisUnitSide = parent.stats.Unit_Side
	var otherUnitSide = unit.stats.Unit_Side
	var opposing = (not thisUnitSide == otherUnitSide)
	return opposing

func find_target() -> Unit:
	#Get all Units on the field.
	var target_list: Array[Node] = []
	var closest_node = null
	var min_distance = INF
	var reference_position = parent.global_position
	
	#Loop through all children in the scene.
	for child in parent.get_parent().get_children():
		#Target must have Unit in its name
		#Target cannot be self, must be ready, and must be on opposing side.
		if child != parent and child.unit_ready == true and is_opposing_unit(child):
			var distance_squared = child.global_position.distance_to(reference_position)
			if distance_squared < min_distance:
				min_distance = distance_squared
				closest_node = child
	#Set target to closest unit found from search, update NavAgent's target position to found unit's.
	if (not closest_node == null):
		target = closest_node
		nav_agent.set_target_position(target.position)
	return closest_node

func locomote(delta):
	#Move to attack state if we've finished moving to target.
	if nav_agent.is_navigation_finished():
		$"..".change_state(attack_state)
		return
	
	#Set velocity towards target.
	var vel_dir = parent.position.direction_to(nav_agent.get_next_path_position())
	var vel_speed = parent.stats.Unit_Movement_Speed
	parent.velocity = vel_dir * vel_speed * delta * 60
	parent.move_and_slide()
	
	#Update rotation of Arrow (if not a Tower).
	if not parent.stats.Unit_Type == "Tower":
		$"../../Arrow".look_at(parent.position + parent.velocity)
	
	#Update unit range if target is a Tower.
	if target.stats.Unit_Type == "Tower":
		nav_agent.target_desired_distance = parent.stats.Unit_Range * 1.5
	else:
		nav_agent.target_desired_distance = parent.stats.Unit_Range
