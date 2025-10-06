extends Node

@onready
var stats = $"../Stats Component"

@export
var starting_state: State
var current_state: State

var mult : float

var aggro = null

# Initialize the state machine by giving each child state a reference to the
# parent object it belongs to and enter the default starting_state.
func init(parent: Unit) -> void:
	for child in get_children():
		child.parent = parent
		stats.Unit_Cur_Health = stats.Unit_Max_Health

	# Initialize to the default state
	change_state(starting_state)

# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()

# Pass through functions for the Unit to call,
# handling state changes as needed.
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

func take_damage(StatsRef : Node):
	var d = float(StatsRef.Unit_Strength - stats.Unit_Defense)
	find_type_adv(StatsRef.Unit_Type)
	d = d * mult
	stats.Unit_Cur_Health = stats.Unit_Cur_Health - d
	if (stats.Unit_Cur_Health <= 0):
		change_state($"Death")

func find_type_adv(type : String):
	var ourType = stats.Unit_Type
	match type:
		"Attack":
			if ourType == "Ranged":
				mult = 1.25
				return
		"Defense":
			if ourType == "Attack":
				mult = 1.25
				return
		"Ranged":
			if ourType == "Defense":
				mult = 1.25
				return
		"Tower":
			mult = 1.0
			return
	mult = 1.0
	return
