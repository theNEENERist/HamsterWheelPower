extends CharacterBody2D


@export var max_speed = 200.0
@export var acceleration = 300
@export var friction = 800
@export var jump_velocity = -100.0

@onready var axis = Vector2.ZERO
@onready var animated_sprite = $AnimatedSprite2D

signal action_interact



func _physics_process(delta: float) -> void:
	
	move(delta)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity
		
	if Input.is_action_just_pressed("Interact"):
		emit_signal("action_interact")

	#Changed up how movement was coded, commented this out in case we want to change back.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("Left", "Right")
	#if direction:
	#	velocity.x = direction * speed
	#else:
	#	velocity.x = move_toward(velocity.x, 0, speed)

func get_input_axis():
	axis.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	return axis.normalized()
	

func move(delta):
	
	axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		apply_friction(friction * delta)
		animated_sprite.play("Idle")
		animated_sprite.speed_scale = 1.0
	else:
		apply_movement(axis * acceleration * delta)
		animated_sprite.play("Walk")
		var current_speed = abs(velocity.x)
		var speed_ratio = current_speed / max_speed
		animated_sprite.speed_scale = speed_ratio
		if Input.is_action_pressed("Left"):
			animated_sprite.flip_h = true
		elif Input.is_action_pressed("Right"):
			animated_sprite.flip_h = false
	
	move_and_slide()

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(max_speed)
