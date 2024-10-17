extends CharacterBody2D

@export var speed = -500
@onready var is_moving = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_moving:
		velocity.x = speed
		move_and_collide(velocity * delta)

func _on_despawn_timer_timeout() -> void:
	get_parent().remove_child(self)

func disable():
	is_moving = false
	$DespawnTimer.stop()
	collision_layer = 0
