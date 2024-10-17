extends Node2D

@onready var digit_sprite_0 = load("res://assets/sprites/0.png")
@onready var digit_sprite_1 = load("res://assets/sprites/1.png")
@onready var digit_sprite_2 = load("res://assets/sprites/2.png")
@onready var digit_sprite_3 = load("res://assets/sprites/3.png")
@onready var digit_sprite_4 = load("res://assets/sprites/4.png")
@onready var digit_sprite_5 = load("res://assets/sprites/5.png")
@onready var digit_sprite_6 = load("res://assets/sprites/6.png")
@onready var digit_sprite_7 = load("res://assets/sprites/7.png")
@onready var digit_sprite_8 = load("res://assets/sprites/8.png")
@onready var digit_sprite_9 = load("res://assets/sprites/9.png")

var digit_sprites = []
var score = 0
const GAP = 100

func _ready() -> void:
	digit_sprites.append($Digit4)
	digit_sprites.append($Digit3)
	digit_sprites.append($Digit2)
	digit_sprites.append($Digit1)
	
func update():
	$Audio.play()
	score += 1
	var digits = get_pos_nums(score)
	for i in range(len(digits)):
		digit_sprites[i].texture = get_digit_texture(digits[i])
		digit_sprites[i].show()
	update_global_position()

func get_pos_nums(num):
	var pos_nums = []
	while num != 0:
		pos_nums.append(num % 10)
		num = num / 10
	return pos_nums

func get_digit_texture(digit):
	match digit:
		0:
			return digit_sprite_0
		1:
			return digit_sprite_1
		2:
			return digit_sprite_2
		3:
			return digit_sprite_3
		4:
			return digit_sprite_4
		5:
			return digit_sprite_5
		6:
			return digit_sprite_6
		7:
			return digit_sprite_7
		8:
			return digit_sprite_8
		9:
			return digit_sprite_9

func reset():
	score = 0
	$Digit1.hide()
	$Digit2.hide()
	$Digit3.hide()
	$Digit4.texture = digit_sprite_0
	update_global_position()

func get_score():
	return 100 

func update_global_position():
	var num_digits = count_digits(score)
	print(num_digits)
	global_position.x = (1080 + (GAP * (num_digits - 1)))/2
	

func count_digits(num):
	if num == 0:
		return 1
		
	var count = 0
	while num != 0:
		num /= 10
		count += 1
	return count
