extends CharacterBody2D

signal hit_ground
const JUMP_VELOCITY = -800.0
const ROTATIONAL_ACCELERATION = 3

@onready var rotational_velocity = 0
@onready var is_active = false
@onready var is_flew_too_high = false

func _physics_process(delta: float) -> void:
	if not is_active:
		return
		
	velocity += 2.5 * get_gravity() * delta
	if rotation < PI/2:
		rotation += rotational_velocity * delta
		rotational_velocity += ROTATIONAL_ACCELERATION * delta

	# Handle jump.
	if Input.is_action_just_pressed("tap") and not is_flew_too_high:
		$FlapSound.play()
		velocity.y = JUMP_VELOCITY
		rotation = -1 * PI/4
		rotational_velocity = 0

	var collision = move_and_collide(velocity * delta)
	if collision:
		var game_object  = collision.get_collider().name
		
		match game_object:
			"Ground": 
				$HitSound.play()
				$Animation.stop()
				hit_ground.emit()
				is_active = false
			"Sky":
				$SwooshSound.play()
				$Animation.stop()
				is_flew_too_high = true
		

func reset(location):
	position = location
	rotation = 0
	is_flew_too_high = false
	$Animation.play()
	
