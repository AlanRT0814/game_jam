extends Area2D

@onready var animated_sprite = $".."
@onready var player = $"../.."
@onready var hitzone = $sword

var frame: int
const  dx = 13
const dy = -4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var attacking = $"../..".is_attacking
	var direction = $"../..".direction
	
	if attacking == false:
		frame = 0
		
	if attacking:
		if animated_sprite.sprite_frames_changed:
			frame += 1
			
	print(frame)
	
	if 10 < frame and frame < 60:
		var x_hitbox = dx * direction
		var y_hitbox = dy * direction
		position = Vector2((player.position.x + x_hitbox), (player.position.y + y_hitbox))
	
	else:
		position = Vector2(0, 0)
	
	
