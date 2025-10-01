extends Node

@export var Pawn : PackedScene

func Try_Spawn_Unit(enemy):
	match enemy:
		0:
			enemy = Pawn
		1:
			pass
		2:
			pass
	var newSpawn = enemy.instantiate()
	var mos_position = $"../MouseMgr".position
	newSpawn.position = mos_position
	add_child(newSpawn)
