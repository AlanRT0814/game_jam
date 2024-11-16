extends CharacterBody2D

@onready var player = get_parent().get_node( "Knight")
@onready var sprite = $Orc_animation

const life = 10
const SPEED = 30.0
const JUMP_VELOCITY = -200.0
var attacking = false

func _ready():
	position = Vector2(55, 0)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var player_position = player.position
	var target_position = Vector2((player_position - position).normalized( ))
	var direction = player.position.x - target_position.x 
	sprite_flip(direction)
	
	if is_on_floor():
		if (target_position.y - player_position.y) > 3 and player_position.y < target_position.y:
			velocity.y = JUMP_VELOCITY
	
	if position.distance_to(player.position) < 20:
		sprite.play("attack")
		attacking = true
		
	if attacking == false:
		if position.distance_to(player_position) > 5:
			velocity.x = target_position.x * SPEED

	move_and_slide()


func sprite_flip(direction):
	if direction > 0:
		sprite.flip_h = false
	
	elif direction < 0:
		sprite.flip_h = true
