extends Node2D


func _ready():
	GlobalSignals.bullet_fired.connect(_on_bullet_fired_recieved)

func _on_bullet_fired_recieved(bullet, position, direction, team):
	add_child(bullet)
	if team == 0:
		bullet.speed = 30
	bullet.team = team
	bullet.global_position = position
	bullet.set_direction(direction)
