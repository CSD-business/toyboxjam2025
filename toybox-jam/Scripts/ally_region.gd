extends Area3D

func _on_area_entered(area: Area3D) -> void:
	if area == GlobalVars.MouseMgr:
		GlobalVars.MouseMgr.InRegion = true

func _on_area_exited(area: Area3D) -> void:
	if area == GlobalVars.MouseMgr:
		GlobalVars.MouseMgr.InRegion = false
