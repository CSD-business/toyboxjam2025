extends State

func enter() -> void:
	super()
	#Trigger animation.
	#Spawn smoke puff particle.
	parent.dparticles.emitting = true
	$"../../DeathSound2".play()
	if parent.stats.Unit_Name == "Tower":
		if parent.stats.Unit_Side == 0:
			GlobalVars.FriendlyTowers -= 1
		if parent.stats.Unit_Side == 1:
			GlobalVars.EnemyTowers -= 1
	else:
		$"../../Unit".hide()
	if parent.stats.Unit_Side == 0:
		GlobalVars.PlayerCasualties += 1
	await get_tree().create_timer(.1).timeout
	$"../..".queue_free()
	
	


func _on_death_particles_finished():
	pass
