extends CharacterBody2D

const JUMP_VELOCITY = -500.0

var is_active = false

func _physics_process(delta: float) -> void:
	if not is_active:
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("tap"):
		velocity.y = JUMP_VELOCITY

	var collision = move_and_collide(velocity * delta)
	if collision:
		var game_object  = collision.get_collider().name
		match game_object:
			"Ground":
				$HitSound.play()
		
