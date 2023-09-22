extends CanvasLayer
class_name UI

@onready var coin_label = $Control/MarginContainer/VBoxContainer/HBoxContainer2/Coins
@onready var player = get_parent().get_node("Player")
@onready var bar = $Control/Shield_bar

var coins = 0:
	set(new_coins):
		coins = new_coins
		_update_coins_label()


func _physics_process(_delta):
	#bar.value = player.shield
	pass


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


func _ready():
	GlobalSignals.update_coins.connect(_update_coins)
	_update_coins_label()

