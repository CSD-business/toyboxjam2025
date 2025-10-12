extends TextureButton

@export var Title : String
@export var Cost : int
@export var UnitId : int

func _ready() -> void:
	$TitleTxt.text = Title
	$CostTxt.text = str(Cost)

func _process(delta: float) -> void:
	if GlobalVars.Stamina - Cost < 0:
		modulate = Color.GRAY
		$CostTxt.modulate = Color.RED
	else:
		modulate = Color.WHITE
		$CostTxt.modulate = Color.WHITE

func _pressed() -> void:
	GlobalVars.Pieces.AllyUnitId = UnitId
	GlobalVars.CurCost = Cost
	$"../../UIButtonSFX".play()

func _on_mouse_entered() -> void:
	GlobalVars.OnUI = true

func _on_mouse_exited() -> void:
	GlobalVars.OnUI = false
