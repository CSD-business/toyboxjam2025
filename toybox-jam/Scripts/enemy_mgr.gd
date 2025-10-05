extends Node3D

@export var level_number : int
@export var ATK_UNIT : PackedScene
@export var DEF_UNIT : PackedScene
@export var RNG_UNIT : PackedScene
var dictionary_ref

var spawnlocs : Array[Vector3]
signal SpawnEnemyUnit(unit, location)
func _ready():
	determine_enemy_ai()
	for marker in get_node("../Markers").get_children():
		spawnlocs.append(marker.position) 
		print(spawnlocs)
		print("Found Marker: " + marker.name)
		#get all the possible spawn locations in the given level
	parse_dictionary_ref(dictionary_ref)

func determine_enemy_ai():
	match level_number:
		1: dictionary_ref = $LevelEnemyDictionary.Level1
		2: pass
		3: pass
		_: print("Invalid level number.")
	
func parse_dictionary_ref(ref):
	for instruction in ref:
		print(instruction)
		if instruction.contains("M1"): 
			if instruction.contains("ATK"):
				SpawnEnemyUnit.emit(spawnlocs[0], ATK_UNIT)
			if instruction.contains("DEF"):
				SpawnEnemyUnit.emit(spawnlocs[0], DEF_UNIT)
			if instruction.contains("RNG"):
				SpawnEnemyUnit.emit(spawnlocs[0], RNG_UNIT)
		if instruction.contains("M2"): 
			if instruction.contains("ATK"):
				SpawnEnemyUnit.emit(spawnlocs[1], ATK_UNIT)
			if instruction.contains("DEF"):
				SpawnEnemyUnit.emit(spawnlocs[1], DEF_UNIT)
			if instruction.contains("RNG"):
				SpawnEnemyUnit.emit(spawnlocs[1], RNG_UNIT)
		if instruction.contains("M3"): 
			if instruction.contains("ATK"):
				SpawnEnemyUnit.emit(spawnlocs[2], ATK_UNIT)
			if instruction.contains("DEF"):
				SpawnEnemyUnit.emit(spawnlocs[2], DEF_UNIT)
			if instruction.contains("RNG"):
				SpawnEnemyUnit.emit(spawnlocs[2], RNG_UNIT)
		if instruction.contains("WAIT"):
			var waittime = int(instruction.replace("WAIT", ""))
			await get_tree().create_timer(waittime).timeout
	print("Repeating commands.")
	parse_dictionary_ref(ref)
