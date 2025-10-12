extends Node3D

@onready var MatIn = preload("res://Materials/MouseMgr.tres")
@onready var MatOut = preload("res://Materials/MouseMgrNo.tres")

@export var camera : Camera3D
@export var raycast : RayCast3D
var InRegion : bool

signal TrySpawnUnit()

func _ready() -> void:
	GlobalVars.MouseMgr = self
	$AnimationPlayer.play("arrow_loop")
	InRegion = false

func _process(_delta: float) -> void:
	SnapToMouse()
	UpdateMat()
	if GlobalVars.GameIsGoing:
		if Input.is_action_just_pressed("Click") and GlobalVars.OnUI == false and InRegion:
			TrySpawnUnit.emit()

func SnapToMouse():
	#Project mouse position from the screen to a 3D space.
	var newLoc = camera.project_position(get_viewport().get_mouse_position(), 10)
	raycast.look_at(newLoc)
	
	#Raycast down and snap to floor.
	if raycast.is_colliding():
		newLoc = raycast.get_collision_point()
	position = newLoc

func UpdateMat():
	if InRegion == true:
		$Node3D/Arrow1.material_override = MatIn
		$Node3D/Arrow2.material_override = MatIn
		$Node3D/Arrow3.material_override = MatIn
		$Node3D/Arrow4.material_override = MatIn
	else:
		$Node3D/Arrow1.material_override = MatOut
		$Node3D/Arrow2.material_override = MatOut
		$Node3D/Arrow3.material_override = MatOut
		$Node3D/Arrow4.material_override = MatOut
