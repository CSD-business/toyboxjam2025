extends Control

func _ready():
	check_level_avaliablilty()

func _on_level_select_pressed():
	$"Control/Main Buttons".hide()
	$Control/Levels.show()


func _on_back_pressed():
	$"Control/Main Buttons".show()
	$Control/Levels.hide()



func _on_credits_pressed():
	pass # Replace with function body.


func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_2.tscn")


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_3.tscn")


func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_4.tscn")


func _on_level_5_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_5.tscn")


func _on_instructions_pressed():
	move_thing($Environment/TutorialCam)
	$"Control/Main Buttons".hide()
	$Control/Title.hide()
	$Control/BackFromTut.show()
	
func move_thing(goal : Node):
	var tween := create_tween()
	tween.set_parallel()
	tween.tween_property($Environment/Camera3D, ^"position", goal.position, 1.0) # take two seconds to move
	tween.tween_property($Environment/Camera3D, ^"rotation", goal.rotation, 1.0) # take two seconds to move


func _on_back_from_tut_pressed():
	move_thing($Environment/NormalCam)
	$Control/BackFromTut.hide()
	$"Control/Main Buttons".show()
	$Control/Title.show()

func check_level_avaliablilty():
	if GlobalVars.CanDoLVL2:
		$Control/Levels/VBoxContainer/HBoxContainer/Level2.disabled = false
	if GlobalVars.CanDoLVL3:
		$Control/Levels/VBoxContainer/HBoxContainer/Level3.disabled = false
	if GlobalVars.CanDoLVL4:
		$Control/Levels/VBoxContainer/HBoxContainer/Level4.disabled = false
	if GlobalVars.CanDoLVL5:
		$Control/Levels/VBoxContainer/HBoxContainer/Level5.disabled = false

func _input(event):
	if Input.is_key_pressed(KEY_U):
		$Control/Levels/VBoxContainer/HBoxContainer/Level2.disabled = false
		$Control/Levels/VBoxContainer/HBoxContainer/Level3.disabled = false
		$Control/Levels/VBoxContainer/HBoxContainer/Level4.disabled = false
		$Control/Levels/VBoxContainer/HBoxContainer/Level5.disabled = false
