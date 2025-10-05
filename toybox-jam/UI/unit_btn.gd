extends TextureButton

@export var Title : String
@export var Cost : String
@export var UnitId : int

func _ready() -> void:
	$TitleTxt.text = Title
	$CostTxt.text = Cost

func _pressed() -> void:
	GlobalVars.Pieces.AllyUnitId = UnitId

func _on_mouse_entered() -> void:
	GlobalVars.OnUI = true

func _on_mouse_exited() -> void:
	GlobalVars.OnUI = false
