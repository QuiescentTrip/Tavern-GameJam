extends CanvasLayer
class_name UI

@onready var coin_label = $Control/MarginContainer/VBoxContainer/HBoxContainer/Control/Coins
@onready var player = get_parent().get_node("Player")
@onready var bar = $Control/MarginContainer/VBoxContainer3/Control2/ProgressBar
@onready var full_hearts = $Control/MarginContainer/VBoxContainer3/Control/Full_hearts
@onready var empty_hearts = $Control/MarginContainer/VBoxContainer3/Control/Empty_hearts

@onready var progress_label = $Control/MarginContainer/VBoxContainer3/Control2/ProgressLabel
@onready var leveltimer = get_parent().get_node("LevelTimer")
@onready var song_1 = get_parent().get_node("Music1")
var level_time


func _ready():
	level_time = int(song_1.stream.get_length())
	leveltimer.set_wait_time(level_time)
	leveltimer.start()
	
	empty_hearts.size.x = 32 * player.max_hearts
	full_hearts.size.x = 32 * player.hearts
	
	GlobalSignals.update_coins.connect(_update_coins)
	_update_coins_label()
	GlobalSignals.update_heart.connect(_update_hearts)



var coins = 0:
	set(new_coins):
		coins = new_coins
		_update_coins_label()



func _physics_process(_delta):
	progress_label.text = str(int(leveltimer.time_left))
	if player != null:
		bar.value = player.shield


func _update_coins_label():
	coin_label.text = "x" + str(coins)

func _update_coins(coins, negative):
	if negative:
		if self.coins < coins:
			coins = 0
		else:
			self.coins -= coins
	else:
		self.coins += coins 

func _update_hearts(hearts, negative):
	if negative:
		full_hearts.size.x -= 32 * hearts
	if !negative:
		full_hearts.size.x += 32 * hearts

