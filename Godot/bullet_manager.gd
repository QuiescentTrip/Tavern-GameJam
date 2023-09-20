extends Node2D

func _on_player_bullet_fired(bullet, position, direction):
	add_child(bullet)
	bullet.global_position = position
	bullet.set_direction(direction)
