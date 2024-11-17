extends CharacterBody2D

@onready var player = get_parent().get_node( "Knight")
@onready var sprite = $Orc_animation
@onready var under_attack = $"../Knight".is_attacking

const life = 10
const SPEED = 50.0
const JUMP_VELOCITY = -100.0
var attacking = false
var direction: int

func _ready():
	position = Vector2(55, -10)

func _physics_process(delta: float) -> void:
	under_attack = $"../Knight".is_attacking
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var player_position = player.position
	var target_position = Vector2((player_position - position).normalized( ))
	
	if is_on_floor():
		if (target_position.y - player_position.y) > 3 and player_position.y < target_position.y:
			velocity.y = JUMP_VELOCITY
	
	if position.distance_to(player.position) < 20:
		sprite.play("attack")
		attacking = true
		
	if position.distance_to(player_position) > 5:
			velocity.x = target_position.x * SPEED
	
	if velocity.x > 0:
		direction = 1
	elif velocity.x < 0:
		direction = -1
	else:
		direction = 0
		
	sprite_flip(direction)
	move_and_slide()


func sprite_flip(direction):
	if direction > 0:
		sprite.flip_h = false
	
	elif direction < 0:
		sprite.flip_h = true


func _hitbox(body: Node2D) -> void:
	if under_attack:
		print("hit!!")
		sprite.play("death")
		await sprite.animation_finished
		#death()
		#
#func death():
	#queue_free()
