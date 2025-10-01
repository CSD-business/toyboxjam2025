extends Node3D

@export var camera : Camera3D
@export var raycast : RayCast3D

func _process(delta: float) -> void:
	SnapToMouse()

func SnapToMouse():
	#Project mouse position from the screen to a 3D space.
	var newLoc = camera.project_position(get_viewport().get_mouse_position(), 10)
	raycast.look_at(newLoc)
	
	#Raycast down and snap to floor.
	if raycast.is_colliding():
		print(raycast.get_collider().position)
		newLoc = raycast.get_collision_point()
	
	print(camera.global_rotation)
	print($RayCast3D.global_rotation)
	
	position = newLoc
