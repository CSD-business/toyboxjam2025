extends Node3D

@export var level_number : int
@export var ATK_UNIT : PackedScene
@export var DEF_UNIT : PackedScene
@export var RNG_UNIT : PackedScene
@onready var Markers = $"../Markers"

var dictionary_ref

var spawnlocs : Array[Vector3]
signal SpawnEnemyUnit(unit, location)
signal start_spawning
func _ready():
	determine_enemy_ai()
	for marker in Markers.get_children():
		spawnlocs.append(marker.position) 
		print(spawnlocs)
		print("Found Marker: " + marker.name)
		#get all the possible spawn locations in the given level
	parse_dictionary_ref(dictionary_ref)

func _process(delta):
	polling_function()

func determine_enemy_ai():
	match level_number:
		1: dictionary_ref = $LevelEnemyDictionary.Level1
		2: dictionary_ref = $LevelEnemyDictionary.Level2
		3: dictionary_ref = $LevelEnemyDictionary.Level3
		4: dictionary_ref = $LevelEnemyDictionary.Level4
		5: dictionary_ref = $LevelEnemyDictionary.Level5
		_: print("Invalid level number.")
	
func parse_dictionary_ref(ref):
	await start_spawning
	if GlobalVars.GameIsGoing:
		for instruction in ref:
			if GlobalVars.GameIsGoing:
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
				if instruction.contains("M4"): 
					if instruction.contains("ATK"):
						SpawnEnemyUnit.emit(spawnlocs[3], ATK_UNIT)
					if instruction.contains("DEF"):
						SpawnEnemyUnit.emit(spawnlocs[3], DEF_UNIT)
					if instruction.contains("RNG"):
						SpawnEnemyUnit.emit(spawnlocs[3], RNG_UNIT)
				if instruction.contains("WAIT"):
					var waittime = int(instruction.replace("WAIT", ""))
					await get_tree().create_timer(waittime).timeout
		print("Repeating commands.")
		parse_dictionary_ref(ref)

func polling_function():
	if GlobalVars.GameIsGoing == true:
		start_spawning.emit()
	
