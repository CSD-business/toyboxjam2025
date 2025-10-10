extends Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation.y = $"../Arrow".rotation.y
	print(str(rotation.y) + " " + name)
	
