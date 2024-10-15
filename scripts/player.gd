extends CharacterBody2D

const JUMP_VELOCITY = -500.0

@onready var is_active = false
var is_falling = false

func _physics_process(delta: float) -> void:
	if not is_active:
		return
		
	velocity += get_gravity() * delta

	# Handle jump. (if not falling)
	if Input.is_action_just_pressed("tap") and not is_falling:
		velocity.y = JUMP_VELOCITY

	var collision = move_and_collide(velocity * delta)
	if collision:
		var game_object  = collision.get_collider().name
		
		match game_object:
			"Ground", "Example": 
				$HitSound.play()
				# Will try to play sound each function call
				# which will keep sound starting over and not
				# hear anything
				# Below solves this
				is_active = false
			"Sky":
				$SwooshSound.play()
				is_falling = true
		
