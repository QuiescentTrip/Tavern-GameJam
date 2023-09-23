extends CanvasLayer
class_name UI

@onready var coin_label = $MarginContainer/VBoxContainer/HBoxContainer/Coins

@onready var player = get_parent().get_node("Player")

@onready var progress_label = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/ProgressLabel
@onready var bar = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/ProgressBar
@onready var level_label = $MarginContainer/CenterContainer/Level


@onready var leveltimer = get_parent().get_node("LevelTimer")

var level_time
var song
var level = 1

func _changelevel():
	level += 1
	_change_level_label(level)
	
func _change_level_label(level):
	level_label.text = "LEVEL " + str(level)
	level_label.set("theme_override_colors/font_color", Color(1,1,1,1))


func _ready():
	var current_song = 1
	print(current_song)
	song = get_parent().get_node("Music" + str(current_song))
	_change_level_label(level)
	print(song)
	level_time = int(song.stream.get_length())
	leveltimer.set_wait_time(level_time)
	leveltimer.start()
	GlobalSignals.update_coins.connect(_update_coins)
	_update_coins_label()
	


var coins = 0:
	set(new_coins):
		coins = new_coins
		_update_coins_label()



func _physics_process(_delta):
	if GlobalVariables.paused:
		leveltimer.paused = true
		return
	else:
		leveltimer.paused = false
	
	progress_label.text = str(int(leveltimer.time_left))
	if player != null:
		bar.value = player.shield
	if leveltimer.is_stopped():
		_changelevel()
	level_label.set("theme_override_colors/font_color", lerp(level_label.get("theme_override_colors/font_color"), Color(1,1,1,0), 0.05))


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
	GlobalVariables.coins = self.coins 

