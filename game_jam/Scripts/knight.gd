extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@onready var animated_spirte = $k_animation
var current_state : String
var attack_1 = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input directions -1, 0, 1 -> left, center, right
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	handle_animation(direction)

	
func handle_animation(dir):
	sprite_flip(dir)
	
	if attack_1 == false:
		attack_1 = Input.is_action_pressed("attack_1")
	
	if attack_1:
		animated_spirte.play("attack_1")
	
	else:
		animated_spirte.play("idle")
		
	print(attack_1)

func sprite_flip(direction):
	if direction > 0:
		animated_spirte.flip_h = false
	
	elif direction < 0:
		animated_spirte.flip_h = true
