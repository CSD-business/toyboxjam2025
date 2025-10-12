extends Control
@export var level_unlock_key : int
var round_over = false 
var round_starting = true
func _process(delta):
	polling_function()
func _ready():
	$Ready.play()

func polling_function():
	if GlobalVars.GameIsGoing == false:
		if round_starting == true:
			await get_tree().create_timer(1).timeout
			round_starting = false
		if GlobalVars.EnemyTowers == 0:
			end_round(0)
		if GlobalVars.FriendlyTowers == 0:
			end_round(1)
	else:
		$HeadsUpUI/ReadyText.text = "Go!"
		if $Go.playing == false:
			$Go.play()
			await get_tree().create_timer(.65).timeout
			$Go.volume_db = -80
		await get_tree().create_timer(1).timeout
		$HeadsUpUI/ReadyText.text = ""
		$HeadsUpUI/ReadyText.hide()
	
func end_round(outcome):
	if round_over == false:
		match outcome:
			0:
				round_over = true
				$SuccessAnn.play()
				$SuccessMenu.play()
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
					5: 
						GlobalVars.Him = true
				#show stuff
				$HeadsUpUI/ResultW.show()
				$HeadsUpUI/WinTimer.show()
				$HeadsUpUI/UnitLosses.show()
				$HeadsUpUI/HBoxContainer.show()
				await get_tree().create_timer(1).timeout
				$HeadsUpUI/HBoxContainer/Menu.disabled = false
				$HeadsUpUI/HBoxContainer/Restart.disabled = false
			1:
				round_over = true
				$FailureAnn.play()
				$FailureMenu.play()
				$HeadsUpUI/ResultL.show()
				$HeadsUpUI/HBoxContainer.show()
				await get_tree().create_timer(1).timeout
				$HeadsUpUI/HBoxContainer/Menu.disabled = false
				$HeadsUpUI/HBoxContainer/Restart.disabled = false
				
func _on_menu_pressed():
	GlobalVars.GameIsGoing = false
	$MenuButtonSFX.play()
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
	

func _on_restart_pressed():
	get_tree().reload_current_scene()
	$MenuButtonSFX.play()
