extends State

@export
var attack_state: State
func enter() -> void:
	super()
	#Get the enemy that we are locomoting to,
	#it shouldn't change(?)
	
func _physics_process(delta):
	#Pathfind to the enemy
	#Research the navigation planes for this
	#It should also rotate to face the enemy
	#When the unit is in range of the enemy, attack
	
	pass
	
