extends Node2D

enum State {Ready, Playing, Pending, Gameover}

@onready var piper_handler_scene  = preload("res://scenes/pipe_handler.tscn")
var piper_handler 
@onready var state = State.Ready
@onready var player_start_position = $Player.position

func _input(event):
	if event.is_action_pressed("tap"):
		match state:
			State.Ready:
				start_game()
			State.Gameover:
				start_ready()
			_: # 'Pending' do nothing. 'Playing' handled by Player script
				pass
				
func start_game():
	$ReadyMessage.hide()
	$Score.show()
	$Player.position.x -= 100  
	$Player.is_active = true
	piper_handler = piper_handler_scene.instantiate()
	piper_handler.position = Vector2(1500, 0)
	piper_handler.connect("scored", update_score)
	$Player.connect("hit_pipe", piper_handler.stop)
	add_child(piper_handler)
	state = State.Playing 
	
func _on_player_hit_ground() -> void:
	start_gameover()
	
func _on_player_hit_pipe() -> void:
	start_gameover()
	
func _on_player_hit_sky() -> void:
	start_gameover()
	
func start_ready():
	$Score.reset()
	$ScoreCard.hide()
	piper_handler.queue_free()
	$GameoverMessage.hide()
	$ReadyMessage.show()
	$Music.play()
	$Player.reset(player_start_position)
	$Player.is_active = false
	$Ground.start()
	state = State.Ready
	
func start_gameover():
	if state == State.Pending or state == State.Gameover:
		return
	$Ground.stop()
	$Music.stop()
	$GameoverMessage.show()
	piper_handler.stop()
	$Score.update_best()
	$Score.hide()
	$ScoreCard.update($Score.score, $Score.best)
	$ScoreCard.show()
	state = State.Pending
	$GameOverInputDelayTimer.start()
	
func _on_game_over_input_delay_timer_timeout() -> void:
	state = State.Gameover

func update_score():
	if state == State.Gameover or state == State.Pending:
		return
		 
	$Score.increment()
