extends State

func enter() -> void:
	super()
	#Trigger animation.
	#Spawn smoke puff particle.
	if parent.stats.Unit_Name == "Tower":
		if parent.stats.Unit_Side == 0:
			GlobalVars.FriendlyTowers -= 1
		if parent.stats.Unit_Side == 1:
			GlobalVars.EnemyTowers -= 1
	if parent.stats.Unit_Side == 0:
		GlobalVars.PlayerCasualties += 1
	$"../..".queue_free()
