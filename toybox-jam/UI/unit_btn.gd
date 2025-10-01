extends TextureButton

@export var Title : String
@export var Cost : String
##Need to find a way to reference a class like in Unreal.

func _ready() -> void:
	$TitleTxt.text = Title
	$CostTxt.text = Cost
