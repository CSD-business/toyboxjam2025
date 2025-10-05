extends Node3D

@export var camera : Camera3D
@export var raycast : RayCast3D

signal TrySpawnUnit(side, Eid, Epos)

func _ready() -> void:
	GlobalVars.MouseMgr = self

func _process(_delta: float) -> void:
	SnapToMouse()
	if Input.is_action_just_pressed("Click") and GlobalVars.OnUI == false:
		TrySpawnUnit.emit(0, 0, Vector3(0,0,0))

func SnapToMouse():
	#Project mouse position from the screen to a 3D space.
	var newLoc = camera.project_position(get_viewport().get_mouse_position(), 10)
	raycast.look_at(newLoc)
	
	#Raycast down and snap to floor.
	if raycast.is_colliding():
		newLoc = raycast.get_collision_point()
	position = newLoc
