extends RigidBody2D

const SPEED = 0.2

@onready var is_paused = false
@onready var time = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_paused == false:
		$Sprite2D.material.set_shader_parameter("Time", time)
		time += delta
	else:
		return

func stop():
	$Sprite2D.material.set_shader_parameter("Speed", 0)
	is_paused = true
	
func start():
	$Sprite2D.material.set_shader_parameter("Speed", SPEED)
	is_paused = false
