extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@onready var animated_spirte = $k_animation

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input directions -1, 0, 1 -> left, center, right
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_spirte.flip_h = false
	
	elif direction < 0:
		animated_spirte.flip_h = true
	
	var attack_1 = Input.is_key_pressed(KEY_SPACE)
	
	if attack_1:
		animated_spirte.play("attack_1")
	
	attack_1 = false
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
