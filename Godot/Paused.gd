extends Node2D

func _ready():
	GlobalVariables.paused = true

func _on_resume_pressed():
	GlobalVariables.paused = false
	queue_free()


func _on_main_menu_pressed():
	GlobalSignals.resetglobal.emit()
	get_tree().change_scene_to_file("res://Title.tscn")


func _on_restart_pressed():
	GlobalSignals.resetglobal.emit()
	get_tree().change_scene_to_file("res://World.tscn")
