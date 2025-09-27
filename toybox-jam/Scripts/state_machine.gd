extends Node

@onready
var stats = $"../Stats Component"

@export
var starting_state: State
var current_state: State

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

func take_damage(damage: int):
	var d = damage - stats.Unit_Defense
	stats.Unit_Cur_Health = stats.Unit_Cur_Health - d
	print("I took " + str(d) + " damage, and have " + str(stats.Unit_Cur_Health) + " health left.")
	if (stats.Unit_Cur_Health <= 0):
		change_state($"Death")
