extends Node2D

var double_price
var shield_price
var heart_price


# Called when the node enters the scene tree for the first time.
func _ready():
	double_price = 400 * GlobalVariables.coin_multi
	shield_price = 100 * GlobalVariables.shield_regen
	heart_price = 200 * GlobalVariables.max_hearts
	$Shield/Price.text = str(shield_price)
	$Heart/Price.text = str(heart_price)
	$Coin/Price.text = str(double_price)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	get_tree().change_scene_to_file("res://World.tscn")


func _on_heart_body_entered(body):
	if GlobalVariables.coins >= heart_price:
		GlobalSignals.update_coins.emit(heart_price, 1)
		GlobalVariables.max_hearts += 1
		GlobalVariables.hearts += 1
		call_deferred("remove_child", $Heart)


func _on_shield_body_entered(body):
	if GlobalVariables.coins >= shield_price:
		GlobalSignals.update_coins.emit(shield_price, 1)
		GlobalVariables.shield_regen += 1
		
		call_deferred("remove_child", $Shield)


func _on_coin_body_entered(body):
	if GlobalVariables.coins >= double_price:
		GlobalSignals.update_coins.emit(double_price, 1)
		GlobalVariables.coin_multi += 1
		call_deferred("remove_child", $Coin)
