extends CharacterBody2D


const SPEED: float = 200.0
const JUMP_VELOCITY: float = -300.0
const ACCELERATION: float = 800.0
const FRICTION: float = 600.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if (Input.is_action_just_pressed("gamepad_jump") or
		Input.is_action_just_pressed("ui_accept")) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jumping")

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		$AnimatedSprite2D.play("idle")

	move_and_slide()
