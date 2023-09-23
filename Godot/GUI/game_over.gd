extends CanvasLayer


func _on_restart_pressed():
	GlobalVariables.paused = false
	get_tree().change_scene_to_file("res://World.tscn")


func _on_continue_pressed():
	if GlobalVariables.coins >= 10:
		GlobalSignals.update_coins.emit(10, 1)
		GlobalSignals.continued.emit()
		GlobalSignals.resetglobal.emit()


func _on_main_menu_pressed():
	GlobalSignals.resetglobal.emit()
	get_tree().change_scene_to_file("res://Title.tscn")
