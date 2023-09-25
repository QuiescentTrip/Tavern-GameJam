extends CanvasLayer

@onready var minus_coins = $PanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/VBoxContainer/HBoxContainer/Minus_coins
@onready var continue_button = $PanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/VBoxContainer/Continue
@onready var score = $PanelContainer/MarginContainer/VBoxContainer/Label/Label2

var coins_needed

func _ready():
	GlobalSignals.died.connect(_onDeath)
	coins_needed = GlobalVariables.deaths * 100
	minus_coins.text = "-" + str(coins_needed)
	score.text = "Score: " + str(GlobalVariables.score)
	if(GlobalVariables.coins < coins_needed):
		continue_button.disabled = true
	else:
		continue_button.disabled = false
	
func _onDeath():
	coins_needed = GlobalVariables.deaths * 100
	minus_coins.text = "-" + str(coins_needed)
	score.text = "Score: " + str(GlobalVariables.score)
	if(GlobalVariables.coins < coins_needed):
		continue_button.disabled = true
	else:
		continue_button.disabled = false

func _on_restart_pressed():
	GlobalSignals.resetglobal.emit()
	GlobalVariables.paused = false
	get_tree().change_scene_to_file("res://World.tscn")


func _on_continue_pressed():
	if GlobalVariables.coins >= coins_needed:
		GlobalSignals.update_coins.emit(coins_needed, 1)
		GlobalSignals.continued.emit()


func _on_main_menu_pressed():
	GlobalSignals.resetglobal.emit()
	get_tree().change_scene_to_file("res://Title.tscn")
