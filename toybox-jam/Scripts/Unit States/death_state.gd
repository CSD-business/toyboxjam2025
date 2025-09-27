extends State

func enter() -> void:
	super()
	#Trigger animation.
	#Spawn smoke puff particle.
	$"../..".queue_free()
