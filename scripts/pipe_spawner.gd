extends Node2D

signal scored

@export var spawn_time = 1.2
@onready var pipes  = preload("res://scenes/pipes.tscn")
@onready var pipe_list = []

func _on_timer_timeout() -> void:
	# Initial short time for quicker game start then change here
	$Timer.wait_time = spawn_time
	$Timer.start()
	var instance = pipes.instantiate()
	var height = randi() % 801 + 400
	instance.position.y = height
	instance.connect("scored", func(): scored.emit())
	pipe_list.append(instance)
	add_child(instance)
	
func stop():
	$Timer.stop()
	for pipe in pipe_list:
		pipe.disable()
	
func _on_player_hit_pipe() -> void:
	stop()
