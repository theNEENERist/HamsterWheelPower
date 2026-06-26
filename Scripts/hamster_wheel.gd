extends Area2D

@export var tooltip_text: String = "E"

var tooltip_label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# shows tooltip when the player is colliding with the wheel.
func tooltip_show() -> void:
	$"ToolTipLabel".text = tooltip_text
	$"ToolTipLabel".show()

 # hides the tooltip if player is not colliding with the wheel.
func tooltip_hide() -> void:
	$"ToolTipLabel".hide()