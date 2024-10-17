extends CharacterBody2D

signal hit_ground
signal hit_pipe
signal hit_sky

const GRAVITY = Vector2(0, 4000)
const JUMP_VELOCITY = -1200.0
const ROTATIONAL_ACCELERATION = 3

@onready var rotational_velocity = 0
@onready var is_active = false
@onready var is_death_fall = false

func _physics_process(delta: float) -> void:
	if not is_active:
		return
		
	velocity += GRAVITY * delta
	if rotation < PI/2:
		rotation += rotational_velocity * delta
		rotational_velocity += ROTATIONAL_ACCELERATION * delta

	# Handle jump.
	if Input.is_action_just_pressed("tap") and not is_death_fall:
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
				hit_sky.emit()
				$SwooshSound.play()
				$Animation.stop()
				is_death_fall = true
			# Pipes -> name changes i.e Pipes, Pipes2, etc.
			_:
				hit_pipe.emit()
				$HitSound.play()
				$Animation.stop()
				is_death_fall = true
		

func reset(location):
	position = location
	rotation = 0
	is_death_fall = false
	$Animation.play()
	
