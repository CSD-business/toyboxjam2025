extends Node

var AllyUnits : Array[PackedScene]
var EnemyUnits : Array[PackedScene]
var AllyUnitId : int

func _ready() -> void:
	GlobalVars.Pieces = self
	AllyUnits = [load("res://Scenes/Units/UnitAtkA.tscn"), load("res://Scenes/Units/UnitDefA.tscn"), load("res://Scenes/Units/UnitRngA.tscn")]
	EnemyUnits = [load("res://Scenes/Units/UnitAtkE.tscn"), load("res://Scenes/Units/UnitDefE.tscn"), load("res://Scenes/Units/UnitRngE.tscn")]

func Try_Spawn_Unit():
	if not GlobalVars.Stamina - GlobalVars.CurCost < 0:
		GlobalVars.Stamina = GlobalVars.Stamina - GlobalVars.CurCost
		var newSpawn = AllyUnits[AllyUnitId].instantiate()
		var mos_position = 	GlobalVars.MouseMgr.position
		newSpawn.position = mos_position
		add_child(newSpawn)

func Spawn_Enemy_Unit(location, unit):
	var newSpawn = unit.instantiate()
	newSpawn.position = location
	add_child(newSpawn)
