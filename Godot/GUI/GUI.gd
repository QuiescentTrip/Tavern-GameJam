extends CanvasLayer
class_name UI

@onready var coin_label = $Control/MarginContainer/VBoxContainer/HBoxContainer2/Coins

var coins = 0:
	set(new_coins):
		coins = new_coins
		_update_coins_label()


func _update_coins_label():
	coin_label.text = "x" + str(coins)


func _ready():
	_update_coins_label()

