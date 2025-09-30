extends State

@export
var locomote_state: State

var target 

func enter() -> void:
	super()
	target = get_parent().aggro
	attack()
	#Stop moving
	parent.velocity.x = 0
	parent.velocity.z = 0


func attack() -> void:
	if is_instance_valid(target):
		$"../../AnimationPlayer".play("Pawn/Pawn_attack")
		await get_tree().create_timer(.16).timeout #estimate for the contact
		target.get_child(1).take_damage(parent.stats.Unit_Strength)
		#get child is (1) because state machine is the 2nd child of units
		await get_tree().create_timer(parent.stats.Unit_Attack_Speed).timeout
		attack()
	else:
		print("No target.")
		parent.state_machine.change_state(locomote_state)
	
