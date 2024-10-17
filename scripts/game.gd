extends Node2D

enum State {Ready, Playing, Gameover}

@onready var pipe_spawner_scene  = preload("res://scenes/pipe_spawner.tscn")
var pipe_spawner 
@onready var state = State.Ready
@onready var player_start_position = $Player.position

func _input(event):
	if event.is_action_pressed("tap"):
		match state:
			State.Ready:
				start_game()
			State.Gameover:
				show_ready()
				
func start_game():
	$ReadyMessage.hide()
	$Player.position.x -= 100  
	$Player.is_active = true
	pipe_spawner = pipe_spawner_scene.instantiate()
	pipe_spawner.position = Vector2(1500, 0)
	$Player.connect("hit_pipe", pipe_spawner.stop)
	add_child(pipe_spawner)
	state = State.Playing 
	
func _on_player_hit_ground() -> void:
	$Ground.stop()
	$Music.stop()
	$GameoverMessage.show()
	pipe_spawner.stop()
	state = State.Gameover
	
func _on_player_hit_pipe() -> void:
	$Ground.stop()
	$Music.stop()
	$GameoverMessage.show()
	pipe_spawner.stop()
	state = State.Gameover
	
func show_ready():
	pipe_spawner.queue_free()
	$GameoverMessage.hide()
	$ReadyMessage.show()
	$Music.play()
	$Player.reset(player_start_position)
	$Player.is_active = false
	$Ground.start()
	state = State.Ready
