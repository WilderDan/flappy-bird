extends CharacterBody2D

signal hit_ground
const JUMP_VELOCITY = -500.0
const ROTATIONAL_ACCELERATION = 0.025

@onready var rotational_velocity = 1
@onready var is_active = false
@onready var is_falling = false

func _physics_process(delta: float) -> void:
	if not is_active:
		return
		
	velocity += get_gravity() * delta
	if rotation < PI/2:
		rotation += rotational_velocity * delta
		rotational_velocity += ROTATIONAL_ACCELERATION

	# Handle jump. (if not falling)
	if Input.is_action_just_pressed("tap") and not is_falling:
		$FlapSound.play()
		velocity.y = JUMP_VELOCITY
		rotation = -1 * PI/4
		rotational_velocity = 1

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
				is_falling = true
		
