extends CharacterBody2D
 
const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite = $k_animation
@onready var time = $k_animation/Timer

var current_state : String
var is_attacking = false

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
	
	if Input.is_action_pressed("attack_1") and not is_attacking:
		start_attack()
		
	#if is_attacking == false:
		#anim	ated_sprite.play("idle")
	

func sprite_flip(direction):
	if direction > 0:
		animated_sprite.flip_h = false
	
	elif direction < 0:
		animated_sprite.flip_h = true
		
func start_attack():
	is_attacking = true
	animated_sprite.play("attack_1")
	await animated_sprite.animation_finished
	end_attack()
	
	
func end_attack() -> void:
	is_attacking = false
	

	
