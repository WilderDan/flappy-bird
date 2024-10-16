extends Node2D

enum State {Title, Playing}

@onready var state = State.Title

func _input(event):
	if event.is_action_pressed("tap"):
		match state:
			State.Title:
				start_game()
				
func start_game():
	state = State.Playing 
	$ReadyMessage.hide() 
	$Player.is_active = true
	
func _on_player_hit_ground() -> void:
	$Ground.stop()
	$Music.stop()
	$GameoverMessage.show()
