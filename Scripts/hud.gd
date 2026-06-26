extends CanvasLayer

@export var max_power: int = 25
@export var min_power: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"ProgressBar".max_value = max_power
	$"ProgressBar".min_value = min_power
	$ProgressBar.value = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# updates the score label on the HUD with the current score
func set_score(score: int) -> void:
	$ProgressBar.value = score

# updates if max or min power has been reached absed on the value
func _on_progress_bar_value_changed(value: float) -> void:
	if value >= max_power:
		Globals.max_power_reached = true
		Globals.min_power_reached = false
	elif value <= min_power:
		Globals.min_power_reached = true
		Globals.max_power_reached = false
	else:
		Globals.max_power_reached = false
		Globals.min_power_reached = false
