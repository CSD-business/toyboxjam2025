extends Node3D

@export var camera : Camera3D
@export var raycast : RayCast3D
@export var Pieces : Node
@export var TestUnit : PackedScene
@export var spawnid : int

signal TrySpawnUnit(unit, location)
func _process(_delta: float) -> void:
	SnapToMouse()
	if Input.is_action_just_pressed("Click"):
		TrySpawnUnit.emit(spawnid)

func SnapToMouse():
	#Project mouse position from the screen to a 3D space.
	var newLoc = camera.project_position(get_viewport().get_mouse_position(), 10)
	raycast.look_at(newLoc)
	
	#Raycast down and snap to floor.
	if raycast.is_colliding():
		newLoc = raycast.get_collision_point()
	position = newLoc
