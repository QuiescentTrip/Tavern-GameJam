extends Node2D


func _ready():
	GlobalSignals.bullet_fired.connect(_on_bullet_fired_recieved)

func _on_bullet_fired_recieved(bullet, position, direction):
	add_child(bullet)
	bullet.global_position = position
	bullet.set_direction(direction)
