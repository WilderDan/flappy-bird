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
	piper_handler.queue_free()
	$GameoverMessage.hide()
	$ReadyMessage.show()
	$Music.play()
	$Player.reset(player_start_position)
	$Player.is_active = false
	$Ground.start()
	state = State.Ready
	
func start_gameover():
	$Ground.stop()
	$Music.stop()
	$GameoverMessage.show()
	piper_handler.stop()
	state = State.Pending
	$GameOverInputDelayTimer.start()
	
func _on_game_over_input_delay_timer_timeout() -> void:
	state = State.Gameover

func update_score():
	if state == State.Gameover or state == State.Pending:
		return
		 
	$Score.update()
	#var num_digits = count_digits($Score.score)
	#print(num_digits)
	#if num_digits > 1:
		#$Score.position.x = (1080 + (80 * num_digits))/2
#
#func count_digits(num):
	#var count = 0
	#while num != 0:
		#num /= 10
		#count += 1
	#return count
