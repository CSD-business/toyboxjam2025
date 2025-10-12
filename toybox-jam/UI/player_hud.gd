extends Control
@export var This_Level = PackedScene
@export var level_unlock_key : int
func _process(delta):
	polling_function()

func polling_function():
	if GlobalVars.GameIsGoing == false:
		$HeadsUpUI/ReadyText.show()
		await get_tree().create_timer(1).timeout
		if GlobalVars.EnemyTowers == 0:
			$HeadsUpUI/ResultW.show()
			#format ui text based on vars
			$HeadsUpUI/WinTimer.text = str("You took " + str(snapped(GlobalVars.RoundPlaytime, .01)) + " seconds!")
			if GlobalVars.PlayerCasualties == 1:
					$HeadsUpUI/UnitLosses.text = str("You lost " + str(GlobalVars.PlayerCasualties) + " unit!")
			else:	
				$HeadsUpUI/UnitLosses.text = str("You lost " + str(GlobalVars.PlayerCasualties) + " units!")
			match level_unlock_key:
				1:
					GlobalVars.CanDoLVL2 = true
				2:
					GlobalVars.CanDoLVL3 = true
				3: 
					GlobalVars.CanDoLVL4 = true
				4:
					GlobalVars.CanDoLVL5 = true
			#show stuff
			$HeadsUpUI/WinTimer.show()
			$HeadsUpUI/UnitLosses.show()
			$HeadsUpUI/HBoxContainer.show()
			await get_tree().create_timer(1).timeout
			$HeadsUpUI/HBoxContainer/Menu.disabled = false
			$HeadsUpUI/HBoxContainer/Restart.disabled = false
		if GlobalVars.FriendlyTowers == 0:
			$HeadsUpUI/ResultL.show()
			$HeadsUpUI/HBoxContainer.show()
	else:
		$HeadsUpUI/ReadyText.text = "Go!"
		await get_tree().create_timer(1).timeout
		$HeadsUpUI/ReadyText.text = ""
		$HeadsUpUI/ReadyText.hide()


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")


func _on_restart_pressed():
	get_tree().reload_current_scene()
