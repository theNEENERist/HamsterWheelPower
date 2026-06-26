extends Node

@export var power: int = 0
@export var wheel_speed = 400

var wheel_velocity: Vector2 = Vector2.ZERO
var screen_size # Size of the game window.
var player_wheel_collide: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var overlapping: Array[Node2D] = $"Hamster Wheel".get_overlapping_bodies()
	if overlapping.size() > 1:
		if overlapping.has($"Player Character"):
			player_wheel_collide = true
			$"Hamster Wheel".tooltip_show()
		else:
			player_wheel_collide = false
			$"Hamster Wheel".tooltip_hide()

	else:
		player_wheel_collide = false
		$"Hamster Wheel".tooltip_hide()

# increases the power variable by 1 and updates the HUD
func power_up() -> void:
	power += 1
	$"HUD".set_score(power)

# decreases the power variable by 1 and updates the HUD
func power_down() -> void:
	power -= 1
	$"HUD".set_score(power)

# listens for left and right input events and starts/stops the power up and down timers accordingly if the wheel is selected.
# will change the wheel_selected variable if the player presses the interact button while colliding with the wheel.
func _input(event):
	if Globals.wheel_selected:
		if event.is_action_pressed("ui_right") or event.is_action_pressed("ui_left"):
			$"Power Up Timer".start()
			$"Power Down Timer".stop()
		if event.is_action_released("ui_right") or event.is_action_released("ui_left"):
			$"Power Down Timer".start()
			$"Power Up Timer".stop()

	if event.is_action_pressed("Interact") and player_wheel_collide:
		Globals.wheel_selected = not Globals.wheel_selected

# calls power_up() function when the timer time out
func _on_power_up_timer_timeout() -> void:
	if not Globals.max_power_reached:
		power_up()

# calls power_down() function when the timer times out
func _on_power_down_timer_timeout() -> void:
	if not Globals.min_power_reached:
		power_down()
