extends AnimatedSprite2D

@export var speed = 400

var wheel_selected: bool = true
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var wheel_velocity = Vector2.ZERO # The player's movement vector.
	if wheel_selected:
		if Input.is_action_pressed("ui_right"):
			wheel_velocity.x += 1
		elif Input.is_action_pressed("ui_left"):
			wheel_velocity.x -= 1

		if wheel_velocity.length() > 0:
			wheel_velocity = wheel_velocity.normalized() * speed

		position += wheel_velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
