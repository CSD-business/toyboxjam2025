class_name Unit
extends CharacterBody3D

@onready
var animations = $AnimationPlayer

@onready
var state_machine = $"State Machine"

@onready
var stats = $"Stats Component"

@onready var nav_agent: NavigationAgent3D = $NavAgent3D
@onready var sparticles: CPUParticles3D = $SpawnParticles
@onready var dparticles: CPUParticles3D = $DeathParticles
@onready var spawnaudio: AudioStreamPlayer = $SpawnSound

var unit_ready : bool

func _ready() -> void:
	#Initialize NavAgent3D's distances using unit stats, then delay further setup.
	nav_agent.path_desired_distance = 0.5
	nav_agent.target_desired_distance = stats.Unit_Range
	actor_setup.call_deferred()
	sparticles.emitting = true
	
	if $"Stats Component".Unit_Type != "Tower":
		if randi_range(1,2) == 1:
			$SpawnSound.play()
			print("talking")
		$SpawnSound2.play()

func actor_setup():
	#Wait for first physics frame so NavServer can sync.
	await get_tree().physics_frame
	
	#Then, initialize state machine to begin in Locomote state.
	state_machine.init(self)
	unit_ready = true

func _physics_process(delta: float) -> void:
	if unit_ready and GlobalVars.GameIsGoing:
		state_machine.process_physics(delta)

func _process(delta: float) -> void:
	if unit_ready and GlobalVars.GameIsGoing:
		state_machine.process_frame(delta)
