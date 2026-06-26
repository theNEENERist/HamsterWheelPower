extends Node

@export var power: int = 0
@export var wheel_speed = 400

var wheel_selected: bool = true
var wheel_velocity: Vector2 = Vector2.ZERO
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size
	print ("Screen size: ", screen_size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func power_up() -> void:
	power += 1
	$"HUD".set_score(power)

func power_down() -> void:
	power -= 1
	$"HUD".set_score(power)

func _input(event):
	if event.is_action_pressed("ui_right") || event.is_action_pressed("ui_left"):
		$"Power Up Timer".start()
		$"Power Down Timer".stop()
	if event.is_action_released("ui_right") || event.is_action_released("ui_left"):
		$"Power Down Timer".start()
		$"Power Up Timer".stop()

# func on_power_timer_timeout() -> void:
# 	if wheel_selected:
# 		if Input.is_action_pressed("ui_right"):
# 			power_up()
# 		elif Input.is_action_pressed("ui_left"):
# 			power_up()
# 		else:
# 			power_down()
# 	else:
# 		power_down()

func _on_power_up_timer_timeout() -> void:
	power_up()


func _on_power_down_timer_timeout() -> void:
	power_down()
