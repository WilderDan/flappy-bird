extends RigidBody2D

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
