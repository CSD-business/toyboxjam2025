extends TextureProgressBar

var StaminaCharge = 0.5

func _process(delta: float) -> void:
	if GlobalVars.Stamina >= max_value:
		GlobalVars.Stamina = max_value
	else:
		GlobalVars.Stamina = GlobalVars.Stamina + (StaminaCharge * delta)
		value = GlobalVars.Stamina
		$StamTxt.text = str(int(GlobalVars.Stamina))
