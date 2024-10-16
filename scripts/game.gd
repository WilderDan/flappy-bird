extends Node2D

enum State {Ready, Playing, Gameover}

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
	$Player.is_active = true
	state = State.Playing 
	
func _on_player_hit_ground() -> void:
	$Ground.stop()
	$Music.stop()
	$GameoverMessage.show()
	state = State.Gameover
	
func show_ready():
	$GameoverMessage.hide()
	$ReadyMessage.show()
	$Music.play()
	$Player.reset(player_start_position)
	$Ground.start()
	state = State.Ready
