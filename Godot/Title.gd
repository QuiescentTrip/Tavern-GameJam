extends Node2D


func _on_title_music_finished():
	$Title_Music.play()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://World.tscn")
