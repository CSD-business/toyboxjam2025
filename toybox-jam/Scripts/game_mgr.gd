extends Node

var friendly_castles = []
var enemy_castles = []

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVars.PlayerCasualties = 0
	for piece in $"../Pieces".get_children():
		if piece.get_node("Stats Component").Unit_Name == "Tower":
			print(piece.name)
			if piece.get_node("Stats Component").Unit_Side == 0:
				friendly_castles.append(piece)
			if piece.get_node("Stats Component").Unit_Side == 1:
				enemy_castles.append(piece)
	print("There's " + str(friendly_castles.size()) + " friendly castles.")
	print("There's " + str(enemy_castles.size()) + " enemy castles.")
	GlobalVars.EnemyTowers = enemy_castles.size()
	GlobalVars.FriendlyTowers = friendly_castles.size()
	
	await get_tree().create_timer(3).timeout
	GlobalVars.GameIsGoing = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVars.GameIsGoing:
		GlobalVars.RoundPlaytime += delta
		if GlobalVars.FriendlyTowers == 0:
			stop_round(0)
		if GlobalVars.EnemyTowers == 0:
			stop_round(1)
		
func stop_round(result : int):
	fade_out_music()
	match result:
		0:
			print("Player Loss")
			GlobalVars.GameIsGoing = false
		1:
			print("Player Win")
			GlobalVars.GameIsGoing = false
func fade_out_music():
	var tween := create_tween()
	tween.tween_property($"../GameMusic", "volume_db", -80, 8)
	print($"../GameMusic".volume_db)
